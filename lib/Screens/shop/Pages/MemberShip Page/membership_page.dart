import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/util/common_page.dart';
import 'package:chino_hills/util/route_manager.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../common_Widgets/common_badge_container.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/discover_loading_page.dart';
import '../Package Page/controller/package_cotroller.dart';

class MembershipPage extends StatelessWidget {
  MembershipPage({super.key});

  final c = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
      initState: (_) => Get.find<PackageController>().memberShipList(),
      builder: (control) {
        if (control.bload) {
          return Shimmer.fromColors(
            baseColor: AppColor().greyColor.withOpacity(.3),
            highlightColor: AppColor().greyColor.withOpacity(.1),
            child: Column(
              children: [
                Container(
                  height: 150.h,
                  width: double.infinity,
                  color: AppColor().whiteColor,
                ),
                Expanded(child: MemberLoadList()),
              ],
            ),
          );
        }
        if (control.memberShip.isEmpty) {
          return Center(
            child: NoRecord(
              AppStrings.noMembershipDataFound,
              Icon(Icons.no_accounts),
              AppStrings.noMembershipDataFound,
            ),
          );
        }
        return LiquidPullToRefresh(
          animSpeedFactor: 1.5,
          springAnimationDurationInMilliseconds: 400,
          key: control.refreshIndicatorKey,
          color: AppColor.dynamicColor,
          showChildOpacityTransition: false,
          onRefresh: control.handleRefresh,
          child: ListView(
            children: [
              _buildHeaderSection(control),
              _buildMembershipList(control),
              SizedBox(height: 20.h),
              getBrand(),
              SizedBox(height: 5.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(PackageController control) {
    return
      Container(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                "assets/new_images/nima_logo.png",
                color: AppColor.dynamicColor,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0.h,
              child: CommonNetworkImageWidget(
                  imageUrl:
                  control.response.headerDetails!.headerimage.toString(),
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
                      AppColor().transparent,
                      AppColor.dynamicColor,
                    ],
                    center: Alignment.topCenter,
                    radius: 0.7,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 20.h,
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        control.response.headerDetails == null
                            ? ""
                            : control.response.headerDetails!.headerTitle
                            .toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                            color: AppColor().whiteColor,
                            fontSize: 22.sp,
                            height: 0.9.h),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        control.response.headerDetails == null
                            ? ""
                            : control.response.headerDetails!.headerDescription
                            .toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.hostGroteskRegular.copyWith(
                          color: AppColor().whiteColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildMembershipList(PackageController control) {
    return Padding(
      padding: EdgeInsets.all(8.h),
      child: ListView.builder(
        itemCount: control.memberShip.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (cc, index) => _buildMembershipCard(control, index),
      ),
    );
  }

  Widget _buildMembershipCard(PackageController control, int index) {
    final member = control.memberShip[index];

    final descriptionList = member.benefits!
        .map((b) => b.benefitTitle ?? "")
        .where((item) => item.isNotEmpty)
        .take(3)
        .toList();
    print("member.membershipId${member.membershipId}");

    return Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: InkWell(
        overlayColor: WidgetStatePropertyAll(AppColor().transparent),
        onTap: () => Get.toNamed(
          RouteManager.membersShipDetailsPage,
          arguments: control.memberShip[index].membershipId,
          parameters: {"onlyShow": "0"},
        ),
        child: Container(
          width: double.infinity,
          height: 320.h,
          margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            image: DecorationImage(
              image: NetworkImage(
                member.membershipImage.toString(),
              ),
              fit: BoxFit.cover,
              onError: (exception, stackTrace) {
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 90.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                      color: AppColor.geryBackGroundColor,
                      borderRadius: BorderRadius.circular(10.r)),
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
          ),
          child: Stack(
            children: [
              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor().blackColor.withOpacity(0.05),
                      AppColor().blackColor.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              // Top buttons
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    member.offeroffText == ""
                        ? SizedBox.shrink()
                        : _buildTopTag(
                        member.offeroffText.toString().toUpperCase()),
                    Container(
                      height: 40.w,
                      width: 40.w,
                      decoration: BoxDecoration(
                        color: AppColor.dynamicColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16.sp,
                        color: AppColor().whiteColor,
                      ),
                    )
                  ],
                ),
              ),
              //Bottom details
              Positioned(
                left: 14.w,
                right: 14.w,
                bottom: 10.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: '\$${member.membershipPricing}',
                                style: AppTypography.hostGroteskRegular.copyWith(
                                  fontSize: 18.sp,
                                  color: AppColor().whiteColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              TextSpan(
                                text: '/month',
                                style: AppTypography.hostGroteskRegular.copyWith(
                                  fontSize: 18.sp,
                                  color: AppColor().whiteColor,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            member.membershipTitle.toString(),
                            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                                color: AppColor().whiteColor,
                                fontSize: 25.sp,
                                height: 1.h),
                          ),
                          descriptionList.isEmpty
                              ? SizedBox.shrink()
                              : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "• ${descriptionList.join('\n• ')}",
                              style: AppTypography.hostGroteskRegular.copyWith(
                                fontSize: 14.sp,
                                color: AppColor().whiteColor,
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildTopTag(String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.dynamicColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        title,
        style: AppTypography.hostGroteskRegular.copyWith(
          color: AppColor().whiteColor,
          fontSize: 13.sp,
        ),
      ),
    );
  }
}
