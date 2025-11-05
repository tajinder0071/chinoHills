import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/common_Widgets/affirm_dialog.dart';

import '../CSS/color.dart';
import '../util/route_manager.dart';

class AffirmBadge extends StatelessWidget {
  AffirmBadge({super.key, required this.isButton});

  bool isButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey.shade400,
            Colors.grey.shade200,
            Colors.grey.shade400,
          ],
          stops: const [0.1, 0.5, 1.5],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    "assets/images/affirm_logo.png",
                    height: 40.h,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  "with",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColor().blackColor,
                  ),
                ),
                SizedBox(width: 6.w),
                Image.asset(
                  "assets/images/app_logo.png",
                  height: 40.h,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Treat today. Pay later. Earn rewards.",
              textAlign: TextAlign.center,
              style: GoogleFonts.merriweather(
                  fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Make monthly payments with no late fees",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColor().blackColor,
              ),
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AffirmDialog(
                    onShopNowTap: () {
                      Get.offAllNamed(RouteManager.dashBoardPage, arguments: 2);
                    },
                    isButton: isButton,
                  ),
                );
              },
              child: Text(
                "How does it work?",
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.dynamicColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InlineAffirmBadge extends StatelessWidget {
  const InlineAffirmBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Treat now, pay later with ",
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor().mediumGreyColor),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Image.asset(
                "assets/images/affirm_logo.png",
                height: 15.h,
              ),
            )
          ]),
    );
  }
}

class BannerAffirmBadge extends StatelessWidget {
  final bool? cardView, isButton;

  const BannerAffirmBadge({
    super.key,
    this.cardView,
    this.isButton,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AffirmDialog(
            onShopNowTap: () {
              Get.offAllNamed(RouteManager.dashBoardPage, arguments: 2);
            },
            isButton: isButton!,
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: cardView! ? BorderRadius.circular(12.r) : null,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade300,
              Colors.grey.shade100,
              Colors.grey.shade300,
            ],
            stops: const [0.1, 0.5, 1.5],
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(6.h),
                child: Image.asset(
                  "assets/images/affirm_logo.png",
                  height: 20.h,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(6.0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.treatTodayPayLater,
                      style: GoogleFonts.merriweather(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      "Make monthly payments with no late fees",
                      style: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor().mediumGreyColor,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
