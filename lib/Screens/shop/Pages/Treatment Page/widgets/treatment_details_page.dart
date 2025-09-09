import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/treatment_quantity_bottom_sheet.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/variation_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../CSS/app_strings.dart';
import '../../../../../CSS/color.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../loading/become_a_member_loading.dart';
import '../../../../../util/common_page.dart';
import '../../../../../util/route_manager.dart';
import '../controller/treatment_details_controller.dart';

class TreatmentDetailsPage extends GetView<TreatmentDetailsController> {
  const TreatmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(
        isLeading: true,
        title: AppStrings.treatment,
        action: [],
      ),
      body: GetBuilder<TreatmentDetailsController>(
          init: Get.find<TreatmentDetailsController>()..fetchDetailsTreatment(),
          builder: (newController) {
            var data = newController.treatmentDetailsModel.treatment;
            return Stack(
              children: [
                newController.isLoading
                    ? MemberLoadDetail()
                    : newController.treatmentDetailsModel.treatment == null
                    ? Center(
                  child: NoRecord(
                    AppStrings.noTreatmentDetailsFound,
                    Icon(Icons.no_accounts),
                    AppStrings.weAreSorryNoTreatmentDetailsAvailable,
                  ),
                )
                    : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.h),
                          child: Text(
                            data!.treatmentName.toString(),
                            style: GoogleFonts.merriweather(
                                fontWeight: FontWeight.w900,
                                fontSize: 22.sp),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  color: AppColor().blackColor,
                                  height: 1.5.h,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                    '\$${controller.selectedQtyPrice.toString().replaceAll(".0", ".00") ?? ""}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text:
                                    '/${controller.selectedtype?['unit_type'] ?? ""}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : SizedBox(width: 5.w),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : Container(
                              height: 25.h,
                              width: 1.w,
                              color: AppColor().blackColor,
                            ),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : SizedBox(width: 5.w),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : Text(
                              '\$${controller.memberShipPrice.toString().replaceAll(".0", ".00")} member',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w900,
                                fontSize: 14.sp,
                                color: AppColor()
                                    .blackColor
                                    .withOpacity(0.7),
                                height: 1.5.h,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        controller.discountPrice.toString() == "0"
                            ? SizedBox.shrink()
                            : Container(
                          margin: EdgeInsets.all(10.0.h),
                          padding: EdgeInsets.only(
                              top: 10.0.h,
                              left: 10.w,
                              right: 10.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.dynamicColor
                                .withOpacity(.04),
                            borderRadius:
                            BorderRadius.circular(8.r),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${AppStrings.save} \$${controller.discountamount.toString().replaceAll(".0", ".00")} ${AppStrings.withA} ${controller.membershipName}"),
                              //add $ sign before discount price
                              TextButton(
                                  onPressed: () {
                                    Get.toNamed(
                                      RouteManager
                                          .membersShipDetailsPage,
                                      arguments: controller
                                          .membershipId,
                                      parameters: {
                                        "onlyShow": "0"
                                      },
                                    );
                                  },
                                  child: Text(
                                    AppStrings.viewMoreInfo
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontWeight:
                                      FontWeight.bold,
                                      fontSize: 15.sp,
                                      color:
                                      AppColor.dynamicColor,
                                    ),
                                  ))
                            ],
                          ),
                        ),
                        controller.discountPrice.toString() == "0"
                            ? SizedBox.shrink()
                            : Container(
                          padding: EdgeInsets.all(10.0.h),
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0.w),
                          decoration: BoxDecoration(
                            color: AppColor.dynamicColor,
                            borderRadius:
                            BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.local_offer_outlined,
                                color: AppColor().whiteColor,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  "${AppStrings.save} ${controller.discounttext.toString().replaceAll(".0", ".00")} ${AppStrings.onThisItemWhenYouApply} ${controller.membershipName} ${AppStrings.inCart}",
                                  style: GoogleFonts.roboto(
                                    color:
                                    AppColor().whiteColor,
                                    fontSize: 13.sp,
                                    height: 1.5.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0.h),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(5.0.r),
                            child: SizedBox(
                              height: 250.0.h,
                              child: PageView.builder(
                                controller: controller.pageController,
                                itemCount: (controller
                                    .treatmentDetailsModel
                                    .treatment!
                                    .images
                                    ?.isNotEmpty ??
                                    false)
                                    ? controller.treatmentDetailsModel
                                    .treatment!.images!.length
                                    : 1,
                                onPageChanged: (index) => controller
                                    .currentPage.value = index,
                                itemBuilder: (context, index) {
                                  return Image.network(
                                    (controller.treatmentDetailsModel.treatment!.images != null &&
                                        controller.treatmentDetailsModel.treatment!.images!.isNotEmpty)
                                        ? controller.treatmentDetailsModel.treatment!
                                        .images![index]
                                        : "",
                                    fit: BoxFit.contain,
                                    width: double.infinity,
                                    loadingBuilder: (context, child,
                                        loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child:
                                        CircularProgressIndicator(
                                          value: loadingProgress
                                              .expectedTotalBytes !=
                                              null
                                              ? loadingProgress
                                              .cumulativeBytesLoaded /
                                              (loadingProgress
                                                  .expectedTotalBytes ??
                                                  1)
                                              : null,
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) {
                                      return Container(
                                        height: 250.h,
                                        width: double.infinity,
                                        color: AppColor
                                            .geryBackGroundColor,
                                        child: Center(
                                            child: Image.asset(
                                              "assets/images/Image_not_available.png",
                                              color:
                                              AppColor().blackColor,
                                              fit: BoxFit.cover,
                                            )),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // Page indicator dots
                        if (controller.treatmentDetailsModel
                            .treatment!.images ==
                            null)
                          SizedBox.shrink()
                        else if (controller.treatmentDetailsModel
                            .treatment!.images!.length <=
                            1)
                          SizedBox.shrink()
                        else
                          Obx(() => Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: List.generate(
                              controller
                                  .treatmentDetailsModel
                                  .treatment!
                                  .images!
                                  .length ??
                                  0,
                                  (index) => AnimatedContainer(
                                duration:
                                Duration(milliseconds: 300),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 2.0.w),
                                height: 8.0,
                                width: controller
                                    .currentPage.value ==
                                    index
                                    ? 16.0.w
                                    : 8.0.w,
                                decoration: BoxDecoration(
                                  color: controller.currentPage
                                      .value ==
                                      index
                                      ? AppColor.dynamicColor
                                      : Colors.grey,
                                  borderRadius:
                                  BorderRadius.circular(
                                      8.0.r),
                                ),
                              ),
                            ),
                          )),
                        SizedBox(height: 10.h),
                        Container(
                          padding: EdgeInsets.all(10.0.h),
                          decoration: BoxDecoration(
                            color:
                            AppColor().greyColor.withOpacity(.1),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0.w),
                            child: Text(
                              controller.treatmentDetailsModel
                                  .treatment!.treatmentDescription
                                  .toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 14.sp,
                                color: AppColor()
                                    .blackColor
                                    .withOpacity(0.9),
                                height: 1.5.h,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          AppStrings.selectATreatment.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: AppColor.dynamicColor,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Column(
                          children: [
                            // First InkWell (always visible)
                            // Show InkWell only if variations > 1
                            if (controller.variationList.length > 1)
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  controller.variationList.length == 1
                                      ? await Get.bottomSheet(
                                    TreatmentQuantityBottomSheet(
                                      addToCart: () {
                                        print(1);
                                        final selectedVariation =
                                        data.variations![
                                        controller
                                            .selectedIndex];
                                        final selectedPrice =
                                            selectedVariation
                                                .prices!.first;
                                        Get.back();
                                        controller.addToCart(
                                          0,
                                          data.treatmentId,
                                          selectedVariation
                                              .variationId,
                                          selectedPrice
                                              .treatmentvariationpriceid,
                                          // ✅ treatment_price_id
                                          controller.selectedQtyPrice
                                              ?.toDouble() ??
                                              0.0, // ✅ treatment_price
                                          controller.selectedtype?['qty'].toString().replaceAll(".0", "") ??
                                              0,
                                        );
                                      },
                                      onBack: () {},
                                      treatmentVarLists:
                                      controller
                                          .variationList,
                                    ),
                                    isDismissible: false,
                                    isScrollControlled: true,
                                  )
                                      : Get.bottomSheet(
                                    VariationSelectorBottomSheet(
                                        onSelect:
                                            (selectedVariation) {
                                          print(2);
                                          Get.back();
                                          Get.bottomSheet(
                                            TreatmentQuantityBottomSheet(
                                              treatmentVarLists: [
                                                selectedVariation
                                              ],
                                              addToCart: () {
                                                // Your cart logic here
                                                final selectedVariation = data
                                                    .variations![
                                                controller
                                                    .selectedIndex];
                                                final selectedPrice =
                                                    selectedVariation
                                                        .prices!
                                                        .first;
                                                Get.back();
                                                controller
                                                    .addToCart(
                                                  0,
                                                  data.treatmentId,
                                                  selectedVariation
                                                      .variationId,
                                                  selectedPrice
                                                      .treatmentvariationpriceid,
                                                  // ✅ treatment_price_id
                                                  controller.selectedQtyPrice
                                                      ?.toDouble() ??
                                                      0.0, // ✅ treatment_price
                                                  selectedPrice
                                                      .qty ??
                                                      0,
                                                );
                                              },
                                              onBack: () {
                                                Get.back();
                                              },
                                            ),
                                            isScrollControlled:
                                            true,
                                          );
                                        },
                                        controller: controller),
                                    isScrollControlled: true,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12),
                                    borderRadius:
                                    BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller
                                                .selectedQtyLabel ??
                                                AppStrings.selectTreatment,
                                            style: GoogleFonts.roboto(
                                              fontSize: 14.sp,
                                              color: AppColor()
                                                  .blackColor,
                                              fontWeight:
                                              FontWeight.bold,
                                              height: 1.5.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),

                            if (controller.selectedQtyLabel != null ||
                                controller.variationList.length == 1)
                              InkWell(
                                highlightColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                onTap: () async {
                                  print(3);
                                  controller.variationList.length == 1
                                      ? await Get.bottomSheet(
                                    TreatmentQuantityBottomSheet(
                                      addToCart: () {
                                        final selectedVariation =
                                        data.variations![
                                        controller
                                            .selectedIndex];
                                        final selectedPrice = controller
                                            .selectedIndexKey == null
                                            ? selectedVariation
                                            .prices!.first
                                            : selectedVariation
                                            .prices![
                                        controller
                                            .selectedIndexKey];
                                        Get.back();
                                        controller.addToCart(
                                          0,
                                          data.treatmentId,
                                          selectedVariation
                                              .variationId,
                                          selectedPrice
                                              .treatmentvariationpriceid,
                                          // ✅ treatment_price_id
                                          controller.selectedQtyPrice
                                              ?.toDouble() ??
                                              0.0, // ✅ treatment_price
                                          controller.selectedtype?['qty'].toString().replaceAll(".0", "") ??
                                              0,
                                        );
                                      },
                                      onBack: () {},
                                      treatmentVarLists:
                                      controller
                                          .variationList,
                                    ),
                                    isDismissible: false,
                                    isScrollControlled: true,
                                  )
                                      : Get.bottomSheet(
                                    TreatmentQuantityBottomSheet(
                                      treatmentVarLists:
                                      controller
                                          .variationList,
                                      // pass all or default variation
                                      addToCart: () {
                                        final selectedVariation =
                                        data.variations![
                                        controller
                                            .selectedIndex];
                                        final selectedPrice = controller
                                            .selectedIndexKey ==
                                            null
                                            ? selectedVariation
                                            .prices!.first
                                            : selectedVariation
                                            .prices![
                                        controller
                                            .selectedIndexKey];
                                        Get.back();
                                        controller.addToCart(
                                          0,
                                          data.treatmentId,
                                          selectedVariation
                                              .variationId,
                                          selectedPrice
                                              .treatmentvariationpriceid,
                                          //treatment_price
                                          // _id
                                          controller.selectedQtyPrice
                                              ?.toDouble() ??
                                              0.0, //treatment_price
                                          controller.selectedtype?['qty'].toString().replaceAll(".0", "") ??
                                              0,
                                        );
                                      },
                                      onBack: () => Get.back(),
                                    ),
                                    isScrollControlled: true,
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.all(10.h),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 10.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12),
                                    borderRadius:
                                    BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      GetBuilder<
                                          TreatmentDetailsController>(
                                        builder: (controller) {
                                          bool hasSelection = controller
                                              .selectedQtyLabel !=
                                              null;

                                          return Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              Text(
                                                "${controller.selectedtype?['qty'].toString().replaceAll(".0", "")} ${controller.selectedtype?['unit_type']}",
                                                style: GoogleFonts
                                                    .roboto(
                                                  fontSize: 14.sp,
                                                  color: AppColor()
                                                      .blackColor,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  height: 1.5.h,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: GoogleFonts.roboto(
                                  fontSize: 14.sp,
                                  color: AppColor().blackColor,
                                  height: 1.5.h,
                                ),
                                children: [
                                  TextSpan(
                                    text:
                                    '\$${controller.selectedQtyPrice.toString().replaceAll(".0", ".00") ?? ""}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  ),
                                  TextSpan(
                                    text:
                                    '/${controller.selectedtype?['unit_type'] ?? ""}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : SizedBox(width: 5.w),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : Container(
                              height: 25.h,
                              width: 1.w,
                              color: AppColor().blackColor,
                            ),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : SizedBox(width: 5.w),
                            controller.memberShipPrice.toString() ==
                                "0"
                                ? SizedBox.shrink()
                                : Text(
                              '\$${controller.memberShipPrice.toString().replaceAll(".0", ".00")} ${AppStrings.memberInSmallLetters}',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w900,
                                fontSize: 14.sp,
                                color: AppColor()
                                    .blackColor
                                    .withOpacity(0.7),
                                height: 1.5.h,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),

                        SizedBox(height: 10.h),
                        controller.membershipName.toString() == ""
                            ? SizedBox.shrink()
                            : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Checkbox(
                                  materialTapTargetSize:
                                  MaterialTapTargetSize
                                      .padded,
                                  checkColor:
                                  AppColor().whiteColor,
                                  side: BorderSide(
                                    color: controller
                                        .isTreatmentCheck
                                        ? AppColor().whiteColor
                                        : AppColor().greyColor,
                                    width: controller
                                        .isTreatmentCheck
                                        ? 5.0
                                        : 1.0,
                                    style: BorderStyle.solid,
                                    strokeAlign: BorderSide
                                        .strokeAlignOutside,
                                  ),
                                  fillColor:
                                  MaterialStateProperty.all(
                                    controller.isTreatmentCheck
                                        ? AppColor.dynamicColor
                                        : AppColor().whiteColor,
                                  ),
                                  value: controller
                                      .isTreatmentCheck ??
                                      false,
                                  // ✅ always non-null
                                  onChanged: (value) {
                                    controller
                                        .isTreatmentCheck =
                                        value ?? false;
                                    print(
                                        "yes : ${controller.isTreatmentCheck}");
                                    controller.update();
                                  },
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              color:
                                              Colors.black),
                                          children: [
                                            TextSpan(
                                              text: AppStrings.becomeA,
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                              ),
                                            ),
                                            TextSpan(
                                              text:
                                              "${AppStrings.member} ${controller.membershipName}",
                                              style: TextStyle(
                                                fontWeight:
                                                FontWeight
                                                    .bold,
                                                backgroundColor: AppColor
                                                    .dynamicColor
                                                    .withOpacity(
                                                    0.3),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "${AppStrings.addToCartNowToSave} \$${controller.memberShipPrice.toString().replaceAll(".0", ".00")} "
                                            "${AppStrings.onThisTreatmentToday}",
                                        style: TextStyle(
                                            fontSize: 14),
                                      ),
                                      Text(
                                        "\$${controller.memberShip.toString().replaceAll(".0", ".00")}${AppStrings.monthMemberShipFeeApplies}",
                                        style: TextStyle(
                                            color: Colors
                                                .grey[600]),
                                      ),
                                      SizedBox(height: 6),
                                      InkWell(
                                        onTap: () {
                                          // show more info
                                          Get.toNamed(
                                            RouteManager
                                                .membersShipDetailsPage,
                                            arguments: controller
                                                .membershipId,
                                            parameters: {
                                              "onlyShow": "0"
                                            },
                                          );
                                        },
                                        child: Text(
                                          "VIEW MORE INFO",
                                          style: TextStyle(
                                            fontWeight:
                                            FontWeight.bold,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        controller.discountPrice.toString() == "0"
                            ? SizedBox.shrink()
                            : Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                              bottom: 12,
                              left: 10.w,
                              right: 10.w),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius:
                            BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text:
                                      "${AppStrings.save} \$${controller.discountamount.toString().replaceAll(".0", ".00")} ",
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      "${AppStrings.withA} ${controller.membershipName}",
                                      style: TextStyle(
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6),
                              InkWell(
                                onTap: () {
                                  // show more info
                                  Get.toNamed(
                                    RouteManager
                                        .membersShipDetailsPage,
                                    arguments: controller
                                        .membershipId,
                                    parameters: {
                                      "onlyShow": "0"
                                    },
                                  );
                                },
                                child: Text(
                                  AppStrings.viewMoreInfoInCapitalLetters,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.convenienceFeeAppliedAtCheckout,
                              style: TextStyle(fontSize: 13.sp),
                            ),
                            SizedBox(width: 5.w),
                            Icon(
                              Icons.info_outline,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.all(15.h),
                          padding: EdgeInsets.all(10.h),
                          decoration: BoxDecoration(
                              color: AppColor().lightGrey),
                          child: Column(
                            children: [
                              Text(AppStrings.helpsWithTheseConcerns),
                              SizedBox(height: 10.h),
                              Wrap(
                                direction: Axis.horizontal,
                                spacing: 10.w,
                                runSpacing: 10.h,
                                alignment: WrapAlignment.center,
                                children: controller
                                    .treatmentDetailsModel
                                    .treatment!
                                    .treatmentConcerns!
                                    .map((concern) => Container(
                                  padding:
                                  EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: AppColor
                                        .dynamicColor
                                        .withOpacity(.1),
                                    borderRadius:
                                    BorderRadius.circular(
                                        5.r),
                                  ),
                                  child: Text(
                                    concern,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor
                                          .dynamicColor,
                                    ),
                                  ),
                                ))
                                    .toList(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
      bottomNavigationBar: SafeArea(
        child: GetBuilder<TreatmentDetailsController>(
          builder: (treatmentController) {
            final data = treatmentController.treatmentDetailsModel.treatment;

            // If loading or data is null or treatment variants are empty, hide the button
            if (treatmentController.isLoading ||
                data == null ||
                data.variations == null ||
                data.variations!.isEmpty) {
              return const SizedBox.shrink();
            }

            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: data.variations!.length == 1 ||
                      controller.selectedQtyLabel != null
                      ? () {
                    print(treatmentController.selectedIndex);
                    final selectedVariation =
                    data.variations![controller.selectedIndex];
                    print(controller.selectedIndexKey);
                    final selectedPrice =
                    controller.selectedIndexKey == '0-0' ||
                        controller.selectedIndexKey.toString() ==
                            "null"
                        ? selectedVariation.prices!.first
                        : selectedVariation
                        .prices![controller.selectedIndexKey];
                    print("selctqty: ${selectedPrice.qty}");
                    controller.addToCart(
                      0,
                      data.treatmentId,
                      selectedVariation.variationId,
                      selectedPrice.treatmentvariationpriceid,
                      // ✅ treatment_price_id
                      controller.selectedQtyPrice.toDouble() ?? 0.0,
                      // ✅ treatment_price
                      controller.selectedtype?['qty'].toString().replaceAll(".0", "") ?? 0,
                    );
                  }
                      : () async {
                    print(5);
                    await Get.bottomSheet(
                      VariationSelectorBottomSheet(
                          onSelect: (selectedVariation) async {
                            // Then show pricing bottom sheet
                            Get.back();
                            await Get.bottomSheet(
                              TreatmentQuantityBottomSheet(
                                treatmentVarLists: [selectedVariation],
                                addToCart: () {
                                  final selectedVariation =
                                  data.variations![
                                  controller.selectedIndex];
                                  final selectedPrice = controller
                                      .selectedIndexKey ==
                                      '0-0' ||
                                      controller.selectedIndexKey
                                          .toString() ==
                                          "null"
                                      ? selectedVariation.prices!.first
                                      : selectedVariation.prices![
                                  int.parse(controller
                                      .selectedIndexKey
                                      .toString())];
                                  // Your cart logic here
                                  Get.back();
                                  controller.addToCart(
                                    0,
                                    data.treatmentId,
                                    selectedVariation.variationId,
                                    selectedPrice
                                        .treatmentvariationpriceid,
                                    // ✅ treatment_price_id
                                    controller.selectedQtyPrice.toDouble() ??
                                        0.0,
                                    // ✅ treatment_price
                                    controller.selectedtype?['qty'].toString().replaceAll(".0", "") ?? 0,
                                  );
                                },
                                onBack: () {
                                  Get.back();
                                },
                              ),
                              isScrollControlled: true,
                            );
                          },
                          controller: controller),
                      isScrollControlled: true,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0.r),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        AppColor.dynamicColor,
                        AppColor.dynamicColor.withAlpha(430)
                      ]),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: treatmentController.isAddingCart
                          ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : Text(
                        AppStrings.addToCart,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 18.h,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //?
  String buildPriceText({
    required var originalPrice,
    var memberPrice,
    String? unit, // e.g. 'treatment', 'syringe', etc.
  }) {
    bool hasUnit = unit != null && unit.isNotEmpty;
    bool hasMember = (memberPrice != null && memberPrice != 0);

    String basePrice = "\$${originalPrice}";
    String memberText = hasMember ? "\$${memberPrice!} member" : "";

    if (hasUnit && hasMember) {
      // Case 1: $49.00/treatment | $39.20 member
      return "$basePrice/$unit | $memberText";
    } else if (!hasUnit && hasMember) {
      // Case 2: From $3,300.00 | $2,640.00 member
      return "From $basePrice | $memberText";
    } else if (!hasUnit && !hasMember) {
      // Case 3: From $1,100.00
      return "From $basePrice";
    } else {
      // fallback - unit but no member
      return "From $basePrice/$unit";
    }
  }
}
