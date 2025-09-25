import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Model/cart_model.dart';
import '../../util/common_page.dart';
import 'controller/checkout_controller.dart';
import 'package:flutter/services.dart';

class CheckoutPage extends StatelessWidget {
  final CheckoutController controller = Get.put(CheckoutController());
  RxList<Item> cartData;
  var discountName, totalCost, discountFee, convenceFee, finalCost;

  CheckoutPage(this.cartData, this.discountName, this.totalCost,
      this.discountFee, this.convenceFee, this.finalCost);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().whiteColor,
      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text("CHECKOUT", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Details
            Text("Contact details",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Confirm your details to receive your sales receipt"),
            SizedBox(height: 10),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            Obx(() => Row(
                  children: [
                    Checkbox(
                      checkColor: AppColor().whiteColor,
                      activeColor: AppColor().blueColor,
                      value: controller.saveAddress.value,
                      onChanged: (val) =>
                          controller.saveAddress.value = val ?? false,
                    ),
                    Text("Save address to your account"),
                  ],
                )),
            SizedBox(height: 20),

            // Payment Method
            Text("Payment method",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Obx(() => Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectedPaymentMethod.value = 0,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    controller.selectedPaymentMethod.value == 0
                                        ? Colors.blue
                                        : Colors.grey,
                                width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.credit_card,
                                  color:
                                      controller.selectedPaymentMethod.value ==
                                              0
                                          ? AppColor().blueColor
                                          : AppColor().greyColor),
                              SizedBox(width: 8),
                              Text(
                                "Card",
                                style: TextStyle(
                                    color: controller
                                                .selectedPaymentMethod.value ==
                                            0
                                        ? AppColor().blueColor
                                        : AppColor().greyColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectedPaymentMethod.value = 1,
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    controller.selectedPaymentMethod.value == 1
                                        ? Colors.blue
                                        : Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.account_balance_wallet,
                                  color:
                                      controller.selectedPaymentMethod.value ==
                                              1
                                          ? Colors.blue
                                          : Colors.grey),
                              SizedBox(width: 8),
                              Text("Affirm"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 15),

            // Card Details
            Obx(() => controller.selectedPaymentMethod.value == 0
                ? Column(
                    children: [
                      TextField(
                        controller: controller.cardNumberController,
                        decoration: InputDecoration(
                          labelText: "Card number",
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.expDateController,
                              decoration: InputDecoration(
                                labelText: "Expiration date (MM/YY)",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ExpiryDateFormatter(),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: controller.cvcController,
                              decoration: InputDecoration(
                                labelText: "Security code (CVC)",
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Obx(() => DropdownButtonFormField<String>(
                            value: controller.selectedCountry.value,
                            decoration: InputDecoration(
                              labelText: "Country",
                              border: OutlineInputBorder(),
                            ),
                            items: ["India", "USA", "UK", "Canada"]
                                .map((country) => DropdownMenuItem(
                                      child: Text(country),
                                      value: country,
                                    ))
                                .toList(),
                            onChanged: (value) =>
                                controller.selectedCountry.value = value!,
                          )),
                    ],
                  )
                : SizedBox.shrink()),

            SizedBox(height: 20),

            // Order Summary
            Text("Order Summary (${cartData.length})",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: cartData
                  .map((item) => ListTile(
                        title: Text(item.name.toString()),
                        trailing: Text("\$${item.price}"),
                      ))
                  .toList(),
            ),
            Divider(),
            ListTile(
              title: Text("Subtotal"),
              trailing: Text(formatCurrency(totalCost)),
            ),
            ListTile(
              title: Text(discountName.toString()),
              trailing: Text(
                "-${discountFee}",
                style: TextStyle(color: Colors.green),
              ),
            ),
            ListTile(
              title: Text("Convenience Fee"),
              trailing: Text(convenceFee),
            ),
            Divider(),
            ListTile(
              title: Text("Order Total",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: Text(finalCost.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            SizedBox(height: 20),

            // Place Order Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.placeOrder(cartData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dynamicColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  "Place order",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (text.length > 4) {
      text = text.substring(0, 4);
    }

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2) formatted += '/';
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
