import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/Model/cart_model.dart';
import 'package:chino_hills/Screens/cartList/Controller/cart_controller.dart';
import '../../../CSS/appTypography.dart';
import '../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../util/common_page.dart';
import 'conveniece_feet_bottom_sheet.dart';

class OrderSummaryCard extends StatelessWidget {
  List<Item> cartData;
  var offerType, discountPrice, nimaCashAppliedAmount;
  bool isNimaCashApplied;

  OrderSummaryCard(this.cartData, this.offerType, this.discountPrice,
      {super.key, required this.isNimaCashApplied, this.nimaCashAppliedAmount});

  @override
  Widget build(BuildContext context) {
    // List discountList = cartData.map((item) => item.discountPrice).toList();
    var totalDiscount = discountPrice;
    return Container(
      margin: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Summary (${CartController.cart.cartItemCount})',
                  style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                Divider(height: 24.h, thickness: 1.2),
                _buildRow(
                    'Subtotal',
                    formatCurrency(CartController.cart.totalCost),
                    Colors.black),
                '$totalDiscount' == "0.0"
                    ? SizedBox.shrink()
                    : SizedBox(height: 12.h),
                '$totalDiscount' == "0.0"
                    ? SizedBox.shrink()
                    : _buildRow(
                        offerType.toString() == "Promo Code"
                            ? 'Discount (Promotion)'
                            : offerType.toString() == 'Membership'
                                ? 'Membership Discount'
                                : 'Discount (Reward)',
                        formatCurrency('-$totalDiscount'),
                        Colors.green),
                CartController.cart.totalConvenienceFee.toString() == "0" ||
                        CartController.cart.totalConvenienceFee.toString() ==
                            "0.0"
                    ? SizedBox.shrink()
                    : SizedBox(height: 12.h),
                CartController.cart.totalConvenienceFee.toString() == "0.0" ||
                        CartController.cart.totalConvenienceFee.toString() ==
                            "0"
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.bottomSheet(
                                ConvenienceFeetBottomSheet(),
                                isScrollControlled: true,
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Convenience Fee',
                                  style: AppTypography.hostGroteskSemiBold
                                      .copyWith(fontSize: 13.sp),
                                ),
                                SizedBox(width: 4.w),
                                Icon(Icons.info_outline,
                                    size: 18.h, color: Colors.grey)
                              ],
                            ),
                          ),
                          Text(
                            formatCurrency(
                                CartController.cart.totalConvenienceFee),
                            style: AppTypography.hostGroteskRegular
                                .copyWith(fontSize: 13.sp),
                          ),
                        ],
                      ),
                isNimaCashApplied ? SizedBox(height: 12.h) : SizedBox.shrink(),
                isNimaCashApplied
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'NimaCash Balance',
                            style: AppTypography.hostGroteskSemiBold
                                .copyWith(fontSize: 13.sp),
                          ),
                          Text(
                            "-${formatCurrency(nimaCashAppliedAmount)}",
                            style: AppTypography.hostGroteskRegular
                                .copyWith(fontSize: 13.sp, color: Colors.green),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                CartController.cart.finalTotalCost.toString().startsWith("-") ||
                        CartController.cart.finalTotalCost.toString() == "0" ||
                        CartController.cart.totalConvenienceFee.toString() ==
                            "0.0"
                    ? SizedBox.shrink()
                    : Divider(height: 32.h, thickness: 1.2),
                CartController.cart.finalTotalCost.toString().startsWith("-") ||
                        CartController.cart.finalTotalCost.toString() == "0" ||
                        CartController.cart.totalConvenienceFee.toString() ==
                            "0.0"
                    ? SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order Total',
                              style: AppTypography.hostGroteskSemiBold.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            formatCurrency(CartController.cart.finalTotalCost),
                            style: AppTypography.hostGroteskRegular.copyWith(
                                fontSize: 13.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Text(
                      "Treat now, pay later with",
                      style: AppTypography.hostGroteskSemiBold.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                        "assets/images/affirm_logo.png",
                        height: 20.h,
                      ),
                    ),
                  ],
                ),
                GetBuilder<CartController>(builder: (controller) {
                  DateTime now = DateTime.now();
                  DateTime nextMonthDate =
                      DateTime(now.year, now.month + 1, now.day);

                  String formattedDate =
                      "${nextMonthDate.day.toString().padLeft(2, '0')}/${nextMonthDate.month.toString().padLeft(2, '0')}/${nextMonthDate.year.toString().substring(2)}";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.isMemberAvailable
                          ? Text(
                              '${controller.memberTitle} will renew on $formattedDate at ${controller.memberPrice}/month',
                              style: AppTypography.hostGroteskSemiBold.copyWith(
                                fontSize: 10.sp,
                                color: Colors.black54,
                              ),
                            )
                          : SizedBox.shrink(),
                      controller.isMemberAvailable
                          ? SizedBox(height: 10.h)
                          : SizedBox.shrink(),
                    ],
                  );
                }),
                SizedBox(height: 20.h),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.0.w, vertical: 6.0.h),
                  child: Text(
                    AppStrings.ImpTermCondition,
                    style: AppTypography.hostGroteskRegular
                        .copyWith(fontSize: 12.sp, color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          // Terms and conditions
          GetBuilder<CartController>(
            builder: (controller) {
              return CommonTermsConditionWidget(
                isneed: true,
                isActivated: controller.isAccepted,
                onChange: (val) {
                  controller.isAccepted = val ?? false;
                  controller.update(); // ✅ trigger UI rebuild
                },
              );
            },
          ),

          SizedBox(height: 20.h),
          getBrand(),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String amount, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: AppTypography.hostGroteskSemiBold.copyWith(fontSize: 13.sp)),
        Text(amount,
            style: AppTypography.hostGroteskRegular
                .copyWith(fontSize: 13.sp, color: color)),
      ],
    );
  }
}
