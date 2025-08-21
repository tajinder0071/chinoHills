import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CSS/color.dart';
import '../../../common_Widgets/common_button_widget.dart';
import '../Controller/cart_controller.dart';

class ConvenienceFeetBottomSheet extends StatelessWidget {
  const ConvenienceFeetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height * 0.35.h,
        // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.0.h),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                  const Spacer(),
                  const Text(
                    'CONVENIENCE FEE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
            Divider(),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                  Text(
                    'Convenience Fee',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${CartController.cart.totalConvenienceFee.value}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.0.h),
              child:  Text(
                'This fee is used to offset admin costs related to your treatment or service.',
                style: GoogleFonts.merriweather(
                  color: AppColor().black80,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Spacer(),
            Divider(),
            CommonButtonWidget(
              margin: 10.0,
              onTap: () => Get.back(),
              buttonName: "Got it",
            ),
          ],
        ),
      ),
    );
  }
}
