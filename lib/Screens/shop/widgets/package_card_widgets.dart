import 'package:chino_hills/CSS/image_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    String formatDiscount(dynamic offer) {
      if (offer == null) return "";

      final offerText = offer.toString().trim();
      if (offerText.isEmpty) return "";

      // Match number inside the string
      final match = RegExp(r'([0-9]+(?:\.[0-9]+)?)').firstMatch(offerText);

      if (match != null) {
        final numericPart = double.tryParse(match.group(1)!);
        if (numericPart != null) {
          if (numericPart == 0) return ""; // hide zero discounts

          // Format the number: drop .0 if whole
          final numberStr = numericPart % 1 == 0
              ? numericPart.toInt().toString()
              : numericPart.toString();

          // Split into prefix + number + suffix
          final prefix =
          offerText.substring(0, match.start).trim(); // before number
          var suffix = offerText.substring(match.end).trim(); // after number

          // Only add space after number if prefix contains a dollar sign
          if (prefix.contains("\$") &&
              suffix.isNotEmpty &&
              !suffix.startsWith(' ')) {
            suffix = ' $suffix';
          }
          return "$prefix$numberStr$suffix".trim();
        }
      }

      return offerText;
    }
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(8.r),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                discount == "" || discount.toString() == "0"
                                    ? SizedBox.shrink()
                                    : Container(
                                  margin: EdgeInsets.zero,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.dynamicColor,
                                    borderRadius:
                                    BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    formatDiscount(discount
                                        .toString()
                                        .toUpperCase()),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                unitType == ""
                                    ? SizedBox.shrink()
                                    : Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.dynamicColor
                                        .withOpacity(.1),
                                    borderRadius:
                                    BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    unitType.toUpperCase(),
                                    style: GoogleFonts.roboto(
                                      color: AppColor.dynamicColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
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
                              style: GoogleFonts.merriweather(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 90.h,
                        width: 110.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            color: Colors.white),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
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
                      //fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor().black80,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Wrap(
                    spacing: 4,
                    runSpacing: -10,
                    children: [
                      ...tags.map((tagData) => _tagChip(tagData)),
                      //...tags.take(2).map((tagData) => _tagChip(tagData)),
                      //if (tags.length > 2) _extraChip("+${tags.length - 2}"),
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
                  color: Colors.grey.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.r),
                    bottomRight: Radius.circular(8.r),
                  )),
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RichText(
                      text: buildPriceTextSpan(
                        originalPrice: originalPrice,
                        memberPrice: memberPrice,
                        unit: unitType,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
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

  // Widget _extraChip(String label) {
  //   return Chip(
  //     label: Text(label,
  //         style: TextStyle(fontSize: 12.sp, color: AppColor.dynamicColor)),
  //     backgroundColor: Colors.white,
  //   );
  // }

  // void _showRemainingTags(BuildContext context, List<String> remainingTags) {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Wrap(
  //           spacing: 8,
  //           runSpacing: 8,
  //           children: remainingTags.map((tag) => _tagChip(tag)).toList(),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _tagChip(String label) {
    return Chip(
      padding: EdgeInsets.zero,
      label: Text(label,
          style: TextStyle(fontSize: 12.sp, color: AppColor.dynamicColor)),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
        side: BorderSide(
          color: Color(0XFFEEEEEE),
        ),
      ),
    );
  }
}
