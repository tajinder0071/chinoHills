import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/common_Widgets/common_badge_container.dart';
import 'package:share_plus/share_plus.dart';

import '../CSS/appTypography.dart';

class CommonReferWidget extends StatelessWidget {
  const CommonReferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 650.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.dynamicColor,
        // borderRadius: BorderRadius.circular(8.r),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative top image
          Positioned.fill(
              child: Image.asset(
            "assets/new_images/schedule_background.png",
            fit: BoxFit.fill,
          )),

          // Small top-left icon
          Positioned(
              top: 60.h,
              left: 16.w,
              child: CommonBadgeContainer(
                icon: Icons.local_offer_outlined,
                iconSize: 15.h,
              )),

          // Main image (person)
          Positioned(
            bottom: 90.h,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/Mask group (1).png',
              width: 350.w,
              fit: BoxFit.contain,
            ),
          ),

          // Text overlay (moved lower to overlap image)
          Positioned(
            top: 130.h,
            left: 16.w,
            right: 16.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "REFER TO\nA FRIEND",
                  style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                    color: AppColor().whiteColor,
                    fontSize: 26.sp,
                    letterSpacing: 1,
                    height: 1.h,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Send A Friend \$25\nTowards Any Services",
                  style: AppTypography.hostGroteskRegular.copyWith(
                    color: AppColor().whiteColor,
                    fontSize: 16.sp,
                    height: 1.h,
                  ),
                ),
              ],
            ),
          ),

          // Button (above bottom edge)
          Positioned(
            bottom: 90.h,
            left: 0,
            right: 0,
            child: Center(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColor().whiteColor, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 13.h,
                    horizontal: 90.w,
                  ),
                ),
                onPressed: () async {
                  final box = context.findRenderObject() as RenderBox?;
                  await Share.share(
                    Platform.isAndroid
                        ? "https://play.google.com/store/apps/details?id=com.app.nima"
                        : "https://apps.apple.com/us/app/nima-newport/id6745820609",
                    subject:
                        "Discover Nima – Book appointments & packages easily",
                    // iOS requires non-empty title
                    sharePositionOrigin:
                        box!.localToGlobal(Offset.zero) & box.size,
                  );
                },
                child: Text(
                  "Send To A Friend",
                  style: AppTypography.hostGroteskSemiBold.copyWith(
                    color: AppColor().whiteColor,
                    fontSize: 15.sp,
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
