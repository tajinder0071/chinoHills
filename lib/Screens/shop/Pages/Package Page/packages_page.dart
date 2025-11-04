import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/CSS/image_page.dart';
import 'package:chino_hills/common_Widgets/no_record.dart';
import 'package:chino_hills/util/common_page.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/common_affirm_badge_widget.dart';
import '../../../../common_Widgets/common_badge_container.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../loading/cart_list_load.dart';
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
                baseColor: AppColor().greyColor.withOpacity(.3),
                highlightColor: AppColor().greyColor.withOpacity(.1),
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
                    Container(
                      clipBehavior: Clip.antiAlias,
                      margin: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
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
                                imageUrl: controller.packageHeaderImage,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      controller.model.headerDetails!
                                                  .headerTitle ==
                                              null
                                          ? "Curated\nPackages"
                                          : controller
                                              .model.headerDetails!.headerTitle
                                              .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTypography.hostGroteskSemiBold.copyWith(
                                          color: AppColor().whiteColor,
                                          fontSize: 22.sp,
                                          height: 0.9.h),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      controller.model.headerDetails!
                                                  .headerTitle ==
                                              null
                                          ? "Curated\nPackages"
                                          : controller.model.headerDetails!
                                              .headerDescription
                                              .toString(),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTypography.hostGroteskSemiBold.copyWith(
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
                    ),
                    // Section 2: Filter
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                AppStrings.filter,
                                style:
                                    AppTypography.hostGroteskSemiBold.copyWith(
                                  fontSize: 14.sp,
                                ),
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
                                    SizedBox(
                                      width: 80.w,
                                      child: Text(
                                        controller.concernValue.isNotEmpty
                                            ? controller.concernValue.length > 1
                                                ? "${controller.concernValue[0]}+${controller.concernValue.length - 1}"
                                                : controller.concernValue[0]
                                            : AppStrings.concern,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography
                                            .galanoGrostesqueSemiBold
                                            .copyWith(
                                          fontSize: 14.sp,
                                          color: AppColor().blackColor,
                                        ),
                                      ),
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
                                      width: 50.w,
                                      child: Text(
                                        controller.bodyValue.isNotEmpty
                                            ? controller.bodyValue.length > 1
                                                ? "${controller.bodyValue[0]}+${controller.bodyValue.length - 1}"
                                                : controller.bodyValue[0]
                                            : AppStrings.area,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.hostGroteskSemiBold
                                            .copyWith(
                                                fontSize: 14.sp,
                                                color: AppColor().blackColor),
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
                                style: AppTypography.hostGroteskSemiBold.copyWith(
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
                                  width: 70.w,
                                  child: Text(
                                    controller.selectFilter == ""
                                        ? AppStrings.featured
                                        : controller.selectFilter,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.hostGroteskSemiBold.copyWith(
                                        fontSize: 14.sp,
                                        color: AppColor().blackColor,
                                      ),
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
                              imageHeight: 120,
                              imageWidth: 120,
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
                              List<String> concerns =
                                  product.concerns!.map((con) => con).toList();
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
                                  children: [
                                    PackageCard(
                                      title: product.name.toString(),
                                      description:
                                          product.description.toString(),
                                      imageUrl: (product.image != null &&
                                              product.image!.isNotEmpty)
                                          ? product.image!
                                          : "",
                                      originalPrice: product.price.toString(),
                                      memberPrice:
                                          product.membershipOfferPrice == ""
                                              ? "0.0"
                                              : product.membershipOfferPrice
                                                  .toString(),
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
                                      unitType: product.type ?? "",
                                      DiscountType: '',
                                    ),
                                    if (index == 2) ...[
                                      SizedBox(height: 10.h),
                                      BannerAffirmBadge(
                                          cardView: true, isButton: false),
                                      SizedBox(height: 10.h),
                                    ],
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
