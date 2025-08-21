import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../CSS/color.dart';

class RewardLoad extends StatelessWidget {
  const RewardLoad({super.key});

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
              margin: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: AppColor().whiteColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, i) => ListTile(
                        title: Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor().whiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      )),
            ),
          ],
        ));
  }
}

//reward detail class
class RewardDetail extends StatelessWidget {
  const RewardDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: ListView(
          children: [
            Container(
              height: 100.h,
              width: double.infinity,
              color: AppColor().whiteColor,
            ),
            Container(
              height: 400.h,
              width: double.infinity,
              margin: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: AppColor().whiteColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 20,
                  itemBuilder: (context, i) => ListTile(
                        title: Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            color: AppColor().whiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 30.h,
              width: double.infinity,
              color: AppColor().whiteColor,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100.h,
              width: double.infinity,
              color: AppColor().whiteColor,
            ),
          ],
        ));
  }
}
