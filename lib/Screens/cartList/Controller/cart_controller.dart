import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../CSS/color.dart';
import '../../../Model/cart_model.dart';
import '../../../Model/offer_detail_model.dart';
import '../../../util/base_services.dart';
import '../../../Model/promode_reward_model.dart' hide Membership;
import '../../../util/common_page.dart';
import '../../../util/local_store_data.dart';
import '../widgets/cart_item_widget.dart';
import '../widgets/success_paymnet_widget.dart';

// Converted to StatelessController (no UI state, only logic)
class CartController extends GetxController {
  static CartController get cart => Get.find();

  // TODO >>. Variable Declaration

  String appliedName = '';
  RxBool isUpdateSomething = false.obs;
  RxBool isDelete = false.obs;
  RxList<Item> cartData = <Item>[].obs;
  var cartModel1 = CartModel1().obs;
  bool isUpdate = false;
  LocalStorage localStorage = LocalStorage();
  var cartItemCount;
  var totalCost;
  var finalTotalCost;

  var totalConvenienceFee;
  var subTotal;

  List cartIdList = [];
  var sendCartID;

  var selectedId = Rx<String?>(null); //todo You can also use int if needed
  var offerselectedId = Rx<String?>(null); //todo You can also use int if needed

  bool _isApiCallInProgress = false;
  Timer? _debounceTimer;

  // Determine item type based on data
  RewardType? rewardType;
  String imageUrl = '';
  String title = '';
  String subtitle = '';
  var price;
  var cartID;
  var itemID;
  var variationId;

  // var variationList = <TreatmentVariation>[];

  bool isMemberAvailable = false;
  var memberTitle;
  var memberPrice;
  var orderID;
  var isPermissionGranted = false;
  var cartitemList = [];

  Placemark? currentLocation;
  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize only once
    if (couponAvailableData.isEmpty) {
      couponAvailableRewards();
    }
  }

  //TODO >>  Fetch the Cart List...

  Future<void> cartList() async {
    cartData.clear();
    cartitemList.clear();
    isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      update(); // or your state change
    });
    try {
      var response = await hitCartListApi();

      if (response['success'] == true) {
        var items = response['data']?['items'];
        sendCartID = response['data']?['cart_id'];
        print("cartModel1.value.data?.cartId${sendCartID}");
        if (items is List) {
          cartData.assignAll(
            items.map((e) => Item.fromJson(e as Map<String, dynamic>)).toList(),
          );
        } else {
          cartData.clear();
        }
        cartModel1.value = CartModel1.fromJson(response);
        print("cartModel1.value.data?.cartId${cartModel1.value.data!.cartId}");
        sendCartID = cartModel1.value.data?.cartId;
        cartItemCount = cartData.length;
        totalCost = response['data']['sub_total'] ?? 0;
        finalTotalCost =
            double.tryParse(response['data']['final_cost'].toString()) ?? 0.0;
        totalConvenienceFee = response['data']['convenience_fee'] ?? 0;

        cartIdList.clear();
        isMemberAvailable = false;
        memberTitle = null;
        memberPrice = null;

        for (var isData in cartData) {
          cartitemList.add(isData.cartItemId);

          /* if (isData.membershipName != null) {
            isMemberAvailable = true;
            memberTitle = isData.membershipName ?? '';
            memberPrice = '\$${isData.price ?? '0.00'}';
          }*/
        }

        // ✅ Update appliedName based on applied promo/reward/member
        final appliedPromo = cartModel1.value.promoCode;
        final appliedReward = cartModel1.value.reward;

        if (appliedPromo != null) {
          appliedName = appliedPromo.name ?? '';
        } else if (appliedReward != null) {
          appliedName = appliedReward.name ?? '';
        } else if (memberTitle != null &&
            cartModel1.value.data?.discountPrice != "") {
          appliedName = memberTitle ?? '';
        } else {
          appliedName = '';
        }
        couponAvailableRewards();
        isLoading = false;
        update();
      } else {
        isMemberAvailable = false;
        cartItemCount = 0;
        isLoading = false;
        update();
      }
    } on Exception catch (e) {
      isLoading = false;
      update();
    }
  }

  List<Treatment> tratment = [];
  List<Membership> membership = [];
  List<Package> package = [];
  OfferDetailModel offerDetailModel = OfferDetailModel();

  learnMore(id) async {
    isLoading = true;
    tratment.clear();
    membership.clear();
    package.clear();
    // update();
    try {
      id.toString() == "null"
          ? null
          : offerDetailModel = await hitLearnDetail(id);
      tratment.addAll(offerDetailModel.data!.treatments!);
      membership.addAll(offerDetailModel.data!.memberships!);
      package.addAll(offerDetailModel.data!.packages!);
      isLoading = false;
      update();
    } on Exception catch (e) {
      isLoading = false;
      update();
    }
  }

  // WORKING ON IT //TODO TO UPDATE THE CART ITEM
  // // Function to unselect promo or reward and update cart
  Future<void> unselectPromoOrReward() async {
    if (selectedId.value != null || offerselectedId.value != null) {
      // If a reward is selected, remove it
      if (selectedId.value != null) {
        await removeAppliedReward(selectedId.value);
        update();
      }
      // If a promo is selected, remove it
      if (offerselectedId.value != null) {
        await removeSelectedPromo(offerselectedId.value);
        update();
      }
    }
  }

  // TODO >> Delete the Single Added Item...
  Future deleteCart(id, index) async {
    isDelete = true.obs;
    update();
    try {
      var response = await hitDeleteCartApi(id);
      isDelete = false.obs;
      cartList();
      couponAvailableRewards();
      print("Promo ID : $id");
      update();
    } on Exception catch (e) {
      update();
    }
  } //fix this

  // Future deleteCart(id, index) async {
  //   // set flag via .value
  //   isDelete.value = true;
  //   update();
  //   try {
  //     var response = await hitDeleteCartApi(id);
  //     // on success, re-fetch or manually remove item
  //     // If the API returns the updated cart, prefer using cartList()
  //     if (response != null && response['success'] == true) {
  //       // Option A (recommended): re-fetch server cart
  //       await cartList(); // this will set sendCartID according to server response
  //
  //       // Option B: if you prefer local remove without network:
  //       // cartData.removeAt(index);
  //       // cartitemList.removeWhere((elem) => elem == id);
  //       // if (cartData.isEmpty) clearCartState();
  //
  //       // If server indicates cart is empty, ensure sendCartID is cleared
  //       final serverCartId = response['data']?['cart_id'];
  //       if (serverCartId == null || serverCartId.toString() == "null" || (response['data']?['items'] is List && (response['data']?['items'] as List).isEmpty)) {
  //         sendCartID = null;
  //         cartModel1.value = CartModel1();
  //         cartData.clear();
  //       }
  //     } else {
  //       // handle failure if needed
  //     }
  //     isDelete.value = false;
  //     couponAvailableRewards(); // refresh offers
  //     update();
  //   } catch (e) {
  //     // error branch
  //     isDelete.value = false;
  //     update();
  //   }
  // }


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

  void addToIdList() {
    tId.clear();
    pId.clear();
    mId.clear();

    for (var item in cartData) {
      if (item.itemType == "treatment") {
        tId.add(item.itemVariantId);
      } else if (item.itemType == "package") {
        pId.add(item.itemVariantId);
      } else if (item.itemType == "membership") {
        mId.add(item.itemVariantId);
      }
    }

    itemList = {
      "treatment_id": tId,
      "package_id": pId,
      "membership_id": mId,
    };

    Get.log("Built itemList: $itemList");
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
    var clientId = await localStorage.getCId();
    var userId = await localStorage.getUId();
    update();
    Map<String, dynamic> map = {
      "user_id": userId,
      "cart_id": cartID ?? 0,
      "treatment_variation_id": variationId,
      "cart_item_id": cartitemID,
      "client_id": "${clientId}"
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
    var clientId = await localStorage.getCId();
    var userId = await localStorage.getUId();
    update();
    Map<String, dynamic> map = {
      "user_id": userId,
      "cart_id": sendCartID,
      "client_id": "${clientId}",
      "order_id": orderid.toString() == "null" || orderid.toString().isEmpty
          ? ""
          : orderid,
    };
    try {
      var response = await hitCreateOrder(map);
      if (response['success'] == true) {
        isUpdate = false;
        orderID = response['order_id'];
        //localy store the order id
        localStorage.saveData("order_id", response['order_id'].toString());
        print("Order ID: ${response['order_id']}");
        makePayment(orderID);
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

  Future<void> makePayment(orderId) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(orderId);
      if (paymentIntentClientSecret == null) return;
      print("object::$paymentIntentClientSecret");

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentClientSecret,
            merchantDisplayName: 'NIMA',
          ));
      await _processPayment(paymentIntentClientSecret, orderId);
    } catch (e) {
      print(e);
    }
  }

  // TODO ??
  int _calculateAmount(double amount) {
    return (amount * 100).round();
  }

  Future<String?> _createPaymentIntent(orderId) async {
    try {
      var currency = currentLocation?.isoCountryCode == "US" ? "USD" : "INR";
      var userName = await localStorage.getName();
      var clientId = await localStorage.getCId();

      final Dio dio = Dio();

      Map<String, dynamic> map = {
        "amount": _calculateAmount(finalTotalCost ?? 0),
        "currency": currency,
        "payment_method_types[]": "card",
        "description": "FLUTTER STRIPE DEMO",
        "statement_descriptor": "FLUTTER STRIPE DEMO",

        // ✅ Flattened shipping fields
        "shipping[name]": userName ?? '',
        "shipping[address][line1]": currentLocation?.street ?? '',
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

  // TODO ??  Make here the payment api to make the cart empty..
  bool isCartClearLoading = false;

  Future<void> clearTheCartAPI({
    required String transactionId,
    required String paymentStatus,
    required String paymentMethod,
    required String paymentNotes,
    required var orderId,
    required int paymentAmount, // ✅ New parameter added
  }) async {
    isCartClearLoading = true;
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

        // Remove the order ID from local storage
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

  Future<void> _processPayment(String clientSecret, String orderId) async {
    try {
      print("💳 Starting payment process...");

      // Step 1: Present the payment sheet
      try {
        await Stripe.instance.presentPaymentSheet();
        print("✅ Payment sheet presented successfully.");
      } on StripeException catch (e) {
        print("❌ StripeException during payment sheet: $e");
        return;
      } catch (e) {
        print("❌ Unexpected error during payment sheet: $e");
        return;
      }

      // Step 2: Extract paymentIntent ID
      if (clientSecret.isEmpty || !clientSecret.contains('_secret')) {
        print("❌ Invalid clientSecret format: $clientSecret");
        return;
      }

      final String paymentIntentId = clientSecret.split('_secret')[0];
      print("🔎 Extracted Payment Intent ID: $paymentIntentId");

      // Step 3: Call Stripe API to get payment intent details
      final Dio dio = Dio();
      final response = await dio.get(
        "https://api.stripe.com/v1/payment_intents/$paymentIntentId",
        options: Options(
          headers: {
            "Authorization": "Bearer ${CommonPage().stripeSicretKey}",
          },
        ),
      );

      // Step 4: Check response and process payment
      if (response.statusCode == 200) {
        final paymentIntentData = response.data;
        print("📦 Stripe PaymentIntent: $paymentIntentData");

        final int paymentAmount = paymentIntentData['amount'] ?? 0;

        await clearTheCartAPI(
          transactionId: paymentIntentData['id'],
          paymentStatus: paymentIntentData['status'],
          paymentMethod:
          paymentIntentData['payment_method_types']?[0] ?? 'card',
          paymentNotes: 'Stripe Payment',
          orderId: orderId,
          paymentAmount: paymentAmount, // ✅ Added this
        );
      } else {
        print(
            "❌ Failed to retrieve payment intent. Status code: ${response.statusCode}");
      }
    } on DioError catch (dioError) {
      print("❌ DioError occurred:");
      print("🔸 Message: ${dioError.message}");
      print("🔸 Status Code: ${dioError.response?.statusCode}");
      print("🔸 Response Data: ${dioError.response?.data}");
      print("🔸 Headers: ${dioError.response?.headers}");
    } catch (e) {
      print("❌ Unexpected error during payment processing: $e");
    }
  }

  RxInt selectedPromoIndex = (-1).obs;
  var selectedComingId;

  RxString enteredCode = ''.obs;
  var isApplyLoading = false;
  var isLoading = false;
  var appliedCouponCode = ''.obs;
  var appledCouponID = -1;
  var appledAmount;

  var couponDiscount = 0.0.obs;
  var totalAmount = 0.0.obs;
  var promoErrorText = '';
  final promoTextController = TextEditingController();

  void removeSelection(rewardID) {
    removeAppliedReward(rewardID);
  }

  PromoRewardModel response = PromoRewardModel();

  bool get isPromoApplied =>
      selectedPromoIndex.value != -1 || enteredCode.isNotEmpty;

//todo apply promo code
  applyPromoCode(code) async {
    isApplyLoading = true;
    update();
    try {
      promoErrorText = ''; // Reset error
      var clientId = await localStorage.getCId();
      var userId = await localStorage.getUId();
      Map<String, dynamic> map = {
        "promo_code": code,
        "cart_id": sendCartID,
        "user_id": userId,
        "client_id": "${clientId}"
      };
      Get.log("apply Cart list :$map");
      var response = await hiApplyCouponCodeAPI(map);
      if (response['success'] == true) {
        //todo promo code applied == True,
        appliedCouponCode.value = code;
        // appledCouponID = response['updated_items'][0]['promo_code_id'];
        // appledAmount = response['updated_items'][0]['total_discount'];
        totalAmount.value -= couponDiscount.value;
        isApplyLoading = false;
        promoTextController.clear();
        isUpdateSomething.value = true;
        rewardId = '';
        rewardName = '';
        await cartList(); // Ensure cartList completes before Get.back()
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
        // No need to update here if only showing a snackbar
      }
      // Removed redundant update() call from here
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
      // No need to update here if only showing a snackbar
    } finally {
      // Ensure isApplyLoading is reset and UI updates regardless of success/failure
      if (isApplyLoading) {
        // Only update if it was true, to avoid unnecessary rebuilds
        isApplyLoading = false;
        update();
      }
    }
  }

  // selectPromoCode(code, index, offerId, isSelected, cartId) async {
  //   isApplyLoading = true;
  //   update();
  //   try {
  //     print("Apply offer to cart1 $cartId");
  //     promoErrorText = ''; //todo Reset error
  //     var clientId = await localStorage.getCId();
  //     var userId = await localStorage.getUId();
  //
  //     Map<String, dynamic> map = {
  //       "promo_code": code,
  //       "cart_id": cartId.toString(),
  //       "user_id": userId.toString(),
  //       "client_id": clientId.toString(),
  //     };
  //     print("Apply offer to cart1");
  //     Get.log("apply Cart list :$map");
  //     var response = await hiApplyCouponCodeAPI(map);
  //     if (response['success'] == true) {
  //       selectedPromoIndex.value = index;
  //       offerselectedId.value = isSelected.toString();
  //       isApplyLoading = false;
  //       isUpdateSomething.value = true;
  //       promoErrorText = ''; // Reset error
  //       appliedName = couponAvailableData[index].title ?? '';
  //       applyPromo = true;
  //       applyReward = false;
  //       rewardId = '';
  //       rewardName = '';
  //       update();
  //       cartList();
  //       Get.back();
  //     } else {
  //       isUpdateSomething.value = false;
  //       // promoErrorText = "Invalid code. Please enter a valid promo code.";
  //       print("object: ${promoErrorText}");
  //       isApplyLoading = false;
  //       update();
  //     }
  //   } on Exception catch (e) {
  //     isUpdateSomething.value = false;
  //     isApplyLoading = false;
  //     update();
  //   }
  // }
  var isLoadingPromo = false;

// Improved selectPromoCode method
//   Future<void> selectPromoCode(code, index, offerId, isSelected, cartId) async {
//     if (isLoadingPromo) return;
//     isLoadingPromo = true;
//     update();
//     try {
//       print("Apply offer to cart1 $cartId");
//       promoErrorText = '';
//       var clientId = await localStorage.getCId();
//       var userId = await localStorage.getUId();
//       Map<String, dynamic> map = {
//         "promo_code": code,
//         "cart_id": cartId.toString(),
//         "user_id": userId.toString(),
//         "client_id": clientId.toString(),
//       };
//       Get.log("apply Cart list :$map");
//       var response = await hiApplyCouponCodeAPI(map);
//
//       if (response['success'] == true) {
//         selectedPromoIndex.value = index;
//         offerselectedId.value = isSelected.toString();
//         isUpdateSomething.value = true;
//         promoErrorText = '';
//         appliedName = couponAvailableData[index].title ?? '';
//         applyPromo = true;
//         applyReward = false;
//         isLoadingPromo = false;
//         rewardId = '';
//         rewardName = '';
//         await cartList();
//         update();
//         Get.back();
//       } else {
//         isUpdateSomething.value = false;
//         Get.snackbar(
//           "Invalid Promo Code",
//           "Please enter a valid promo code.",
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red.shade400,
//           colorText: Colors.white,
//           margin: const EdgeInsets.all(12),
//           duration: const Duration(seconds: 3),
//         );
//       }
//     } catch (e) {
//       print("Error selecting promo code: $e");
//       isUpdateSomething.value = false;
//       Get.snackbar(
//         "Error",
//         "Something went wrong. Please try again.",
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red.shade400,
//         colorText: Colors.white,
//         margin: const EdgeInsets.all(12),
//         duration: const Duration(seconds: 3),
//       );
//     } finally {
//       isLoadingPromo = false;
//       update();
//     }
//   }

  Future<void> selectPromoCode(code, index, offerId, isSelected, cartId) async {
    if (isLoadingPromo) return;
    isLoadingPromo = true;
    update();
    try {
      print("Apply offer to cart1 $cartId");
      promoErrorText = '';
      var clientId = await localStorage.getCId();
      var userId = await localStorage.getUId();

      // Create base map with required parameters
      Map<String, dynamic> map = {
        "promo_code": code,
        "user_id": userId.toString(),
        "client_id": clientId.toString(),
      };

      // Only add cart_id parameter if cartId is not null and not empty
      if (cartId != null && cartId.toString().isNotEmpty && cartId.toString() != "null") {
        map["cart_id"] = cartId.toString();
      }

      Get.log("apply Cart list :$map");
      var response = await hiApplyCouponCodeAPI(map);

      if (response['success'] == true) {
        selectedPromoIndex.value = index;
        offerselectedId.value = isSelected.toString();
        isUpdateSomething.value = true;
        promoErrorText = '';
        appliedName = couponAvailableData[index].title ?? '';
        applyPromo = true;
        applyReward = false;
        isLoadingPromo = false;
        rewardId = '';
        rewardName = '';
        await cartList();
        update();
        Get.back();
      } else {
        isUpdateSomething.value = false;
        Get.snackbar(
          "Invalid Promo Code",
          "Please enter a valid promo code.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print("Error selecting promo code: $e");
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
    } finally {
      isLoadingPromo = false;
      update();
    }
  }

  Future<void> applyAvailableCode(rewardId, index, cartId) async {
    if (isApplyLoading) return; // Prevent multiple calls

    isApplyLoading = true;
    update();

    try {
      var clientId = await localStorage.getCId();
      var userId = await localStorage.getUId();
      Map<String, dynamic> map = {
        "reward_id": rewardId,
        "cart_id": cartId,
        "user_id": userId,
        "client_id": "${clientId}",
      };

      Get.log("apply Cart list :$map");
      var response = await hiApplyAvailableAPI(map);

      if (response['success'] == true) {
        isUpdateSomething.value = true;
        selectedPromoIndex.value = index;
        selectedId.value = rewardId.toString();
        applyReward = true;
        applyPromo = false;
        promoId = '';
        promoname = '';
        promoErrorText = '';
        await cartList();
        Get.back();
      } else {
        isUpdateSomething.value = false;
        Get.snackbar(
          "Error",
          "Failed to apply reward. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade400,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print("Error applying available code: $e");
      isUpdateSomething.value = false;
    } finally {
      isApplyLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    _debounceTimer?.cancel();
    super.onClose();
  }

  Future<void> applyMembership(memId, cartId) async {
    if (isApplyLoading) return; // Prevent multiple calls

    isApplyLoading = true;
    update();

    try {
      var clientId = await localStorage.getCId();
      var userId = await localStorage.getUId();
      Map<String, dynamic> map = {
        "membership_id": memId,
        "cart_id": cartId,
        "user_id": userId,
        "client_id": "${clientId}",
      };

      Get.log("apply Cart list :$map");
      var response = await hiApplyMembershipAPI(map);

      if (response == null || response.toString() == "null") {
        await cartList();
        Get.back();
        return;
      }

      if (response['success'] == true) {
        isUpdateSomething.value = true;
        selectedId.value = rewardId.toString();
        rewardId = '';
        applyReward = true;
        await cartList();
        Get.back();
      } else {
        isUpdateSomething.value = false;
        print("Membership application failed: ${response.toString()}");
        Get.back();
      }
    } catch (e) {
      print("Error applying membership: $e");
      isUpdateSomething.value = false;
      Get.back();
    } finally {
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

  removeAppliedReward(rewardid) async {
    isApplyLoading = true;
    update();
    try {
      var respons =
      await hiRemoveCouponCodeAPI(rewardid, cartModel1.value.data!.cartId);
      print(respons['success']);
      if (respons['success'] == true) {
        isUpdateSomething.value = true;
        selectedPromoIndex.value = -1;
        rewardName = '';
        promoname = '';
        promoId = '';
        rewardId = '';
        applyPromo = false;
        applyReward = false;
        selectedId.value = null;
        isApplyLoading = false;
        selectedComingId = '';
        memberTitle = response.membership!.membershipTitle;
        applyMembership(
            response.membership!.membershipId, cartModel1.value.data!.cartId);
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
      var respons =
      await hitRemoveAddedCouponAPI(promoID, cartModel1.value.data!.cartId);
      if (respons['success'] == true) {
        isUpdateSomething.value = true;
        memberTitle = response.membership!.membershipTitle;
        promoErrorText = '';
        promoname = '';
        applyPromo = false;
        applyReward = false;
        rewardName = '';
        rewardName = '';
        applyMembership(
            response.membership!.membershipId, cartModel1.value.data!.cartId);
        isApplyLoading = false;
        await cartList(); // Ensure cartList completes before Get.back()
        Get.back();
        update();
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

  var memId = '';

  var memDiscount = '';

  String? promoname = '';

  var applyPromo;

  var promoId = '';

  var rewardId = '';

  var rewardName = '';

  var applyReward;

  // Future<void> couponAvailableRewards() async {
  //   isRewardLoading = true;
  //   try {
  //     couponAvailableData.clear();
  //     availableData.clear();
  //
  //     addToIdList();
  //
  //     response = await hitPromoRewardAPI(
  //       tId,
  //       pId,
  //       mId,
  //     );
  //
  //     isRewardLoading = false;
  //     couponAvailableData.addAll(response.offers ?? []);
  //     availableData.addAll(response.rewards ?? []);
  //
  //     Get.log("Available reward list => ${response.toJson()}");
  //     update();
  //   } catch (e) {
  //     isRewardLoading = false;
  //     update();
  //   }
  // }
  // Improved couponAvailableRewards with debounce
  Future<void> couponAvailableRewards() async {
    // Prevent multiple simultaneous API calls
    if (_isApiCallInProgress) {
      print("API call already in progress, skipping...");
      return;
    }

    // Cancel any pending debounced calls
    _debounceTimer?.cancel();

    // Debounce the API call
    _debounceTimer = Timer(Duration(milliseconds: 300), () async {
      await _performCouponAvailableRewardsAPI();
    });
  }

  Future<void> _performCouponAvailableRewardsAPI() async {
    if (_isApiCallInProgress) return;

    _isApiCallInProgress = true;
    isRewardLoading = true;

    try {
      couponAvailableData.clear();
      availableData.clear();

      addToIdList();

      response = await hitPromoRewardAPI(
        tId,
        pId,
        mId,
      );

      couponAvailableData.addAll(response.offers ?? []);
      availableData.addAll(response.rewards ?? []);

      Get.log("Available reward list => ${response.toJson()}");
    } catch (e) {
      print("Error in couponAvailableRewards: $e");
    } finally {
      isRewardLoading = false;
      _isApiCallInProgress = false;
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
