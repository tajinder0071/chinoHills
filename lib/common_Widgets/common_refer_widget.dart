import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../CSS/color.dart';
import 'common_button_widget.dart';

class CommonReferWidget extends StatelessWidget {
  const CommonReferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.dynamicColor,
        // borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Icon(Icons.card_giftcard, color: Colors.white, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            "REFER A FRIEND",
            style: GoogleFonts.merriweather(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Send a friend \$25\nTowards Any Service !",
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15.h),
          CommonButtonWidget(
            isOutlineButton: true,
            onTap: () async {
              final box = context.findRenderObject() as RenderBox?;
              /* await Share.share(
                Platform.isAndroid
                    ? "https://play.google.com/store/apps/details?id=com.app.nima"
                    : "https://apps.apple.com/us/app/nima-newport/id6745820609",
                subject: "",
                sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
              );*/
              await Share.shareXFiles(
                [
                  XFile(
                    Platform.isAndroid
                        ? "https://play.google.com/store/apps"
                        : "https://apps.apple.com/us/app",
                  ),
                ],
                sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size
              );
            },
            buttonName: "Send to a friend",
          ),
        ],
      ),
    );
  }
}
