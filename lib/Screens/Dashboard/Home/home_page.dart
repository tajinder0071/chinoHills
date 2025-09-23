import 'package:chino_hills/Screens/Dashboard/Home/widget/become_a_member.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/best_selling_widget.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/special_offers_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:upgrader/upgrader.dart';
import '../../../CSS/app_strings.dart';
import '../../../CSS/color.dart';
import '../../../CSS/image_page.dart';
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
  final VoidCallback onTap;
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
    required this.onTap,
    required this.onBrowseByConcernOnTap,
    required this.shopAllMemberOnTap,
    required this.exploreAllServiceIOnTap,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

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
                SizedBox(height: mediaQuery.height * 0.01),
                buildWelcomeSection(controller),
                // SizedBox(height: mediaQuery.height * 0.01),
                controller.homeData.isEmpty
                    ? SizedBox.shrink()
                    : buildRewardSection(context, controller),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: mediaQuery.width * 0.15,
                  ),
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        Get.toNamed(RouteManager.qRCodeScannerPage)!.then((
                          onValue,
                        ) {
                          shopController.homeApi();
                        }),
                    icon: Image.asset(
                      AppImages.qrImage,
                      height: mediaQuery.height * 0.03,
                      color: Colors.white,
                    ),
                    label: Text(
                      AppStrings.checkInForRewards,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.dynamicColor,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.width * 0.05,
                        vertical: mediaQuery.height * 0.015,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: mediaQuery.height * 0.03),
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
                SizedBox(height: mediaQuery.height * 0.03),
                Container(
                  color: AppColor().greyColor.withValues(alpha: 0.1),
                  padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
                  child: Column(
                    children: [
                      BestSellingWidget(
                        onBrowseByConcernOnTap: () {},
                        onTap: onTap,
                      ),
                      SizedBox(height: mediaQuery.height * 0.03),
                    ],
                  ),
                ),
                controller.homeData.isEmpty
                    ? SizedBox.shrink()
                    : controller.homeData[0].offerCards!.isEmpty
                    ? SizedBox.shrink()
                    : SpecialOffersWidget(
                        discoverMoreTap: discoverMoreOnTap,
                        isShowAll: true,
                        offerData: controller.homeData[0].offerCards,
                      ),
                SizedBox(height: mediaQuery.height * 0.03),
                connectWithUs(),
                SizedBox(height: mediaQuery.height * 0.03),
                CommonReferWidget(),
                SizedBox(height: mediaQuery.height * 0.03),
                getBrand(),
                SizedBox(height: mediaQuery.height * 0.015),
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

    var mediaQuery = MediaQuery.of(Get.context!).size;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: mediaQuery.height * 0.03),
      child: Text(
        "${getGreeting()}, ${controller.userName == "" || controller.userName == null ? "" : controller.userName.toString().toUpperCase()}",
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          fontSize: 16.sp,
          color: AppColor.dynamicColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget buildRewardSection(context, ShopController controller) {
    var mediaQuery = MediaQuery.of(Get.context!).size;
    return Padding(
      padding: EdgeInsets.only(
        left: mediaQuery.height * 0.01,
        right: mediaQuery.height * 0.01,
      ),
      child: Column(
        children: [
          controller.homeData.isEmpty
              ? SizedBox.shrink()
              : Text(
                  'Only ${double.parse(controller.homeData[0].unlockAtCount.toString()).toInt()} more visit or spend ${formatCurrency(controller.homeData[0].unlockSpend.toString())} for your next reward!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          SizedBox(height: mediaQuery.height * 0.01),
          Text(
            AppStrings.scanText,
            textAlign: TextAlign.center,
            style: GoogleFonts.merriweather(
              fontSize: 15.sp,
              color: AppColor().greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: mediaQuery.height * 0.02),
        ],
      ),
    );
  }

  Widget buildNimaRewardImageSection(ShopController controller, context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.52,
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
                        height: size.height * 0.45,
                        width: double.infinity,
                        color: AppColor.geryBackGroundColor,
                        child: Center(
                          child: Image.asset(
                            AppImages.noAvailableImage,
                            color: AppColor().blackColor,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    child: Container(
                      height: size.height * 0.52,
                      width: double.infinity,
                      color: AppColor().blackColor.withOpacity(.1),
                    ),
                  ),
                  Positioned(
                    bottom: size.height * 0.03,
                    left: size.width * 0.03,
                    right: size.width * 0.03,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            controller.homeData[0].mainheader
                                .toString()
                                .toUpperCase(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.merriweather(
                              fontSize: 35.sp,
                              color: AppColor().whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          Text(
                            controller.homeData[0].subheader.toString(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.merriweather(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor().whiteColor,
                            ),
                          ),
                        ],
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
                              height: size.height * 0.3,
                              width: double.infinity,
                              color: AppColor.geryBackGroundColor,
                              child: Center(
                                child: Image.asset(
                                  AppImages.noAvailableImage,
                                  color: AppColor().blackColor,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          child: Container(
                            height: size.height * 0.52,
                            width: double.infinity,
                            color: AppColor().blackColor.withOpacity(.1),
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.03,
                          left: size.width * 0.03,
                          right: size.width * 0.03,
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  controller.homeData[0].mainheader
                                      .toString()
                                      .toUpperCase(),
                                  style: GoogleFonts.merriweather(
                                    fontSize: 35.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: size.height * 0.02),
                                Text(
                                  controller.homeData[0].subheader.toString(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.merriweather(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor().whiteColor,
                                  ),
                                ),
                              ],
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
                            height: size.height * 0.3,
                            width: double.infinity,
                            color: AppColor.geryBackGroundColor,
                            child: Center(
                              child: Image.asset(
                                AppImages.noAvailableImage,
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
                          padding: EdgeInsets.only(
                            bottom: size.height * 0.03,
                            left: size.width * 0.03,
                            right: size.width * 0.03,
                          ),
                          child: Text(
                            data.title!.toUpperCase(),
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
    var size = MediaQuery.of(Get.context!).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.01,
              vertical: size.height * 0.01,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.dynamicColor),
            ),
            child: Icon(Icons.question_mark, color: AppColor.dynamicColor),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            AppStrings.browseConcern.toUpperCase(),
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.dynamicColor,
            ),
          ),
          SizedBox(height: size.height * 0.03),
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
                    height: size.height * 0.25,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : ConstantNetworkImage(
                    imageUrl: "${controller.homeData[0].concernsImage}",
                    width: double.infinity,
                    height: size.height * 0.25,
                    errorWidget: Center(child: Text("No Image Available")),
                    isLoad: true,
                    boxFit: BoxFit.cover,
                  ),
          ),
          SizedBox(height: size.height * 0.02),
          Text(
            AppStrings.chooseTreatment,
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(
              fontSize: 27.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            "Find the best options for you in just a few clicks.",
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: 16.sp,
              color: AppColor().greyColor,
            ),
          ),
          SizedBox(height: size.height * 0.02),
          CommonButtonWidget(
            onTap: onShopPage,
            buttonName: 'Browse by Concern',
          ),
        ],
      ),
    );
  }

  Widget connectWithUs() {
    var size = MediaQuery.of(Get.context!).size;
    return Padding(
      padding: EdgeInsets.all(size.height * 0.02),
      child: Column(
        children: [
          Text(
            "connect with us".toUpperCase(),
            style: TextStyle(
              color: AppColor.dynamicColor,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.04),
          Image.network(logoPath.toString()),
          SizedBox(height: size.height * 0.04),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColor.dynamicColor,
                size: size.height * 0.035,
              ),
              SizedBox(height: size.width * 0.03),
              Expanded(
                child: Text(
                  "19782 MacArthur Blvd Suite 225, Irvine , CA 92612",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.dynamicColor,
                    color: AppColor.dynamicColor,
                    fontSize: 15.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.02),
          Row(
            children: [
              Icon(
                Icons.local_phone_outlined,
                color: AppColor.dynamicColor,
                size: size.height * 0.035,
              ),
              SizedBox(height: size.width * 0.04),
              Expanded(
                child: Text(
                  "(949) 763-9255",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.dynamicColor,
                    color: AppColor.dynamicColor,
                    fontSize: 15.h,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          CommonButtonWidget(onTap: () {}, buttonName: "Schedule your visit"),
        ],
      ),
    );
  }
}
