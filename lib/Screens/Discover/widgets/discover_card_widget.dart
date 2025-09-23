import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CSS/color.dart';
import '../../../common_Widgets/cacheNetworkImage.dart';
import '../../../common_Widgets/common_button_widget.dart';
import '../../../common_Widgets/common_network_image_widget.dart';
import '../../../util/common_page.dart';
import '../../shop/controller/shop_controller.dart';

class CustomCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String headline;
  final String ctaText;
  final String? description;
  final VoidCallback onTapCTA;
  final VoidCallback? onTapLearnMore;
  final bool isOffer;
  final String? offerExpiresText;
  bool isOfferApplied;
  final int index;

  CustomCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.headline,
    required this.ctaText,
    required this.onTapCTA,
    required this.isOfferApplied,
    this.description,
    this.onTapLearnMore,
    this.isOffer = false,
    this.offerExpiresText,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final ShopController controller = Get.find();
    //print("offerExpiresText:$offerExpiresText");
    return Container(
      clipBehavior: Clip.antiAlias,
      // margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      padding: EdgeInsets.only(
        top: 30.h,
        bottom: 20.h,
        left: 10.w,
        right: 10.w,
      ),
      decoration: BoxDecoration(
        color: index.isEven ? AppColor().whiteColor : AppColor().lightGrey,
        //borderRadius: BorderRadius.circular(10.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     offset: Offset(2, 2),
        //     blurRadius: 5.r,
        //   ),
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isOffer
              ? SizedBox(
                  height: 220.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CommonNetworkImageWidget(
                        imageUrl: imageUrl,
                        height: 250.h,
                        width: double.infinity,
                        borderRadius: BorderRadius.circular(10.r),
                        fit: BoxFit.fill,
                      ),
                      if (offerExpiresText != null)
                        Positioned(
                          top: 10.h,
                          left: 15.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                FadeTransition(
                                  opacity: controller.blinkAnimation,
                                  child: ScaleTransition(
                                    scale: controller.scaleAnimation,
                                    child: Container(
                                      width: 8.w,
                                      height: 8.w,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Expire in ${getTimeDifference(offerExpiresText!)}",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                  ),
                  child: ConstantNetworkImage(
                    isLoad: true,
                    imageUrl: imageUrl,
                    boxFit: BoxFit.cover,
                    height: 222.h,
                    width: double.infinity,
                  ),
                ),
          SizedBox(height: 20.h),
          Text(
            title.toString().replaceAll(
              title[0].toString(),
              title[0].toUpperCase(),
            ),
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.merriweather(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.h),
          Text(
            headline,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontSize: 15.sp),
          ),
          SizedBox(height: 15.h),

          CommonButtonWidget(
            isDisabled: isOfferApplied,
            isOutlineButton: false,
            onTap: isOfferApplied ? null : onTapCTA,
            buttonName: ctaText.replaceAll("  ", " "),
          ),
          SizedBox(height: 20.h),
          // if ((description?.isNotEmpty ?? false) && onTapLearnMore != null)
          InkWell(
            onTap: onTapLearnMore,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Learn More",
                  style: GoogleFonts.roboto(
                    color: AppColor.dynamicColor,
                    fontSize: 17.h,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.navigate_next_outlined,
                  size: 25,
                  color: AppColor.dynamicColor,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
