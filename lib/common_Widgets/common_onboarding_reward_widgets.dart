/*
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Screens/Signup Reward Page/controller/signup_reward_controller.dart';

class RewardOnboardingScreen extends StatelessWidget {
  RewardOnboardingScreen({super.key});

  final controller = Get.put(RewardUnlockedController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/pngs/reward_background_image.png"),
        Positioned(
          top: 90.h,
          left: 15.w,
          child: Text(
            "FREE\nREWARD\nFOR NEW\nMEMBERS!",
            style: GoogleFonts.sarabun(
                fontSize: 44.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.65),
                height: 1.0
            ),
          ),
        ),

        Positioned(
          bottom: -4,
          right: 0,
          left: 0,
          child: Image.asset("assets/images/pngs/star.png"),
        ),
        Positioned(
          top: 280.h,
          left: 15.w,
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: InkWell(
              onTap: controller.currentPage.value < 3
                  ? () =>
                  controller.jumpToPage(controller.currentPage.value + 1)
                  : null,
              child: Container(
                height: 52.h,
                width: 52.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GiftScreen extends StatelessWidget {
  GiftScreen({super.key});

  final controller = Get.put(RewardUnlockedController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/pngs/reward_background_image.png"),
        Positioned(
          top: 90.h,
          left: 15.w,
          child: Text(
            "EARN\nREWARDS\nFOR VISITS\nAND\nPURCHASES",
            style: GoogleFonts.sarabun(
                fontSize: 44.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.65),
                height: 1.0

            ),
          ),
        ),

        Positioned(
          bottom: -4,
          right: 0,
          left: 0,
          child: Image.asset("assets/images/pngs/gift.png"),
        ),
        Positioned(
          top: 320.h,
          left: 15.w,
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: InkWell(
              onTap: controller.currentPage.value < 3
                  ? () =>
                  controller.jumpToPage(controller.currentPage.value + 1)
                  : null,
              child: Container(
                height: 52.h,
                width: 52.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CakeScreen extends StatelessWidget {
  CakeScreen({super.key});

  final controller = Get.put(RewardUnlockedController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/pngs/reward_background_image.png"),
        Positioned(
          top: 90.h,
          left: 15.w,
          child: Text(
            "FREE\nBIRTHDAY\nGIFTS",
            style: GoogleFonts.sarabun(
                fontSize: 44.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.65),
                height: 1.0
            ),
          ),
        ),

        Positioned(
          bottom: -4,
          right: 0,
          left: 0,
          child: Image.asset("assets/images/pngs/cake.png"),
        ),
        Positioned(
          top: 230.h,
          left: 15.w,
          child: Padding(
            padding:  EdgeInsets.only(top: 15.h),
            child: InkWell(
              onTap: controller.currentPage.value < 3
                  ? () =>
                  controller.jumpToPage(controller.currentPage.value + 1)
                  : null,
              child: Container(
                height: 52.h,
                width: 52.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardScreen extends StatelessWidget {
  CardScreen({super.key});

  final controller = Get.put(RewardUnlockedController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/pngs/reward_background_image.png"),
        Positioned(
          top: 90.h,
          left: 15.w,
          child: Text(
            "MEMBER\nONLY OFFERS\nAND EVENTS",
            style: GoogleFonts.sarabun(
                fontSize: 44.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.65),
                height: 1.0

            ),
          ),
        ),

        Positioned(
          bottom: -4,
          right: 0,
          left: 0,
          child: Image.asset("assets/images/pngs/card.png"),
        ),
        Positioned(
          top: 230.h,
          left: 15.w,
          child: Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: InkWell(
              onTap: controller.currentPage.value < 3
                  ? () =>
                  controller.jumpToPage(controller.currentPage.value + 1)
                  : null,
              child: Container(
                height: 52.h,
                width: 52.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
*/
