import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/common_badge_container.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../common_Widgets/coomon_horizontal_list.dart';
import '../../../../util/common_page.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../../../shop/controller/shop_controller.dart';
import '../../../../Model/home_model.dart';

class BestSellingWidget extends StatelessWidget {
  final bool isBrowse;
  final bool isEnable;
  final VoidCallback exploreAllServiceOnTap;
  final VoidCallback onTap;
  final bool showExploreAllService;

  const BestSellingWidget(
      {super.key,
      this.isBrowse = false,
      this.isEnable = false,
      required this.exploreAllServiceOnTap,
      required this.onTap,
      this.showExploreAllService = true});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isBrowse ? SizedBox.shrink() : SizedBox(height: size.height * .04),
            Column(
              children: [
                isBrowse ? _buildTitleForBrowse(size) : _buildTitle(size),
                SizedBox(height: size.height * .01),
                isEnable ? _buildSubtitle(size) : SizedBox.shrink(),
                SizedBox(height: size.height * .01),
              ],
            ),
            isBrowse
                ? _buildServiceListForBrowse(context, size)
                : _buildServiceList(context, size),
            SizedBox(height: size.height * 0.1),
            showExploreAllService
                ? Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: CommonButtonWidget(
                      innerColor: AppColor.dynamicColor,
                      onTap: exploreAllServiceOnTap,
                      buttonName: AppStrings.exploreAllService,
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(height: size.height * .01),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonBadgeContainer(
          icon: Icons.star_rate_rounded,
        ),
        SizedBox(height: size.height * .02),
        Text(
          isEnable
              ? "EXPLORE OUR BEST–SELLING\nSERVICES"
              : "best-selling\nservices".toUpperCase(),
          style:  AppTypography.galanoGrostesqueSemiBold.copyWith(
              color: Colors.black.withValues(alpha: 0.65),
              fontSize: 26.sp,
              height: 0.9.h),
          textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildTitleForBrowse(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CommonBadgeContainer(
          icon: Icons.star_rate_rounded,
          outerSize: 45,
          iconSize: 15.h,
          innerPadding: 10.h,
        ),
        Text(
          isEnable
              ? "EXPLORE OUR BEST–SELLING\nSERVICES"
              : "Best-Selling Services",
          style: AppTypography.galanoGrostesqueSemiBold.copyWith(
              color: Colors.black.withValues(alpha: 0.65),
              fontSize: 18.sp,
              height: 0.9.h),
          //textAlign: TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildSubtitle(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .1),
      child: Text(
        AppStrings.favTreatmentMessage,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 14.sp,
          fontFamily: 'host-grotesk',
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildServiceList(BuildContext context, Size size) {
    return GetBuilder<ShopController>(
      builder: (controller) {
        // Collect all best-selling items from HomeDatum
        List<BestSelling> bestSellingList = [];
        for (var homeDatum in controller.homeData) {
          if (homeDatum.bestSelling != null) {
            bestSellingList.addAll(homeDatum.bestSelling!);
          }
        }

        if (bestSellingList.isEmpty) {
          print(
              "${bestSellingList.any((e) => e.itemType != null && e.itemType.toString().isNotEmpty) ? size.height * .34 : size.height * .2}");
          return SizedBox(
            height: size.height * .2,
            child: Center(
              child: Text(
                AppStrings.noBestSellingText,
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
            ),
          );
        }

        return SizedBox(
          height: bestSellingList.any(
            (e) => e.itemType != null && e.itemType.toString().isNotEmpty,
          )
              ? isTablet(context)
                  ? 370.h
                  : 330.h
              : 335.h, // responsive height
          child: CommonHorizontalList(
            items: bestSellingList,
            itemBuilder: (context, data, index) => _buildOfferCard(
              isBrowseEnabled: false,
              data.itemImage,
              data.itemName,
              '',
              () {
                if (data.itemType?.toLowerCase() == "treatments") {
                  Get.to(
                    () => TreatmentDetailsPage(),
                    arguments: data.itemId,
                    binding: CommonBinding(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                } else {
                  Get.to(
                    () => PackageDetailPage(sectionName: "Package"),
                    arguments: data.itemId,
                    binding: CommonBinding(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                }
              },
              originalPrice: data.itemPrice,
              memberPrice: data.membershipOfferPrice?.toString() ?? "",
              type: data.itemType.toString(),
              size: size,
            ),
          ),
        );
      },
    );
  }

  Widget _buildServiceListForBrowse(BuildContext context, Size size) {
    return GetBuilder<ShopController>(
      builder: (controller) {
        // Collect all best-selling items from HomeDatum
        List<BestSelling> bestSellingList = [];
        for (var homeDatum in controller.homeData) {
          if (homeDatum.bestSelling != null) {
            bestSellingList.addAll(homeDatum.bestSelling!);
          }
        }

        if (bestSellingList.isEmpty) {
          print(
              "${bestSellingList.any((e) => e.itemType != null && e.itemType.toString().isNotEmpty) ? size.height * .34 : size.height * .2}");
          return SizedBox(
            height: size.height * .2,
            child: Center(
              child: Text(
                AppStrings.noBestSellingText,
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
            ),
          );
        }

        return SizedBox(
          height: bestSellingList.any(
            (e) => e.itemType != null && e.itemType.toString().isNotEmpty,
          )
              ? isTablet(context)
                  ? 370.h
                  : 235.h
              : 240.h, // responsive height
          child: CommonHorizontalList(
            items: bestSellingList,
            itemBuilder: (context, data, index) => _buildOfferCardForBrowse(
              isBrowseEnabled: true,
              data.itemImage,
              data.itemName,
              '',
              () {
                if (data.itemType?.toLowerCase() == "treatments") {
                  Get.to(
                    () => TreatmentDetailsPage(),
                    arguments: data.itemId,
                    binding: CommonBinding(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                } else {
                  Get.to(
                    () => PackageDetailPage(sectionName: "Package"),
                    arguments: data.itemId,
                    binding: CommonBinding(),
                    transition: Transition.fadeIn,
                    duration: const Duration(milliseconds: 500),
                  );
                }
              },
              originalPrice: data.itemPrice,
              memberPrice: data.membershipOfferPrice?.toString() ?? "",
              type: data.itemType.toString(),
              size: size,
            ),
          ),
        );
      },
    );
  }

  Widget _buildOfferCard(
    imageUrl,
    title,
    var daysLeft,
    VoidCallback onTapDetails, {
    isBrowseEnabled,
    required originalPrice,
    required String memberPrice,
    required String type,
    required Size size,
  }) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: () => onTapDetails(),
      child: Container(
        width: size.width * 0.60,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          //border: Border.all(color: AppColor.dynamicColor.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(12.r),
          color: AppColor().whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // --- Background image ---
              CommonNetworkImageWidget(
                imageUrl: imageUrl.toString(),
                height: isBrowseEnabled ? 235.h : 335.h,
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(12.r),
              ),

              // --- Gradient overlay for bottom readability ---
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.60),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 80.h,
                left: 12.w,
                right: 12.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (type.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.dynamicColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          type.capitalizeFirst ?? type,
                          style:  AppTypography.galanoGrostesqueSemiBold.copyWith(
                            fontSize: 12.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Text(
                      title.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                          color: Colors.white,
                          fontSize: 20.sp,
                          height: 1.2),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.h,
                left: 12.w,
                right: 12.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          memberPrice,
                          style: AppTypography.hostGroteskRegular.copyWith(
                            color: AppColor().whiteColor,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          "Member",
                          style: AppTypography.hostGroteskRegular.copyWith(
                              color: AppColor().whiteColor,
                              fontSize: 14.sp,
                              ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: AppColor.dynamicColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCardForBrowse(
    imageUrl,
    title,
    var daysLeft,
    VoidCallback onTapDetails, {
    isBrowseEnabled,
    required originalPrice,
    required String memberPrice,
    required String type,
    required Size size,
  }) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: () => onTapDetails(),
      child: Container(
        width: size.width * 0.60,
        margin: EdgeInsets.only(right: 10.w),
        decoration: BoxDecoration(
          //border: Border.all(color: AppColor.dynamicColor.withValues(alpha: 0.4)),
          borderRadius: BorderRadius.circular(12.r),
          color: AppColor().whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            children: [
              // --- Background image ---
              CommonNetworkImageWidget(
                imageUrl: imageUrl.toString(),
                height: isBrowseEnabled ? 235.h : 335.h,
                width: double.infinity,
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(12.r),
              ),

              // --- Gradient overlay for bottom readability ---
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.60),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 16.h,
                left: 12.w,
                right: 12.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (type.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.dynamicColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          type.capitalizeFirst ?? type,
                          style: AppTypography.hostGroteskRegular.copyWith(
                              fontSize: 12.sp,
                              color: Colors.white,
                             ),
                        ),
                      ),
                    Text(
                      title.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                          color: Colors.white,
                          fontSize: 20.sp,
                          height: 1.4),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16.h,
                left: 12.w,
                right: 12.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          memberPrice,
                          style: AppTypography.hostGroteskRegular.copyWith(
                            color: AppColor().whiteColor,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          "Member",
                          style: AppTypography.hostGroteskRegular.copyWith(
                            color: AppColor().whiteColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 30.w,
                      width: 30.w,
                      decoration: BoxDecoration(
                        color: AppColor.dynamicColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12.h,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
