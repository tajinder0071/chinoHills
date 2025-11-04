import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/become_a_member.dart';
import 'package:chino_hills/Screens/shop/Pages/Browse/widgets/our_services_widget.dart';
import 'package:chino_hills/Screens/shop/controller/shop_controller.dart';
import 'package:chino_hills/loading/become_a_member_loading.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../common_Widgets/common_refer_widget.dart';
import '../../../Dashboard/Home/widget/best_selling_widget.dart';
import '../../../Dashboard/Home/widget/browse_section.dart';
import '../../../Dashboard/Home/widget/special_offers_widget.dart';
import '../Package Page/controller/package_cotroller.dart';
import '../Treatment Page/widgets/treatment_details_page.dart';

class BrowsePage extends StatelessWidget {
  final VoidCallback onBrowseByConcernOnTap;
  final VoidCallback discoverMoreOnTap;

  BrowsePage({
    super.key,
    required this.onBrowseByConcernOnTap,
    required this.discoverMoreOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        init: Get.find<PackageController>()..getBrowserData(),
        builder: (packageController) => LiquidPullToRefresh(
              animSpeedFactor: 1.5,
              springAnimationDurationInMilliseconds: 400,
              key: packageController.refreshIndicatorKey,
              color: AppColor.dynamicColor,
              showChildOpacityTransition: false,
              onRefresh: packageController.handleRefreshForBrowsePage,
              child: packageController.isBrowserLoading
                  ? Shimmer.fromColors(
                      baseColor: AppColor().greyColor.withOpacity(.3),
                      highlightColor: AppColor().greyColor.withOpacity(.1),
                      child: ListView(
                        children: [
                          Container(
                            height: 200.h,
                            width: double.infinity,
                            color: AppColor().whiteColor,
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            height: 200.h,
                            child: BecomeAMemberLoading(),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            height: 200.h,
                            width: double.infinity,
                            color: AppColor().whiteColor,
                          ),
                        ],
                      ))
                  : packageController.browseDetailModel.data == null
                      ? SizedBox.shrink()
                      : Stack(
                          children: [
                            PageView(
                              scrollDirection: Axis.vertical,
                              controller: packageController.pageController,
                              onPageChanged: packageController.onPageChanged,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15.w, vertical: 10.h),
                                      width: double.infinity,
                                      height: 210.h,
                                      decoration: BoxDecoration(
                                        color: AppColor.dynamicColor
                                            .withOpacity(.96),
                                        borderRadius:
                                            BorderRadiusGeometry.circular(20),
                                      ),
                                      child: Stack(
                                        clipBehavior: Clip.antiAlias,
                                        children: [
                                          Positioned(
                                            right: -120,
                                            top: -100,
                                            bottom: -100,
                                            child: Image.asset(
                                              "assets/new_images/nima_logo.png",
                                              color: AppColor.dynamicColor,
                                            ),
                                          ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            bottom: 0.h,
                                            child: CommonNetworkImageWidget(
                                                imageUrl: packageController
                                                            .browseDetailModel
                                                            .data!
                                                            .headerDetails ==
                                                        null
                                                    ? "https://www.shutterstock.com/image-photo/concentrated-millennial-girl-sit-on-600nw-2473271475.jpg"
                                                    : "${packageController.browseDetailModel.data!.headerDetails!.headerimage}",
                                                height: 300.h,
                                                width: 250.w,
                                                borderRadius:
                                                    BorderRadius.only(),
                                                fit: BoxFit.contain),
                                          ),
                                          Positioned(
                                            left: 0,
                                            top: 0,
                                            right: 0,
                                            bottom: -200.h,
                                            child: Container(
                                              height: 300.h,
                                              width: 330.w,
                                              decoration: BoxDecoration(
                                                gradient: RadialGradient(
                                                  colors: [
                                                    AppColor().transparent,
                                                    AppColor.dynamicColor,
                                                  ],
                                                  center: Alignment.topCenter,
                                                  radius: 0.7,
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Positioned(
                                          //     top: 20,left: 20.w,
                                          //     child: CommonBadgeContainer(
                                          //       outerSize: 50,
                                          //       icon: Icons.check_rounded,
                                          //       iconSize: 14,
                                          //     )),
                                          Positioned(
                                            bottom: 20.h,
                                            child: SizedBox(
                                              width: 300.w,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(left: 20.w),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      packageController
                                                                  .browseDetailModel
                                                                  .data!
                                                                  .headerDetails ==
                                                              null
                                                          ? ""
                                                          : "${packageController.browseDetailModel.data!.headerDetails!.mainheader}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTypography
                                                          .galanoGrostesqueSemiBold
                                                          .copyWith(
                                                              color:
                                                                  AppColor().whiteColor,
                                                              fontSize: 22.sp,
                                                              height: 0.9.h),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Text(
                                                      packageController
                                                                  .browseDetailModel
                                                                  .data!
                                                                  .headerDetails ==
                                                              null
                                                          ? ""
                                                          : "${packageController.browseDetailModel.data!.headerDetails!.promotiontitle}",
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTypography
                                                          .hostGroteskRegular
                                                          .copyWith(
                                                        color: AppColor().whiteColor,
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                    Text(
                                                      packageController
                                                                  .browseDetailModel
                                                                  .data!
                                                                  .headerDetails ==
                                                              null
                                                          ? ""
                                                          : "${packageController.browseDetailModel.data!.headerDetails!.promotiondetails}",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: AppTypography
                                                          .hostGroteskRegular
                                                          .copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppColor()
                                                            .whiteColor,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.h),
                                                    packageController
                                                            .browseDetailModel
                                                            .data!
                                                            .headerDetails!
                                                            .browseServices!
                                                            .isEmpty
                                                        ? SizedBox.shrink()
                                                        : InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                  () =>
                                                                      TreatmentDetailsPage(),
                                                                  binding:
                                                                      CommonBinding(),
                                                                  transition:
                                                                      Transition
                                                                          .fadeIn,
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  arguments: packageController
                                                                              .browseDetailModel
                                                                              .data ==
                                                                          null
                                                                      ? 0
                                                                      : packageController
                                                                          .browseDetailModel
                                                                          .data!
                                                                          .headerDetails!
                                                                          .browseServices);
                                                            },
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10.w,
                                                                      vertical:
                                                                          5.h),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(6
                                                                              .r),
                                                                  color: AppColor()
                                                                      .whiteColor),
                                                              child: Text(
                                                                AppStrings
                                                                    .shopNow,
                                                                style: AppTypography
                                                                    .hostGroteskRegular
                                                                    .copyWith(
                                                                        color: AppColor
                                                                            .dynamicColor,
                                                                        fontSize:
                                                                            15.sp),
                                                              ),
                                                            ),
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    packageController.browseDetailModel.data ==
                                            null
                                        ? SizedBox.shrink()
                                        : packageController.browseDetailModel
                                                .data!.bestSelling!.isNotEmpty
                                            ? BestSellingWidget(
                                                isBrowse: true,
                                                exploreAllServiceOnTap: () {},
                                                onTap: () {},
                                                showExploreAllService: false,
                                              )
                                            : SizedBox.shrink(),
                                  ],
                                ),
                                //Our Services Section is here...
                                if (packageController.browseCategory.isNotEmpty)
                                  OurServicesPage(),
                                //Membership Services Section is here...
                                GetBuilder<PackageController>(
                                    builder: (packageController) {
                                  return BecomeAMember(
                                    isBrowse: true,
                                    onPressed: () {
                                      ShopController.shop
                                          .goToTabByName(AppStrings.membership);
                                    },
                                    data: [],
                                    perks: [],
                                  );
                                }),
                                //Browse Services Section is here...
                                BrowseSection(
                                    onBrowseByConcernOnTap: () {
                                      onBrowseByConcernOnTap();
                                    },
                                    isBrowse: true),
                                // Special Offers
                                if (packageController.offerCards.isNotEmpty)
                                  GetBuilder<PackageController>(
                                      builder: (controller) {
                                    return packageController.browseDetailModel
                                            .data!.offerCards!.isEmpty
                                        ? SizedBox.shrink()
                                        : SpecialOffersWidget(
                                            discoverMoreTap: () {},
                                            isShowAll: false,
                                            offerData: packageController
                                                .browseDetailModel
                                                .data!
                                                .offerCards!,
                                          );
                                  }),
                                CommonReferWidget(),
                              ],
                            ),
                          ],
                        ),
            ));
  }
}
