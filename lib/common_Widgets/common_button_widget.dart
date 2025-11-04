import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/appTypography.dart';

import '../CSS/color.dart';

class CommonButtonWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonName;
  final bool isOutlineButton;
  final bool isLoading;
  final double margin;
  final bool isDisabled;
  final double width;
  final Color outlineColor;

  final Color innerColor;

  CommonButtonWidget(
      {super.key,
      required this.onTap,
      required this.buttonName,
      this.margin = 0.0,
      this.isOutlineButton = false,
      this.isLoading = false,
      this.isDisabled = false,
      this.width = double.infinity,
      this.outlineColor = Colors.white,
      required this.innerColor});

  @override
  Widget build(BuildContext context) {
    return isOutlineButton
        ? SizedBox(
            height: 50.h,
            width: width,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: outlineColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0.r),
                ),
              ),
              onPressed: onTap,
              child: Text(
                buttonName,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  color: outlineColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.all(margin),
            child: SizedBox(
              width: width,
              height: 60.h,
              child: ElevatedButton(
                onPressed: isDisabled ? null : onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: innerColor,
                  disabledBackgroundColor: Colors.grey.shade400,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 14,
                  shadowColor: AppColor().blackColor.withOpacity(0.6),
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
                        style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
              ),
            ),
          );
  }
}
