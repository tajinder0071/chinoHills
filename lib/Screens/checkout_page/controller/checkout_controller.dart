import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:chino_hills/Model/cart_model.dart';

import '../Widgets/confirm_order.dart';

class CheckoutController extends GetxController {
  // Text Controllers
  final emailController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expDateController = TextEditingController();
  final cvcController = TextEditingController();

  // State Variables
  var saveAddress = true.obs;
  var selectedPaymentMethod = 0.obs; // 0 = card, 1 = Affirm
  var selectedCountry = "India".obs;

  // Order Summary (you can load from API in real app)
  final orderItems = [
    {"title": "AquaGold® x 1", "price": 350.00},
    {"title": "AquaGold® W/ Botox & HA x 1", "price": 495.00},
  ];

  double get subtotal =>
      orderItems.fold(0.0, (sum, item) => sum + (item["price"] as double));

  double get discount => 126.75;

  double get fee => 17.96;

  double get total => subtotal - discount + fee;

  placeOrder(RxList<Item> cartData) {
    // Handle API Call
    Get.to(OrderConfirmationPage(cartData: cartData));
  }
}
