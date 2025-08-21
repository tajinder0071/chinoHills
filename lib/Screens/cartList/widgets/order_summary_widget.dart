import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../util/common_page.dart';
import '../Controller/cart_controller.dart';
import 'conveniece_feet_bottom_sheet.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Order Summary (${CartController.cart.cartItemCount.value})',
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Divider(height: 24.h, thickness: 1.2),
                _buildRow('Subtotal',
                    formatCurrency(CartController.cart.totalCost.value)),
                Obx(() {
                  final promoCode =
                      CartController.cart.cartModel1.value.promoCode;
                  final availableReward =
                      CartController.cart.cartModel1.value.reward;

                  if (promoCode != null || availableReward != null) {
                    final discount = CartController
                        .cart.cartModel1.value.appliedCartDiscountValue;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Row(
                            children: [
                              Text(
                                'Discount (Promotion)',
                                style:
                                    GoogleFonts.merriweather(fontSize: 13.sp),
                              ),
                              SizedBox(width: 4.w),
                            ],
                          ),
                        ),
                        Text(
                          "- ${formatCurrency(discount)}",
                          style:
                              TextStyle(fontSize: 13.sp, color: Colors.green),
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }),
                SizedBox(height: 12.h),
                Row(
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
                            style: GoogleFonts.merriweather(fontSize: 13.sp),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.info_outline,
                              size: 18.h, color: Colors.grey)
                        ],
                      ),
                    ),
                    Text(
                        formatCurrency(
                            CartController.cart.totalConvenienceFee.value),
                        style: TextStyle(fontSize: 13.sp)),
                  ],
                ),
                Divider(height: 32.h, thickness: 1.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Order Total',
                        style: GoogleFonts.roboto(
                            fontSize: 13.sp, fontWeight: FontWeight.bold)),
                    Text(
                      formatCurrency(CartController.cart.finalTotalCost.value),
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
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
                              style: GoogleFonts.roboto(
                                  fontSize: 10.sp,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            )
                          : SizedBox.shrink(),
                      controller.isMemberAvailable
                          ? SizedBox(height: 10.h)
                          : SizedBox.shrink(),
                    ],
                  );
                }),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.0.w, vertical: 6.0.h),
                  child: Text(
                    "Important Terms and Conditions: All financing subject to credit approval. APRs depend on creditworthiness, term length, and other factors. “As low as” does not guarantee your rate or payment options as this is dependent on your creditworthiness. Check with your provider about additional amounts required for procedure that may be ineligible for financing. Scheduled payments in example based on the full 24-month term. Length of financing is up to you and/or your creditworthiness.",
                    style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          //TODO ?? Here we define treatment on click
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: CommonTermsConditionWidget(),
          ),
          SizedBox(height: 20.h),
          getBrand(),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.merriweather(fontSize: 13.sp)),
        Text(amount, style: TextStyle(fontSize: 13.sp)),
      ],
    );
  }
} //
