import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Model/cart_model.dart';
import 'package:chino_hills/Screens/Account/controller/account_detail_controller.dart';
import 'package:chino_hills/util/local_stoage.dart';
import '../../CSS/appTypography.dart';
import '../../common_Widgets/common_terms_condition_widget.dart';
import '../../common_Widgets/common_text_field.dart';
import '../../common_Widgets/common_webViewUrl.dart';
import '../../common_Widgets/phone_number_firmate.dart';
import '../../util/common_page.dart';
import '../../util/services.dart';
import 'controller/checkout_controller.dart';
import 'package:flutter/services.dart';

class CheckoutPage extends StatelessWidget {
  final CheckoutController controller = Get.put(CheckoutController());
  RxList<Item> cartData;
  var discountName,
      totalCost,
      discountFee,
      convenceFee,
      finalCost,
      sendCartID,
      finalTotalCost,
      nimaCash;

  CheckoutPage(
      this.cartData,
      this.discountName,
      this.totalCost,
      this.discountFee,
      this.convenceFee,
      this.finalCost,
      this.sendCartID,
      this.finalTotalCost,
      this.nimaCash);

  AccountDetailController accountController =
      Get.put(AccountDetailController());

  @override
  Widget build(BuildContext context) {
    controller.requestPermission();
    accountController.getDetail();
    return Scaffold(
      backgroundColor: AppColor().whiteColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text("CHECKOUT",
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
              color: Colors.black,
              fontSize: 15.sp,
            )),
        backgroundColor: AppColor().whiteColor,
        elevation: 0,
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.all(8.h),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Contact Details
                Text("Contact details",
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 16.sp,
                    )),
                SizedBox(height: 8.h),
                Text(
                  "Confirm your details to receive your sales receipt",
                  style: AppTypography.hostGroteskRegular
                      .copyWith(fontSize: 12.sp),
                ),
                SizedBox(height: 10.h),
                CommonTextField(
                  controller: controller.emailController,
                  formate: [EmailInputFormatter()],
                  text: "Email",
                  autofillHints: [AutofillHints.email],
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  isDateField: false,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() => Row(
                      children: [
                        Checkbox(
                          checkColor: AppColor().whiteColor,
                          activeColor: AppColor.dynamicColor,
                          value: controller.saveAddress.value,
                          onChanged: (val) =>
                              controller.saveAddress.value = val ?? false,
                        ),
                        Text(
                          "Save address to your account",
                          style: AppTypography.hostGroteskRegular
                              .copyWith(fontSize: 12.sp),
                        ),
                      ],
                    )),
                SizedBox(height: 10.h),
                Divider(
                  height: 2.h,
                ),
                SizedBox(height: 10.h),
                SizedBox(height: 10.h),
                // Payment Method
                Text("Payment method",
                    style: AppTypography.hostGroteskSemiBold.copyWith(
                      fontSize: 16.sp,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Obx(() => Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                controller.selectedPaymentMethod.value = 0,
                            child: Container(
                              padding: EdgeInsets.all(12.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller
                                                .selectedPaymentMethod.value ==
                                            0
                                        ? AppColor.dynamicColor
                                        : Colors.grey,
                                    width: 2.w),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.credit_card,
                                      color: controller.selectedPaymentMethod
                                                  .value ==
                                              0
                                          ? AppColor.dynamicColor
                                          : AppColor().greyColor),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Card",
                                    style: AppTypography.hostGroteskSemiBold
                                        .copyWith(
                                            color: controller
                                                        .selectedPaymentMethod
                                                        .value ==
                                                    0
                                                ? AppColor.dynamicColor
                                                : AppColor().greyColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                controller.selectedPaymentMethod.value = 1,
                            child: Container(
                              padding: EdgeInsets.all(12.h),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: controller
                                                .selectedPaymentMethod.value ==
                                            1
                                        ? AppColor.dynamicColor
                                        : AppColor().greyColor),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.account_balance_wallet,
                                      color: controller.selectedPaymentMethod
                                                  .value ==
                                              1
                                          ? AppColor.dynamicColor
                                          : AppColor().greyColor),
                                  SizedBox(width: 8.w),
                                  Text(
                                    "Affirm",
                                    style: AppTypography.hostGroteskSemiBold
                                        .copyWith(
                                            fontSize: 12.sp,
                                            color: controller
                                                        .selectedPaymentMethod
                                                        .value ==
                                                    1
                                                ? AppColor.dynamicColor
                                                : AppColor().greyColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                SizedBox(height: 15.h),
                Obx(() => controller.selectedPaymentMethod.value == 0
                    ? CardFormField(
                        key: ValueKey(Theme.of(context).primaryColor),
                        style: CardFormStyle(
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          borderColor: Colors.grey.shade400,
                          borderRadius: 10,
                          borderWidth: 1,
                          cursorColor: AppColor().blackColor,
                          textColor: AppColor().blackColor,
                          placeholderColor: AppColor().blackColor,
                          fontSize: 16,
                        ),
                        onCardChanged: (card) {
                          controller.cardComplete = card?.complete ?? false;
                        },
                        controller: controller.cardFormEditController,
                      )
                    : Row(
                        children: [
                          Image.network(
                            "https://cdn-icons-png.flaticon.com/512/4341/4341764.png",
                            height: 40.h,
                            color: AppColor().mediumGreyColor,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              "After submission, you will be redirected to securely complete next steps.",
                              style: AppTypography.hostGroteskSemiBold.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor().mediumGreyColor),
                            ),
                          )
                        ],
                      )),
                SizedBox(
                  height: 15.h,
                ),
                Divider(
                  height: 2.h,
                ),
                SizedBox(
                  height: 15.h,
                ),
                // Order Summary
                Text("Order Summary (${cartData.length})",
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 15.sp,
                    )),
                SizedBox(height: 10.h),
                Column(
                  children: cartData
                      .map((item) => ListTile(
                            title: Text(
                              item.name.toString(),
                              style: AppTypography.hostGroteskRegular
                                  .copyWith(fontSize: 12.sp),
                            ),
                            trailing: Text(
                              "\$${item.price.toString().replaceAll(".0", "")}",
                              style: AppTypography.hostGroteskRegular
                                  .copyWith(fontSize: 13.sp),
                            ),
                          ))
                      .toList(),
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Subtotal",
                    style: AppTypography.hostGroteskSemiBold
                        .copyWith(fontSize: 12.sp),
                  ),
                  trailing: Text(
                    formatCurrency(totalCost),
                    style: AppTypography.hostGroteskRegular
                        .copyWith(fontSize: 13.sp),
                  ),
                ),
                discountFee == "-\$0.00" || discountFee == "-\$0"
                    ? SizedBox.shrink()
                    : ListTile(
                        title: Text(
                          discountName.toString(),
                          style: AppTypography.hostGroteskSemiBold
                              .copyWith(fontSize: 12.sp),
                        ),
                        trailing: Text(
                          "${discountFee}",
                          style: AppTypography.hostGroteskSemiBold
                              .copyWith(color: Colors.green, fontSize: 13.sp),
                        ),
                      ),
                convenceFee.toString() == "\$0"
                    ? SizedBox.shrink()
                    : ListTile(
                        title: Text(
                          "Convenience Fee",
                          style: AppTypography.hostGroteskSemiBold
                              .copyWith(fontSize: 12.sp),
                        ),
                        trailing: Text(
                          convenceFee,
                          style: AppTypography.hostGroteskRegular
                              .copyWith(fontSize: 13.sp),
                        ),
                      ),
                nimaCash.toString() == "0.0"
                    ? SizedBox.shrink()
                    : ListTile(
                        title: Text(
                          "Nima Cash",
                          style: AppTypography.hostGroteskSemiBold
                              .copyWith(fontSize: 12.sp),
                        ),
                        trailing: Text(
                          nimaCash.toString().replaceAll(".0", ""),
                          style: AppTypography.hostGroteskRegular
                              .copyWith(fontSize: 13.sp),
                        ),
                      ),
                finalCost.toString().startsWith("-") ||
                        finalCost.toString() == "\$0"
                    ? SizedBox.shrink()
                    : Divider(),
                finalCost.toString().startsWith("-") ||
                        finalCost.toString() == "\$0"
                    ? SizedBox.shrink()
                    : ListTile(
                        title: Text("Order Total",
                            style: AppTypography.hostGroteskSemiBold.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 12.sp)),
                        trailing: Text(finalCost.toString(),
                            style: AppTypography.hostGroteskSemiBold.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 14.sp)),
                      ),
                SizedBox(height: 20.h),

                // Place Order Button

                GetBuilder<CheckoutController>(builder: (controller) {
                  return CommonTermsConditionWidget(
                    isneed: true,
                    isActivated: controller.isAccepted,
                    onChange: (val) {
                      controller.isAccepted = val ?? false;
                      controller.update();
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        GetBuilder<CheckoutController>(
          builder: (controller) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.h),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: controller.isAccepted
                    ? () async {
                        LocalStorage localStorage = LocalStorage();
                        var userId = await localStorage.getUId();
                        var clientId = await localStorage.getCId();
                        var orderId = await localStorage.getOId();
                        print("Hello");
                        // controller.placeOrder(cartData);
                        if (controller.formKey.currentState!.validate()) {
                          print("Hello");
                          if (controller.selectedPaymentMethod.value == 1) {
                            if (controller.currentLocation != null) {
                              /*   var url = controller.currentLocation!.country
                                          .toString() ==
                                      "US"
                                  ? "https://devnima.scanacart.com/affirm/affirmCheckout.cfm?phone=${accountController.phoneController.text.trim()}&email=${controller.emailController.text.trim()}&firstname=${accountController.firstNameController.text.toString().trim()}&lastname=${accountController.lastNameController.text.toString().trim()}&dob=${accountController.dobController.text.toString().trim()}&address=${controller.currentLocation?.street!.trim()}&city=${controller.currentLocation?.locality!.toString().trim()}&state=${controller.currentLocation?.administrativeArea!.trim()}&zipcode=${controller.currentLocation?.postalCode!.trim()}&country=${controller.currentLocation!.country.toString()}&client_id=$clientId&user_id=$userId&order_id=$orderId&total_amount=${finalCost.toString().replaceAll('\$', '')}"
                                  : "https://devnima.scanacart.com/affirm/affirmCheckout.cfm?phone=${accountController.phoneController.text.trim()}&email=${controller.emailController.text.trim()}&firstname=${accountController.firstNameController.text.toString().trim()}&lastname=${accountController.lastNameController.text.toString().trim()}&dob=${accountController.dobController.text.toString().trim()}&address=123%20Main%20St&city=San%20Francisco&state=CA&zipcode=94111&country=USA&client_id=$clientId&user_id=$userId&order_id=$orderId&total_amount=${finalCost.toString().replaceAll('\$', '')}";*/
                              var url = controller.currentLocation!.country
                                          .toString() ==
                                      "US"
                                  ? "https://nimawellness.com/affirm/affirmCheckout.cfm?phone=${accountController.phoneController.text.trim()}&email=${controller.emailController.text.trim()}&firstname=${accountController.firstNameController.text.toString().trim()}&lastname=${accountController.lastNameController.text.toString().trim()}&dob=${accountController.dobController.text.toString().trim()}&address=${controller.currentLocation?.street!.trim()}&city=${controller.currentLocation?.locality!.toString().trim()}&state=${controller.currentLocation?.administrativeArea!.trim()}&zipcode=${controller.currentLocation?.postalCode!.trim()}&country=${controller.currentLocation!.country.toString()}&client_id=$clientId&user_id=$userId&order_id=$orderId&total_amount=${finalCost.toString().replaceAll('\$', '')}"
                                  : "https://nimawellness.com/affirm/affirmCheckout.cfm?phone=${accountController.phoneController.text.trim()}&email=${controller.emailController.text.trim()}&firstname=${accountController.firstNameController.text.toString().trim()}&lastname=${accountController.lastNameController.text.toString().trim()}&dob=${accountController.dobController.text.toString().trim()}&address=123%20Main%20St&city=San%20Francisco&state=CA&zipcode=94111&country=USA&client_id=$clientId&user_id=$userId&order_id=$orderId&total_amount=${finalCost.toString().replaceAll('\$', '')}";
                              Get.to(WebViewPage(
                                url: url,
                                title: "Payment",
                              ));
                            } else {
                              controller.requestPermission();
                            }
                          } else if (controller.selectedPaymentMethod.value ==
                              0) {
                            if (controller.cardComplete == true) {
                              print("final cost:$finalTotalCost");
                              controller.makePayment(
                                  orderId, sendCartID, finalTotalCost);
                            } else {
                              showMessage("Please enter complete card details",
                                  context);
                            }
                          }
                        }
                      }
                    : () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isAccepted
                        ? AppColor.dynamicColor
                        : AppColor().mediumGreyColor,
                    disabledBackgroundColor: AppColor.disableButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                    shadowColor: AppColor.dynamicColor,
                    padding: EdgeInsets.all(13.h)),
                child: controller.isCartClearLoading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          color: AppColor().whiteColor,
                        ),
                      )
                    : Text(
                        "Place order",
                        style: AppTypography.hostGroteskSemiBold.copyWith(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        )
      ],
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
