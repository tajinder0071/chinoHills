import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../CSS/color.dart';
import '../../../../../binding/treartmentDetailsBinding.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../loading/cart_list_load.dart';
import '../../../../../loading/discover_loading_page.dart';
import '../../../../../util/common_page.dart';
import '../../../widgets/package_card_widgets.dart';
import '../../../widgets/show_selctection_bottomsheet_widget.dart';
import '../../Package Page/Widgets/package_detail_page.dart';
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
        title: "Browse by Concern",
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
                    : (controller.response?.concernName == null &&
                            controller.treatment.isEmpty &&
                            controller.package.isEmpty)
                        ? Center(
                            child: NoRecord(
                              "No Package Data Found",
                              Icon(Icons.no_accounts),
                              "We're sorry. no browse by concern data available at this moment.\nPlease check back later",
                            ),
                          )
                        : ListView(
                            children: [
                              ///Todo: Brows by concern header
                              controller.response?.concernName == null &&
                                      controller.response?.concernDescription ==
                                          null
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
                                              browseController
                                                  .response!.concernName
                                                  .toString(),
                                              style: GoogleFonts.merriweather(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 25.sp,
                                                  color: AppColor().whiteColor),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              browseController
                                                  .response!.concernDescription
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
                                return newCon.package.isEmpty &&
                                        newCon.treatment.isEmpty
                                    ? SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            if (newCon.isBothEmpty) ...[
                                              Text(
                                                "Filter: ",
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
                                                      title:
                                                          "FILTER BY Service Type",
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
                                              "Sort: ",
                                              style: TextStyle(fontSize: 16.h),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.bottomSheet(
                                                  CommonBottomSheet(
                                                    selectedOptions: [],
                                                    title: "Sort By",
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
                                                    }, name: '',
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
                              if (browseController.package.isEmpty &&
                                  browseController.treatment.isEmpty)
                                NoRecord("No Data Found", Icon(Icons.search),
                                    "We're sorry. no browse by concern data available at this moment.\nPlease check back later")
                              else
                                Column(
                                  children: [
                                    ///todo:: package
                                    browseController.package.isEmpty
                                        ? SizedBox.shrink()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount:
                                                browseController.package.length,
                                            itemBuilder: (context, index) {
                                              var product = browseController
                                                  .package[index];
                                              List<String> concerns = product
                                                  .concerns!
                                                  .map((con) => con.concernName
                                                      .toString())
                                                  .toList();
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Column(
                                                  children: [
                                                    PackageCard(
                                                      title: product.packageName
                                                          .toString(),
                                                      description: product
                                                          .description
                                                          .toString(),
                                                      imageUrl: product
                                                              .packageImages!
                                                              .isEmpty
                                                          ? ""
                                                          : product
                                                              .packageImages![0]
                                                              .toString(),
                                                      originalPrice:
                                                          double.parse(product
                                                              .pricing
                                                              .toString()),
                                                      memberPrice: /*product
                                                              .membershipDiscountAmount
                                                              .toString() ??*/
                                                          0.0,
                                                      tags: concerns,
                                                      discount: 0.0,
                                                      sectionName: 'Package',
                                                      onPressed: () {
                                                        Get.to(
                                                          PackageDetailPage(
                                                            sectionName:
                                                                'Package',
                                                          ),
                                                          arguments:
                                                              product.packageId,
                                                          transition:
                                                              Transition.fadeIn,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                        );
                                                      },
                                                      unitType: "", DiscountType: '',
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),

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
                                                  .map((con) => con.concernName
                                                      .toString())
                                                  .toList();
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10.w),
                                                child: Column(
                                                  children: [
                                                    PackageCard(
                                                      title:
                                                          treat.treatmentName ??
                                                              "",
                                                      description: treat
                                                              .treatmentDescription ??
                                                          "",
                                                      imageUrl: treat
                                                              .treatmentImagePaths!
                                                              .isEmpty
                                                          ? ""
                                                          : treat
                                                              .treatmentImagePaths![0],
                                                      originalPrice: treat.price
                                                              .toString() ??
                                                          0.0,
                                                      memberPrice: /*treat
                                                              .membershipDiscountAmount
                                                              .toString() ??*/
                                                          0.0,
                                                      tags: concerns,
                                                      sectionName: 'Treatments',
                                                      onPressed: () {
                                                        Get.to(
                                                          () =>
                                                              TreatmentDetailsPage(),
                                                          arguments: treat.id,
                                                          binding:
                                                              TreatmentDetailsBinding(),
                                                          transition:
                                                              Transition.fadeIn,
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                        );
                                                      },
                                                      unitType:
                                                          treat.unitType ?? "",
                                                      discount: 0, DiscountType: '',
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
