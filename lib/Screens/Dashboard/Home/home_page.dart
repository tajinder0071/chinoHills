import 'package:chino_hills/Screens/Dashboard/Home/widget/become_a_member.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/best_selling_widget.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/special_offers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:upgrader/upgrader.dart';
import '../../../CSS/app_strings.dart';
import '../../../CSS/color.dart';
import '../../../common_Widgets/cacheNetworkImage.dart';
import '../../../common_Widgets/common_button_widget.dart';
import '../../../common_Widgets/common_refer_widget.dart';
import '../../../util/common_page.dart';
import '../../../util/route_manager.dart';
import '../../Reward/controller/reward_details_controller.dart';
import '../../shop/controller/shop_controller.dart';

class HomePage extends StatelessWidget {
  final String logoPath;
  final bool isLogoLoading;
  final VoidCallback onBrowseByConcernOnTap;
  final VoidCallback shopAllMemberOnTap;
  final VoidCallback exploreAllServiceIOnTap;
  final VoidCallback discoverMoreOnTap;
  final ShopController shopController = Get.put(ShopController());
  RewardDetailsController reward = Get.put(RewardDetailsController());

  HomePage(
    this.logoPath,
    this.isLogoLoading, {
    super.key,
    required this.discoverMoreOnTap,
    required this.onBrowseByConcernOnTap,
    required this.shopAllMemberOnTap,
    required this.exploreAllServiceIOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: GetBuilder<ShopController>(
        builder: (controller) => LiquidPullToRefresh(
          animSpeedFactor: 1.5,
          springAnimationDurationInMilliseconds: 400,
          color: AppColor.dynamicColor,
          showChildOpacityTransition: false,
          key: controller.refreshIndicatorKey,
          onRefresh: controller.handleRefresh,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.h),
                buildWelcomeSection(controller),
                SizedBox(height: 10.h),
                controller.homeData.isEmpty
                    ? SizedBox.shrink()
                    : buildRewardSection(context, controller),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        Get.toNamed(RouteManager.qRCodeScannerPage)!.then((
                          onValue,
                        ) {
                          shopController.homeApi();
                        }),
                    icon: Icon(
                      AntDesign.scan_outline,
                      color: Colors.white,
                      size: 23.h,
                    ),
                    label: Text(
                      AppStrings.checkInForRewards,
                      style: GoogleFonts.sarabun(
                        color: Colors.white,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.dynamicColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.h,
                        vertical: isTablet(context) ? 5.h : 12.w,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                buildNimaRewardImageSection(controller, context),
                controller.homeData.isEmpty
                    ? SizedBox.shrink()
                    : BecomeAMember(
                        onPressed: shopAllMemberOnTap,
                        data: controller.homeData[0].memberships,
                        perks: controller.homeData[0].membershipPerks,
                        membershipPerkHeader:
                            controller.homeData[0].membershipsPerksHeader,
                      ),
                buildBrowseByConcernSection(controller, onBrowseByConcernOnTap),
                SizedBox(height: 25.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BestSellingWidget(onBrowseByConcernOnTap: () {}),
                ),
                SizedBox(height: 25.h),
                controller.homeData.isEmpty
                    ? SizedBox.shrink()
                    : controller.homeData[0].offerCards!.isEmpty
                    ? SizedBox.shrink()
                    : SpecialOffersWidget(
                        discoverMoreTap: discoverMoreOnTap,
                        isShowAll: true,
                        offerData: controller.homeData[0].offerCards,
                        // offerData: [],
                      ),
                CommonReferWidget(),
                SizedBox(height: 10.h),
                getBrand(),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWelcomeSection(ShopController controller) {
    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) {
        return "Good Morning".toUpperCase();
      } else if (hour < 17) {
        return "Good Afternoon".toUpperCase();
      } else {
        return "Good Evening".toUpperCase();
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        "${getGreeting()}, ${controller.userName == "" || controller.userName == null ? "" : controller.userName.toString().toUpperCase()}",
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          fontSize: 18.sp,
          color: AppColor.dynamicColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget buildRewardSection(context, ShopController controller) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          controller.homeData.isEmpty
              ? SizedBox.shrink()
              : Text(
                  'Just ${double.parse(controller.homeData[0].unlockAtCount.toString()).toInt()} more visit or spend ${formatCurrency(controller.homeData[0].unlockSpend.toString())} for your next reward!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sarabun(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          SizedBox(height: 4.h),
          Text(
            AppStrings.scanText,
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(
              fontSize: 16.sp,
              color: AppColor().greyColor,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget buildNimaRewardImageSection(ShopController controller, context) {
    return SizedBox(
      height: isTablet(context)
          ? MediaQuery.of(context).size.height * .65
          : 450.h,
      width: double.infinity,
      child: controller.homeData.isEmpty
          ? Center(child: commonLoader(color: AppColor.dynamicColor))
          : controller.homeData[0].announcementOffers!.isEmpty
          ? Container(
              decoration: BoxDecoration(
                color: Colors.grey[200], // fallback background
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    (controller.homeData[0].headerImage != null &&
                            controller.homeData[0].headerImage!.isNotEmpty)
                        ? controller.homeData[0].headerImage.toString()
                        : "",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.black12,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.dynamicColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250.h,
                        width: double.infinity,
                        color: AppColor.geryBackGroundColor,
                        child: Center(
                          child: Image.asset(
                            "assets/images/Image_not_available.png",
                            color: AppColor().blackColor,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 50.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        controller.homeData[0].mainheader
                            .toString()
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          /* shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(2, 2),
                                )
                              ],*/
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5.h,
                    left: 5.w,
                    right: 5.w,
                    child: Text(
                      controller.homeData[0].subheader.toString(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.merriweather(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor().whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : PageView.builder(
              controller: controller.pageController,
              itemCount:
                  (controller.homeData[0].announcementOffers?.length ?? 0) + 1,
              onPageChanged: (index) => controller.currentPage = index,
              itemBuilder: (context, index) {
                // First page -> Header Image
                if (index == 0) {
                  return Container(
                    decoration: BoxDecoration(color: Colors.grey[200]),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          (controller.homeData[0].headerImage != null &&
                                  controller
                                      .homeData[0]
                                      .headerImage!
                                      .isNotEmpty)
                              ? controller.homeData[0].headerImage.toString()
                              : "",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.black12,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.dynamicColor,
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                      : null,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 250.h,
                              width: double.infinity,
                              color: AppColor.geryBackGroundColor,
                              child: Center(
                                child: Image.asset(
                                  "assets/images/Image_not_available.png",
                                  color: AppColor().blackColor,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 50.h,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Text(
                              controller.homeData[0].mainheader
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black.withOpacity(0.6),
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            controller.homeData[0].subheader.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.merriweather(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColor().whiteColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Other pages -> Announcement Offers
                var data =
                    controller.homeData[0].announcementOffers![index - 1];
                return Container(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        (data.image != null && data.image!.isNotEmpty)
                            ? data.image.toString()
                            : "",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: Colors.black12,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: AppColor.dynamicColor,
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 250.h,
                            width: double.infinity,
                            color: AppColor.geryBackGroundColor,
                            child: Center(
                              child: Image.asset(
                                "assets/images/Image_not_available.png",
                                color: AppColor().blackColor,
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            data.title!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget buildBrowseByConcernSection(
    ShopController controller,
    VoidCallback onShopPage,
  ) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.chooseTreatment,
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(
              fontSize: 27.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15.h),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor().whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: controller.homeData.isEmpty
                ? SizedBox(
                    height: 200.h,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : ConstantNetworkImage(
                    imageUrl: "${controller.homeData[0].concernsImage}",
                    width: double.infinity,
                    height: 200.h,
                    errorWidget: Center(child: Text("No Image Available")),
                    isLoad: true,
                    boxFit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Find the best options for you in just a few clicks.",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(fontSize: 17.sp),
          ),
          SizedBox(height: 10.h),
          CommonButtonWidget(
            onTap: onShopPage,
            buttonName: 'Browse by Concern',
          ),
        ],
      ),
    );
  }
}
