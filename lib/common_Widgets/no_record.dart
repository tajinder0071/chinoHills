import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../CSS/color.dart';

class NoRecord extends StatelessWidget {
  String? data, subTitle;

  Icon icon;

  NoRecord(this.data, this.icon, this.subTitle, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: AppColor().background,
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/file.png", height: 120.h),
            SizedBox(height: 7.h),
            Text(data!.toUpperCase(),
                style: TextStyle(
                    fontSize: 17.h,
                    color: AppColor.dynamicColor,
                    fontWeight: FontWeight.w500)),
            SizedBox(height: 5.h),
            Text(subTitle!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.h, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
