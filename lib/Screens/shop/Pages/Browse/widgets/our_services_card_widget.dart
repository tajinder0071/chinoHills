import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/appTypography.dart';
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
      borderRadius: BorderRadius.circular(20.0.r),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: AppColor().greyColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            /// ---- IMAGE WITH BLUE LABEL ----
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: Image.network(
                imagePath,
                height: isTablet(context) ? 140.h : 90.h,
                width: isTablet(context) ? 160.w : 120.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: isTablet(context) ? 140.h : 100.h,
                    width: isTablet(context) ? 160.w : 120.w,
                    color: Colors.blue.shade50,
                    child: const Icon(Icons.error),
                  );
                },
                loadingBuilder: (ctx, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: isTablet(context) ? 140.h : 100.h,
                    width: isTablet(context) ? 160.w : 120.w,
                    child: Center(
                      child: Platform.isAndroid
                          ? commonLoader(color: AppColor.dynamicColor)
                          : CupertinoActivityIndicator(
                              color: AppColor.dynamicColor),
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12.w),

            /// ---- TEXT AREA ----
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.h),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 150.w,
                        child: Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                            fontSize: 16.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      // host-grotesk
                      Container(
                        height: 36.h,
                        width: 36.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2F6FED),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 22.h,
                        ),
                      ),
                    ]),
              ),
            ),

            /// ---- RIGHT ARROW ----
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       height: 36.h,
            //       width: 36.h,
            //       decoration: const BoxDecoration(
            //         color: Color(0xFF2F6FED),
            //         shape: BoxShape.circle,
            //       ),
            //       child: Icon(
            //         Icons.chevron_right,
            //         color: Colors.white,
            //         size: 22.h,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
