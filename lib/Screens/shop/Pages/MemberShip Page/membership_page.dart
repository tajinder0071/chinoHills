import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
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
    // PackageController.instance.memberShipList();

    return GetBuilder<PackageController>(
      initState: (_) => Get.find<PackageController>().memberShipList(),
      builder: (control) {
        return control.bload
            ? Shimmer.fromColors(
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
              )
            : control.memberShip.isEmpty
            ? Center(
                child: NoRecord(
                  "No Membership's Data Found",
                  Icon(Icons.no_accounts),
                  "We're sorry. no membership's data available at this moment.",
                ),
              )
            : LiquidPullToRefresh(
                animSpeedFactor: 1.5,
                springAnimationDurationInMilliseconds: 400,
                key: control.refreshIndicatorKey,
                color: AppColor.dynamicColor,
                showChildOpacityTransition: false,
                onRefresh: control.handleRefresh,
                child: ListView(
                  children: [
                    //? Todo ?? MemberShip Header Section ....
                    Stack(
                      children: [
                        // Background Image with error handling
                        Image.network(
                          control.response.categoryHeaderCloudUrl.toString(),
                          width: double.infinity,
                          height: 180.h,
                          color: Colors.black.withOpacity(0.5),
                          colorBlendMode: BlendMode.darken,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180.h,
                              color: Colors.black12, // fallback background
                              child: Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.white54,
                                  size: 100.h,
                                ),
                              ),
                            );
                          },
                        ),

                        // Content Overlay
                        Positioned.fill(
                          child: Container(
                            color: Colors.black12,
                            width: double.infinity,
                            height: 180.h,
                            padding: EdgeInsets.symmetric(horizontal: 10.h),
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  control.response.categoryHeader.toString(),
                                  style: GoogleFonts.merriweather(
                                    color: Colors.white,
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  control.response.categoryDescription
                                      .toString(),
                                  style: GoogleFonts.actor(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // TODO ?? membership list Section
                    Padding(
                      padding: EdgeInsets.all(8.h),
                      child: ListView.builder(
                        itemCount: control.memberShip.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (cc, index) => Padding(
                          padding: EdgeInsets.only(bottom: 10.0.h),
                          child: InkWell(
                            overlayColor: WidgetStatePropertyAll(
                              AppColor().transparent,
                            ),
                            onTap: () => Get.toNamed(
                              RouteManager.membersShipDetailsPage,
                              arguments: control.memberShip[index].memberId,
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
                                        imageUrl:
                                            CommonPage().image_url +
                                            control
                                                .memberShip[index]
                                                .membershipImage
                                                .toString(),
                                        width: double.infinity,
                                        height: 170.h,
                                        boxFit: BoxFit.contain,
                                      ),
                                    ),
                                  ),

                                  // Content Section
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              control
                                                  .memberShip[index]
                                                  .membershipHeader
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 25.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            control
                                                    .memberShip[index]
                                                    .description
                                                    .toString()
                                                    .replaceAll('[', '')
                                                    .replaceAll(']', '')
                                                    .replaceAll(',', '\n• ')
                                                    .isEmpty
                                                ? SizedBox.shrink()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          8.0,
                                                        ),
                                                    child: Text(
                                                      () {
                                                        // Clean and split the description
                                                        final rawDescription =
                                                            control
                                                                .memberShip[index]
                                                                .description
                                                                .toString();
                                                        final cleanedList =
                                                            rawDescription
                                                                .replaceAll(
                                                                  '[',
                                                                  '',
                                                                )
                                                                .replaceAll(
                                                                  ']',
                                                                  '',
                                                                )
                                                                .split(',')
                                                                .map(
                                                                  (item) => item
                                                                      .trim(),
                                                                )
                                                                .where(
                                                                  (item) => item
                                                                      .isNotEmpty,
                                                                )
                                                                .take(3)
                                                                .toList();
                                                        return "• ${cleanedList.join('\n• ')}";
                                                      }(),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                            SizedBox(height: 12),
                                          ],
                                        ),
                                      ),
                                      //todo? Price & Link Section
                                      InkWell(
                                        onTap: () => Get.toNamed(
                                          RouteManager.membersShipDetailsPage,
                                          arguments: control.memberShip[index],
                                          parameters: {"onlyShow": "0"},
                                        ),
                                        child: Container(
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
                                                '\$${control.memberShip[index].price}/month',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  color: Colors.black,
                                                  decoration:
                                                      TextDecoration.none,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Spacer(),
                                              Text(
                                                "See all benefits",
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.dynamicColor,
                                                ),
                                              ),
                                              Icon(
                                                Icons.navigate_next_rounded,
                                                color: AppColor.dynamicColor,
                                                size: 20.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    getBrand(),
                    SizedBox(height: 5.h),
                  ],
                ),
              );
      },
    );
  }
}
