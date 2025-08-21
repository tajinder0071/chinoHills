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
import '../../../CSS/color.dart';
import '../../../common_Widgets/cacheNetworkImage.dart';
import '../../../common_Widgets/common_button_widget.dart';
import '../../../common_Widgets/common_refer_widget.dart';
import '../../../util/common_page.dart';
import '../../../util/route_manager.dart';
import '../../shop/controller/shop_controller.dart';

class HomePage extends StatelessWidget {
  HomePage(
    this.logoPath,
    this.isLogoLoading, {
    super.key,
    required this.discoverMoreOnTap,
    required this.onBrowseByConcernOnTap,
    required this.shopAllMemberOnTap,
    required this.exploreAllServiceIOnTap,
  });

  ShopController shopController = Get.put(ShopController());

  //TODO:Variables are declared here.
  var logoPath, isLogoLoading;
  final VoidCallback onBrowseByConcernOnTap,
      shopAllMemberOnTap,
      exploreAllServiceIOnTap,
      discoverMoreOnTap;

  //TODO: Page starts here
  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: GetBuilder<ShopController>(
        init: ShopController(),
        builder: (controller) => LiquidPullToRefresh(
          animSpeedFactor: 1.5,
          springAnimationDurationInMilliseconds: 400,
          color: AppColor.dynamicColor,
          showChildOpacityTransition: false,
          key: controller.refreshIndicatorKey,
          onRefresh: controller.handleRefresh,
          child: SingleChildScrollView(
            child: Column(
              //Todo all the section inside thos colum are define below at the end as common widgets
              children: [
                //TODO: Welcome Text Section
                buildWelcomeSection(controller),
                //TODO: Reward Section
                controller.datum.isEmpty
                    ? SizedBox.shrink()
                    : buildRewardSection(context, controller),
                //TODO: NIMA Rewards Image Section
                buildNimaRewardImageSection(controller, context),
                //TODO: Become a Member Section
                BecomeAMember(onPressed: () => shopAllMemberOnTap()),
                SizedBox(height: 15.h),
                //TODO: Browse by Concern Section
                buildBrowseByConcernSection(controller, onBrowseByConcernOnTap),
                SizedBox(height: 25.h),
                //TODO: Best Selling Section (Conditionally Rendered)
                if (shopController.package.isEmpty &&
                    shopController.treatment.isEmpty)
                  SizedBox.shrink()
                else
                  BestSellingWidget(
                    isEnable: true,
                    onBrowseByConcernOnTap: exploreAllServiceIOnTap,
                  ),
                // TODO >>  Special Offers
                (shopController.specialDataList.isNotEmpty)
                    ? SpecialOffersWidget(
                        discoverMoreTap: discoverMoreOnTap,
                        isShowAll: true,
                      )
                    : SizedBox.shrink(),
                //TODO >> Refer a Friend Section
                CommonReferWidget(),
                SizedBox(height: 10.h),
                //Todo >> Brand Section
                getBrand(),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: Method to Build Welcome Section
  Widget buildWelcomeSection(ShopController controller) {
    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) {
        return "Good Morning";
      } else if (hour < 17) {
        return "Good Afternoon";
      } else {
        return "Good Evening";
      }
    }

    return Column(
      children: [
        SizedBox(height: 15.h),
        Text(
          "${getGreeting()}, ${controller.userName.toString().toUpperCase()}",
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 17.sp,
            color: AppColor.dynamicColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  //TODO: Method to Build Reward Section
  Widget buildRewardSection(context, ShopController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 15.h,
        bottom: 15.h,
        left: 10.w,
        right: 10.w,
      ),
      child: Column(
        children: [
          //
          controller.datum.isEmpty
              ? SizedBox.shrink()
              : Text(
                  'Just ${int.parse(controller.datum[0].visitLeft.toString().replaceAll(".0", ""))} more visit or spend \$${controller.datum[0].unlocksAt.toString().replaceAll(".0", "")} for your next reward!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sarabun(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          SizedBox(height: 4.h),
          Text(
            "Scan in store or shop in-app to get closer to your next reward.",
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(
              fontSize: 16.sp,
              color: AppColor().greyColor,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton.icon(
            onPressed: () => Get.toNamed(RouteManager.qRCodeScannerPage),
            icon: Icon(AntDesign.scan_outline, color: Colors.white, size: 23.h),
            label: Text(
              "Check in for rewards",
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
                horizontal: 20.h,
                vertical: isTablet(context) ? 5.h : 12.w,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //TODO: Method to Build NIMA Reward Image Section
  Widget buildNimaRewardImageSection(ShopController controller, context) {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: isTablet(context)
                  ? MediaQuery.of(context).size.height * .65
                  : 450.h,
              width: double.infinity,
              child: controller.homeData.isEmpty
                  ? Center(child: commonLoader(color: AppColor.dynamicColor))
                  : ConstantNetworkImage(
                      imageUrl: "${controller.homeData[0].headerImage}",
                      errorWidget: Center(child: Text("No image available")),
                      isLoad: true,
                      boxFit: BoxFit.cover,
                    ),
            ),
            Positioned(
              child: Container(
                height: isTablet(context)
                    ? MediaQuery.of(context).size.height * .65
                    : 450.h,
                width: double.infinity,
                color: Colors.black12,
              ),
            ),
            Positioned(
              bottom: 10.h,
              left: 0.w,
              right: 0.w,
              child: controller.homeData.isEmpty
                  ? Text("")
                  : Column(
                      children: [
                        Text(
                          controller.homeData[0].mainheader.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.merriweather(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor().whiteColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
            ),
          ],
        ),
      ],
    );
  }

  //TODO: Method to Build Browse by Concern Section
  Widget buildBrowseByConcernSection(
    ShopController controller,
    VoidCallback onShopPage,
  ) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Not sure which treatment to choose?",
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
                  offset: const Offset(0, 3), // changes position of shadow
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
            onTap: () => onShopPage(),
            buttonName: 'Browse by Concern',
          ),
        ],
      ),
    );
  }

  //TODO: Method to Build Generic Card Component
  Widget buildCard({required Color color, required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.r),
      ),
      padding: EdgeInsets.all(16.r),
      child: child,
    );
  }
}
