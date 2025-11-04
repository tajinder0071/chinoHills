import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../CSS/image_page.dart';
import '../../../../common_Widgets/common_badge_container.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../util/common_page.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/browse_Concern_load.dart' show BrowseConcernLoad;
import '../../../../util/route_manager.dart';
import '../Package Page/controller/package_cotroller.dart';

class BrowseByConcernPage extends StatelessWidget {
  const BrowseByConcernPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().whiteColor,
      body: GetBuilder<PackageController>(
          init: Get.find<PackageController>()..browseList(),
          builder: (controller) {
            return controller.bload
                ? Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Column(
                      children: [
                        Container(
                          height: 200.h,
                          width: double.infinity,
                          color: AppColor().whiteColor,
                        ),
                        Expanded(child: BrowseConcernLoad())
                      ],
                    ))
                : controller.browseImageDatum.isEmpty
                    ? Center(
                        child: NoRecord(
                          AppStrings.noDataFound,
                          Icon(Icons.no_accounts),
                          AppStrings.weAreSorryNoBrowseDataAvailable,
                        ),
                      )
                    : LiquidPullToRefresh(
                        animSpeedFactor: 1.5,
                        springAnimationDurationInMilliseconds: 400,
                        key: controller.refreshIndicatorKey,
                        color: AppColor.dynamicColor,
                        showChildOpacityTransition: false,
                        backgroundColor: Colors.white,
                        onRefresh: controller.handleRefreshBrows,
                        child: ListView(
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 10.h),
                              width: double.infinity,
                              height: 220.h,
                              decoration: BoxDecoration(
                                color: AppColor.dynamicColor.withOpacity(.96),
                                borderRadius: BorderRadiusGeometry.circular(20),
                              ),
                              child: Stack(
                                clipBehavior: Clip.antiAlias,
                                children: [
                                  Positioned(
                                    right: -120,
                                    top: -100,
                                    bottom: -100,
                                    child: Image.asset(
                                      AppImages.nimaLogo,
                                      color: AppColor.dynamicColor,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    bottom: 0.h,
                                    child: CommonNetworkImageWidget(
                                        imageUrl: CommonPage().image_url +
                                            controller.browseImageDatum[0]
                                                .concernsImage
                                                .toString(),
                                        height: 300.h,
                                        width: 250.w,
                                        borderRadius: BorderRadius.only(),
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
                                            Colors.transparent,
                                            AppColor.dynamicColor,
                                          ],
                                          center: Alignment.topCenter,
                                          radius: 0.7,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 20,
                                      left: 20.w,
                                      child: CommonBadgeContainer(
                                        outerSize: 50,
                                        icon: Icons.check_rounded,
                                        iconSize: 14,
                                      )),
                                  Positioned(
                                    bottom: 20.h,
                                    child: SizedBox(
                                      width: 200.w,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20.w),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              AppStrings.browseByConcernNormal,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                                                  color: Colors.white,
                                                  fontSize: 22.sp,
                                                  fontWeight: FontWeight.bold,
                                                  height: 0.9.h),
                                            ),
                                            SizedBox(height: 5.h),
                                            Text(
                                              AppStrings.selectFromPopular,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTypography.hostGroteskSemiBold.copyWith(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            controller.browseImageDatum.isEmpty
                                ? SizedBox(height: 20.0)
                                : SizedBox.shrink(),
                            controller.browseImageDatum.isEmpty
                                ? Center(
                                    child: NoRecord(
                                      AppStrings.noDataFound,
                                      Icon(Icons.no_accounts),
                                      AppStrings
                                          .weAreSorryNoBrowseDataAvailable,
                                    ),
                                  )
                                : ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.browseDatum.length,
                                    itemBuilder: (context, index) => Container(
                                          margin: EdgeInsets.all(6.h),
                                          padding: EdgeInsets.symmetric(vertical: 8.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              color: AppColor().lightGrey),
                                          child: ListTile(
                                              onTap: () => Get.toNamed(
                                                  RouteManager
                                                      .browseConcernDetail,
                                                  arguments: controller
                                                      .browseDatum[index].id),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      controller
                                                          .browseDatum[index]
                                                          .concernName
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTypography
                                                          .galanoGrostesqueSemiBold
                                                          .copyWith(
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${controller.browseDatum[index].treatmentCount.toString().replaceAll(".0", "")} treatments",
                                                    style: AppTypography
                                                        .hostGroteskRegular
                                                        .copyWith(
                                                            fontSize: 13.sp,
                                                            color: Colors
                                                                .grey[800]),
                                                  ),
                                                ],
                                              ),
                                              trailing: CircleAvatar(
                                                backgroundColor:
                                                    AppColor.dynamicColor,
                                                child: Icon(
                                                    Icons.keyboard_arrow_right,
                                                    color:
                                                        AppColor().whiteColor),
                                              ),
                                              contentPadding: EdgeInsets.only(
                                                  left: 10.w, right: 10.w)),
                                        )),
                            SizedBox(height: 20.h),
                            getBrand(),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      );
          }),
    );
  }
}
