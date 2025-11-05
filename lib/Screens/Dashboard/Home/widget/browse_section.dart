import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../CSS/image_page.dart';
import '../../../../common_Widgets/common_badge_container.dart';
import '../../../../common_Widgets/cacheNetworkImage.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../shop/controller/shop_controller.dart';

class BrowseSection extends StatelessWidget {
  final VoidCallback onBrowseByConcernOnTap;
  bool isBrowse;

  BrowseSection({
    super.key,
    required this.onBrowseByConcernOnTap,
    required this.isBrowse,
  });

  final controller = Get.put(ShopController());
  var mediaQuery = MediaQuery
      .of(Get.context!)
      .size;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.dynamicColor,
      body: Stack(
        children: [
          Positioned.fill(
            top: 0.h,
            right: 0.w,
            left: 0.w,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration:
              BoxDecoration(color: AppColor().whiteColor, boxShadow: [
                BoxShadow(
                  color: AppColor().greyColor.withValues(alpha: 0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ]),
              child: controller.homeData.isEmpty
                  ? SizedBox(
                height: mediaQuery.height * 0.25,
                child: Center(child: CircularProgressIndicator()),
              )
                  : ConstantNetworkImage(
                imageUrl: "${controller.homeData[0].concernsImage}",
                width: double.infinity,
                height: mediaQuery.height * 0.25,
                errorWidget: Container(
                  height: mediaQuery.height * 0.3,
                  width: double.infinity,
                  color: AppColor.geryBackGroundColor,
                  child: Center(
                    child: Image.asset(
                      AppImages.noAvailableImage,
                      color: AppColor().blackColor,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                isLoad: true,
                boxFit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
              child: Image.asset(
                "assets/new_images/browse_section_background.png",
                fit: BoxFit.fill,
              )),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColor().blackColor.withValues(alpha: 0.40),
                    AppColor().blackColor.withValues(alpha: 0.40),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: 40.h,
              left: 0.w,
              right: 0.w,
              child: buildBrowseByConcernSection(
                  context, controller, onBrowseByConcernOnTap)),
        ],
      ),
    );
  }

  Widget buildBrowseByConcernSection(BuildContext context,
      ShopController controller, VoidCallback onShopPage) {
    var size = MediaQuery
        .of(Get.context!)
        .size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonBadgeContainer(
            icon: Icons.question_mark_rounded,
            iconSize: 15.h,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            AppStrings.browseConcern.toUpperCase(),
            textAlign: TextAlign.start,
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                fontSize: 26.sp, color: AppColor().whiteColor, height: 1.h),
          ),
          isBrowse
              ? SizedBox(height: size.height * 0.23)
              : SizedBox(height: size.height * 0.35),
          Text(
            AppStrings.chooseTreatment.toUpperCase(),
            textAlign: TextAlign.start,
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
              fontSize: 26.sp,
              height: 0.9.h,
              color: AppColor().whiteColor,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            "Find The Best Options For You\nIn Just A Few Clicks.",
            textAlign: TextAlign.start,
            style: AppTypography.hostGroteskRegular
                .copyWith(fontSize: 14.sp, color: AppColor().whiteColor),
          ),
          SizedBox(height: size.height * 0.01),
          CommonButtonWidget(
            innerColor: AppColor.dynamicColor,
            onTap: onShopPage,
            buttonName: 'Browse By Concern',
          ),
        ],
      ),
    );
  }
}
