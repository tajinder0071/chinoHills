import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CSS/color.dart';
import '../../../util/common_page.dart';

enum RewardType { treatment, membership, package }

class RewardItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final dynamic price;
  final dynamic discountPrice;
  final RewardType type;
  final VoidCallback onRemove;

  RewardItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.type,
    required this.onRemove,
    this.subtitle = '',
  });

  Color get bgColor => type == RewardType.membership
      ? AppColor.dynamicColorWithOpacity
      : Colors.white;

  String get typeLabel {
    switch (type) {
      case RewardType.treatment:
        return 'TREATMENT';
      case RewardType.membership:
        return 'MEMBERSHIP';
      case RewardType.package:
        return 'PACKAGE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              imageUrl.toString(),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              errorBuilder: (context, url, error) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  height: 90.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                      color: AppColor.geryBackGroundColor,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Center(
                    child: Image.asset(
                      "assets/images/Image_not_available.png",
                      color: AppColor().blackColor,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              loadingBuilder: (BuildContext ctx, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // ✅ Return the fully loaded image
                }
                return SizedBox(
                  height: 90.h,
                  width: 110.w,
                  child: Center(
                    child: Platform.isAndroid
                        ? Center(
                        child: commonLoader(color: AppColor.dynamicColor))
                        : CupertinoActivityIndicator(
                        color: AppColor.dynamicColor),
                  ),
                );
              },
              height: 90.h,
              width: 110.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.bold, fontSize: 13.sp)),
                    ),
                    SizedBox(width: 5.0.w),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            /*typeLabel == 'MEMBERSHIP'
                                ? Text(
                                    price.toString(),
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  )
                                :*/ discountPrice.toString() == "0.0"
                                ? Text(
                              price.toString(),
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.sp,
                              ),
                            )
                                : Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '${discountPrice.toString()}',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Text(
                                  price.toString(),
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    color: AppColor().greyColor,
                                    decoration:
                                    TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            )
                          ]),
                    ),
                  ],
                ),
                SizedBox(height: 5.0.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColor.dynamicColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    typeLabel,
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.dynamicColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: isTablet(context) ? 17.h : 14.h),
                      ),
                    ),
                    TextButton(
                      onPressed: onRemove,
                      child: Text(
                        "REMOVE",
                        style: GoogleFonts.roboto(
                            fontSize: isTablet(context) ? 17.h : 14.h,
                            color: AppColor.dynamicColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
