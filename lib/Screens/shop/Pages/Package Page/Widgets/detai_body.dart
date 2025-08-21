import 'package:chino_hills/Screens/shop/Pages/Package%20Page/Widgets/package_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../loading/become_a_member_loading.dart';
import '../../../../../util/common_page.dart';
import '../controller/package_cotroller.dart';
import 'details_page_view.dart';

class DetaiBody extends StatelessWidget {
  const DetaiBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
      init: Get.find<PackageController>()..fetchDetailsPackages(),
      builder: (packageController) {
        var data = packageController.packageDetailsModel.data?[0];
        return packageController.isLoading
            ? MemberLoadDetail()
            : packageController.packageDetailsModel.data?[0] == null
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
                    SizedBox(height: 30.h),
                    Text(
                      data!.packageName.toString(),
                      style: GoogleFonts.merriweather(
                        fontWeight: FontWeight.w900,
                        fontSize: 22.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.h),
                    RichText(
                      text: buildPriceTextSpan(
                        originalPrice: data.pricing, // fallback price
                        memberPrice: data.membershipDiscountAmount,
                        unit: "",
                      ),
                    ),
                    // TODO?? Use it letter...
                    /*(data.membershipData?.membership == null ||
                                  data.membershipData?.membership == "")
                              ? SizedBox.shrink()
                              : Container(
                                  //9513940252
                                  margin: EdgeInsets.all(10.r),
                                  padding: EdgeInsets.all(10.r),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColor.dynamicColor
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius.circular(5.0.r)),
                                  child: Column(
                                    children: [
                                      Text.rich(
                                          textAlign: TextAlign.center,
                                          TextSpan(children: [
                                            TextSpan(
                                                text: "Save ",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16.sp,
                                                    color: Colors.grey.shade700,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            TextSpan(
                                                text: formatCurrency(data
                                                    .membershipData
                                                    ?.membershipPrice),
                                                // " \$${data.membershipDiscountAmount} ",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16.sp,
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text:
                                                    " with a ${data.membershipData?.membership} membership",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 16.sp,
                                                    color: Colors.grey.shade700,
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ])),
                                      TextButton(
                                          onPressed: () {
                                            Get.toNamed(
                                                RouteManager
                                                    .membersShipDetailsPage,
                                                arguments: data.membershipData
                                                        ?.memberId ??
                                                    0,
                                                parameters: {"onlyShow": "1"});
                                          },
                                          style: ButtonStyle(),
                                          child: Text(
                                            "View more info".toUpperCase(),
                                            style: GoogleFonts.roboto(
                                                color: AppColor.dynamicColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp),
                                          ))
                                    ],
                                  ),
                                ),
                          data.membershipDiscountAmount == null
                              ? SizedBox.shrink()
                              : Container(
                                  margin: EdgeInsets.all(10.r),
                                  // padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                      color: AppColor.dynamicColor,
                                      borderRadius:
                                          BorderRadius.circular(5.0.r)),
                                  child: ListTile(
                                    title: Text(
                                        "Save \$${data.membershipDiscountAmount.toString()} off on this item when you apply '\$${data.membershipDiscountAmount.toString()} Towards Any Service ' in cart!",
                                        style: GoogleFonts.roboto(
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start),
                                    leading: Icon(
                                      Icons.local_offer,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),*/
                    DetailsPageView(data: data),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0.w,
                        vertical: 6.0.h,
                      ),
                      child: Text(
                        data.description.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.all(16.0.w),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "SELECT A TREATMENT",
                            style: GoogleFonts.merriweather(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.dynamicColor,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          InkWell(
                            onTap: () async {
                              int? selectedIndex = await Get.bottomSheet(
                                PackageBottomSheet(
                                  onApply: () {
                                    packageController.addToCart(true);
                                  },
                                  treatmentList: packageController
                                      .packageDetailsModel
                                      .data!,
                                ),
                                isDismissible: false,
                                isScrollControlled: true,
                              );

                              Get.log("The comming value : $selectedIndex");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${data.qty.toInt()} package",
                                    style: GoogleFonts.merriweather(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_down),
                                ],
                              ),
                            ),
                          ),

                          //? Show the Prices...
                          SizedBox(height: 20.h),
                          RichText(
                            text: buildPriceTextSpan(
                              originalPrice: data.pricing, // fallback price
                              memberPrice: data.membershipDiscountAmount,
                              unit: "",
                            ),
                          ),
                          /*    SizedBox(height: 20.h),
                                (data.membershipData?.membership == null ||
                                        data.membershipData?.membership == "")
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
                                                GetBuilder<PackageController>(
                                                    builder: (c) {
                                                  return Transform.scale(
                                                    scale: 1.2,
                                                    child: Checkbox(
                                                        materialTapTargetSize:
                                                            MaterialTapTargetSize
                                                                .padded,
                                                        checkColor: AppColor()
                                                            .whiteColor,
                                                        side: BorderSide(
                                                            color: packageController
                                                                    .isMemberChecked
                                                                ? AppColor()
                                                                    .whiteColor
                                                                : AppColor()
                                                                    .greyColor,
                                                            width: packageController
                                                                    .isMemberChecked
                                                                ? 5.0
                                                                : 1.0,
                                                            style: BorderStyle
                                                                .solid,
                                                            strokeAlign: BorderSide
                                                                .strokeAlignOutside),
                                                        fillColor: packageController
                                                                .isMemberChecked
                                                            ? WidgetStatePropertyAll(
                                                                AppColor
                                                                    .dynamicColor)
                                                            : WidgetStatePropertyAll(
                                                                AppColor()
                                                                    .whiteColor),
                                                        value:
                                                            c.isMemberChecked,
                                                        onChanged: (value) {
                                                          c.isMemberChecked =
                                                              value ?? false;
                                                          print(
                                                              "yes :${c.isMemberChecked}");
                                                          c.update();
                                                        }),
                                                  );
                                                }),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      Text("Become a ",
                                                          style: GoogleFonts
                                                              .roboto(
                                                                  fontSize:
                                                                      14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
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
                                                            "${data.membershipData?.membership} Member",
                                                            style: GoogleFonts
                                                                .roboto(
                                                              fontSize: 12.sp,
                                                              color: AppColor
                                                                  .dynamicColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              textAlign: TextAlign.center,
                                              "Add to cart now to save ${formatCurrency(data.membershipData?.membershipPrice)} on this package today, plus monthly benefits",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 4.h),
                                            Center(
                                              child: Text(
                                                  "\$${data.membershipData?.membershipPrice}/month membership fee applies",
                                                  style: GoogleFonts.roboto(
                                                      fontSize: 12.sp,
                                                      color: Colors.grey)),
                                            ),
                                            Center(
                                              child: TextButton(
                                                  onPressed: () => Get.toNamed(
                                                      RouteManager
                                                          .membersShipDetailsPage,
                                                      arguments: data.membershipData?.memberId ?? 0,
                                                      parameters: {"onlyShow": "1"}),
                                                  style: ButtonStyle(),
                                                  child: Text(
                                                    "View more info"
                                                        .toUpperCase(),
                                                    style: GoogleFonts.roboto(
                                                        color: AppColor
                                                            .dynamicColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14.sp),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                SizedBox(height: 10.h),
                                (data.membershipData?.membership == null ||
                                        data.membershipData?.membership == "")
                                    ? SizedBox.shrink()
                                    : Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.h, horizontal: 6.0.w),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: AppColor.dynamicColor
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(5.0.r)),
                                        child: Column(
                                          children: [
                                            Text.rich(
                                                textAlign: TextAlign.center,
                                                TextSpan(children: [
                                                  TextSpan(
                                                      text: "Save ",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 13.sp,
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                  TextSpan(
                                                      text: formatCurrency(data
                                                          .membershipData
                                                          ?.membershipPrice),
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 14.sp,
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text:
                                                          " with a ${data.membershipData?.membership} membership",
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 13.sp,
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontWeight:
                                                              FontWeight.w400))
                                                ])),
                                            TextButton(
                                                onPressed: () => Get.toNamed(
                                                    RouteManager
                                                        .membersShipDetailsPage,
                                                    arguments: data
                                                            .membershipData
                                                            ?.memberId ??
                                                        0,
                                                    parameters: {"onlyShow": "1"}),
                                                style: ButtonStyle(),
                                                child: Text(
                                                  "View more info"
                                                      .toUpperCase(),
                                                  style: GoogleFonts.roboto(
                                                      color:
                                                          AppColor.dynamicColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14.sp),
                                                ))
                                          ],
                                        ),
                                      ),*/
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Convenience fee applied at checkout",
                                style: GoogleFonts.merriweather(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.info_outline,
                                size: 16.sp,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10.h),
                          (data.concern != null && data.concern!.isNotEmpty)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "HELPS WITH THESE CONCERNS",
                                      style: GoogleFonts.merriweather(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.dynamicColor,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    Wrap(
                                      spacing: 8.w,
                                      runSpacing: 8.h,
                                      children: data.concern!
                                          .map(
                                            (concern) => Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 12.w,
                                                vertical: 6.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColor.dynamicColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Text(
                                                concern.concernName ?? "",
                                                style: GoogleFonts.poppins(
                                                  color: AppColor.dynamicColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                )
                              : SizedBox.shrink(),
                          (data.addedTreatment != null &&
                                  data.addedTreatment!.isNotEmpty)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    (data.concern != null &&
                                            data.concern!.isNotEmpty)
                                        ? SizedBox(height: 30.h)
                                        : SizedBox(height: 0.h),
                                    Text(
                                      "WHAT IS INCLUDED?",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.merriweather(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.dynamicColor,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: data.addedTreatment!
                                          .map(
                                            (item) => Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 4.h,
                                                horizontal: 10.0.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "•",
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      color:
                                                          AppColor.dynamicColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Expanded(
                                                    child: Text(
                                                      item,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 13.sp,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                    data.fetchPackageInstructions!.data!.isEmpty
                                        ? SizedBox.shrink()
                                        : SizedBox(height: 20.h),
                                    data.fetchPackageInstructions!.data!.isEmpty
                                        ? SizedBox.shrink()
                                        : Container(
                                            width: double.infinity,
                                            color: Colors.grey.shade200,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                              horizontal: 8.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Section Title
                                                Text(
                                                  "What to expect"
                                                      .toUpperCase(),
                                                  style:
                                                      GoogleFonts.merriweather(
                                                        fontSize: 16.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColor
                                                            .dynamicColor,
                                                      ),
                                                ),
                                                // Card-style box
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                    4.0,
                                                  ),
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.all(
                                                          16.0,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      (data
                                                                  .fetchPackageInstructions!
                                                                  .data ??
                                                              [])
                                                          .expand(
                                                            (row) => row
                                                                .whereType<
                                                                  String
                                                                >(),
                                                          )
                                                          .map(
                                                            (item) => "• $item",
                                                          )
                                                          .join('\n'),
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ],
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0.h),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.0.w,
                        vertical: 6.0.h,
                      ),
                      child: Text(
                        "Important Terms and Conditions: All financing subject to credit approval. APRs depend on creditworthiness, term length, and other factors. “As low as” does not guarantee your rate or payment options as this is dependent on your creditworthiness. Check with your provider about additional amounts required for procedure that may be ineligible for financing. Scheduled payments in example based on the full 24-month term. Length of financing is up to you and/or your creditworthiness.",
                        style: GoogleFonts.roboto(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    //TODO ?? Here we define treatment on click...
                    CommonTermsConditionWidget(),
                  ],
                ),
              );
      },
    );
  }
}
