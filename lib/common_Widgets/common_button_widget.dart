import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CSS/color.dart';

class CommonButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonName;
  final bool isOutlineButton;
  final bool isLoading;
  final double margin;
  final bool isDisabled;

  CommonButtonWidget({
    super.key,
    required this.onTap,
    required this.buttonName,
    this.margin = 0.0,
    this.isOutlineButton = false,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return isOutlineButton
        ? SizedBox(
            height: 50.h,
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0.r),
                ),
              ),
              onPressed: onTap,
              child: Text(
                buttonName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.all(margin),
            child: SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: isDisabled ? null : onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dynamicColor,
                  disabledBackgroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                  shadowColor: AppColor.dynamicColor,
                ),
                child: isLoading
                    ? CircularProgressIndicator(
                        color: AppColor().whiteColor,
                        strokeWidth: 2,
                      )
                    : Text(
                        buttonName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.h,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          );
  }
}
