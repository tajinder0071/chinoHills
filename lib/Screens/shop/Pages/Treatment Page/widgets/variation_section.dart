import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/app_strings.dart';
import '../../../../../CSS/color.dart';
import '../../../../../Model/treatment_details_model.dart';
import '../../../../../util/common_page.dart';
import '../controller/treatment_details_controller.dart';

class VariationSelectorBottomSheet extends StatelessWidget {
  final TreatmentDetailsController controller;
  final Function(Variation selectedVariation) onSelect;

  const VariationSelectorBottomSheet({
    super.key,
    required this.onSelect,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    if (controller.selectedQtyLabel == null) [controller.selectedIndex = -1];
    return Container(
      height: Get.height * 0.6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear)),
                Text(
                  AppStrings.selectAVariation,
                  style:
                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: controller.variationList.length,
              itemBuilder: (ctx, index) {
                final variation = controller.variationList[index];
                final isActive = controller.selectedIndex == index;

                return ListTile(
                  leading: Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                      Border.all(color: AppColor.dynamicColor, width: 2),
                      color: isActive ? AppColor.dynamicColor : Colors.white,
                    ),
                    child: isActive
                        ? Icon(Icons.circle, size: 8.w, color: Colors.white)
                        : null,
                  ),
                  title: Text(
                    variation.variationName ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      // semi-bold to highlight title
                      color: AppColor().blackColor,
                    ),
                  ),
                  subtitle: Text(
                    "${AppStrings.from}\$${formatCurrency(variation.prices![0].price)} | "
                        "\$${formatCurrency(variation.prices![0].membershipInfo!.membershipOfferPrice)} ${AppStrings.member}"
                        '',
                    style: GoogleFonts.roboto(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor().blackColor.withOpacity(0.6),
                    ),
                  ),
                  onTap: () {
                    controller.selectedIndex = index;
                    if (variation.prices != null &&
                        variation.prices!.isNotEmpty) {
                      controller.selectedIndexKey = 0;

                      var firstPrice = variation.prices![0];

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        controller.updateValidQuantity(
                          qtyLabel: variation.variationName ?? "",
                          price: (firstPrice.price ?? 0).toDouble(),
                          membershipPrice: (firstPrice
                              .membershipInfo?.membershipOfferPrice ??
                              0)
                              .toDouble(),
                          unitType: controller
                              .treatmentDetailsModel.treatment?.unitType ??
                              "",
                          qty: firstPrice.qty.toString().replaceAll(".0", ""),
                        );
                      });
                    }
                    // Update quantity & pricing
                    if (variation.prices != null &&
                        variation.prices!.isNotEmpty) {
                      final firstPrice = variation.prices!.first;
                      controller.selectedQtyLabel = firstPrice.qty ?? '';
                      controller.selectedQtyPrice = firstPrice.price ?? 0;
                      controller.selectedtype = {
                        "qty": firstPrice.qty ?? "",
                        "unit_type": controller
                            .treatmentDetailsModel.treatment?.unitType ??
                            "",
                      };

                      if (firstPrice.membershipInfo != null) {
                        controller.memberShipPrice =
                            firstPrice.membershipInfo!.membershipOfferPrice;
                        controller.discountPrice =
                            firstPrice.membershipInfo!.discountedPrice;
                        controller.membershipName =
                            firstPrice.membershipInfo!.membershipName;
                        controller.membershipId =
                            firstPrice.membershipInfo!.membershipId;
                      } else {
                        controller.memberShipPrice = 0;
                      }
                    }

                    onSelect(variation);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
