import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/controller/treatment_controller.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/treatment_details_page.dart';
import 'package:chino_hills/binding/cart_billing.dart';
import 'package:chino_hills/common_Widgets/no_record.dart';
import 'package:chino_hills/loading/cart_list_load.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/appTypography.dart';
import '../../../../common_Widgets/common_badge_container.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../util/common_page.dart';
import '../../widgets/package_card_widgets.dart';
import '../../widgets/show_selctection_bottomsheet_widget.dart';
import '../Package Page/controller/package_cotroller.dart';

class TreatmentPage extends StatefulWidget {
  const TreatmentPage({super.key});

  @override
  State<TreatmentPage> createState() => _TreatmentPageState();
}

class _TreatmentPageState extends State<TreatmentPage> {
  final con = Get.put(TreatmentController());
  final pcon = Get.put(PackageController());
  List bodyValue = [];
  List concernValue = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con.selectedArea = [];
    con.selectedOptions = [];
    con.selectFilterValue = [];
    con.selectFilter = "";
    con.getTreatmentList([], [], "");
    pcon.browseList();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TreatmentController>(
        init: TreatmentController(),
        builder: (treatController) {
          return treatController.loading
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
                  ))
              : LiquidPullToRefresh(
                  animSpeedFactor: 1.5,
                  springAnimationDurationInMilliseconds: 400,
                  key: treatController.refreshIndicatorKey,
                  color: AppColor.dynamicColor,
                  showChildOpacityTransition: false,
                  onRefresh: treatController.handleRefresh,
                  child: ListView(
                    children: [
                      // TODO ? Section 1 : Here Show the Image And Shadow Text...

                      Container(
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 10.h),
                        width: double.infinity,
                        height: 200.h,
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
                                "assets/new_images/nima_logo.png",
                                color: AppColor.dynamicColor,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0.h,
                              child: CommonNetworkImageWidget(
                                  imageUrl: con.packageHeaderImage,
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
                                        treatController.treatmentListModel
                                                    .headerDetails ==
                                                null
                                            ? "Curated\nTreatments"
                                            : treatController.treatmentListModel
                                                .headerDetails!.headerTitle
                                                .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography
                                            .galanoGrostesqueSemiBold
                                            .copyWith(
                                                color: AppColor().whiteColor,
                                                fontSize: 22.sp,
                                                height: 0.9.h),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        treatController.treatmentListModel
                                                    .headerDetails ==
                                                null
                                            ? "Shop our treatment"
                                            : treatController
                                                .treatmentListModel
                                                .headerDetails!
                                                .headerDescription
                                                .toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography.hostGroteskRegular
                                            .copyWith(
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

                      // TODO ? Section 2 : Here Flitter...

                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Todo: Section 1 - Filter
                            Row(
                              children: [
                                Text(
                                  "Filter:",
                                  style: AppTypography.galanoGrostesqueSemiBold
                                      .copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                //Todo: Concern Button
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      CommonBottomSheet(
                                        selectedOptions:
                                            treatController.selectedOptions,
                                        title: "FILTER BY CONCERN",
                                        options: pcon.concern,
                                        isSortBy: false,
                                        selectedValue: [],
                                        onReset: () {
                                          treatController.selectedOptions
                                              .clear();
                                          treatController.getTreatmentList(
                                              treatController.selectedOptions,
                                              treatController.selectedArea,
                                              treatController.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        onApply: () {
                                          concernValue = pcon.concern
                                              .where((item) => treatController
                                                  .selectedOptions
                                                  .contains(item['id']))
                                              .map((item) => item['title'])
                                              .toList();
                                          treatController.getTreatmentList(
                                              treatController.selectedOptions,
                                              treatController.selectedArea,
                                              treatController.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        name: 'treatments',
                                      ),
                                      isScrollControlled: true,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 80.w,
                                        child: Text(
                                          concernValue.isNotEmpty
                                              ? concernValue.length > 1
                                                  ? "${concernValue[0]}+${concernValue.length - 1}"
                                                  : concernValue[0]
                                              : "Concern",
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
                                SizedBox(
                                  width: 5,
                                ),
                                // Area Button
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      CommonBottomSheet(
                                        selectedOptions:
                                            treatController.selectedArea,
                                        title: "FILTER BY Area",
                                        options: pcon.bodyArea,
                                        isSortBy: false,
                                        selectedValue: [],
                                        onReset: () {
                                          treatController.selectedArea.clear();
                                          treatController.getTreatmentList(
                                              treatController.selectedOptions,
                                              treatController.selectedArea,
                                              treatController.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        onApply: () {
                                          bodyValue = pcon.bodyArea
                                              .where((item) => treatController
                                                  .selectedArea
                                                  .contains(item['id']))
                                              .map((item) => item['title'])
                                              .toList();
                                          treatController.getTreatmentList(
                                              treatController.selectedOptions,
                                              treatController.selectedArea,
                                              treatController.selectFilter);
                                          Navigator.pop(context);
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
                                          bodyValue.isNotEmpty
                                              ? bodyValue.length > 1
                                                  ? "${bodyValue[0]}+${bodyValue.length - 1}"
                                                  : bodyValue[0]
                                              : "Area",
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
                              ],
                            ),

                            //! todo Section 2 - Sort
                            Row(
                              children: [
                                Text(
                                  "Sort:",
                                  style: AppTypography.galanoGrostesqueSemiBold
                                      .copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    Get.bottomSheet(
                                      CommonBottomSheet(
                                        selectedOptions: [],
                                        title: "Sort By",
                                        options: treatController.filter,
                                        isSortBy: true,
                                        selectedValue:
                                            treatController.selectFilterValue,
                                        onReset: () {
                                          treatController.selectFilterValue
                                              .clear();
                                          treatController.selectFilter = "";
                                          treatController.getTreatmentList(
                                              treatController.selectedOptions,
                                              treatController.selectedArea,
                                              treatController.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        onApply: () {
                                          String index = treatController
                                              .selectFilterValue
                                              .toString()
                                              .replaceAll('[', '')
                                              .replaceAll(']', '');
                                          if (int.parse(index) >= 0 &&
                                              int.parse(index) <
                                                  treatController
                                                      .filterBack.length) {
                                            treatController.selectFilter =
                                                treatController.filterBack[
                                                            int.parse(index)]
                                                        ['title'] ??
                                                    "";
                                          } else {
                                            treatController.selectFilter =
                                                ""; // or some fallback value
                                          }
                                          treatController.getTreatmentList(
                                              treatController.selectedOptions,
                                              treatController.selectedArea,
                                              treatController.selectFilter);
                                          Navigator.pop(context);
                                        },
                                        name: '',
                                      ),
                                      isScrollControlled: true,
                                    );
                                  },
                                  child: SizedBox(
                                      width: 70.w,
                                      child: Text(
                                        treatController.selectFilter == ""
                                            ? "Featured"
                                            : treatController.selectFilter,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTypography
                                            .galanoGrostesqueSemiBold
                                            .copyWith(
                                          fontSize: 14.sp,
                                          color: AppColor().blackColor,
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      treatController.treatmentData.isEmpty
                          ? SizedBox(height: 30.h)
                          : SizedBox.shrink(),
                      // TODO ? Section 3 : Here List Of Data...
                      treatController.treatmentData.isEmpty
                          ? Center(
                              child: NoRecord(
                                imageHeight: 120,
                                imageWidth: 120,
                                "No Treatment Data Found",
                                Icon(Icons.no_accounts),
                                "We're sorry. no treatment data available at this moment.",
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: treatController.treatmentData.length,
                              itemBuilder: (context, index) {
                                final product =
                                    treatController.treatmentData[index];
                                List<String> concerns = product.concerns!
                                    .map((con) => con.toString())
                                    .toList();
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    children: [
                                      PackageCard(
                                        title: product.name ?? "",
                                        description: product.description ?? "",
                                        imageUrl: (product.image != null &&
                                                product.image!.isNotEmpty)
                                            ? product.image.toString()
                                            : "",
                                        originalPrice: product.price.toString(),
                                        memberPrice:
                                            product.membershipOfferPrice == ""
                                                ? "0.0"
                                                : product.membershipOfferPrice!
                                                    .toString(),
                                        tags: concerns,
                                        discount: product.offeroffText ==
                                                    null ||
                                                product.offeroffText!.isEmpty
                                            ? 0
                                            : product.offeroffText,
                                        // int.parse(double.parse(product
                                        //             .offeroffText
                                        //             .toString())
                                        //         .toStringAsFixed(0)),
                                        sectionName: 'Treatments',
                                        onPressed: () {
                                          //Todo redirect to Treatment details
                                          Get.to(
                                            () => TreatmentDetailsPage(),
                                            arguments: product.id,
                                            binding: CommonBinding(),
                                            transition: Transition.fadeIn,
                                            duration:
                                                Duration(milliseconds: 500),
                                          );
                                        },
                                        unitType: product.type ?? "",
                                        DiscountType: "",
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
