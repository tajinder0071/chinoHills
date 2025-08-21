import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../CSS/color.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback? onReset;
  final VoidCallback? onApply;
  final bool? isApplyButtonEnabled;

  BottomButton({this.onReset, this.onApply, this.isApplyButtonEnabled});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: 45.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    border:
                        Border.all(color: AppColor.dynamicColor, width: 1.h)),
                child: ElevatedButton(
                  onPressed: onReset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text(
                    "Reset filter",
                    style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColor.dynamicColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Container(
                width: double.infinity,
                height: 45.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    colors: [
                      isApplyButtonEnabled!
                          ? AppColor.dynamicColor
                          : AppColor.dynamicColor.withOpacity(0.5),
                      isApplyButtonEnabled!
                          ? AppColor.dynamicColor
                          : AppColor.dynamicColor.withOpacity(0.3),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: isApplyButtonEnabled! ? onApply : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: isApplyButtonEnabled!
                          ? AppColor().whiteColor
                          : AppColor().whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
