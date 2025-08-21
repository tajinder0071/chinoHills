import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../CSS/color.dart';

class NfcLoadingScreen extends StatelessWidget {
  const NfcLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor().whiteColor.withOpacity(.7),
      borderRadius: BorderRadius.circular(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColor.dynamicColor),
          SizedBox(height: 10.h),
          Text("Please wait...",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColor.dynamicColor))
        ],
      ),
    );
  }
}
