import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../CSS/app_strings.dart';
import '../../../../../CSS/color.dart';
import '../../../../../binding/cart_billing.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../loading/cart_list_load.dart';
import '../../../../../util/common_page.dart';
import '../../../widgets/package_card_widgets.dart';
import '../../../widgets/show_selctection_bottomsheet_widget.dart';
import '../../Treatment Page/widgets/treatment_details_page.dart';
import '../controller/browse_controller.dart';

class BrowsConcernDetail extends StatelessWidget {
  BrowsConcernDetail(this.uid, {super.key});

  var uid;
  BrowseController browseController = Get.put(BrowseController());

  @override
  Widget build(BuildContext context) {
    browseController.getBrowserbyConcernsList(uid, "", "", false);
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(
        isLeading: true,
        title: AppStrings.browseByConcernNormal,
        action: [],
      ),
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
                  height: 200.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            AppColor.dynamicColor,
                            AppColor.dynamicColor
                                .withAlpha(400),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 28.w, right: 10.w),
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          browseController.response!
                              .headerDetails!.headerTitle
                              .toString(),
                          style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.w700,
                              fontSize: 25.sp,
                              color: AppColor().whiteColor),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          browseController
                              .response!
                              .headerDetails!
                              .headerDescription
                              .toString(),
                          style: GoogleFonts.poppins(
                              color: AppColor().whiteColor,
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                ///Todo: filters

                GetBuilder<BrowseController>(builder: (newCon) {
                  return newCon.treatment.isEmpty
                      ? SizedBox.shrink()
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
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
                                  newCon.getBrowserbyConcernsList(uid,
                                      newCon.selectedOptions,
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
                  NoRecord(AppStrings.noDataFound, Icon(Icons.search),
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
                                        .membershipOfferPrice
                                        .toString() ??
                                        0.0,
                                    tags: concerns,
                                    sectionName: 'Treatments',
                                    onPressed: () {
                                      Get.to(
                                            () =>
                                            TreatmentDetailsPage(),
                                        arguments: treat.id,
                                        binding:
                                        CommonBinding(),
                                        transition:
                                        Transition.fadeIn,
                                        duration: Duration(
                                            milliseconds:
                                            500),
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
