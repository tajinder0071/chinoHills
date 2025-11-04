import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/util/common_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/common_Widgets/no_record.dart';
import 'package:chino_hills/Screens/shop/Pages/Package%20Page/Widgets/package_bottom_sheet.dart';
import 'package:chino_hills/Screens/shop/Pages/Package%20Page/controller/package_cotroller.dart';
import 'package:chino_hills/util/route_manager.dart';
import '../../../../../CSS/appTypography.dart';
import '../../../../../CSS/app_strings.dart';
import '../../../../../common_Widgets/common_app_bar.dart';
import '../../../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../../../loading/become_a_member_loading.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        init: Get.find<PackageController>()..fetchDetailsPackages(),
        builder: (packageController) {
          var data = packageController.packageDetailsModel.package;
          return Stack(
            children: [
              packageController.isLoading
                  ? MemberLoadDetail()
                  : data == null
                      ? Center(
                          child: NoRecord(
                            "No Package Details Found",
                            Icon(Icons.no_accounts),
                            "We're sorry. no package details available at this moment.",
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Column(children: [
                                SizedBox(
                                    height: MediaQuery.sizeOf(context).height,
                                    child: Stack(
                                      children: [
                                        /// Scrollable image slider
                                        Positioned.fill(
                                          child: PageView.builder(
                                            controller: packageController
                                                .pageController,
                                            itemCount: (packageController
                                                        .packageDetailsModel
                                                        .package
                                                        ?.images
                                                        ?.isNotEmpty ??
                                                    false)
                                                ? packageController
                                                    .packageDetailsModel
                                                    .package!
                                                    .images!
                                                    .length
                                                : 1,
                                            onPageChanged: (index) =>
                                                packageController
                                                    .currentPage.value = index,
                                            itemBuilder: (context, index) {
                                              return Image.network(
                                                (packageController
                                                            .packageDetailsModel
                                                            .package
                                                            ?.images
                                                            ?.isNotEmpty ??
                                                        false)
                                                    ? packageController
                                                        .packageDetailsModel
                                                        .package!
                                                        .images![index]
                                                    : "",
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                },
                                                errorBuilder: (context, error,
                                                    stackTrace) {
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
                                          top: 100.h,
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
                                                  width: Get.width * 0.5,
                                                  child: Text(
                                                    data.packageName
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
                                                      fontSize: 26.sp,
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
                                                      fontSize: 15.sp,
                                                      color:
                                                          AppColor().whiteColor,
                                                      height: 1.5,
                                                    ),
                                                    children: [
                                                      buildPriceTextSpan(
                                                        isPackage: false,
                                                        originalPrice:
                                                            packageController
                                                                .price,
                                                        memberPrice: packageController
                                                                    .memprice
                                                                    .toString() !=
                                                                ''
                                                            ? packageController
                                                                .memprice
                                                            : data
                                                                .membershipInfo!
                                                                .discountedPrice,
                                                        unit: "",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),
                                                data.membershipInfo
                                                            ?.discountAmount ==
                                                        0
                                                    ? RichText(
                                                        textAlign:
                                                            TextAlign.start,
                                                        text: TextSpan(
                                                          style: AppTypography
                                                              .hostGroteskSemiBold
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
                                                                text: formatCurrency(data
                                                                    .membershipInfo
                                                                    ?.discountAmount),
                                                                style: AppTypography
                                                                    .galanoGrostesqueSemiBold
                                                                    .copyWith(
                                                                        fontSize: 14
                                                                            .sp,
                                                                        color: AppColor()
                                                                            .whiteColor)),
                                                            TextSpan(
                                                                text:
                                                                    " with a ${data.membershipInfo?.membershipName} membership",
                                                                style: AppTypography
                                                                    .hostGroteskSemiBold
                                                                    .copyWith(
                                                                  fontSize:
                                                                      14.sp,
                                                                  color: AppColor()
                                                                      .whiteColor,
                                                                ))
                                                          ],
                                                        ),
                                                      )
                                                    : SizedBox.shrink()
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
                                                  margin: EdgeInsets.all(10.r),
                                                  // padding: EdgeInsets.all(10.r),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColor.dynamicColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0.r)),
                                                  child: ListTile(
                                                    title: Text(
                                                      "Save ${data.offeroffText.toString()} on this item when you apply '${data.offerName.toString()}' Towards Any Service ' in cart!",
                                                      style: AppTypography
                                                          .hostGroteskSemiBold
                                                          .copyWith(
                                                        fontSize: 14.sp,
                                                        color: AppColor()
                                                            .whiteColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    leading: Icon(
                                                      Icons
                                                          .local_offer_outlined,
                                                      color:
                                                          AppColor().whiteColor,
                                                    ),
                                                  ),
                                                ),
                                        ),

                                        /// AppBar row
                                      ],
                                    )),
                                SizedBox(height: 10.h),
                              ]),
                              Container(
                                padding: EdgeInsets.all(16.0.w),
                                color: AppColor().whiteColor,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "SELECT A PACKAGE",
                                      style: AppTypography
                                          .galanoGrostesqueSemiBold
                                          .copyWith(
                                              fontSize: 20.sp,
                                              color: AppColor.dynamicColor),
                                    ),
                                    SizedBox(height: 20.h),
                                    InkWell(
                                      onTap: () async {
                                        await Get.bottomSheet(
                                            PackageBottomSheet(
                                              onApply: () {
                                                packageController.addToCart(
                                                    true,
                                                    memberShipPrice: packageController
                                                                    .memprice
                                                                    .toString() !=
                                                                '' ||
                                                            packageController
                                                                    .memprice
                                                                    .toString() !=
                                                                '0'
                                                        ? packageController
                                                            .memprice
                                                        : data.membershipInfo!
                                                            .membershipPrice,
                                                    membershipId: data
                                                        .membershipInfo!
                                                        .membershipId);
                                              },
                                              treatmentList: packageController
                                                  .packageDetailsModel.package!,
                                            ),
                                            isDismissible: false,
                                            isScrollControlled: true);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 14.h),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor()
                                                  .blackColor
                                                  .withOpacity(.2)),
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${packageController.quantity} package",
                                                style: GoogleFonts.sarabun(
                                                    fontSize: 15.sp,
                                                    color: AppColor()
                                                        .blackColor
                                                        .withOpacity(0.65),
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                    data.membershipInfo?.membershipName ==
                                                null ||
                                            data.membershipInfo
                                                    ?.membershipName ==
                                                ""
                                        ? SizedBox.shrink()
                                        : SizedBox(height: 20.h),
                                    data.membershipInfo?.membershipName ==
                                                null ||
                                            data.membershipInfo
                                                    ?.membershipName ==
                                                ""
                                        ? SizedBox.shrink()
                                        : SizedBox(
                                            height: 10,
                                          ),
                                    (data.membershipInfo?.membershipName ==
                                                null ||
                                            data.membershipInfo
                                                    ?.membershipName ==
                                                "")
                                        ? SizedBox.shrink()
                                        : Container(
                                            padding: EdgeInsets.all(12.w),
                                            decoration: BoxDecoration(
                                              color: AppColor.dynamicColor
                                                  .withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GetBuilder<
                                                            PackageController>(
                                                        builder: (c) {
                                                      return Transform.scale(
                                                        scale: 1.2,
                                                        child: Checkbox(
                                                            materialTapTargetSize:
                                                                MaterialTapTargetSize
                                                                    .padded,
                                                            checkColor:
                                                                AppColor()
                                                                    .whiteColor,
                                                            side: BorderSide(
                                                                color: packageController.isMemberChecked
                                                                    ? AppColor()
                                                                        .whiteColor
                                                                    : AppColor()
                                                                        .greyColor,
                                                                width: packageController
                                                                        .isMemberChecked
                                                                    ? 5.0
                                                                    : 1.0,
                                                                style:
                                                                    BorderStyle
                                                                        .solid,
                                                                strokeAlign:
                                                                    BorderSide
                                                                        .strokeAlignOutside),
                                                            fillColor: packageController
                                                                    .isMemberChecked
                                                                ? WidgetStatePropertyAll(
                                                                    AppColor
                                                                        .dynamicColor)
                                                                : WidgetStatePropertyAll(
                                                                    AppColor()
                                                                        .whiteColor),
                                                            value: c
                                                                .isMemberChecked,
                                                            onChanged: (value) {
                                                              c.isMemberChecked =
                                                                  value ??
                                                                      false;
                                                              print(
                                                                  "yes :${c.isMemberChecked}");
                                                              c.update();
                                                            }),
                                                      );
                                                    }),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            "Become a ",
                                                            style: AppTypography
                                                                .galanoGrostesqueSemiBold
                                                                .copyWith(
                                                                    color: AppColor()
                                                                        .blackColor
                                                                        .withOpacity(
                                                                            0.65),
                                                                    fontSize:
                                                                        20.sp,
                                                                    height:
                                                                        1.1),
                                                          ),
                                                          Expanded(
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          6.w,
                                                                      vertical:
                                                                          2.h),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColor
                                                                    .dynamicColor
                                                                    .withOpacity(
                                                                        0.1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4.r),
                                                              ),
                                                              child: Text(
                                                                "${data.membershipInfo?.membershipName} Member",
                                                                style: AppTypography
                                                                    .hostGroteskSemiBold
                                                                    .copyWith(
                                                                  fontSize:
                                                                      14.sp,
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
                                                SizedBox(height: 10.h),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  "Add to cart now to save ${formatCurrency(data.membershipInfo?.discountAmount)} on this package today, plus monthly benefits",
                                                  style: AppTypography
                                                      .hostGroteskRegular
                                                      .copyWith(
                                                          fontSize: 14.sp,
                                                          color: AppColor()
                                                              .blackColor
                                                              .withOpacity(
                                                                  0.65)),
                                                ),
                                                SizedBox(height: 20.h),
                                                InkWell(
                                                  onTap: () => Get.toNamed(
                                                      RouteManager
                                                          .membersShipDetailsPage,
                                                      arguments: data.membershipInfo!.membershipId ?? 0,
                                                      parameters: {
                                                        "onlyShow": "1"
                                                      }),
                                                  child: Center(
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
                                                                    .dynamicColor),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                    data.membershipInfo?.membershipName ==
                                                null ||
                                            data.membershipInfo
                                                    ?.membershipName ==
                                                ""
                                        ? SizedBox.shrink()
                                        : SizedBox(height: 10.h),
                                    (data.membershipInfo!.membershipName ==
                                                null ||
                                            data.membershipInfo!
                                                    .membershipName ==
                                                "")
                                        ? SizedBox.shrink()
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12.h,
                                                horizontal: 6.0.w),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: AppColor.dynamicColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5.0.r)),
                                            child: Column(
                                              children: [
                                                Text.rich(
                                                    textAlign: TextAlign.center,
                                                    TextSpan(
                                                        style: AppTypography
                                                            .hostGroteskSemiBold
                                                            .copyWith(
                                                                fontSize: 15.sp,
                                                                color: AppColor()
                                                                    .greyColor
                                                                    .withOpacity(
                                                                        .65),
                                                                height: 1.2),
                                                        children: [
                                                          TextSpan(
                                                            text: "Save ",
                                                          ),
                                                          TextSpan(
                                                              text: formatCurrency(data
                                                                  .membershipInfo
                                                                  ?.discountAmount),
                                                              style: AppTypography
                                                                  .galanoGrostesqueSemiBold
                                                                  .copyWith(
                                                                fontSize: 15.sp,
                                                                color: AppColor()
                                                                    .blackColor
                                                                    .withOpacity(
                                                                        .5),
                                                              )),
                                                          TextSpan(
                                                            text:
                                                                " with a ${data.membershipInfo?.membershipName} membership",
                                                          )
                                                        ])),
                                                SizedBox(height: 20.h),
                                                InkWell(
                                                  onTap: () => Get.toNamed(
                                                      RouteManager
                                                          .membersShipDetailsPage,
                                                      arguments: data.membershipInfo?.membershipId ?? 0,
                                                      parameters: {
                                                        "onlyShow": "1"
                                                      }),
                                                  child: Center(
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
                                                        style:
                                                            GoogleFonts.sarabun(
                                                                fontSize: 12.sp,
                                                                color: AppColor
                                                                    .dynamicColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            "Convenience fee applied at checkout",
                                            style: GoogleFonts.sarabun(
                                                fontSize: 12.sp,
                                                color: AppColor().greyColor)),
                                        IconButton(
                                          padding: EdgeInsets.zero,
                                          splashColor: AppColor().transparent,
                                          highlightColor:
                                              AppColor().transparent,
                                          onPressed: () {
                                            Get.dialog(
                                              Dialog(
                                                backgroundColor:
                                                    Color(0xFF082026),
                                                shape: RoundedRectangleBorder(),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                      Text(
                                                        "A small convenience fee supports platform maintenance, "
                                                        "secure payment processing, customer service, and ongoing "
                                                        "improvements to enhance your experience.",
                                                        style:
                                                            GoogleFonts.sarabun(
                                                                fontSize: 14.sp,
                                                                color: AppColor()
                                                                    .whiteColor),
                                                      ),
                                                      SizedBox(
                                                        height: 5.h,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.info_outline,
                                              size: 16.sp,
                                              color: AppColor().greyColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 5.h),
                                    (data.concerns != null &&
                                            data.concerns!.isNotEmpty)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "HELPS WITH THESE CONCERNS",
                                                style: GoogleFonts.sarabun(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.dynamicColor,
                                                ),
                                              ),
                                              SizedBox(height: 10.h),
                                              Wrap(
                                                spacing: 8.w,
                                                runSpacing: 8.h,
                                                children: data.concerns!
                                                    .map(
                                                      (concern) => Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    12.w,
                                                                vertical: 6.h),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColor
                                                              .dynamicColor
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.r),
                                                        ),
                                                        child: Text(
                                                          concern ?? "",
                                                          style: GoogleFonts
                                                              .sarabun(
                                                            color: AppColor
                                                                .dynamicColor,
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30.0.h),
                              Text(
                                "WHAT IS INCLUDED?",
                                style: GoogleFonts.sarabun(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.dynamicColor,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: packageController.packageDetailsModel
                                    .package!.includedTreatments!.length,
                                itemBuilder: (context, index) {
                                  final treatment = packageController
                                      .packageDetailsModel
                                      .package!
                                      .includedTreatments![index];
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        top: 4.h, left: 20.w, right: 20.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "- ",
                                              style: GoogleFonts.sarabun(
                                                  fontSize: 30.sp),
                                            ),
                                            Expanded(
                                              child: Text(
                                                treatment.treatmentName ?? "",
                                                style: treatment.description ==
                                                        ""
                                                    ? GoogleFonts.sarabun(
                                                        fontSize: 16.sp)
                                                    : GoogleFonts.sarabun(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ),
                                            treatment.description!.isEmpty
                                                ? SizedBox.shrink()
                                                : IconButton(
                                                    onPressed: () {
                                                      packageController
                                                          .onClick();
                                                    },
                                                    icon: packageController
                                                                .isclick ==
                                                            false
                                                        ? Icon(Icons
                                                            .keyboard_arrow_down)
                                                        : Icon(Icons
                                                            .keyboard_arrow_up))
                                          ],
                                        ),
                                        packageController.isclick == false
                                            ? SizedBox.shrink()
                                            : Text(
                                                treatment.description
                                                    .toString(),
                                                style: GoogleFonts.sarabun(
                                                    fontSize: 15.sp),
                                              )
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10.0.h),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.0.w, vertical: 6.0.h),
                                child: Text(
                                  "Important Terms and Conditions: All financing subject to credit approval. APRs depend on creditworthiness, term length, and other factors. “As low as” does not guarantee your rate or payment options as this is dependent on your creditworthiness. Check with your provider about additional amounts required for procedure that may be ineligible for financing. Scheduled payments in example based on the full 24-month term. Length of financing is up to you and/or your creditworthiness.",
                                  style: GoogleFonts.sarabun(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor().black80),
                                ),
                              ),
                              //TODO ?? Here we define treatment on click...
                              CommonTermsConditionWidget(
                                isneed: false,
                              ),
                              SafeArea(
                                bottom: true,
                                child: GetBuilder<PackageController>(
                                  builder: (packageController) {
                                    return packageController.isLoading
                                        ? SizedBox.shrink()
                                        : packageController.packageDetailsModel
                                                    .package ==
                                                null
                                            ? SizedBox.shrink()
                                            : SafeArea(
                                                child: SizedBox(
                                                  width: 252.w,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      onPressed:
                                                          packageController
                                                                  .isAddingCart
                                                              ? null
                                                              : () async {
                                                                  packageController
                                                                          .isAddingCart =
                                                                      true;
                                                                  packageController
                                                                      .update(); // show loader
                                                                  await Future
                                                                      .delayed(
                                                                          Duration
                                                                              .zero); // wait 1 second
                                                                  packageController
                                                                          .isAddingCart =
                                                                      false;
                                                                  packageController
                                                                      .update(); // hide loader

                                                                  packageController.addToCart(
                                                                      false,
                                                                      memberShipPrice: packageController.memprice.toString() != '' ||
                                                                              packageController.memprice.toString() ==
                                                                                  '0'
                                                                          ? packageController
                                                                              .memprice
                                                                          : packageController.packageDetailsModel.package!.membershipInfo ==
                                                                                  null
                                                                              ? ""
                                                                              : packageController
                                                                                  .packageDetailsModel.package!.membershipInfo!.membershipPrice,
                                                                      membershipId: packageController.packageDetailsModel.package!.membershipInfo ==
                                                                              null
                                                                          ? ""
                                                                          : packageController
                                                                              .packageDetailsModel
                                                                              .package!
                                                                              .membershipInfo!
                                                                              .membershipId);
                                                                },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 14,
                                                        shadowColor: AppColor
                                                            .dynamicColor
                                                            .withOpacity(0.6),
                                                        padding:
                                                            EdgeInsets.zero,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0.r),
                                                        ),
                                                        backgroundColor: AppColor
                                                            .dynamicColor, // background to support elevation
                                                      ),
                                                      child: Container(
                                                        height: 50.h,
                                                        width: double.infinity,
                                                        alignment:
                                                            Alignment.center,
                                                        child: packageController
                                                                .isAddingCart
                                                            ? CircularProgressIndicator(
                                                                strokeWidth: 2,
                                                                valueColor: AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    AppColor()
                                                                        .whiteColor),
                                                              )
                                                            : Text(
                                                                AppStrings
                                                                    .addToCart,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    GoogleFonts
                                                                        .sarabun(
                                                                  color: AppColor()
                                                                      .whiteColor,
                                                                  fontSize:
                                                                      16.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                              SizedBox(
                                height: 40.h,
                              )
                            ],
                          ),
                        ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CommonAppBar(
                    title: "Package",
                    titleColor: AppColor().blackColor,
                  )),
            ],
          );
        });
  }
}
