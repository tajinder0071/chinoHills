import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/common_Widgets/common_badge_container.dart';
import 'package:chino_hills/common_Widgets/common_button_widget.dart';

class ScheduleSection extends StatelessWidget {
  const ScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(Get.context!).size;
    return Scaffold(
        backgroundColor: AppColor.dynamicColor,
        body: Stack(
          children: [
            Positioned(
                top: 0.h,
                left: 0.w,
                right: 0.w,
                child: Image.asset(
                  "assets/new_images/schedule_girl_image_bg.png",
                  fit: BoxFit.fill,
                )),
            Positioned.fill(
                child: Image.asset(
              "assets/new_images/schedule_background.png",
              fit: BoxFit.fill,
            )),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor().blackColor.withValues(alpha: 0.40),
                      AppColor().blackColor.withValues(alpha: 0.40),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                top: 60.h,
                left: 15.w,
                right: 15.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonBadgeContainer(
                      icon: Icons.local_offer_outlined,
                      iconSize: 15.h,
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      "SCHEDULE\nYOUR VISIT",
                      textAlign: TextAlign.start,
                      style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                          fontSize: 26.sp,
                          color: AppColor().whiteColor,
                          height: 0.9.h),
                    ),
                    SizedBox(height: size.height * 0.5),
                    Center(
                      child: CommonButtonWidget(
                        innerColor: AppColor.dynamicColor,
                        onTap: () {},
                        buttonName: "Book Now!",
                        width: 330.w,
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
