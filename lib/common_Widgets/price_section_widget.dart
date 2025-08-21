// Price widget
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../CSS/color.dart';
import '../util/common_page.dart';

class PriceSection extends StatelessWidget {
  final dynamic originalPrice;
  final dynamic memberPrice;
  final VoidCallback? onPressed;

  const PriceSection({
    Key? key,
    required this.originalPrice,
    required this.memberPrice,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColor.geryBackGroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatCurrency(originalPrice),
            style: TextStyle(
              color: AppColor().blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
          SizedBox(width: 8.w),
          Container(height: 27.h, width: 1, color: AppColor().blackColor),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatCurrency(memberPrice),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                'Member',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.navigate_next_rounded,
              color: AppColor.dynamicColor,
              size: 25.h,
            ),
          ),
        ],
      ),
    );
  }
}
