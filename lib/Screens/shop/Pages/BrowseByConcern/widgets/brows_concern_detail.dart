import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/shop/Pages/BrowseByConcern/controller/browse_controller.dart';
import 'package:chino_hills/binding/cart_billing.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import 'package:chino_hills/loading/cart_list_load.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../CSS/appTypography.dart';
import '../../../../../CSS/image_page.dart';
import '../../../../../common_Widgets/common_badge_container.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../util/common_page.dart';
import '../../../widgets/package_card_widgets.dart';
import '../../../widgets/show_selctection_bottomsheet_widget.dart';
import '../../Package Page/Widgets/package_detail_page.dart';
import '../../Treatment Page/widgets/treatment_details_page.dart';

class BrowsConcernDetail extends StatelessWidget {
  BrowsConcernDetail(this.uid, {super.key});

  var uid;
  BrowseController browseController = Get.put(BrowseController());

  @override
  Widget build(BuildContext context) {
    browseController.getBrowserbyConcernsList(uid, "", "", false);
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: CommonAppBar(title: AppStrings.browseByConcernNormal),
      body: GetBuilder<BrowseController>(
          builder: (controller) => Stack(children: [
                controller.isLoading
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
                    : (controller.response?.headerDetails == null &&
                            controller.treatment.isEmpty)
                        ? Center(
                            child: NoRecord(
                              AppStrings.noDataFound,
                              Icon(Icons.no_accounts),
                              AppStrings.weAreSorryNoBrowseDataAvailable,
                            ),
                          )
                        : ListView(
                            children: [
                              ///Todo: Brows by concern header
                              controller.response?.headerDetails == null &&
                                      controller.response?.headerDetails == null
                                  ? SizedBox.shrink()
                                  : Container(
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.w, vertical: 10.h),
                                      width: double.infinity,
                                      height: 200.h,
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
                                              AppImages.nimaLogo,
                                              color: AppColor.dynamicColor,
                                            ),
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
                                            top: 100.h,
                                            child: SizedBox(
                                              width: 200.w,
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
                                                      browseController
                                                          .response!
                                                          .headerDetails!
                                                          .headerTitle
                                                          .toString(),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTypography
                                                          .galanoGrostesqueSemiBold
                                                          .copyWith(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 22.sp,
                                                              height: 0.9.h),
                                                    ),
                                                    SizedBox(height: 5.h),
                                                    Text(
                                                      browseController
                                                          .response!
                                                          .headerDetails!
                                                          .headerDescription
                                                          .toString(),
                                                      maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppTypography
                                                          .hostGroteskRegular
                                                          .copyWith(
                                                        color: Colors.white,
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

                              ///Todo: filters

                              GetBuilder<BrowseController>(builder: (newCon) {
                                return newCon.treatment.isEmpty
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w),
                                        child: Row(
                                          children: [
                                            if (newCon.isBothEmpty) ...[
                                              Text(
                                                AppStrings.filter,
                                                style:
                                                    TextStyle(fontSize: 16.h),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.bottomSheet(
                                                    // This is my here i want to implemnet like below in apply
                                                    CommonBottomSheet(
                                                      name: "",
                                                      selectedOptions: [],
                                                      title: AppStrings
                                                          .filterByServiceType,
                                                      options:
                                                          newCon.serviceType,
                                                      isSortBy: true,
                                                      selectedValue: newCon
                                                          .selectServiceFilterValue,
                                                      onReset: () {
                                                        newCon.selectFilterValue
                                                            .clear();
                                                        newCon.selectFilter =
                                                            "";
                                                        newCon
                                                            .getBrowserbyConcernsList(
                                                                uid,
                                                                [],
                                                                "",
                                                                false);
                                                        Navigator.pop(
                                                            Get.context!);
                                                      },
                                                      onApply: () {
                                                        print(newCon
                                                            .selectServiceFilterValue);
                                                        String index = newCon
                                                            .selectServiceFilterValue
                                                            .toString()
                                                            .replaceAll('[', '')
                                                            .replaceAll(
                                                                ']', '');
                                                        if (int.parse(index) >=
                                                                0 &&
                                                            int.parse(index) <
                                                                newCon
                                                                    .serviceBackType
                                                                    .length) {
                                                          newCon.selectService =
                                                              newCon.serviceBackType[
                                                                          int.parse(
                                                                              index)]
                                                                      [
                                                                      'title'] ??
                                                                  "";
                                                        } else {
                                                          newCon.selectService =
                                                              ""; // or some fallback value
                                                        }
                                                        newCon.getBrowserbyConcernsList(
                                                            uid,
                                                            "",
                                                            browseController
                                                                .selectService,
                                                            true);
                                                      },
                                                    ),
                                                    isScrollControlled: true,
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      browseController
                                                                  .selectService ==
                                                              ""
                                                          ? "Service Type"
                                                          : browseController
                                                              .selectService,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Icon(
                                                        Icons
                                                            .keyboard_arrow_down_sharp,
                                                        color: Colors.blue),
                                                  ],
                                                ),
                                              ),
                                              const Spacer(),
                                            ],
                                            Text(
                                              AppStrings.sort,
                                              style: TextStyle(fontSize: 16.h),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.bottomSheet(
                                                  CommonBottomSheet(
                                                    selectedOptions: [],
                                                    title: AppStrings.sortBy,
                                                    options: newCon.filter,
                                                    isSortBy: true,
                                                    selectedValue: newCon
                                                        .selectFilterValue,
                                                    onReset: () {
                                                      newCon.selectFilterValue
                                                          .clear();
                                                      newCon.selectFilter = "";
                                                      newCon.getBrowserbyConcernsList(
                                                          uid,
                                                          newCon
                                                              .selectedOptions,
                                                          "treatment",
                                                          false);
                                                      Navigator.pop(
                                                          Get.context!);
                                                    },
                                                    onApply: () {
                                                      print(newCon
                                                          .selectFilterValue);
                                                      String index = newCon
                                                          .selectFilterValue
                                                          .toString()
                                                          .replaceAll('[', '')
                                                          .replaceAll(']', '');
                                                      if (int.parse(index) >=
                                                              0 &&
                                                          int.parse(index) <
                                                              newCon.filterBack
                                                                  .length) {
                                                        newCon.selectFilter =
                                                            newCon.filterBack[int
                                                                        .parse(
                                                                            index)]
                                                                    ['title'] ??
                                                                "";
                                                      } else {
                                                        newCon.selectFilter =
                                                            ""; // or some fallback value
                                                      }
                                                      newCon
                                                          .getBrowserbyConcernsList(
                                                              uid,
                                                              browseController
                                                                  .selectFilter,
                                                              "",
                                                              true);
                                                      Navigator.pop(
                                                          Get.context!);
                                                    },
                                                    name: '',
                                                  ),
                                                  isScrollControlled: true,
                                                );
                                              },
                                              child: Text(
                                                browseController.selectFilter ==
                                                        ""
                                                    ? "Featured"
                                                    : browseController
                                                        .selectFilter,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                              }),
                              SizedBox(height: 10.h),
                              if (browseController.treatment.isEmpty)
                                NoRecord(
                                    AppStrings.noDataFound,
                                    Icon(Icons.search),
                                    AppStrings.weAreSorryNoBrowseDataAvailable)
                              else
                                Column(
                                  children: [
                                    ///todo:: package
                                    //todo: treatment
                                    browseController.treatment.isEmpty
                                        ? SizedBox.shrink()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: browseController
                                                .treatment.length,
                                            itemBuilder: (context, index) {
                                              var treat = browseController
                                                  .treatment[index];
                                              List<String> concerns = treat
                                                  .concerns!
                                                  .map((con) => con.toString())
                                                  .toList();
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Column(
                                                  children: [
                                                    PackageCard(
                                                      title: treat.name ?? "",
                                                      description:
                                                          treat.description ??
                                                              "",
                                                      imageUrl:
                                                          treat.image!.isEmpty
                                                              ? ""
                                                              : treat.image!,
                                                      originalPrice: treat.price
                                                              .toString() ??
                                                          0.0,
                                                      memberPrice: treat
                                                                  .membershipOfferPrice ==
                                                              ""
                                                          ? "0.0"
                                                          : treat
                                                              .membershipOfferPrice
                                                              .toString(),
                                                      //memberPrice: treat.membershipOfferPrice.toString() ?? 0.0,
                                                      tags: concerns,
                                                      sectionName: 'Treatments',
                                                      onPressed: () {
                                                        treat.type == "Package"
                                                            ? Get.to(
                                                                () =>
                                                                    PackageDetailPage(
                                                                  sectionName:
                                                                      "Package",
                                                                ),
                                                                arguments:
                                                                    treat.id,
                                                                binding:
                                                                    CommonBinding(),
                                                                transition:
                                                                    Transition
                                                                        .fadeIn,
                                                                duration:
                                                                    Duration(
                                                                  milliseconds:
                                                                      500,
                                                                ),
                                                              )
                                                            : Get.to(
                                                                () =>
                                                                    TreatmentDetailsPage(),
                                                                arguments:
                                                                    treat.id,
                                                                binding:
                                                                    CommonBinding(),
                                                                transition:
                                                                    Transition
                                                                        .fadeIn,
                                                                duration:
                                                                    Duration(
                                                                  milliseconds:
                                                                      500,
                                                                ),
                                                              );
                                                      },
                                                      unitType:
                                                          treat.type ?? "",
                                                      discount: 0,
                                                      DiscountType: '',
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),

                                    SizedBox(height: 20.h),
                                    getBrand(),
                                    SizedBox(height: 5.h),
                                  ],
                                )
                            ],
                          ),
              ])),
    );
  }
}
