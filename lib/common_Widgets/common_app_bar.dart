import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/common_Widgets/common_back_and_forward_button.dart';

import '../CSS/color.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color? titleColor;

  const CommonAppBar({required this.title, super.key, this.titleColor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () => Navigator.pop(context),
                child: CommonBackButton(
                  buttonHeight: 35.h,
                  buttonWidth: 35.w,
                  iconSize: 15.h,
                )),
            Text(
              title,
              style: AppTypography.hostGroteskMedium.copyWith(
                fontSize: 20.sp,
                //fontWeight: FontWeight.w500,
                color: titleColor ?? AppColor().lightBlackColor,
              ),
            ),
            const Icon(Icons.account_circle_outlined,
                color: Colors.transparent),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
