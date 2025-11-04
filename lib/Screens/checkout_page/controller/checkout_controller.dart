import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:chino_hills/Model/cart_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../CSS/color.dart';
import '../../../util/base_services.dart';
import '../../../util/common_page.dart';
import '../../../util/local_stoage.dart';
import '../../cartList/widgets/success_paymnet_widget.dart';
import '../Widgets/confirm_order.dart';

class CheckoutController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expDateController = TextEditingController();
  final cvcController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  LocalStorage localStorage = LocalStorage();

  // State Variables
  var saveAddress = true.obs;
  var selectedPaymentMethod = 0.obs; // 0 = card, 1 = Affirm
  var selectedCountry = "USA".obs;


  placeOrder(RxList<Item> cartData) {
    // Handle API Call
    Get.to(OrderConfirmationPage(cartData: cartData));
  }

  Future<void> launchURL(customUrl) async {
    final Uri url = Uri.parse(customUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $customUrl';
    }
  }

  Placemark? currentLocation;
  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLat.value = position.latitude;
      currentLng.value = position.longitude;
      Get.log(" Currnt :${currentLat.value}");
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Get.log("This the all information :$placemarks");
      if (placemarks.isNotEmpty) {
        currentLocation = placemarks[0];
        print("Current Location: $currentLocation"); // Debugging
      }
    } catch (e) {
      Get.log("Error getting location: $e");
    }
  }

  var isPermissionGranted = false;

  FocusNode cardNumberFocus = FocusNode();
  FocusNode expDateFocus = FocusNode();
  FocusNode cvcFocus = FocusNode();

  Rx<bool> isCartClearLoading = false.obs;

  bool cardComplete = false;

  CardFormEditController? cardFormEditController = CardFormEditController();

  bool isAccepted = false;

  Future<void> requestPermission() async {
    isAccepted = false;
    update();
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      isPermissionGranted = true;
      await _getCurrentLocation(); // Get coordinates and address
    } else if (permission == LocationPermission.denied) {
    } else if (permission == LocationPermission.deniedForever) {
      Get.defaultDialog(
        title: "Location Permission",
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        titleStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        backgroundColor: Colors.white,
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "You have permanently denied location access. Please enable it from settings.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
        radius: 10,
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
            Geolocator.openAppSettings();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.dynamicColor,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Open Settings",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        cancel: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColor.dynamicColor),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Cancel",
            style: TextStyle(color: AppColor.dynamicColor, fontSize: 16),
          ),
        ),
      );
    }
  }

  Future<void> makePayment(orderId, cart_id, finalTotalCost) async {
    isCartClearLoading.value = true;
    update();
    try {
      String? clientSecret =
          await _createPaymentIntent(orderId, finalTotalCost);
      if (clientSecret == null) return;

      final paymentIntent = await Stripe.instance.confirmPayment(
        data: PaymentMethodParams.card(
          paymentMethodData: const PaymentMethodData(),
        ),
        paymentIntentClientSecret: clientSecret,
      );

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        await clearTheCartAPI(
          transactionId: paymentIntent.id,
          paymentStatus: paymentIntent.status.name,
          paymentMethod: "card",
          paymentNotes: "Stripe Payment",
          orderId: orderId,
          paymentAmount: _calculateAmount(finalTotalCost),
          sendCartID: cart_id,
        );
      }
    } catch (e) {
      isCartClearLoading.value = false;
      update();
      print("❌ Error in makePayment: $e");
    } finally {
      isCartClearLoading.value = false;
      update();
    }
  }

  // TODO ??
  int _calculateAmount(double amount) {
    return (amount * 100).round();
  }

  Future<String?> _createPaymentIntent(orderId, finalTotalCost) async {
    try {
      var currency = currentLocation?.isoCountryCode == "US" ? "USD" : "INR";
      var userName = await localStorage.getName();
      var clientId = await localStorage.getCId();
      print("currentLocation?.street=>${currentLocation?.street}");

      final Dio dio = Dio();

      Map<String, dynamic> map = {
        "amount": _calculateAmount(finalTotalCost ?? 0),
        "currency": currency,
        "payment_method_types[]": "card",
        "description": "FLUTTER STRIPE DEMO",
        "statement_descriptor": "FLUTTER STRIPE DEMO",

        // ✅ Flattened shipping fields
        "shipping[name]": userName ?? '',
        "shipping[address][line1]": currentLocation?.subAdministrativeArea ?? '',
        "shipping[address][line2]": currentLocation?.subLocality ?? '',
        "shipping[address][city]": currentLocation?.locality ?? '',
        "shipping[address][state]": currentLocation?.administrativeArea ?? '',
        "shipping[address][postal_code]": currentLocation?.postalCode ?? '',
        "shipping[address][country]": currentLocation?.isoCountryCode ?? '',

        // ✅ Flattened metadata
        "metadata[order_id]": "$orderId",
        "metadata[client_id]": "$clientId",
      };

      print("📤 Sending to Stripe: $map");

      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: map,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${CommonPage().stripeSicretKey}",
          },
        ),
      );

      print("✅ Stripe Response: ${response.data}");

      if (response.data != null) {
        return response.data['client_secret'];
      }
      return null;
    } on DioError catch (e) {
      print("❌ Stripe API error: ${e.response?.statusCode}");
      print("❌ Message: ${e.message}");
      print("❌ Response data: ${e.response?.data}");
      return null;
    } catch (e) {
      print("❌ General error: $e");
      return null;
    }
  }

  Future<void> clearTheCartAPI(
      {required String transactionId,
      required String paymentStatus,
      required String paymentMethod,
      required String paymentNotes,
      required var orderId,
      required int paymentAmount,
      sendCartID}) async
  {
    isCartClearLoading.value = true;
    update();
    var clientId = await localStorage.getCId();
    var userId = await localStorage.getUId();

    Map<String, dynamic> sendMap = {
      "cart_id": sendCartID,
      "user_id": userId,
      "payment_amount": paymentAmount, // ✅ Add payment amount here
      "transaction_id": transactionId,
      "payment_status": paymentStatus,
      "payment_method": paymentMethod,
      "payment_notes": paymentNotes,
      "order_id": orderId,
      "client_id": "$clientId",
    };

    print("📝 Payload to clear cart: $sendMap");

    update();
    try {
      var response = await hitClearTheCart(sendMap);
      Get.log("Cart Clear Response: ${response['success']}");

      if (response['success'] == true) {
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => PaymentSuccessPopup(
            transactionId: transactionId.toString(),
            transactionType: paymentMethod.toString(),
          ),
        );
        isCartClearLoading.value = false;
        update();

        // Remove the order ID from local storage
      }
    } catch (e) {
      print("❌ Clear Cart Failed: $e");
    } finally {
      isCartClearLoading.value = false;
      update();
    }
  }
}
