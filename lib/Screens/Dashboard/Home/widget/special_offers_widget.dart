import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/shop/controller/shop_controller.dart';
import 'package:chino_hills/common_Widgets/common_badge_container.dart';
import 'package:chino_hills/common_Widgets/common_button_widget.dart';
import 'package:chino_hills/common_Widgets/coomon_horizontal_list.dart';
import 'package:chino_hills/util/common_page.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../Model/detail_browse_model.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/route_manager.dart';

class SpecialOffersWidget extends StatelessWidget {
  final VoidCallback discoverMoreTap;
  bool isShowAll;
  List<OfferCards>? offerData;

  SpecialOffersWidget({
    super.key,
    required this.discoverMoreTap,
    this.isShowAll = false,
    this.offerData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.only(top: 25.h, left: 0.w, bottom: 10.0.h),
        width: double.infinity,
        color: AppColor().greyColor.withValues(alpha: 0.2),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.sizeOf(context).height * .03),
              // Todo >> Icons and Text...
              CommonBadgeContainer(
                icon: Icons.local_offer_outlined,
                iconSize: 15.h,
              ),
              SizedBox(height: 15.h),
              Text(
                AppStrings.specialOffer,
                style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                    fontSize: 22.sp,
                    color: AppColor().blackColor.withValues(alpha: 0.65),
                    height: 0.9.h // default color
                    ),
              ),
              SizedBox(height: 15.h),
              // Todo >>  Show here the list...
              SizedBox(
                height: isTablet(context)
                    ? MediaQuery.of(context).size.height * .38
                    : MediaQuery.of(context).size.height < 812
                        ? MediaQuery.of(context).size.height * .45
                        : 330.h,
                child: controller.isSpecialOfferLoading
                    ? SizedBox(
                        height: isTablet(context)
                            ? MediaQuery.of(context).size.height * .38
                            : MediaQuery.of(context).size.height < 812
                                ? MediaQuery.of(context).size.height * .45
                                : 330.h,
                        child: BecomeAMemberLoading())
                    : offerData!.isEmpty || offerData == null
                        ? CommonHorizontalList(
                            items: offerData!,
                            itemBuilder: (context, data, index) =>
                                _buildOfferCard(
                                    data.image,
                                    data.title,
                                    data.endDate == ""
                                        ? ""
                                        : getTimeDifference(data.endDate ?? ""),
                                    () {
                                  Get.toNamed(
                                    RouteManager.learnMore,
                                    arguments: {
                                      "specialOffer": [],
                                      "isExpired": true,
                                      "cartData": [],
                                      "cartDatas": offerData![index],
                                      "id": offerData![index].id
                                    },
                                  );
                                }, context))
                        : ListView.builder(
                            padding: EdgeInsets.only(left: 5.h),
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: offerData!.length,
                            itemBuilder: (context, index) {
                              var data = offerData![index];
                              return _buildOfferCard(
                                  data.image,
                                  data.title,
                                  data.endDate == ""
                                      ? ""
                                      : getTimeDifference(data.endDate == ""
                                          ? DateFormat("MMMM, dd yyyy HH:mm:ss")
                                              .format(DateTime.now())
                                          : data.endDate.toString()), () {
                                Get.log("Is tapped");
                                Get.toNamed(
                                  RouteManager.learnMore,
                                  arguments: {
                                    "specialOffer": data,
                                    "isExpired": true,
                                    "cartData": [],
                                    "id": data.id
                                  },
                                );
                              }, context);
                            },
                          ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              // 364926490
              // Todo >> move to discover sections...
              isShowAll
                  ? CommonButtonWidget(
                      innerColor: AppColor.dynamicColor,
                      onTap: discoverMoreTap,
                      buttonName: "Discover More Offers")
                  : SizedBox.shrink(),
              SizedBox(height: isShowAll ? 10.h : 0.0),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildOfferCard(imageUrl, title, var daysLeft,
      VoidCallback onTapDetails, BuildContext context) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: () => onTapDetails(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 7.0.w),
        width: MediaQuery.sizeOf(context).width * 0.55,
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColor().blackColor.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // Background image
              CommonNetworkImageWidget(
                imageUrl: imageUrl.toString(),
                height: 335.h,
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.zero,
              ),

              // Gradient overlay
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor().transparent,
                        AppColor().blackColor.withValues(alpha: 0.65),
                      ],
                    ),
                  ),
                ),
              ),

              // Bottom section
              Positioned(
                bottom: 16.h,
                left: 12.w,
                right: 50.w, // space for arrow
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                          color: AppColor().whiteColor,
                          fontSize: 24.sp,
                          height: 1.2),
                    ),
                  ],
                ),
              ),

              // Circular arrow button
              Positioned(
                bottom: 12.h,
                right: 12.w,
                child: Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: AppColor.dynamicColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.sp,
                    color: AppColor().whiteColor,
                  ),
                ),
              ),

              // Expiry badge (if applicable)
              Positioned(
                top: 12.h,
                right: 12.w,
                child: daysLeft == ""
                    ? const SizedBox.shrink()
                    : Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: AppColor.dynamicColor.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeTransition(
                              opacity:
                                  Get.find<ShopController>().blinkAnimation,
                              child: ScaleTransition(
                                scale:
                                    Get.find<ShopController>().scaleAnimation,
                                child: Container(
                                  width: 8.w,
                                  height: 8.w,
                                  decoration: BoxDecoration(
                                    color: AppColor().redColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'Expires in $daysLeft',
                              style: AppTypography.hostGroteskSemiBold.copyWith(
                                color: AppColor().whiteColor,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
