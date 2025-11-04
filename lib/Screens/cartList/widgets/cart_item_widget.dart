import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chino_hills/CSS/image_page.dart';
import '../../../CSS/appTypography.dart';
import '../../../CSS/color.dart';

enum RewardType { treatment, membership, package }

class RewardItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final dynamic price;
  final dynamic discountPrice;
  final RewardType type;
  final VoidCallback onRemove;
  var offerType;

  RewardItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.type,
    required this.onRemove,
    this.subtitle = '',
    required this.offerType,
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
      padding: EdgeInsets.all(8.w),
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColor().lightGrey,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.network(
                  imageUrl,
                  height: 85.h,
                  width: 100.w,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 85.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: AppColor.geryBackGroundColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          AppImages.noAvailableImage,
                          color: AppColor().blackColor,
                          height: 30.h,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (ctx, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 85.h,
                      width: 100.w,
                      child: Center(
                        child: Platform.isAndroid
                            ? CircularProgressIndicator(
                                color: AppColor.dynamicColor,
                                strokeWidth: 2,
                              )
                            : CupertinoActivityIndicator(
                                color: AppColor.dynamicColor),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 6.h,
                left: 6.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColor.dynamicColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    typeLabel,
                    style: AppTypography.hostGroteskSemiBold.copyWith(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      typeLabel.toUpperCase() == 'MEMBERSHIP' &&
                              offerType.toUpperCase() == 'MEMBERSHIP'
                          ? Text(
                              price.toString(),
                              style: AppTypography.hostGroteskSemiBold.copyWith(
                                fontSize: 10.sp,
                              ),
                            )
                          : discountPrice.toString() == "\$0" ||
                                  discountPrice.toString().startsWith("-") ||
                                  discountPrice.toString() == "0.0"
                              ? Text(
                                  price.toString(),
                                  style: AppTypography.hostGroteskSemiBold
                                      .copyWith(
                                    fontSize: 10.sp,
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      discountPrice.toString(),
                                      style: AppTypography.hostGroteskSemiBold
                                          .copyWith(
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                    Text(
                                      price.toString(),
                                      style: AppTypography.hostGroteskRegular
                                          .copyWith(
                                        fontSize: 10.sp,
                                        color: AppColor().greyColor,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                      SizedBox(height: 2.h),
                      Text(
                        subtitle,
                        style: AppTypography.hostGroteskSemiBold.copyWith(
                          color: Colors.grey,
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: AppColor.dynamicColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: AppColor().whiteColor,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
