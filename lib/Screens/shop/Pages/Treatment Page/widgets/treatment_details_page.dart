import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/treatment_quantity_bottom_sheet.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/variation_section.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import '../../../../../CSS/color.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../loading/become_a_member_loading.dart';
import '../../../../../util/route_manager.dart';
import '../controller/treatment_details_controller.dart';

class TreatmentDetailsPage extends GetView<TreatmentDetailsController> {
  const TreatmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String formatDiscount(dynamic offer) {
      if (offer == null) return "";

      final offerText = offer.toString().trim();
      if (offerText.isEmpty) return "";

      // Match number inside the string
      final match = RegExp(r'([0-9]+(?:\.[0-9]+)?)').firstMatch(offerText);

      if (match != null) {
        final numericPart = double.tryParse(match.group(1)!);
        if (numericPart != null) {
          if (numericPart == 0) return ""; // hide zero discounts

          // Format the number: drop .0 if whole
          final numberStr = numericPart % 1 == 0
              ? numericPart.toInt().toString()
              : numericPart.toString();

          // Split into prefix + number + suffix
          final prefix =
              offerText.substring(0, match.start).trim(); // before number
          var suffix = offerText.substring(match.end).trim(); // after number

          // Only add space after number if prefix contains a dollar sign
          if (prefix.contains("\$") &&
              suffix.isNotEmpty &&
              !suffix.startsWith(' ')) {
            suffix = ' $suffix';
          }
          return "$prefix$numberStr$suffix".trim();
        }
      }

      return offerText;
    }

    return Scaffold(
      backgroundColor: AppColor().background,
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
                            Icon(
                              Icons.no_accounts,
                              size: 20.h,
                            ),
                            AppStrings.weAreSorryNoTreatmentDetailsAvailable,
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                  height: MediaQuery.sizeOf(context).height * 1,
                                  child: Stack(
                                    children: [
                                      /// Scrollable image slider
                                      Positioned.fill(
                                        child: PageView.builder(
                                          controller: controller.pageController,
                                          itemCount: (controller
                                                      .treatmentDetailsModel
                                                      .treatment
                                                      ?.images
                                                      ?.isNotEmpty ??
                                                  false)
                                              ? controller.treatmentDetailsModel
                                                  .treatment!.images!.length
                                              : 1,
                                          onPageChanged: (index) => controller
                                              .currentPage.value = index,
                                          itemBuilder: (context, index) {
                                            return Image.network(
                                              (controller
                                                          .treatmentDetailsModel
                                                          .treatment
                                                          ?.images
                                                          ?.isNotEmpty ??
                                                      false)
                                                  ? controller
                                                      .treatmentDetailsModel
                                                      .treatment!
                                                      .images![index]
                                                  : "",
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                              loadingBuilder: (context, child,
                                                  loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              },
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Center(
                                                  child: Image.asset(
                                                    "assets/images/Image_not_available.png",
                                                    color:
                                                        AppColor().blackColor,
                                                    fit: BoxFit.cover,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),

                                      /// Background overlay image — disable touch to keep PageView scrollable
                                      Positioned.fill(
                                        child: IgnorePointer(
                                          child: Image.asset(
                                            "assets/new_images/browse_section_background.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),

                                      /// Gradient overlay
                                      Positioned.fill(
                                        child: IgnorePointer(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  AppColor()
                                                      .blackColor
                                                      .withOpacity(0.40),
                                                  AppColor()
                                                      .blackColor
                                                      .withOpacity(0.40),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      /// Text and overlay content
                                      Positioned(
                                        top: 110.h,
                                        left: 0,
                                        right: 0,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 15.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.6,
                                                child: Text(
                                                  data?.treatmentName
                                                          ?.toString()
                                                          .toUpperCase() ??
                                                      "",
                                                  softWrap: true,
                                                  textAlign: TextAlign.start,
                                                  style: AppTypography
                                                      .galanoGrostesqueSemiBold
                                                      .copyWith(
                                                    color:
                                                        AppColor().whiteColor,
                                                    fontSize: 22.sp,
                                                    height: 1.0,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15.h),
                                              RichText(
                                                textAlign: TextAlign.start,
                                                text: TextSpan(
                                                  style: AppTypography
                                                      .hostGroteskRegular
                                                      .copyWith(
                                                    fontSize: 18.sp,
                                                    color:
                                                        AppColor().whiteColor,
                                                    height: 1.5,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "\$${controller.selectedQtyPrice.toString()}",
                                                    ),
                                                    controller.selectedtype?[
                                                                'unit_type'] ==
                                                            ""
                                                        ? TextSpan()
                                                        : TextSpan(
                                                            text:
                                                                '/${controller.selectedtype?['unit_type'] ?? ""}',
                                                          ),
                                                  ],
                                                ),
                                              ),
                                              // Space before divider
                                              if (controller.memberShipPrice
                                                          .toString() !=
                                                      "0" &&
                                                  controller.memberShipPrice
                                                          .toString() !=
                                                      "0.0" &&
                                                  controller.memberShipPrice
                                                          .toString() !=
                                                      "0.00")
                                                SizedBox(width: 8.w),
                                              // Member Price Text
                                              if (controller.memberShipPrice
                                                          .toString() !=
                                                      "0" &&
                                                  controller.memberShipPrice
                                                          .toString() !=
                                                      "0.0" &&
                                                  controller.memberShipPrice
                                                          .toString() !=
                                                      "0.00")
                                                RichText(
                                                  textAlign: TextAlign.start,
                                                  text: TextSpan(
                                                    style: AppTypography
                                                        .hostGroteskSemiBold
                                                        .copyWith(
                                                      fontSize: 18.sp,
                                                      color:
                                                          AppColor().whiteColor,
                                                      height: 1.5,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            '\$${controller.memberShipPrice.toString()}',
                                                      ),
                                                      TextSpan(
                                                        text: '/Member',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              SizedBox(height: 15.h),
                                              controller.discountamount
                                                      .toString()
                                                      .isEmpty
                                                  ? SizedBox.shrink()
                                                  : RichText(
                                                      textAlign:
                                                          TextAlign.start,
                                                      text: TextSpan(
                                                        style: AppTypography
                                                            .hostGroteskRegular
                                                            .copyWith(
                                                          fontSize: 15.sp,
                                                          color: AppColor()
                                                              .whiteColor,
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "${AppStrings.save} ",
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "\$${controller.discountamount.toString()}",
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "${AppStrings.withA} ${controller.membershipName}",
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      /// Offer banner
                                      Positioned(
                                        bottom: 40.h,
                                        left: 0,
                                        right: 0,
                                        child: data?.offeroffText == ""
                                            ? const SizedBox.shrink()
                                            : Container(
                                                padding: EdgeInsets.all(10.0.h),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10.0.w),
                                                decoration: BoxDecoration(
                                                  color: AppColor.dynamicColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons
                                                            .local_offer_outlined,
                                                        color: AppColor()
                                                            .whiteColor,
                                                        size: 25.h),
                                                    SizedBox(width: 10.w),
                                                    Expanded(
                                                      child: Text(
                                                        "${AppStrings.save} ${formatDiscount(data?.offeroffText)} ${AppStrings.onThisItemWhenYouApply} '${data?.offerName}' ${AppStrings.inCart}",
                                                        style: AppTypography
                                                            .hostGroteskRegular
                                                            .copyWith(
                                                          color: AppColor()
                                                              .whiteColor,
                                                          fontSize: 14.sp,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),

                                      /// AppBar row
                                    ],
                                  )),
                              SizedBox(height: 10.h),
                              // Page indicator dots
                              if (controller.treatmentDetailsModel.treatment!
                                      .images ==
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
                                        controller.treatmentDetailsModel
                                                .treatment!.images!.length ??
                                            0,
                                        (index) => AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.0.w),
                                          height: 8.0,
                                          width: controller.currentPage.value ==
                                                  index
                                              ? 16.0.w
                                              : 8.0.w,
                                          decoration: BoxDecoration(
                                            color:
                                                controller.currentPage.value ==
                                                        index
                                                    ? AppColor.dynamicColor
                                                    : AppColor().greyColor,
                                            borderRadius:
                                                BorderRadius.circular(8.0.r),
                                          ),
                                        ),
                                      ),
                                    )),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.all(10.0.h),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0.w),
                                  child: Text(
                                    controller.treatmentDetailsModel.treatment!
                                        .treatmentDescription
                                        .toString(),
                                    style: AppTypography.hostGroteskRegular
                                        .copyWith(
                                      fontSize: 15.sp,
                                      color: AppColor()
                                          .blackColor
                                          .withOpacity(0.65),
                                      height: 1.5.h,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                AppStrings.selectATreatment.toUpperCase(),
                                style: AppTypography.galanoGrostesqueSemiBold
                                    .copyWith(
                                  fontSize: 16.sp,
                                  color: AppColor.dynamicColor,
                                ),
                              ),
                              SizedBox(height: 10.h),

                              if (controller.variationList.length > 1)
                                InkWell(
                                  highlightColor: AppColor().transparent,
                                  splashColor: AppColor().transparent,
                                  onTap: () async {
                                    controller.variationList.length == 1
                                        ? await Get.bottomSheet(
                                            TreatmentQuantityBottomSheet(
                                              addToCart: () {
                                                print(1);
                                                final selectedVariation = data
                                                        ?.variations![
                                                    controller.selectedIndex];
                                                final selectedPrice =
                                                    selectedVariation
                                                        ?.prices!.first;
                                                Get.back();
                                                controller.addToCart(
                                                  0,
                                                  data?.treatmentId,
                                                  selectedVariation!
                                                      .variationId,
                                                  selectedPrice!
                                                      .treatmentvariationpriceid,
                                                  controller.selectedQtyPrice ??
                                                      0.0,
                                                  controller
                                                          .selectedtype?['qty']
                                                          .toString()
                                                          .replaceAll(
                                                              ".0", "") ??
                                                      0,
                                                );
                                              },
                                              onBack: () {},
                                              treatmentVarLists:
                                                  controller.variationList,
                                            ),
                                            isDismissible: false,
                                            isScrollControlled: true,
                                          )
                                        : Get.bottomSheet(
                                            VariationSelectorBottomSheet(
                                                onSelect: (selectedVariation) {
                                                  print(2);
                                                  Get.back();
                                                  Get.bottomSheet(
                                                    TreatmentQuantityBottomSheet(
                                                      treatmentVarLists: [
                                                        selectedVariation
                                                      ],
                                                      addToCart: () {
                                                        // Your cart logic here
                                                        final selectedVariation =
                                                            data!.variations![
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
                                                          controller
                                                                  .selectedQtyPrice ??
                                                              0.0, // ✅ treatment_price
                                                          selectedPrice.qty ??
                                                              0,
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
                                  child: Container(
                                    margin: EdgeInsets.all(10.h),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 14.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor()
                                              .blackColor
                                              .withOpacity(.2)),
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            controller.selectedQtyLabel ??
                                                AppStrings.selectTreatment,
                                            style: AppTypography
                                                .hostGroteskSemiBold
                                                .copyWith(
                                              fontSize: 15.sp,
                                              color: AppColor()
                                                  .blackColor
                                                  .withOpacity(0.65),
                                              height: 1.5.h,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 30.w,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.dynamicColor,
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColor().whiteColor,
                                            size: 15.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              if (controller.selectedQtyLabel != null ||
                                  controller.variationList.length == 1)
                                InkWell(
                                  highlightColor: AppColor().transparent,
                                  splashColor: AppColor().transparent,
                                  onTap: () async {
                                    print(3);
                                    controller.variationList.length == 1
                                        ? await Get.bottomSheet(
                                            TreatmentQuantityBottomSheet(
                                              addToCart: () {
                                                final selectedVariation = data!
                                                        .variations![
                                                    controller.selectedIndex];
                                                final selectedPrice = controller
                                                            .selectedIndexKey ==
                                                        null
                                                    ? selectedVariation
                                                        .prices!.first
                                                    : selectedVariation.prices![
                                                        controller
                                                            .selectedIndexKey];
                                                Get.back();
                                                controller.addToCart(
                                                  0,
                                                  data.treatmentId,
                                                  selectedVariation.variationId,
                                                  selectedPrice
                                                      .treatmentvariationpriceid,
                                                  // ✅ treatment_price_id
                                                  controller.selectedQtyPrice ??
                                                      0.0, // ✅ treatment_price
                                                  controller
                                                          .selectedtype?['qty']
                                                          .toString()
                                                          .replaceAll(
                                                              ".0", "") ??
                                                      0,
                                                );
                                              },
                                              onBack: () {},
                                              treatmentVarLists:
                                                  controller.variationList,
                                            ),
                                            isDismissible: false,
                                            isScrollControlled: true,
                                          )
                                        : Get.bottomSheet(
                                            TreatmentQuantityBottomSheet(
                                              treatmentVarLists:
                                                  controller.variationList,
                                              // pass all or default variation
                                              addToCart: () {
                                                final selectedVariation = data!
                                                        .variations![
                                                    controller.selectedIndex];
                                                final selectedPrice = controller
                                                            .selectedIndexKey ==
                                                        null
                                                    ? selectedVariation
                                                        .prices!.first
                                                    : selectedVariation.prices![
                                                        controller
                                                            .selectedIndexKey];
                                                Get.back();
                                                controller.addToCart(
                                                  0,
                                                  data.treatmentId,
                                                  selectedVariation.variationId,
                                                  selectedPrice
                                                      .treatmentvariationpriceid,
                                                  //treatment_price_id
                                                  controller.selectedQtyPrice
                                                          ?.toDouble() ??
                                                      0.0, //treatment_price
                                                  controller
                                                          .selectedtype?['qty']
                                                          .toString()
                                                          .replaceAll(
                                                              ".0", "") ??
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
                                        horizontal: 12.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor()
                                              .blackColor
                                              .withOpacity(.3)),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GetBuilder<TreatmentDetailsController>(
                                          builder: (controller) {
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.selectedtype?['qty'].toString().replaceAll(".0", "")} ${controller.selectedtype?['unit_type']}",
                                                  style: AppTypography
                                                      .galanoGrostesqueSemiBold
                                                      .copyWith(
                                                    fontSize: 15.sp,
                                                    color: AppColor()
                                                        .blackColor
                                                        .withOpacity(0.65),
                                                    height: 1.5.h,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        Container(
                                          height: 30.w,
                                          width: 30.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColor.dynamicColor,
                                          ),
                                          child: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: AppColor().whiteColor,
                                            size: 15.h,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              controller.membershipName.toString() == ""
                                  ? SizedBox.shrink()
                                  : Padding(
                                      padding: EdgeInsets.all(10.h),
                                      child: Container(
                                        padding: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColor.dynamicColor
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Transform.scale(
                                              scale:
                                                  Get.width > 600 ? 1.6 : 1.2,
                                              // 📱 normal phones → 1.2, tablets → 1.6
                                              child: Checkbox(
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
                                                onChanged: (value) {
                                                  controller.isTreatmentCheck =
                                                      value ?? false;
                                                  print(
                                                      "yes : ${controller.isTreatmentCheck}");
                                                  controller.update();
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.h,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                    textAlign: TextAlign.start,
                                                    text: TextSpan(
                                                      style: AppTypography
                                                          .galanoGrostesqueSemiBold
                                                          .copyWith(
                                                              color: AppColor()
                                                                  .blackColor
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontSize: 17.sp,
                                                              height: 1.1),
                                                      children: [
                                                        TextSpan(
                                                          text: AppStrings
                                                              .becomeA,
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "${AppStrings.member} ${controller.membershipName}",
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    "${AppStrings.addToCartNowToSave} \$${controller.discountamount.toString()} "
                                                    "${AppStrings.onThisTreatmentToday}",
                                                    style: AppTypography
                                                        .hostGroteskRegular
                                                        .copyWith(
                                                            fontSize: 13.sp,
                                                            color: AppColor()
                                                                .blackColor
                                                                .withOpacity(
                                                                    0.5)),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  InkWell(
                                                    onTap: () {
                                                      // show more info
                                                      Get.toNamed(
                                                        RouteManager
                                                            .membersShipDetailsPage,
                                                        arguments: controller
                                                            .membershipId,
                                                        parameters: {
                                                          "onlyShow": "0",
                                                        },
                                                      );
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        horizontal: 10.w,
                                                        vertical: 6.h,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: AppColor
                                                            .dynamicColor
                                                            .withOpacity(.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.r),
                                                      ),
                                                      child: Text(
                                                        "View More Info",
                                                        style: AppTypography
                                                            .hostGroteskSemiBold
                                                            .copyWith(
                                                          fontSize: 12.sp,
                                                          color: AppColor
                                                              .dynamicColor,
                                                        ),
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

                              if (controller.treatmentDetailsModel.treatment
                                          ?.treatmentConcerns !=
                                      null &&
                                  controller.treatmentDetailsModel.treatment!
                                      .treatmentConcerns!.isNotEmpty)
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.all(10.h),
                                  padding: EdgeInsets.all(10.h),
                                  decoration: BoxDecoration(
                                    color:
                                        AppColor.dynamicColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            AppStrings.helpsWithTheseConcerns,
                                            style: AppTypography
                                                .galanoGrostesqueSemiBold
                                                .copyWith(
                                              color: AppColor()
                                                  .blackColor
                                                  .withOpacity(0.65),
                                              fontSize: 15.sp,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
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
                                            .map(
                                              (concern) => Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 6.h,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColor.dynamicColor
                                                      .withOpacity(.1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r),
                                                ),
                                                child: Text(
                                                  concern,
                                                  style: AppTypography
                                                      .hostGroteskRegular
                                                      .copyWith(
                                                          fontSize: 12.sp,
                                                          color: AppColor
                                                              .dynamicColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              //SizedBox(height: 10.h),
                              SafeArea(
                                bottom: true,
                                child: GetBuilder<TreatmentDetailsController>(
                                  builder: (treatmentController) {
                                    final data = treatmentController
                                        .treatmentDetailsModel.treatment;

                                    // If loading or data is null or treatment variants are empty, hide the button
                                    if (treatmentController.isLoading ||
                                        data == null ||
                                        data.variations == null ||
                                        data.variations!.isEmpty) {
                                      return const SizedBox.shrink();
                                    }

                                    return SizedBox(
                                      width: 252.w,
                                      child: ElevatedButton(
                                        onPressed: data.variations!.length ==
                                                    1 ||
                                                controller.selectedQtyLabel !=
                                                    null
                                            ? () {
                                                print(treatmentController
                                                    .selectedIndex);
                                                final selectedVariation = data
                                                        .variations![
                                                    controller.selectedIndex];
                                                print(controller
                                                    .selectedIndexKey);
                                                final selectedPrice = controller
                                                                .selectedIndexKey ==
                                                            '0-0' ||
                                                        controller
                                                                .selectedIndexKey
                                                                .toString() ==
                                                            "null"
                                                    ? selectedVariation
                                                        .prices!.first
                                                    : selectedVariation.prices![
                                                        controller
                                                            .selectedIndexKey];
                                                print(
                                                    "selctqty: ${selectedPrice.qty}");
                                                controller.addToCart(
                                                  0,
                                                  data.treatmentId,
                                                  selectedVariation.variationId,
                                                  selectedPrice
                                                      .treatmentvariationpriceid,
                                                  // ✅ treatment_price_id
                                                  controller.selectedQtyPrice ??
                                                      0.0,
                                                  // ✅ treatment_price
                                                  controller
                                                          .selectedtype?['qty']
                                                          .toString() ??
                                                      0,
                                                );
                                              }
                                            : () async {
                                                print(5);
                                                controller.isAddingCart = true;
                                                controller
                                                    .update(); // show loader
                                                await Future.delayed(
                                                    Duration.zero);
                                                controller.isAddingCart = false;
                                                controller
                                                    .update(); // hide loader
                                                await Get.bottomSheet(
                                                  VariationSelectorBottomSheet(
                                                    onSelect:
                                                        (selectedVariation) async {
                                                      // Then show pricing bottom sheet
                                                      Get.back();
                                                      await Get.bottomSheet(
                                                        TreatmentQuantityBottomSheet(
                                                          treatmentVarLists: [
                                                            selectedVariation
                                                          ],
                                                          addToCart: () {
                                                            final selectedVariation =
                                                                data.variations![
                                                                    controller
                                                                        .selectedIndex];
                                                            final selectedPrice = controller
                                                                            .selectedIndexKey ==
                                                                        '0-0' ||
                                                                    controller.selectedIndexKey
                                                                            .toString() ==
                                                                        "null"
                                                                ? selectedVariation
                                                                    .prices!
                                                                    .first
                                                                : selectedVariation
                                                                        .prices![
                                                                    int.parse(
                                                                    controller
                                                                        .selectedIndexKey
                                                                        .toString(),
                                                                  )];
                                                            // Your cart logic here
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
                                                              controller
                                                                      .selectedQtyPrice
                                                                      .toDouble() ??
                                                                  0.0,
                                                              // ✅ treatment_price
                                                              controller
                                                                      .selectedtype?[
                                                                          'qty']
                                                                      .toString() ??
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
                                                    controller: controller,
                                                  ),
                                                  isScrollControlled: true,
                                                );
                                              },
                                        style: ElevatedButton.styleFrom(
                                          elevation: 14,
                                          shadowColor: AppColor.dynamicColor
                                              .withOpacity(0.6),
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0.r),
                                          ),
                                          backgroundColor:
                                              AppColor.dynamicColor,
                                        ),
                                        child: Container(
                                          height: 45.h,
                                          width: double.infinity,
                                          alignment: Alignment.center,
                                          child: treatmentController
                                                  .isAddingCart
                                              ? CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          AppColor()
                                                              .whiteColor),
                                                )
                                              : Text(
                                                  AppStrings.addToCart,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTypography
                                                      .hostGroteskSemiBold
                                                      .copyWith(
                                                    color:
                                                        AppColor().whiteColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              )
                            ],
                          ),
                        ),
              Positioned(
                top: 0.h,
                right: 0,
                left: 0,
                child: CommonAppBar(
                  title: "Treatment",
                  titleColor: AppColor().blackColor,
                ),
              )
            ],
          );
        },
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
