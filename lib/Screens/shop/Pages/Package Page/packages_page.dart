import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/color.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/cart_list_load.dart';
import '../../../../util/common_page.dart';
import '../../widgets/package_card_widgets.dart';
import '../../widgets/show_selctection_bottomsheet_widget.dart';
import 'Widgets/package_detail_page.dart';
import 'controller/package_cotroller.dart';

class PackagesPage extends StatefulWidget {
  PackagesPage({Key? key}) : super(key: key);

  @override
  State<PackagesPage> createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  List bodyValue = [];
  final pcon = Get.put(PackageController());
  List concernValue = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pcon.selectedArea = [];
    pcon.selectedOptions = [];
    pcon.selectFilterValue = [];
    pcon.selectFilter = "";
    pcon.browseList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        init: Get.find<PackageController>()..packageList([], [], ""),
        builder: (controller) {
          return controller.load
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
                      Expanded(
                        child: TreatementLoad(),
                      )
                    ],
                  ))
              : LiquidPullToRefresh(
                  animSpeedFactor: 1.5,
                  springAnimationDurationInMilliseconds: 400,
                  key: controller.refreshIndicatorKey,
                  color: AppColor.dynamicColor,
                  showChildOpacityTransition: false,
                  onRefresh: controller.handleRefreshPackage,
                  child: ListView(
                    children: [
                      // TODO ? Section 1 : Here Show the Image And Shadow Text...

                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: NetworkImage(controller.packageHeaderImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Gradient Opacity Layer
                            Positioned.fill(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: [
                                            Colors.black.withOpacity(0.7),
                                            // Dark shade on the left
                                            Colors.transparent,
                                            // Fade out to right
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: 100.w, // Fixed width
                                      color: Colors
                                          .transparent // Semi-transparent effect
                                      ),
                                ],
                              ),
                            ),

                            // Text Content
                            Padding(
                              padding: EdgeInsets.all(15.0.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.model.categoryHeader == null
                                        ? "Curated\nPackages"
                                        : controller.model.categoryHeader
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  Text(
                                    controller.model.categoryDescription == null
                                        ? "Multiple treatments to\ntackle specific areas\nand concerns"
                                        : controller.model.categoryDescription!
                                            .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // TODO ? Section 2 : Here Flitter...
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //todo Section 1 - Filter
                            Row(
                              children: [
                                Text(
                                  "Filter:",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 5),
                                // Concern Button
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      CommonBottomSheet(
                                        selectedOptions:
                                            controller.selectedOptions,
                                        title: "FILTER BY CONCERN",
                                        options: controller.concern,
                                        isSortBy: false,
                                        selectedValue: [],
                                        onReset: () {
                                          concernValue.clear();
                                          controller.selectedOptions.clear();
                                          controller.packageList(
                                              controller.selectedOptions,
                                              controller.selectedArea,
                                              controller.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        onApply: () {
                                          print(
                                              'selectOption:${controller.selectedOptions}');
                                          print(
                                              'selectOption:${controller.selectedOptions}');
                                          concernValue = controller.concern
                                              .where((item) => controller
                                                  .selectedOptions
                                                  .contains(item['id']))
                                              .map((item) => item['title'])
                                              .toList();
                                          controller.packageList(
                                              controller.selectedOptions,
                                              controller.selectedArea,
                                              controller.selectFilter);
                                          Navigator.pop(context);
                                        }, name: 'packages',
                                      ),
                                      isScrollControlled: true,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        concernValue.isNotEmpty
                                            ? concernValue.length > 1
                                                ? "${concernValue[0]}+${concernValue.length - 1}"
                                                : concernValue[0]
                                            : "Concern",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_rounded,
                                          color: AppColor.dynamicColor),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                // Area Button
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      CommonBottomSheet(
                                        selectedOptions:
                                            controller.selectedArea,
                                        title: "FILTER BY Area",
                                        options: pcon.bodyArea,
                                        isSortBy: false,
                                        selectedValue: [],
                                        onReset: () {
                                          bodyValue.clear();
                                          controller.selectedArea.clear();
                                          controller.packageList(
                                              controller.selectedOptions,
                                              controller.selectedArea,
                                              controller.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        onApply: () {
                                          bodyValue = controller.bodyArea
                                              .where((item) => controller
                                                  .selectedArea
                                                  .contains(item['id']))
                                              .map((item) => item['title'])
                                              .toList();
                                          print("object:: ${bodyValue[0]}");
                                          controller.packageList(
                                              controller.selectedOptions,
                                              controller.selectedArea,
                                              controller.selectFilter);
                                          Navigator.pop(context);
                                        }, name: '',
                                      ),
                                      isScrollControlled: true,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          bodyValue.isNotEmpty
                                              ? bodyValue.length > 1
                                                  ? "${bodyValue[0]}+${bodyValue.length - 1}"
                                                  : bodyValue[0]
                                              : "Area",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Icon(Icons.keyboard_arrow_down_rounded,
                                          color: AppColor.dynamicColor),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            //todo Section 2 - Sort
                            Row(
                              children: [
                                Text(
                                  "Sort:",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(width: 5.w),
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      CommonBottomSheet(
                                        selectedOptions: [],
                                        title: "Sort By",
                                        options: controller.filter,
                                        isSortBy: true,
                                        selectedValue:
                                            controller.selectFilterValue,
                                        onReset: () {
                                          controller.selectFilterValue.clear();
                                          controller.selectFilter = "";
                                          controller.packageList(
                                              controller.selectedOptions,
                                              controller.selectedArea,
                                              controller.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        onApply: () {
                                          print(controller.selectFilterValue);
                                          String index = controller
                                              .selectFilterValue
                                              .toString()
                                              .replaceAll('[', '')
                                              .replaceAll(']', '');
                                          if (int.parse(index) >= 0 &&
                                              int.parse(index) <
                                                  controller
                                                      .filterBack.length) {
                                            controller.selectFilter =
                                                controller.filterBack[
                                                            int.parse(index)]
                                                        ['title'] ??
                                                    "";
                                          } else {
                                            controller.selectFilter =
                                                ""; // or some fallback value
                                          }
                                          controller.packageList(
                                              controller.selectedOptions,
                                              controller.selectedArea,
                                              controller.selectFilter);
                                          Navigator.pop(context);
                                        }, name: '',
                                      ),
                                      isScrollControlled: true,
                                    );
                                  },
                                  child: SizedBox(
                                      width: 70,
                                      child: Text(
                                        controller.selectFilter == ""
                                            ? "Featured"
                                            : controller.selectFilter,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // TODO ? Section 3 : Here List Of Data...
                      controller.shopDatum.isEmpty
                          ? Center(
                              child: NoRecord(
                                "No Package Data Found",
                                Icon(Icons.no_accounts),
                                "We're sorry. no package data available at this moment.\nPlease check back later",
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: controller.shopDatum.length,
                              itemBuilder: (context, index) {
                                final product = controller.shopDatum[index];
                                // Extract concern names using map()
                                List<String> concerns = product.concern!
                                    .map((con) => con.concernName.toString())
                                    .toList();
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    children: [
                                      PackageCard(
                                        title: product.packageName.toString(),
                                        description:
                                            product.description.toString(),
                                        imageUrl:
                                            (product.packageImages != null &&
                                                    product.packageImages!
                                                        .isNotEmpty)
                                                ? product.packageImages![0]
                                                : "",
                                        originalPrice:
                                            product.pricing.toString(),
                                        memberPrice:
                                            product.membershipFinalPrice,
                                        tags: concerns,
                                        discount:
                                            product.rewardsPercentage == null
                                                ? 0
                                                : double.parse(product
                                                    .rewardsPercentage
                                                    .toString()),
                                        sectionName: 'Package',
                                        onPressed: () {
                                          Get.to(
                                            () => PackageDetailPage(
                                                sectionName: 'Package'),
                                            arguments: product.packageId,
                                            transition: Transition.fadeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                          );
                                        },
                                        unitType: "", DiscountType: '',
                                      ),
                                    ],
                                  ),
                                );
                              }),
                      SizedBox(height: 20.h),
                      getBrand(),
                      SizedBox(height: 5.h),
                    ],
                  ),
                );
        });
  }
}
