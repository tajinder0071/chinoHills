import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/treartment_bottom_sheet.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/treatment_quantity_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../loading/become_a_member_loading.dart';
import '../../../../../util/common_page.dart';
import '../../../../../util/route_manager.dart';
import '../controller/treatment_details_controller.dart';
import 'image_page_view.dart';

class TreatmentDetailsPage extends GetView<TreatmentDetailsController> {
  const TreatmentDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(isLeading: true, title: "Treatement", action: []),
      body: GetBuilder<TreatmentDetailsController>(
        init: Get.find<TreatmentDetailsController>()..fetchDetailsTreatment(),
        builder: (newController) {
          var data = newController.treatmentDetailsModel.data;
          return Stack(
            children: [
              newController.isLoading
                  ? MemberLoadDetail()
                  : newController.treatmentDetailsModel.data == null
                  ? Center(
                      child: NoRecord(
                        "No Treatment Details Found",
                        Icon(Icons.no_accounts),
                        "We're sorry. no treatment details available at this moment.",
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          Text(
                            data!.treatmentName.toString(),
                            style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.w900,
                              fontSize: 22.sp,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10.h),

                          RichText(
                            text: buildPriceTextSpan(
                              originalPrice:
                                  (data.treatmentvarient != null &&
                                      data.treatmentvarient!.isNotEmpty)
                                  ? data
                                        .treatmentvarient![controller
                                                    .selectedIndex !=
                                                -1
                                            ? controller.selectedIndex
                                            : 0]
                                        .treatmentVariationPrice
                                  : data.price ?? 0,
                              // fallback price
                              memberPrice:
                                  (data.treatmentvarient != null &&
                                      data.treatmentvarient!.isNotEmpty)
                                  ? data
                                        .treatmentvarient![controller
                                                    .selectedIndex !=
                                                -1
                                            ? controller.selectedIndex
                                            : 0]
                                        .membershipDiscountAmount
                                  : data.discountAmount ?? 0,
                              // memberPrice: data.membershipDiscountAmount,
                              unit: data.unitType,
                            ),
                          ),

                          // Todo ?? Save Section

                          /*if (data.membershipData == null ||
                          data.membershipData?.membershipTitle == null ||
                          data.discountAmount == null)
                        SizedBox.shrink()
                      else
                        Container(
                          margin: EdgeInsets.all(10.r),
                          padding: EdgeInsets.all(10.r),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.dynamicColor.withOpacity(0.1),
                            borderRadius:
                            BorderRadius.circular(5.0.r),
                          ),
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
                                          .discountAmount),
                                      style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          color: Colors.black54,
                                          fontWeight:
                                          FontWeight.bold)),
                                  TextSpan(
                                      text:
                                      " with a ${data.membershipData
                                          ?.membershipTitle} membership",
                                      style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          color: Colors.grey.shade700,
                                          fontWeight:
                                          FontWeight.w400)),
                                ]),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Get.toNamed(
                                        RouteManager
                                            .membersShipDetailsPage,
                                        arguments: data.membershipData
                                            ?.membershipId ??
                                            0,
                                        parameters: {"onlyShow": "1"}),
                                child: Text(
                                  "View more info".toUpperCase(),
                                  style: GoogleFonts.roboto(
                                      color: AppColor.dynamicColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                          //  Todo ? Save 2 section
                          /*data.discountAmount == null
                          ? SizedBox(height: 20.h)
                          : Container(
                        margin: EdgeInsets.all(10.r),
                        // padding: EdgeInsets.all(10.r),
                        decoration: BoxDecoration(
                            color: AppColor.dynamicColor,
                            borderRadius:
                            BorderRadius.circular(5.0.r)),
                        child: ListTile(
                          title: Text(
                              "Save \$${data.discountAmount
                                  .toString()} off on this item when you apply '\$25 Towards Any Service ' in cart!",
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
                      ),
*/

                          // ? Todo ?  PageView.. for multiple images...
                          TrearmentImagePageView(data: data),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15.0.w,
                              vertical: 6.0.h,
                            ),
                            child: Text(
                              data.treatmentDescription.toString(),
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87,
                              ),
                            ),
                          ),
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
                                    await Get.bottomSheet(
                                      TreatmentBottomSheet(
                                        onApply: () {
                                          Get.back();
                                          Get.bottomSheet(
                                            TreatmentQuantityBottomSheet(
                                              treatmentVarLists:
                                                  data.treatmentvarient!,
                                              addToCart: () async {
                                                controller.addToCart(
                                                  0,
                                                  controller
                                                      .treatmentDetailsModel
                                                      .data!
                                                      .id,
                                                  controller.selectedIndex != -1
                                                      ? data
                                                            .treatmentvarient![controller
                                                                .selectedIndex]
                                                            .treatmentVariationId
                                                      : 0,
                                                );
                                              },
                                              onBack: () {
                                                Get.back();
                                              },
                                              // treatmentVarLists: data.treatmentvarient!,
                                              treatmentList: [
                                                data
                                                    .treatmentvarient![controller
                                                                .selectedIndex !=
                                                            -1
                                                        ? controller
                                                              .selectedIndex
                                                        : 0]
                                                    .treatmentVariationPrice,
                                              ],
                                            ),
                                          );
                                        },
                                        treatmentList: data.treatmentvarient!,
                                      ),
                                      isDismissible: false,
                                      isScrollControlled: true,
                                    );
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
                                        Expanded(
                                          child: Text(
                                            "${controller.selectedIndex != -1 && data.treatmentvarient!.isNotEmpty ? data.treatmentvarient![controller.selectedIndex].treatmentVariationName : controller.treatmentName}",
                                            style: GoogleFonts.merriweather(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                        Icon(Icons.keyboard_arrow_down),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                RichText(
                                  text: buildPriceTextSpan(
                                    originalPrice:
                                        (data.treatmentvarient != null &&
                                            data.treatmentvarient!.isNotEmpty)
                                        ? data
                                              .treatmentvarient![controller
                                                          .selectedIndex !=
                                                      -1
                                                  ? controller.selectedIndex
                                                  : 0]
                                              .treatmentVariationPrice
                                        : data.price ?? 0, // fallback price
                                    memberPrice:
                                        (data.treatmentvarient != null &&
                                            data.treatmentvarient!.isNotEmpty)
                                        ? data
                                              .treatmentvarient![controller
                                                          .selectedIndex !=
                                                      -1
                                                  ? controller.selectedIndex
                                                  : 0]
                                              .membershipDiscountAmount
                                        : data.discountAmount ?? 0,
                                    unit: data.unitType,
                                  ),
                                ),
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
                                Column(
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
                                    SizedBox(height: 15.h),
                                    Wrap(
                                      spacing: 10.w,
                                      children: data.concern!
                                          .map(
                                            (concern) => Container(
                                              margin: EdgeInsets.only(
                                                bottom: 8.0.h,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10.w,
                                                vertical: 10.h,
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColor.dynamicColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              child: Text(
                                                concern.concernName.toString(),
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
                                ),
                                (newController
                                            .treatmentDetailsModel
                                            .data
                                            ?.treatmentInstructionData
                                            ?.data
                                            ?.isEmpty ??
                                        true)
                                    ? const SizedBox.shrink()
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
                                              "What to expect".toUpperCase(),
                                              style: GoogleFonts.merriweather(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.dynamicColor,
                                              ),
                                            ),
                                            // Card-style box
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                13.0,
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                padding: const EdgeInsets.all(
                                                  16.0,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  newController
                                                      .treatmentDetailsModel
                                                      .data!
                                                      .treatmentInstructionData!
                                                      .data!
                                                      .expand(
                                                        (innerList) =>
                                                            innerList,
                                                      )
                                                      .map((item) => "• $item")
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
                            ),
                          ),
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
                    ),
            ],
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: GetBuilder<TreatmentDetailsController>(
          builder: (treatmentController) {
            final data = treatmentController.treatmentDetailsModel.data;

            // If loading or data is null or treatment variants are empty, hide the button
            if (treatmentController.isLoading ||
                data == null ||
                data.treatmentvarient == null ||
                data.treatmentvarient!.isEmpty) {
              return const SizedBox.shrink();
            }

            return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: treatmentController.selectedIndex != -1
                      ? () {
                          controller.addToCart(
                            0,
                            data.id,
                            data
                                .treatmentvarient![controller.selectedIndex]
                                .treatmentVariationId,
                          );
                        }
                      : () async {
                          await Get.bottomSheet(
                            TreatmentBottomSheet(
                              onApply: () {
                                Get.back();
                                Get.bottomSheet(
                                  TreatmentQuantityBottomSheet(
                                    treatmentVarLists: data.treatmentvarient!,
                                    addToCart: controller.isAddingCart
                                        ? () {}
                                        : () async {
                                            controller.addToCart(
                                              0,
                                              data.id,
                                              controller.selectedIndex != -1
                                                  ? data
                                                        .treatmentvarient![controller
                                                            .selectedIndex]
                                                        .treatmentVariationId
                                                  : 0,
                                            );
                                          },
                                    onBack: () => Get.back(),
                                    treatmentList: [
                                      data
                                          .treatmentvarient![controller
                                                      .selectedIndex !=
                                                  -1
                                              ? controller.selectedIndex
                                              : 0]
                                          .treatmentVariationPrice,
                                    ],
                                  ),
                                );
                              },
                              treatmentList: data.treatmentvarient!,
                            ),
                            isDismissible: false,
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
                      gradient: LinearGradient(
                        colors: [
                          AppColor.dynamicColor,
                          AppColor.dynamicColor.withAlpha(430),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      height: 50.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: treatmentController.isAddingCart
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            )
                          : Text(
                              "Add to cart",
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
