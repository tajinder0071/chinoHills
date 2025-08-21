import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../CSS/color.dart';

class BecomeAMemberLoading extends StatelessWidget {
  const BecomeAMemberLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return Container(
              height: 150.h,
              width: 190.w,
              margin: EdgeInsets.only(left: 5.h, right: 5.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r),
                color: AppColor.geryBackGroundColor,
              ),
            );
          },
        ));
  }
}

class MemberLoadDetail extends StatelessWidget {
  const MemberLoadDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            height: 25.h,
            width: 200.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 10),
          Container(
            height: 25.h,
            width: 300.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 100.h,
            width: double.infinity,
            margin: EdgeInsets.all(8.h),
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 300.h,
            width: double.infinity,
            margin: EdgeInsets.all(8.h),
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 30.h,
            width: 300.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 45.h,
            width: 350.w,
            color: AppColor().whiteColor,
          ),
        ],
      ),
    );
  }
}

class TreatementLoadDetail extends StatelessWidget {
  TreatementLoadDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
            height: 200.h,
            width: double.infinity,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40.h,
            width: 300.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(height: 20),
          Container(
            height: 20.h,
            width: 200.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 150.h,
            width: 350.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 45.h,
            width: 300.w,
            color: AppColor().whiteColor,
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 45.h,
            width: double.infinity,
            color: AppColor().whiteColor,
          ),
        ],
      ),
    );
  }
}
