import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../common_Widgets/cacheNetworkImage.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/discover_loading_page.dart';
import '../../../../util/common_page.dart';
import '../../../../util/route_manager.dart';
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
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
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
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image:
          NetworkImage(control.response.headerDetails!.headerimage ?? ''),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            control.response.headerDetails!.headerTitle ?? '',
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            control.response.headerDetails!.headerDescription ?? '',
            style: GoogleFonts.actor(
              color: Colors.white,
              fontSize: 13.sp,
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
        child: Card(
          color: AppColor().whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.r),
                        topLeft: Radius.circular(5.r),
                      ),
                      child: ConstantNetworkImage(
                        isLoad: true,
                        imageUrl: member.membershipImage.toString(),
                        width: double.infinity,
                        height: 170.h,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                  ),
                  member.offeroffText == ""
                      ? SizedBox.shrink()
                      : Positioned(
                    top: 10.h,
                    left: 5.w,
                    child: Container(
                      height: 25.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: AppColor.dynamicColor,
                        borderRadius: BorderRadius.circular(5.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(2, 2),
                            blurRadius: 5.r,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          member.offeroffText.toString().toUpperCase(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.merriweather(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor().whiteColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // Content Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.membershipTitle.toString(),
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                        descriptionList.isEmpty
                            ? SizedBox.shrink()
                            : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "• ${descriptionList.join('\n• ')}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  Container(
                    height: 50.h,
                    padding: EdgeInsets.all(10.0.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.r),
                        bottomRight: Radius.circular(5.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '\$${member.membershipPricing}/month',
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              decoration: TextDecoration.none),
                        ),
                        SizedBox(width: 10),
                        Spacer(),
                        Text(
                          AppStrings.seeAllBenefits,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.dynamicColor,
                          ),
                        ),
                        Icon(Icons.navigate_next_rounded,
                            color: AppColor.dynamicColor, size: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
