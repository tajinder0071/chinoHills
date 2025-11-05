import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chino_hills/CSS/color.dart';

class CommonBadgeContainer extends StatelessWidget {
  final String? imagePath;
  final Color? color;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double outerSize;
  final double innerPadding;
  final bool isTablet;

  const CommonBadgeContainer({
    super.key,
    this.imagePath,
    this.color,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.outerSize = 60,
    this.innerPadding = 14,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: outerSize.w,
      width: outerSize.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.6),
      ),
      child: Padding(
        padding: EdgeInsets.all(innerPadding.w),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/new_images/badge.png"),
              colorFilter: ColorFilter.mode(
                AppColor.dynamicColor,
                BlendMode.srcIn,
              ),
              fit: BoxFit.contain,
            ),
          ),
          child: icon != null
              ? Icon(
            icon,
            color: iconColor ?? Colors.white,
            size: iconSize ?? (isTablet ? 30.h : 20.h),
          )
              : null,
        ),
      ),
    );
  }
}
