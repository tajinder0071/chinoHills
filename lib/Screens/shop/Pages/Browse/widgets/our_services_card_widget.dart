import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../util/common_page.dart';

class ServiceCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.0.r),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0.r),
          boxShadow: [
            BoxShadow(
              color: AppColor().greyColor.withValues(alpha: 0.4),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0.r),
                bottomLeft: Radius.circular(10.0.r),
              ),
              child: Image.network(
                imagePath.toString(),
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                errorBuilder: (context, url, error) {
                  return Container(
                    margin: EdgeInsets.all(5.0),
                    clipBehavior: Clip.antiAlias,
                    height: 110.h,
                    width: 110.w,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(child: Icon(Icons.error)),
                  );
                },
                loadingBuilder:
                    (
                      BuildContext ctx,
                      Widget child,
                      ImageChunkEvent? loadingProgress,
                    ) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return SizedBox(
                        height: 110.h,
                        width: 110.w,
                        child: Center(
                          child: Platform.isAndroid
                              ? Center(
                                  child: commonLoader(
                                    color: AppColor.dynamicColor,
                                  ),
                                )
                              : CupertinoActivityIndicator(
                                  color: AppColor.dynamicColor,
                                ),
                        ),
                      );
                    },
                height: 110.h,
                width: 110.w,
              ),
            ),
            SizedBox(width: 10.0.w),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.merriweather(
                        fontSize: 11.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0.w, top: 45.h),
              child: Icon(
                Icons.chevron_right,
                color: AppColor.dynamicColor,
                size: 24.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
