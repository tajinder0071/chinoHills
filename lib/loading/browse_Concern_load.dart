import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../CSS/color.dart';

class BrowseConcernLoad extends StatelessWidget {
  const BrowseConcernLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, i) => Column(
              children: [
                Container(
                  height: 50.h,
                  width: double.infinity,
                  margin: EdgeInsets.all(10.h),
                  color: AppColor().whiteColor,
                ),
                Divider()
              ],
            ));
  }
}
