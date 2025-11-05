import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../CSS/color.dart';
import '../../../CSS/image_page.dart';
import '../../../util/route_manager.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.noDataFoundBg),
                      colorFilter: ColorFilter.mode(
                        AppColor.dynamicColor,
                        BlendMode.srcIn,
                      ))),
              child: Icon(
                Iconsax.shopping_bag,
                size: 60.h,
                color: AppColor().whiteColor,
              ),
            ),
          ),
          //Image.asset("assets/images/file.png", height: 120.h),
          SizedBox(height: 7.h),
          Center(
            child: Text("YOUR CART IS EMPTY",
                style: GoogleFonts.sarabun(
                    fontSize: 19.sp,
                    color: AppColor().blackColor,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 10.h),
          Center(
            child: Text("You Have No Item’s In Your Cart\nAt The Moment",
                textAlign: TextAlign.center,
                style: GoogleFonts.sarabun(
                    fontSize: 15.sp, color: Colors.black.withValues(alpha: 0.65))),
          ),
          // Shop Now button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.h, vertical: 20.w),
            child: SizedBox(
              height: 50.h,
              width: 252.w,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dynamicColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                  elevation: 14,
                  shadowColor: AppColor().blackColor.withValues(alpha: 0.6),
                ),
                onPressed: () {
                  Get.offAllNamed(RouteManager.dashBoardPage, arguments: 2);
                },
                child: Text(
                  "SHOP NOW",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
