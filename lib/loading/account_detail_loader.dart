import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../CSS/color.dart';

class AccountDetailLoader extends StatelessWidget {
  const AccountDetailLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.h,
            width: 90.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 10),
          Container(
            height: 70.h,
            width: double.infinity,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 20.h,
            width: 90.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 10),
          Container(
            height: 70.h,
            width: double.infinity,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 10),
          Container(
            height: 20.h,
            width: 90.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 10),
          Container(
            height: 70.h,
            width: double.infinity,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 10),
          Container(
            height: 20.h,
            width: 90.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 10),
          Container(
            height: 70.h,
            width: double.infinity,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 50.h,
          ),
          Center(
            child: Container(
              height: 40.h,
              width: 250.w,
              color: AppColor().whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
