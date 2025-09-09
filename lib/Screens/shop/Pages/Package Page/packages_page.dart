import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'package:shimmer/shimmer.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/cart_list_load.dart';
import '../../../../util/common_page.dart';
import '../../widgets/package_card_widgets.dart';
import '../../widgets/show_selctection_bottomsheet_widget.dart';
import 'Widgets/package_detail_page.dart';
import 'controller/package_cotroller.dart';

class PackagesPage extends StatelessWidget {
  PackagesPage({Key? key}) : super(key: key);

  final PackageController pcon = Get.put(PackageController());

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
          ),
        )
            : LiquidPullToRefresh(
          animSpeedFactor: 1.5,
          springAnimationDurationInMilliseconds: 400,
          key: controller.refreshIndicatorKey,
          color: AppColor.dynamicColor,
          showChildOpacityTransition: false,
          onRefresh: controller.handleRefreshPackage,
          child: ListView(
            children: [
              // Section 1: Image and Shadow Text
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
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100.w,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.model.headerDetails!.headerTitle ==
                                null
                                ? "Curated\nPackages"
                                : controller
                                .model.headerDetails!.headerTitle
                                .toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            controller.model.headerDetails!
                                .headerDescription ==
                                null
                                ? "Multiple treatments to\ntackle specific areas\nand concerns"
                                : controller.model.headerDetails!
                                .headerDescription
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
              // Section 2: Filter
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppStrings.filter,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        //SizedBox(width: 5),
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
                                  controller.concernValue.clear();
                                  controller.selectedOptions.clear();
                                  controller.packageList(
                                    controller.selectedOptions,
                                    controller.selectedArea,
                                    controller.selectFilter,
                                  );
                                  Get.back();
                                  controller.update();
                                },
                                onApply: () {
                                  controller.concernValue.clear();
                                  controller.concernValue.addAll(
                                      controller.concern
                                          .where((item) => controller
                                          .selectedOptions
                                          .contains(item['id']))
                                          .map((item) => item['title'])
                                          .toList());
                                  controller.packageList(
                                    controller.selectedOptions,
                                    controller.selectedArea,
                                    controller.selectFilter,
                                  );
                                  Get.back();
                                  controller.update();
                                },
                                name: 'packages',
                              ),
                              isScrollControlled: true,
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                controller.concernValue.isNotEmpty
                                    ? controller.concernValue.length > 1
                                    ? "${controller.concernValue[0]}+${controller.concernValue.length - 1}"
                                    : controller.concernValue[0]
                                    : AppStrings.concern,
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
                        SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              CommonBottomSheet(
                                selectedOptions: controller.selectedArea,
                                title: "FILTER BY Area",
                                options: pcon.bodyArea,
                                isSortBy: false,
                                selectedValue: [],
                                onReset: () {
                                  controller.bodyValue.clear();
                                  controller.selectedArea.clear();
                                  controller.packageList(
                                    controller.selectedOptions,
                                    controller.selectedArea,
                                    controller.selectFilter,
                                  );
                                  Get.back();
                                  controller.update();
                                },
                                onApply: () {
                                  controller.bodyValue.clear();
                                  controller.bodyValue.addAll(controller
                                      .bodyArea
                                      .where((item) => controller
                                      .selectedArea
                                      .contains(item['id']))
                                      .map((item) => item['title'])
                                      .toList());
                                  controller.packageList(
                                    controller.selectedOptions,
                                    controller.selectedArea,
                                    controller.selectFilter,
                                  );
                                  Get.back();
                                },
                                name: '',
                              ),
                              isScrollControlled: true,
                            );
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 30,
                                child: Text(
                                  controller.bodyValue.isNotEmpty
                                      ? controller.bodyValue.length > 1
                                      ? "${controller.bodyValue[0]}+${controller.bodyValue.length - 1}"
                                      : controller.bodyValue[0]
                                      : AppStrings.area,
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
                    Row(
                      children: [
                        Text(
                          AppStrings.sort,
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500),
                        ),
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
                                    controller.selectFilter,
                                  );
                                  Get.back();
                                },
                                onApply: () {
                                  String index = controller
                                      .selectFilterValue
                                      .toString()
                                      .replaceAll('[', '')
                                      .replaceAll(']', '');
                                  if (int.parse(index) >= 0 &&
                                      int.parse(index) <
                                          controller.filterBack.length) {
                                    controller.selectFilter = controller
                                        .filterBack[
                                    int.parse(index)]['title'] ??
                                        "";
                                  } else {
                                    controller.selectFilter = "";
                                  }
                                  controller.packageList(
                                    controller.selectedOptions,
                                    controller.selectedArea,
                                    controller.selectFilter,
                                  );
                                  Get.back();
                                },
                                name: '',
                              ),
                              isScrollControlled: true,
                            );
                          },
                          child: SizedBox(
                            width: 70,
                            child: Text(
                              controller.selectFilter == ""
                                  ? AppStrings.featured
                                  : controller.selectFilter,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Section 3: List Of Data
              controller.shopDatum.isEmpty
                  ? Center(
                child: NoRecord(
                  AppStrings.noDataFound,
                  Icon(Icons.no_accounts),
                  AppStrings.weAreSorryNoPackageDataAvailable,
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.shopDatum.length,
                itemBuilder: (context, index) {
                  final product = controller.shopDatum[index];
                  List<String> concerns = product.concerns!.map((con) => con).toList();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        PackageCard(
                          title: product.name.toString(),
                          description: product.description.toString(),
                          imageUrl: (product.image != null && product.image!.isNotEmpty) ? product.image!
                              : "",
                          originalPrice: product.price.toString(),
                          memberPrice: product.membershipOfferPrice== "" ? "0.0" : product.membershipOfferPrice.toString(),
                          tags: concerns,
                          discount: product.offeroffText,
                          sectionName: 'Package',
                          onPressed: () {
                            Get.to(
                                  () => PackageDetailPage(
                                  sectionName: 'Package'),
                              arguments: product.id,
                              transition: Transition.fadeIn,
                              binding: CommonBinding(),
                              duration: Duration(milliseconds: 500),

                            );
                          },
                          unitType: "",
                          DiscountType: '',
                        ),
                      ],
                    ),
                  );
                },
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
