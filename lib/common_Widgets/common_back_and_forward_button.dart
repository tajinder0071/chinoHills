import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chino_hills/CSS/color.dart';

class CommonBackButton extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final double iconSize;
  final VoidCallback? onTap;

  const CommonBackButton(
      {this.buttonHeight = 42, this.buttonWidth = 42, this.onTap, super.key, this.iconSize = 16});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.zero,
        height: buttonHeight.h,
        width: buttonWidth.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.dynamicColor,
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor().whiteColor,
          size: iconSize.h,
        ),
      ),
    );
  }
}

class CommonForwardButton extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final double iconSize;
  final VoidCallback? onTap;

  const CommonForwardButton(
      {this.buttonHeight = 42, this.buttonWidth = 42, super.key, this.onTap, this.iconSize = 16});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.zero,
        height: 42.h,
        width: 42.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.dynamicColor,
        ),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColor().whiteColor,
          size: iconSize.h,
        ),
      ),
    );
  }
}
class CommonRoundedButton extends StatelessWidget {
  final double buttonHeight;
  final double buttonWidth;
  final double iconSize;
  final IconData icon;
  final VoidCallback? onTap;

  const CommonRoundedButton(
      {this.buttonHeight = 42, this.buttonWidth = 42, this.icon = Icons.call, this.iconSize = 18, super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.zero,
        height: buttonHeight.h,
        width: buttonWidth.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.dynamicColor,
        ),
        child: Icon(
          icon,
          color: AppColor().whiteColor,
          size: iconSize.h,
        ),
      ),
    );
  }
}

