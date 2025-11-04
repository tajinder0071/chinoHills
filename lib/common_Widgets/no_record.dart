import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/CSS/image_page.dart';

class NoRecord extends StatelessWidget {
  String? data, subTitle;

  Icon icon;
  Color? color;
  double imageHeight;
  double imageWidth;
  double iconSize;
  final IconData? iconData;

  NoRecord(this.data, this.icon, this.subTitle,
      {this.color,
      this.iconSize = 80,
      this.imageHeight = 150,
      this.imageWidth = 150,
      super.key,
      this.iconData = Icons.question_mark_rounded});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: color ?? AppColor().background,
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: imageHeight.h,
              width: imageWidth.w,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages.noDataFoundBg),
                      colorFilter: ColorFilter.mode(
                        AppColor.dynamicColor,
                        BlendMode.srcIn,
                      ))),
              child: Icon(
                iconData,
                size: iconSize.h,
                color: AppColor().whiteColor,
              ),
            ),
            //Image.asset("assets/images/file.png", height: 120.h),
            SizedBox(height: 7.h),
            Text(data!.toUpperCase(),
                style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                    fontSize: 19.sp,
                    color: AppColor.dynamicColor,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 5.h),
            Text(subTitle!,
                textAlign: TextAlign.center,
                style: AppTypography.hostGroteskRegular.copyWith(
                    fontSize: 15.sp, color: Colors.black.withOpacity(0.65))),
          ],
        ),
      ),
    );
  }
}
