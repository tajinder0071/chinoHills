import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CSS/color.dart';

class FeatureItemWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  const FeatureItemWidget({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.h),
      margin: EdgeInsets.only(bottom: 8.0.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(2, 2), blurRadius: 2),
            BoxShadow(
                color: Colors.black12, offset: Offset(-2, -2), blurRadius: 2)
          ],
          color: AppColor().whiteColor),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.dynamicColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8.h),
            child: Icon(icon, color: AppColor.dynamicColor),
          ),
          SizedBox(width: 10.h),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(fontSize: 14.sp),
          )
        ],
      ),
    );
  }
}
