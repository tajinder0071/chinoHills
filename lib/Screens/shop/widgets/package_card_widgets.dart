import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;

import '../../../CSS/color.dart';
import '../../../util/common_page.dart';

class PackageCard extends StatelessWidget {
  final String title, unitType;
  final String sectionName;
  final String DiscountType;
  final String description;
  final String imageUrl;
  var originalPrice;
  var memberPrice;
  final List tags;
  var discount;
  final VoidCallback onPressed;

  PackageCard({
    Key? key,
    required this.title,
    required this.unitType,
    required this.DiscountType,
    required this.sectionName,
    required this.description,
    required this.imageUrl,
    required this.originalPrice,
    required this.memberPrice,
    required this.tags,
    required this.discount,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(2, 2),
              blurRadius: 5.r,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(12.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TODo ?? Offers and Package and Image here and Title
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                if (discount > 0 &&
                                    DiscountType == "btn-percent")
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: AppColor.dynamicColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      'Upto $discount% OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  )
                                else if (discount > 0 &&
                                    DiscountType == "btn-amount")
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: AppColor.dynamicColor,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                    child: Text(
                                      'Upto \$$discount OFF',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                if (discount > 0) SizedBox(width: 5.w),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.dynamicColor.withAlpha(30),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    sectionName.toString().toUpperCase(),
                                    style: TextStyle(
                                      color: AppColor.dynamicColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              title.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: Image.network(
                            imageUrl.toString(),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                            errorBuilder: (context, url, error) {
                              return Container(
                                clipBehavior: Clip.antiAlias,
                                height: 90.h,
                                width: 110.w,
                                decoration: BoxDecoration(
                                    color: AppColor.geryBackGroundColor,
                                    borderRadius: BorderRadius.circular(10.r)),
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
                                return child; //  Return the fully loaded image
                              }
                              return SizedBox(
                                height: 90.h,
                                width: 110.w,
                                child: Center(
                                  child: Platform.isAndroid
                                      ? commonLoader(
                                          color: AppColor.dynamicColor)
                                      : CupertinoActivityIndicator(
                                          color: AppColor.dynamicColor,
                                        ),
                                ),
                              );
                            },
                            height: 90.h,
                            width: 110.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    description.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 5,
                    children: [
                      ...tags.take(2).map((tagData) => _tagChip(tagData)),
                      if (tags.length > 2) _extraChip("+${tags.length - 2}"),
                    ],
                  )
                ],
              ),
            ),
            Container(
              // height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 10.0.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  )),
              child: Row(
                children: [
                  RichText(
                    text: buildPriceTextSpan(
                      originalPrice: originalPrice,
                      memberPrice: memberPrice,
                      unit: unitType,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Spacer(),
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(Icons.navigate_next_rounded,
                        color: AppColor.dynamicColor, size: 28.h),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _extraChip(String label) {
    return Chip(
      label: Text(label,
          style: TextStyle(fontSize: 12.sp, color: AppColor.dynamicColor)),
      backgroundColor: Colors.white,
    );
  }

  void _showRemainingTags(BuildContext context, List<String> remainingTags) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: remainingTags.map((tag) => _tagChip(tag)).toList(),
          ),
        );
      },
    );
  }

  Widget _tagChip(String label) {
    return Chip(
      label: Text(label,
          style: TextStyle(fontSize: 12.sp, color: AppColor.dynamicColor)),
      backgroundColor: Colors.white,
    );
  }
}
