import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/color.dart';
import '../../../../util/common_page.dart';
import '../../../../common_Widgets/load_nfc.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/browse_Concern_load.dart' show BrowseConcernLoad;
import '../../../../util/route_manager.dart';
import '../Package Page/controller/package_cotroller.dart';

class BrowseByConcernPage extends StatelessWidget {
  BrowseByConcernPage({super.key});

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
                          "No Data Found",
                          Icon(Icons.no_accounts),
                          "We're sorry. no browse by concern data available at this moment.\nPlease check back later",
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
                              height: 200.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColor().greyColor,
                                image: DecorationImage(
                                    image: NetworkImage(CommonPage().image_url +
                                        controller
                                            .browseImageDatum[0].concernsImage
                                            .toString()),
                                    fit: BoxFit.contain),
                              ),
                              child: Container(
                                  width: double.infinity,
                                  height: 180.h,
                                  color: Colors.black26,
                                  padding: EdgeInsets.only(
                                      top: 20.h, left: 10.w, right: 150.w),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Browse by concern",
                                            style: GoogleFonts.merriweather(
                                                fontWeight: FontWeight.w900,
                                                fontSize: 20.sp,
                                                color: Colors.white)),
                                        SizedBox(height: 10.h),
                                        Text(
                                          "Select from popular \nconcerns to find the best treatment for you",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                            controller.browseImageDatum.isEmpty
                                ? SizedBox(height: 20.0)
                                : SizedBox.shrink(),
                            controller.browseImageDatum.isEmpty
                                ? Center(
                                    child: NoRecord(
                                      "No Data Found",
                                      Icon(Icons.no_accounts),
                                      "We're sorry. no browse by concern data available at this moment.\nPlease check back later",
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.all(12.h),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(2, 2),
                                              blurRadius: 5),
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(-2, -2),
                                              blurRadius: 5),
                                        ]),
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            controller.browseDatum.length,
                                        itemBuilder: (context, index) => Column(
                                              children: [
                                                ListTile(
                                                    onTap: () => Get.toNamed(
                                                        RouteManager
                                                            .browseConcernDetail,
                                                        arguments: controller
                                                            .browseDatum[index]
                                                            .id),
                                                    title: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            controller
                                                                .browseDatum[
                                                                    index]
                                                                .concernName
                                                                .toString(),
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .roboto(
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ),
                                                        Text(
                                                          "${controller.browseDatum[index].treatmentCount.toString().replaceAll(".0", "")} treatments",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: Colors
                                                                          .grey[
                                                                      800]),
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Icon(
                                                        Icons
                                                            .keyboard_arrow_right,
                                                        color: AppColor
                                                            .dynamicColor),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10.w,
                                                            right: 10.w)),
                                                Divider(
                                                    color: AppColor
                                                        .dynamicColorWithOpacity)
                                              ],
                                            )),
                                  ),
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
