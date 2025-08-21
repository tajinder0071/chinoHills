import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../Model/treatment_details_model.dart';
import '../../../../../util/common_page.dart';
import '../controller/treatment_details_controller.dart';

class TreatmentQuantityBottomSheet extends StatefulWidget {
  final VoidCallback addToCart, onBack;
  final List treatmentList;
  List<Treatmentvarient> treatmentVarLists;

  TreatmentQuantityBottomSheet({
    super.key,
    required this.addToCart,
    required this.onBack,
    required this.treatmentList,
    required this.treatmentVarLists,
  });

  @override
  State<TreatmentQuantityBottomSheet> createState() =>
      _TreatmentQuantityBottomSheetState();
}

class _TreatmentQuantityBottomSheetState
    extends State<TreatmentQuantityBottomSheet> {
  int isSelected = 0;

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
          //! Header with title & close button
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
                      "SELECT YOUR QUANTITY".toUpperCase(),
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
          Divider(),
          Expanded(
              child: GetBuilder<TreatmentDetailsController>(builder: (ctn) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (ctx, index) {
                var treatmentData = widget.treatmentVarLists[index];

                return _buildServiceOption(
                  "",
                  treatmentData,
                  2204.00,
                  isSelected == index,
                  () {
                    isSelected = index;
                    setState(() {});
                    // controller.selectTreatment(index);
                  },
                );
              },
            );
          })),
          SizedBox(height: 20.h),
          //! Bottom Button
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: widget.onBack,
                      overlayColor:
                          WidgetStatePropertyAll(AppColor().transparent),
                      child: Container(
                        width: double.infinity,
                        height: 45.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                                color: AppColor.dynamicColor, width: 1.0)
                            ),
                        child: ElevatedButton(
                          onPressed: widget.onBack,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                            overlayColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Text(
                            "Back",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.dynamicColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: InkWell(
                      onTap: widget.addToCart,
                      overlayColor:
                          WidgetStatePropertyAll(AppColor().transparent),
                      child: Container(
                        width: double.infinity,
                        height: 45.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: LinearGradient(colors: [
                            AppColor.dynamicColor,
                            AppColor.dynamicColor.withAlpha(400)
                          ]),
                        ),
                        child: ElevatedButton(
                          onPressed: widget.addToCart,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                            overlayColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: GetBuilder<TreatmentDetailsController>(
                              builder: (logic) {
                            return logic.isAddingCart
                                ? CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor().whiteColor,
                                  ))
                                : Text(
                                    "Add To Cart",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColor().whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceOption(String title, Treatmentvarient originalPrice,
      var memberPrice, index, VoidCallback onTap) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 24.w,
            height: 24.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.dynamicColor, width: 2),
              color: index ? AppColor.dynamicColor : Colors.white,
            ),
            child: index
                ? Icon(Icons.circle, size: 8.w, color: Colors.white)
                : null,
          ),
          title: Text(
            "${originalPrice.treatmentVariationqty} treatment",
            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.0.h),
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.merriweather(
                    fontSize: 12.sp, color: Colors.grey),
                children: [
                  TextSpan(
                    text: formatCurrency(
                        originalPrice.treatmentVariationPrice.toString()),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: onTap,
        ),
        Divider(indent: 15.w, endIndent: 10.0.w),
      ],
    );
  }
}
