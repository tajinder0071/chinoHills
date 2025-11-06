import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/common_Widgets/common_badge_container.dart';
import 'package:chino_hills/common_Widgets/common_network_image_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../Model/dynamic_tab_model.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/cart_list_load.dart';
import '../../../../util/route_manager.dart';
import '../../controller/dynamic_tab_controller.dart';
import '../../widgets/package_card_widgets.dart';
import '../Package Page/Widgets/package_detail_page.dart';
import '../Treatment Page/widgets/treatment_details_page.dart';
import 'package:upgrader/upgrader.dart';

class DynamicData extends StatefulWidget {
  final String dynamicId;

  const DynamicData({required this.dynamicId, super.key});

  @override
  State<DynamicData> createState() => _DynamicDataState();
}

class _DynamicDataState extends State<DynamicData> {
  late DynamicTabController controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller in initState to ensure proper lifecycle
    controller =
        Get.put(DynamicTabController(widget.dynamicId), tag: widget.dynamicId);
  }

  @override
  void dispose() {
    // Clean up controller when widget is disposed
    Get.delete<DynamicTabController>(tag: widget.dynamicId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: GetBuilder<DynamicTabController>(
        tag: widget.dynamicId,
        builder: (controller) => LiquidPullToRefresh(
          animSpeedFactor: 1.5,
          springAnimationDurationInMilliseconds: 400,
          color: AppColor.dynamicColor,
          showChildOpacityTransition: false,
          key: controller.refreshIndicatorKey,
          onRefresh: controller.handleRefresh,
          child: Scaffold(
            backgroundColor: AppColor().greyColor.withValues(alpha: 0.05),
            body: Obx(() {
              if (controller.isLoading.value) {
                return Shimmer.fromColors(
                  baseColor: AppColor().greyColor.withValues(alpha: .3),
                  highlightColor: AppColor().greyColor.withValues(alpha: .1),
                  child: Column(
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        color: AppColor().whiteColor,
                      ),
                      Expanded(
                        child: TreatementLoad(),
                      ),
                    ],
                  ),
                );
              }

              final dataList = controller.dynamicTabModel.value?.data ?? [];
              final header = controller.dynamicTabModel.value?.headerDetails;

              if (dataList.isEmpty) {
                return Center(
                  child: NoRecord(
                      AppStrings.noDataFound,
                      const Icon(Icons.no_accounts),
                      AppStrings.weAreSorryNoDataAvailable,
                      color: AppColor().transparent),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderSection(header),
                    /*    Padding(
                      padding: EdgeInsets.all(8.0),
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
                                      selectedOptions: controller.selectedOptions,
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
                                  width: 70.w,
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
                    ),*/
                    ListView.builder(
                      padding: EdgeInsets.fromLTRB(13.w, 7.h, 13.w, 0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final item = dataList[index];

                        List<String> tags = [];
                        if (item.concerns is List) {
                          tags = List<String>.from(item.concerns!);
                        } else if (item.concerns is String) {
                          tags = (item.concerns! as String)
                              .replaceAll(' ', '')
                              .split(',')
                              .where((e) => e.isNotEmpty)
                              .toList();
                        }

                        return PackageCard(
                          title: item.name ?? AppStrings.unnamed,
                          description: item.description ?? "",
                          imageUrl: item.image ?? "",
                          originalPrice: item.price?.toString() ?? "0.0",
                          memberPrice: item.type == 'Package'
                              ? item.membershipInfo == null
                                  ? item.membershipOfferPrice
                                  : item.membershipInfo!.membershipOfferPrice
                              : item.membershipOfferPrice ?? "0.0",
                          tags: tags,
                          sectionName: item.type ?? 'Treatments',
                          onPressed: () {
                            if (item.type == "Treatment") {
                              Get.to(
                                () => TreatmentDetailsPage(),
                                arguments: item.id,
                                binding: CommonBinding(),
                                transition: Transition.fadeIn,
                                duration: Duration(milliseconds: 500),
                              );
                            } else if (item.type == "Package") {
                              Get.to(
                                () => PackageDetailPage(
                                  sectionName: 'Package',
                                ),
                                arguments: item.id,
                                binding: CommonBinding(),
                                transition: Transition.fadeIn,
                                duration: Duration(milliseconds: 500),
                              );
                            } else {
                              Get.toNamed(
                                RouteManager.membersShipDetailsPage,
                                arguments: item.id,
                                parameters: {"onlyShow": "0"},
                              );
                            }
                          },
                          unitType: item.type.toString(),
                          DiscountType: "0",
                          discount: item.offeroffText.toString(),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // You need to implement this method based on your header structure
  Widget _buildHeaderSection(HeaderDetails? headerDetails) {
    if (headerDetails == null) return const SizedBox.shrink();
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      width: double.infinity,
      height: 220.h,
      decoration: BoxDecoration(
        color: AppColor.dynamicColor.withValues(alpha: .96),
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
                imageUrl: headerDetails.headerimage.toString(),
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
                      headerDetails.headerTitle ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                          color: AppColor().whiteColor, fontSize: 22.sp, height: 0.9.h),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      headerDetails.headerDescription ?? '',
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
}
