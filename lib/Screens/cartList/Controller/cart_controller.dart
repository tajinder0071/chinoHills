import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../CSS/color.dart';
import '../../../Model/cart_model.dart';
import '../../../util/base_services.dart';
import '../../../Model/promode_reward_model.dart';
import '../../../util/common_page.dart';
import '../../../../../util/local_store_data.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/success_paymnet_widget.dart';

class CartController extends GetxController {
  static CartController get cart => Get.find();

  // TODO >>. Variable Declaration

  RxBool isLoading = false.obs;
  RxBool isUpdateSomething = false.obs;
  RxBool isDelete = false.obs;
  RxList<CartItem> cartData = <CartItem>[].obs;
  var cartModel1 = CartModel1().obs;
  bool isUpdate = false;
  LocalStorage localStorage = LocalStorage();
  RxInt cartItemCount = 0.obs;
  var totalCost = "".obs;
  var finalTotalCost = 0.0.obs;

  var totalConvenienceFee = "".obs;
  var subTotal = "".obs;
  List cartIdList = [];
  var sendCartID;
  var selectedId = Rx<String?>(null); //todo You can also use int if needed
  var offerselectedId = Rx<String?>(null); //todo You can also use int if needed

  // Determine item type based on data
  RewardType? rewardType;
  String imageUrl = '';
  String title = '';
  String subtitle = '';
  var price;
  var cartID;
  var itemID;
  var variationId;
  var variationList = <TreatmentVariation>[];

  bool isMemberAvailable = false;
  var memberTitle;
  var memberPrice;
  var orderID;
  var isPermissionGranted = false;
  var cartitemList = [];

  Placemark? currentLocation;
  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  //TODO >>  Fetch the Cart List...
  cartList() async {
    cartData.clear();
    cartitemList.clear();
    isLoading.value = true;
    try {
      var orderid =await LocalStorage().getOId();
      print("order_id:$orderid");

      var response = await hitCartListApi();
      if (response['success'] == true) {
        cartData.assignAll((response['cartItems'] as List)
            .map((e) => CartItem.fromJson(e))
            .toList());
        cartModel1.value = CartModel1.fromJson(response);

        // and then can be null

        cartItemCount.value = cartData.length ?? 0;
        totalCost.value = response['total_price'] ?? 0;
        finalTotalCost.value =
            double.tryParse(response['final_cost'].toString()) ?? 0.0;
        totalConvenienceFee.value = response['totalConvenienceFee'] ?? 0;
        cartIdList.clear();
        isMemberAvailable = false;
        memberTitle = null;
        memberPrice = null;
        for (var isData in cartData) {
          cartIdList.add(isData.cartId);
          cartitemList.add(isData.cartItemId);
          sendCartID = isData.cartId;
          // ✅ Check for membership and update values
          if (isData.membershipName != null) {
            // isMemberAvailable = true;
            memberTitle = isData.membershipName ?? '';
            memberPrice = '\$${isData.price ?? '0.00'}';
          }
        }
        addToIdList();
        couponAvailableRewards();
        Get.log("yes in cart members : $isMemberAvailable");
        isLoading.value = false;
        update();
      } else {
        isMemberAvailable = false;
        cartItemCount.value = 0;
        isLoading.value = false;
        update();
      }
    } on Exception catch (e) {
      isLoading.value = false;
      update();
    }
  }

  // TODO >> Delete the Single Added Item...
  Future deleteCart(id, index) async {
    cartData[index].isItemDelete = true;
    update();
    try {
      var userId =await localStorage.getUId();
      Map<String, dynamic> map = {"user_id": userId, "cart_id": id};
      var response = await hitDeleteCartApi(userId, id);
      cartData[index].isItemDelete = false;
      cartList();
      couponAvailableRewards();
      print("Promo ID : $id");
      update();
    } on Exception catch (e) {
      cartData[index].isItemDelete = false;
      update();
    }
  }

  // TODO >>. Request the Location permission...
  Future<void> requestPermission() async {
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

  var itemList = {};

  //todo:: tId >> pId >> mId create array of objects and retuen th value like this this "item_id": {
  //     "treatment_id": [1, 2, 3],
  //     "package_id": [1],
  //     "membership_id": [32, 34]
  //   },
  void addToIdList() {
    tId.clear();
    pId.clear();
    mId.clear();
    for (var item in cartData) {
      if (item.treatmentId != null) {
        tId.add(item.treatmentVariationId);
      }
      if (item.packageId != null) {
        pId.add(item.packageId);
      }
      if (item.memberId != null) {
        mId.add(item.memberId);
      }
    }
    itemList = {
      "treatment_id": tId.isEmpty ? [] : tId,
      // Ensure it's an empty list if null
      "package_id": pId.isEmpty ? [] : pId,
      // Ensure it's an empty list if null
      "membership_id": mId.isEmpty ? [] : mId
      // Ensure it's an empty list if null
    };
  }

  // Todo ?? Getting the current location...
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
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

//TODO >> Update the Product Items..
  Future<void> updateProduct(
    variationId,
    cartID,
    int cartitemID,
  ) async {
    isUpdate = true;
    var userId =await localStorage.getUId();
    var cId =await localStorage.getCId();
    update();
    Map<String, dynamic> map = {
      "user_id": userId,
      "cart_id": cartID ?? 0,
      "treatment_variation_id": variationId,
      "cart_item_id": cartitemID,
      "client_id": "${cId}"
    };
    print("Update Map : $map");
    try {
      var response = await hitUpdateCartListAPI(map);
      if (response['success'] == true) {
        isUpdate = false;
        Get.back();
        cartList();
        couponAvailableRewards();
        update();
      } else {
        isUpdate = false;
        update();
      }
    } on Exception catch (e) {
      isUpdate = false;
      update();
      print(e.toString());
    }
  }

  Future<void> createOrder(id, promo_id, orderid) async {
    isUpdate = true;
    var userId =await localStorage.getUId();
    var cId =await localStorage.getCId();
    update();
    Map<String, dynamic> map = {
      "user_id": userId,
      "cart_id": sendCartID,
      "client_id": "${cId}",
      "order_id": orderid.toString() == "null" || orderid.toString().isEmpty
          ? ""
          : orderid,
    };
    print("map: $map");
    try {
      var response = await hitCreateOrder(map);
      if (response['success'] == true) {
        isUpdate = false;
        orderID = response['order_id'];
        //localy store the order id
        localStorage.saveData("order_id", response['order_id']);
        print("Order ID: ${response['order_id']}");
        makePayment(double.parse(finalTotalCost.value.toString()),
            response['order_id']);
        update();
      } else {
        isUpdate = false;
        update();
      }
    } on Exception catch (e) {
      isUpdate = false;
      update();
      print(e.toString());
    }
  }

  Future<void> makePayment(double amount, orderId) async {
    try {
      String? paymentIntentClientSecret =
          await _createPaymentIntent(amount, orderId);
      if (paymentIntentClientSecret == null) return;
      print("object::$paymentIntentClientSecret");

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'CH BUCKS',
      ));
      await _processPayment(paymentIntentClientSecret, amount, orderId);
    } catch (e) {
      print(e);
    }
  }

  // TODO ??
  int _calculateAmount(double amount) {
    return (amount * 100).round();
  }

  Future<String?> _createPaymentIntent(double amount, orderId) async {
    try {
      var currency = currentLocation!.isoCountryCode == "US" ? "USD" : "INR";
      var userName =await localStorage.getName();
      var cId =await localStorage.getCId();
      final Dio dio = Dio();
      Map<String, dynamic> map = {
        "amount": _calculateAmount(amount),
        "currency": currency,
        'payment_method_types[]': 'card',
        'description': 'FLUTTER STRIPE DEMO',
        'statement_descriptor': 'FLUTTER STRIPE DEMO',
        'shipping': {
          'name': userName,
          'address': {
            'line1': currentLocation!.street,
            'line2': currentLocation!.subLocality ?? "",
            'city': currentLocation!.locality,
            'state': currentLocation!.administrativeArea,
            'postal_code': currentLocation!.postalCode,
            'country': currentLocation!.isoCountryCode
          },
        },
        'metadata': {
          'order_id': orderId,
          'client_id': "${cId}",
        }
      };
      print("map=>$map");
      var response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: map,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${CommonPage().stripeSicretKey}",
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
      );
      print("Response: ${response.data}");
      if (response.data != null) {
        log("checkout:: ${response.data}");
        return response.data['client_secret'];
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  // TODO ??  Make here the payment api to make the cart empty..
  bool isCartClearLoading = false;

  Future<void> clearTheCartAPI({
    required String transactionId,
    required String paymentStatus,
    required String paymentMethod,
    required String paymentNotes,
    required var orderId,
    required var amount,
  }) async {
    isCartClearLoading = true;
    var userId =await localStorage.getUId();
    var cId =await localStorage.getCId();

    Map<String, dynamic> sendMap = {
      "cart_id": sendCartID,
      "user_id": userId,
      "payment_amount": amount,
      "transaction_id": transactionId,
      "payment_status": paymentStatus,
      "payment_method": paymentMethod,
      "payment_notes": paymentNotes,
      "order_id": orderId,
      "client_id": cId,
    };
    print("Doe map : ${sendMap}");

    update();
    try {
      var response = await hitClearTheCart(sendMap);
      Get.log("Cart Clear Response: ${response['success']}");
      if (response['success'] == true) {
        showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context) => PaymentSuccessPopup(
            amount: amount.toString(),
            transactionId: transactionId.toString(),
            transactionType: paymentMethod.toString(),
          ),
        );
        //remove the order id from local storage
        cartList();
      }
    } catch (e) {
      print("❌ Clear Cart Failed: $e");
    } finally {
      isCartClearLoading = false;
      update();
    }
  }

  // TODO ? Process the payment
  Future<void> _processPayment(
      String clientSecret, double amount, orderId) async {
    try {
      print("object Payment");
      await Stripe.instance.presentPaymentSheet();
      print("✅ Payment Success");
      // Fetch payment intent details from Stripe after payment
      final Dio dio = Dio();
      var response = await dio.get(
        "https://api.stripe.com/v1/payment_intents/${clientSecret.split('_secret')[0]}",
        options: Options(headers: {
          "Authorization": "Bearer ${CommonPage().stripeSicretKey}",
        }),
      );

      if (response.statusCode == 200) {
        var paymentIntentData = response.data;
        print("🔍 Stripe PI: $paymentIntentData");
        // Now call clearTheCartAPI with details
        clearTheCartAPI(
          transactionId: paymentIntentData['id'],
          paymentStatus: paymentIntentData['status'],
          // should be 'succeeded'
          paymentMethod:
              paymentIntentData['payment_method_types']?[0] ?? 'card',
          paymentNotes: 'Stripe Payment',
          orderId: orderId,
          amount: amount,
        );
      }
    } catch (e) {
      print("❌ Payment Failed: $e");
    }
  }

  RxInt selectedPromoIndex = (-1).obs;
  var selectedComingId;

  RxString enteredCode = ''.obs;
  var isApplyLoading = false;
  var appliedCouponCode = ''.obs;
  var appledCouponID = -1;
  var appledAmount;

  var couponDiscount = 0.0.obs;
  var totalAmount = 0.0.obs;
  var promoErrorText = '';
  final promoTextController = TextEditingController();

  void selectPromo(reardId, int index, isPromoCode, offerCode) {
    print("isSelected :${isPromoCode}");
    selectedComingId = reardId;

    !isPromoCode
        ? applyAvailableCode(reardId, index)
        : applyPromoCode(offerCode);
  }

  void removeSelection(rewardID) {
    removeAppliedPromo(rewardID);
  }

  bool get isPromoApplied =>
      selectedPromoIndex.value != -1 || enteredCode.isNotEmpty;

//todo apply promo code.
  applyPromoCode(code) async {
    isApplyLoading = true;
    update();
    try {
      promoErrorText = ''; // Reset error
      var userId =await localStorage.getUId();
      var cId =await localStorage.getCId();
      Map<String, dynamic> map = {
        "promo_code": code,
        "cart_id": cartID,
        "user_id": userId,
        "client_id": "${cId}"
      };
      Get.log("apply Cart list :$map");
      var response = await hiApplyCouponCodeAPI(map);
      if (response['success'] == true) {
        //todo promo code applied == True,
        appliedCouponCode.value = code;
        appledCouponID = response['updated_items'][0]['promo_code_id'];
        appledAmount = response['updated_items'][0]['total_discount'];
        totalAmount.value -= couponDiscount.value;
        isApplyLoading = false;
        promoTextController.clear();
        isUpdateSomething.value = true;
        cartList();
        Get.back();
        update();
      } else {
        // todo Snackbar
        isUpdateSomething.value = false;
        promoTextController.clear();
        Get.snackbar(
          "Invalid Promo Code",
          "Please enter a valid promo code.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 3),
        );
        isApplyLoading = false;
        update();
      }
    } on Exception catch (e) {
      isApplyLoading = false;
      isUpdateSomething.value = false;
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade400,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 3),
      );
      update();
    }
  }

  selectPromoCode(code, index, offerId, isSelected) async {
    isApplyLoading = true;
    var cId=await localStorage.getCId();
    update();
    try {
      promoErrorText = ''; //todo Reset error
      var userId =await localStorage.getUId();
      Map<String, dynamic> map = {
        "promo_code": code,
        "cart_id": cartID,
        "user_id": userId,
        "client_id": "${cId}",
      };
      Get.log("apply Cart list :$map");
      var response = await hiApplyCouponCodeAPI(map);
      if (response['success'] == true) {
        selectedPromoIndex.value = index;
        offerselectedId.value = isSelected.toString();
        isApplyLoading = false;
        isUpdateSomething.value = true;
        promoErrorText = ''; // Reset error
        update();
        cartList();
        Get.back();
      } else {
        isUpdateSomething.value = false;
        // promoErrorText = "Invalid code. Please enter a valid promo code.";
        print("object: ${promoErrorText}");
        isApplyLoading = false;
        update();
      }
    } on Exception catch (e) {
      isUpdateSomething.value = false;
      isApplyLoading = false;
      update();
    }
  }

  applyAvailableCode(rewardId, index) async {
    isApplyLoading = true;
    update();
    try {
      var userId =await localStorage.getUId();
      var cId =await localStorage.getCId();
      Map<String, dynamic> map = {
        "reward_id": rewardId,
        "cart_item_id":
            cartitemList.toString().replaceAll('[', "").replaceAll(']', ""),
        "user_id": userId,
        "client_id": "${cId}",
      };
      Get.log("apply Cart list :$map");
      var response = await hiApplyAvailableAPI(map);
      if (response['success'] == true) {
        isUpdateSomething.value = true;
        selectedPromoIndex.value = index;
        selectedId.value = rewardId.toString();
        isApplyLoading = false;
        promoErrorText = ''; // Reset error
        cartList();
        Get.back();
        update();
      } else {
        isUpdateSomething.value = false;
        print("object: ${promoErrorText}");
        isApplyLoading = false;
        update();
      }
    } on Exception catch (e) {
      isUpdateSomething.value = false;
      isApplyLoading = false;
      update();
    }
  }

  void resetPromoState() {
    promoTextController.clear();
    appliedCouponCode.value = '';
    couponDiscount.value = 0.0;
    appledCouponID = -1;
  }

  removeAppliedPromo(rewardId) async {
    isApplyLoading = true;
    update();
    try {
      var userId =await localStorage.getUId();
      var response =
          await hiRemoveCouponCodeAPI(rewardId, userId, cartIdList[0]);
      print(response['success']);
      if (response['success'] == true) {
        isUpdateSomething.value = true;
        selectedPromoIndex.value = -1;
        selectedId.value = null;
        isApplyLoading = false;
        selectedComingId = '';
        cartList();
        Get.back();
        update();
      } else {
        isUpdateSomething.value = false;
        isApplyLoading = false;
        update();
      }
    } on Exception catch (e) {
      isUpdateSomething.value = false;

      isApplyLoading = false;
      update();
    }
  }

  Future<void> removeSelectedPromo(var promoID) async {
    isApplyLoading = true;
    update();
    try {
      var userId =await localStorage.getUId();
      var response =
          await hitRemoveAddedCouponAPI(promoID, userId, cartIdList[0]);
      if (response['success'] == true) {
        isUpdateSomething.value = true;
        isApplyLoading = false;
        cartList();
        Get.back();
      }
    } finally {
      isUpdateSomething.value = false;
      isApplyLoading = false;
      update();
    }
  }

  Future<void> removeAddedPromo(var promoID) async {
    isApplyLoading = true;
    update();
    try {
      var userId =await localStorage.getUId();
      var response =
          await hitRemoveAddedCouponAPI(promoID, userId, cartIdList[0]);
      if (response['success'] == true) {
        isUpdateSomething.value = true;
        appliedCouponCode.value = ''; //todo Clear applied promo
        couponDiscount.value = 0.0;
        promoTextController.clear(); //todo Clear input
      }
    } finally {
      isUpdateSomething.value = false;
      isApplyLoading = false;
      update();
    }
  }

  //  Todo ?? available reward...
  bool isRewardLoading = false;
  List<Offer> couponAvailableData = [];
  List<Reward> availableData = [];

  var tId = [];
  var pId = [];
  var mId = [];

  Future<void> couponAvailableRewards() async {
    isRewardLoading = true;
    try {
      var userId =await localStorage.getUId();
      couponAvailableData.clear();
      availableData.clear();
      couponAvailableData = [];
      availableData = [];
      PromoRewardModel response = await hitPromoRewardAPI(
          userId,
          tId.isEmpty ? [] : tId,
          pId.isEmpty ? [] : pId,
          mId.isEmpty ? [] : mId);
      isRewardLoading = false;
      couponAvailableData.addAll(response.offers!);
      availableData.addAll(response.rewards!);
      Get.log("Available reward list==>${response}");
      update();
    } on Exception catch (e) {
      isRewardLoading = false;
      update();
    }
  }
}

class checkoutbox {}

// Model..
class PromoModel {
  String? title;
  var amount;

  PromoModel({this.amount, this.title});
}
