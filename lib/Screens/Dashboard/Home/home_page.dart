import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/best_selling_section.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/browse_section.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/home_page_section.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/membership_page_section.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/schedule_visit_section.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/special_offer_section.dart';
import 'package:chino_hills/util/route_manager.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upgrader/upgrader.dart';
import '../../../CSS/appTypography.dart';
import '../../../common_Widgets/common_refer_widget.dart';
import '../../../loading/cart_list_load.dart';
import '../../../util/common_page.dart';
import '../../Reward/controller/reward_details_controller.dart';
import '../../cartList/Controller/cart_controller.dart';
import '../../shop/controller/shop_controller.dart';
import 'package:icons_plus/icons_plus.dart';

class HomePage extends StatelessWidget {
  final String logoPath;
  final bool isLogoLoading;
  final VoidCallback onBrowseByConcernOnTap;
  final VoidCallback onTap;
  final VoidCallback shopAllMemberOnTap;
  final VoidCallback exploreAllServiceOnTap;
  final VoidCallback discoverMoreOnTap;
  final ShopController shopController = Get.put(ShopController());
  RewardDetailsController reward = Get.put(RewardDetailsController());
  ScrollController scrollController = ScrollController();
  final Function(int)? onPageChanged;

  HomePage(
    this.logoPath,
    this.isLogoLoading, {
    super.key,
    required this.discoverMoreOnTap,
    required this.onTap,
    required this.onBrowseByConcernOnTap,
    required this.shopAllMemberOnTap,
    required this.exploreAllServiceOnTap,
    required this.scrollController,
    this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: GetBuilder<ShopController>(
        builder: (controller) => controller.load
            ? Shimmer.fromColors(
                baseColor: AppColor().greyColor.withOpacity(.3),
                highlightColor: AppColor().greyColor.withOpacity(.1),
                child: HomePageLoad())
            : LiquidPullToRefresh(
                animSpeedFactor: 1.5,
                springAnimationDurationInMilliseconds: 400,
                color: AppColor.dynamicColor,
                showChildOpacityTransition: false,
                key: controller.refreshIndicatorKey,
                onRefresh: controller.handleRefresh,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          controller.homeData == null ||
                                  controller.homeData.isEmpty
                              ? SizedBox.shrink()
                              : PageView(
                                  scrollDirection: Axis.vertical,
                                  controller: controller.pageController,
                                  onPageChanged: (index) {
                                    controller.onPageChanged(index);
                                    if (onPageChanged != null) {
                                      onPageChanged!(index);
                                    }
                                  },
                                  children: [
                                    HomePageSection(),
                                    MembershipPageSection(
                                      shopAllMemberOnTap: () {
                                        shopAllMemberOnTap();
                                      },
                                    ),
                                    BrowseSection(
                                      onBrowseByConcernOnTap: () {
                                        onBrowseByConcernOnTap();
                                      },
                                      isBrowse: false,
                                    ),
                                    if (controller
                                        .homeData[0].bestSelling!.isNotEmpty)
                                      BestSellingSection(
                                        onTap: onTap,
                                        exploreAllServiceOnTap:
                                            exploreAllServiceOnTap,
                                      ),
                                    if (controller
                                        .homeData[0].offerCards!.isNotEmpty)
                                      SpecialOfferSection(
                                          discoverMoreOnTap: discoverMoreOnTap),
                                    ScheduleSection(),
                                    CommonReferWidget(),
                                  ],
                                ),
                          Positioned(
                              child: Container(
                            height: 50.h,
                            width: double.infinity,
                            color: AppColor().transparent,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 12.w),
                                  child: Text(
                                    "Home",
                                    style: AppTypography.hostGroteskSemiBold
                                        .copyWith(
                                      fontSize:
                                          isTablet(context) ? 22.sp : 17.sp,
                                      color: AppColor().blackColor,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  splashColor: AppColor().transparent,
                                  highlightColor: AppColor().transparent,
                                  onTap: () =>
                                      Get.toNamed(RouteManager.searchPage),
                                  child: SizedBox(
                                    height: 30.h,
                                    width: 30.w,
                                    child: Icon(Iconsax.search_normal_outline,
                                        size: isTablet(context) ? 30.h : 20.h),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                GetBuilder<CartController>(
                                  builder: (cartController) {
                                    return InkWell(
                                      splashColor: AppColor().transparent,
                                      highlightColor: AppColor().transparent,
                                      child: Badge.count(
                                        count:
                                            cartController.cartItemCount ?? 0,
                                        backgroundColor: AppColor.dynamicColor,
                                        textStyle: AppTypography
                                            .hostGroteskRegular
                                            .copyWith(
                                          fontSize: 10.sp,
                                          color: AppColor().whiteColor,
                                        ),
                                        child: Icon(
                                          Iconsax.shopping_bag_outline,
                                          size: isTablet(context) ? 30.h : 22.h,
                                        ),
                                      ),
                                      onTap: () {
                                        Get.put(() => CartController());
                                        Get.toNamed(RouteManager.cartList);
                                      },
                                    );
                                  },
                                ),
                                SizedBox(width: 10.w),
                                InkWell(
                                  splashColor: AppColor().transparent,
                                  highlightColor: AppColor().transparent,
                                  onTap: () =>
                                      Get.toNamed(RouteManager.settingsTab),
                                  child: SizedBox(
                                      height: 30.h,
                                      width: 30.w,
                                      child: Icon(Iconsax.user_outline,
                                          size:
                                              isTablet(context) ? 30.h : 20.h)),
                                ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                )),
      ),
    );
  }
}
