import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/controller/treatment_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/app_strings.dart';
import '../../../../../CSS/color.dart';
import '../../../../../Model/treatment_details_model.dart';


class TreatmentQuantityBottomSheet extends StatefulWidget {
  final VoidCallback addToCart, onBack;
  final List<Variation> treatmentVarLists;

  TreatmentQuantityBottomSheet({
    super.key,
    required this.addToCart,
    required this.onBack,
    required this.treatmentVarLists,
  });

  @override
  State<TreatmentQuantityBottomSheet> createState() =>
      _TreatmentQuantityBottomSheetState();
}

class _TreatmentQuantityBottomSheetState
    extends State<TreatmentQuantityBottomSheet> {
  final TreatmentDetailsController ctn = Get.find<TreatmentDetailsController>();

  @override
  void initState() {
    super.initState();
    print(ctn.treatmentDetailsModel.treatment!.variations!.length == 1);
    if (ctn.treatmentDetailsModel.treatment!.variations!.length == 1 &&
        ctn.selectedIndex == 0) {
      if (ctn.treatmentDetailsModel.treatment!.variations![ctn.selectedIndex]
          .prices !=
          null &&
          ctn.treatmentDetailsModel.treatment!.variations![ctn.selectedIndex]
              .prices!.isNotEmpty) {
        ctn.selectedIndexKey = 0;

        var firstPrice = ctn.treatmentDetailsModel.treatment!
            .variations![ctn.selectedIndex].prices![0];

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ctn.updateValidQuantity(
            qtyLabel: ctn.treatmentDetailsModel.treatment!
                .variations![ctn.selectedIndex].variationName ??
                "",
            price: (firstPrice.price ?? 0).toDouble(),
            membershipPrice:
            (firstPrice.membershipInfo?.membershipOfferPrice ?? 0)
                .toDouble(),
            unitType: ctn.treatmentDetailsModel.treatment?.unitType ?? "",
            qty: firstPrice.qty.toString().replaceAll(".0", ""),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.59,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      AppStrings.selectYourQuantity.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40.w),
              ],
            ),
          ),

          // Variations list
          ctn.treatmentDetailsModel.treatment!.variations![ctn.selectedIndex]
              .prices!.isEmpty
              ? Center(child: Text(AppStrings.noVariationsAvailable))
              : Expanded(
            child: GetBuilder<TreatmentDetailsController>(
              builder: (_) {
                final prices = ctn.treatmentDetailsModel.treatment!
                    .variations![ctn.selectedIndex].prices ??
                    [];
                return ListView.builder(
                  itemCount: prices.length,
                  itemBuilder: (ctx, pIndex) {
                    var priceData = prices[pIndex];
                    // String key = "${ctn.selectedIndex}-$pIndex";
                    var key = pIndex;
                    var qty = priceData.qty.toString().replaceAll(".0", "");
                    var price = (priceData.price ?? 0).toDouble();
                    var memPrice = (priceData.membershipInfo?.membershipOfferPrice ?? 0).toDouble();
                    print(ctn.selectedIndex);
                    var unitType =
                        ctn.treatmentDetailsModel.treatment?.unitType;

                    return _buildServiceOption(
                      variationName: unitType,
                      price: price,
                      qty: qty,
                      isActive: ctn.selectedIndexKey == key,
                      onTap: () {
                        ctn.selectedIndexKey = int.parse(key.toString());
                        ctn.update();

                        ctn.updateSelectedQuantity(
                          price: price,
                          membershipPrice: memPrice,
                          unitType: ctn.treatmentDetailsModel.treatment
                              ?.unitType ??
                              "",
                          qty: qty,
                        );
                      },
                      memPrice: memPrice,
                    );
                  },
                );
              },
            ),
          ),

          SizedBox(height: 20.h),

          // Bottom Buttons
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              height: 45.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dynamicColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: GetBuilder<TreatmentDetailsController>(
                  builder: (logic) {
                    return logic.isAddingCart
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor().whiteColor),
                    )
                        : Text(
                      AppStrings.addToCart,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColor().whiteColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceOption({
    var variationName,
    var price,
    var qty,
    var isActive,
    VoidCallback? onTap,
    var memPrice,
  }) {
    return ListTile(
      leading: Container(
        width: 24.w,
        height: 24.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColor.dynamicColor, width: 2),
          color: isActive ? AppColor.dynamicColor : Colors.white,
        ),
        child: isActive
            ? Icon(Icons.circle, size: 8.w, color: Colors.white)
            : null,
      ),
      title: Text(
        "$qty $variationName",
        style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 4.0.h),
        child: Row(
          children: [
            Text(
              "\$${price.toStringAsFixed(2)}",
              // 👈 Added $ and fixed to 2 decimals
              style: GoogleFonts.merriweather(
                fontSize: 13.sp,
                color: Colors.black54,
              ),
            ),
            memPrice == 0
                ? SizedBox.shrink()
                : Container(
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              height: 12.h,
              width: 1.w,
              color: Colors.grey,
            ),
            memPrice == 0
                ? SizedBox.shrink()
                : Text(
              "\$${memPrice.toStringAsFixed(2)} ${AppStrings.member}", // 👈 Added $
              style: GoogleFonts.merriweather(
                fontSize: 13.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

