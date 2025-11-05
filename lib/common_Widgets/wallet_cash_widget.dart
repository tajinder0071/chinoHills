import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/util/common_page.dart';
import '../../../CSS/color.dart';
import '../Screens/cartList/Controller/Wallet_controller.dart';
import '../Screens/cartList/Controller/cart_controller.dart';

class WalletCashWidget extends StatelessWidget {
  final double availableAmount;
  final double subtotalAmount;
  final double nimaCashBalance;

  final VoidCallback? onApply;
  final GestureTapCallback? isEdit;
  final GestureTapCallback? onRemove;
  final bool isViewMode;
  final bool isAvailable;

  WalletCashWidget({
    super.key,
    required this.availableAmount,
    required this.subtotalAmount,
    required this.onApply,
    required this.isEdit,
    required this.onRemove,
    required this.isViewMode,
    required this.isAvailable, required this.nimaCashBalance,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WalletController());
    final cartController = Get.put(CartController());

    final RxBool isInputValid = false.obs;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(
            color: AppColor().greyColor.withOpacity(0.4),
            width: 1.h,
          ),
        ),
        child: Obx(
          () => Column(
            children: [
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 25.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Cash: ",
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: isAvailable
                                ? "You have ${formatCurrency(availableAmount)} available"
                                : "${formatCurrency(availableAmount)} applied",
                            style: GoogleFonts.roboto(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      isViewMode
                          ? TextButton(
                              onPressed: onApply,
                              child: Text(
                                "APPLY",
                                style: TextStyle(
                                  color: AppColor().blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.h),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: isEdit,
                                    child: Text(
                                      "EDIT",
                                      style: TextStyle(
                                        color: AppColor().blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  InkWell(
                                    onTap: onRemove,
                                    child: Text(
                                      "REMOVE",
                                      style: TextStyle(
                                        color: AppColor().blackColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                    ],
                  ),
                ],
              ),

              // Edit Section
              controller.isEditing.value
                  ? Column(
                      children: [
                        Divider(
                          color: Colors.grey.shade300,
                          thickness: 1,
                          height: 20,
                        ),
                        Form(
                          key: _formKey,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      10.w, 8.h, 10.w, 16.h),
                                  child: TextFormField(
                                    controller: controller.amountController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Amount \$',
                                      labelStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14.sp,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.w,
                                        vertical: 6.h,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.w,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1.2.w,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.black87,
                                    ),
                                    cursorColor: Colors.black,
                                    cursorHeight: 20.h,

                                    onChanged: (value) {
                                      final amount = double.tryParse(value);
                                      if (amount == null ||
                                          amount <= 0 ||
                                          amount > subtotalAmount ||
                                          amount > nimaCashBalance) {
                                        isInputValid.value = false;
                                      } else {
                                        isInputValid.value = true;
                                      }
                                      _formKey.currentState?.validate();
                                    },
                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "Please enter an amount";
                                      }
                                      final amount = double.tryParse(value);
                                      if (amount == null) {
                                        return "Please enter a valid number";
                                      }
                                      if (amount <= 0) {
                                        return "Amount must be greater than zero";
                                      }
                                      if (amount > subtotalAmount) {
                                        return "Amount exceeds maximum eligible amount: \$${subtotalAmount.toInt()}";
                                      }
                                      if (amount > nimaCashBalance) {
                                        return "Amount exceeds available cash";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),

                              // Apply Button
                              Obx(
                                () => InkWell(
                                  onTap: isInputValid.value
                                      ? () async {
                                          if (_formKey.currentState!.validate()) {
                                            double editedAmount = double.parse(controller.amountController.text);
                                            await controller.applyEditedCash(editedAmount);
                                            cartController.cartList();
                                            controller.amountController.clear();
                                            controller.isEditing.value = false;
                                          }
                                        }
                                      : null,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 10.h, top: 18.h),
                                    child: Text(
                                      "APPLY",
                                      style: TextStyle(
                                        color: isInputValid.value
                                            ? AppColor().blackColor
                                            : Colors.grey, // disabled look
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
