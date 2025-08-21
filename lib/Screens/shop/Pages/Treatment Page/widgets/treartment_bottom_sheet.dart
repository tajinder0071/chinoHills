import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../common_Widgets/no_record.dart';
import '../../../../../util/common_page.dart';
import '../controller/treatment_details_controller.dart';

class TreatmentBottomSheet extends StatelessWidget {
  final VoidCallback onApply;
  final List treatmentList;

  const TreatmentBottomSheet({
    super.key,
    required this.onApply,
    required this.treatmentList,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TreatmentDetailsController>();

    return Container(
      height: Get.height * 0.89,
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
                  onPressed: () => Get.back(result: controller.selectedIndex),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "SELECT YOUR SERVICE".toUpperCase(),
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

          if (treatmentList.isEmpty)
            Expanded(
              child: Center(
                  child: NoRecord(
                      "No Service Found ", Icon(Icons.search_off), "")),
            )
          else
            Expanded(
              child: GetBuilder<TreatmentDetailsController>(
                builder: (ctn) {
                  return ListView.builder(
                    itemCount: treatmentList.length,
                    itemBuilder: (ctx, index) {
                      var treatmentData = treatmentList[index];
                      var isSelected = controller.selectedIndex == index;
                      return _buildServiceOption(
                          treatmentData.treatmentVariationName,
                          treatmentData.treatmentVariationPrice,
                          treatmentData.membershipDiscountAmount,
                          isSelected, () {
                        controller.selectTreatment(index);
                        controller.isSelectedAny =
                            controller.selectedIndex != -1 ? true : false;
                        Get.log("The Print :${controller.isSelectedAny}");
                        controller.update();
                      }, 10.0);
                    },
                  );
                },
              ),
            ),
          SizedBox(height: 20.h),
          Spacer(),
          //! Bottom Button
          SafeArea(
            child: GetBuilder<TreatmentDetailsController>(builder: (ctn) {
              return Padding(
                padding: EdgeInsets.all(10.h),
                child: InkWell(
                  onTap: ctn.isSelectedAny ? onApply : null,
                  overlayColor: WidgetStatePropertyAll(AppColor().transparent),
                  child: Container(
                    width: double.infinity,
                    height: 45.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: ctn.isSelectedAny
                          ? AppColor.dynamicColor
                          : Colors.grey.shade300,
                    ),
                    child: ElevatedButton(
                      onPressed: ctn.isSelectedAny ? onApply : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        disabledBackgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColor().whiteColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

Widget _buildServiceOption(String title, var originalPrice, var memberPrice,
    bool isSelected, VoidCallback onTap, var discount) {
  return Column(
    children: [
      ListTile(
        leading: Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColor.dynamicColor, width: 2),
            color: isSelected ? AppColor.dynamicColor : Colors.white,
          ),
          child: isSelected
              ? Icon(Icons.circle, size: 8.w, color: Colors.white)
              : null,
        ),
        title: Row(
          children: [
            // Discount Badge
           /* Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColor.dynamicColor,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: Text(
                "$discount OFF",
                style: GoogleFonts.merriweather(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),*/
            SizedBox(width: 8.w),
            // Title
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.merriweather(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: RichText(
            text: TextSpan(
              style:
                  GoogleFonts.merriweather(fontSize: 12.sp, color: Colors.grey),
              children: [
                TextSpan(
                  text: "From ",
                ),
                TextSpan(
                  text: formatCurrency(originalPrice),
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.grey,
                  ),
                ),
                // TextSpan(
                //   text: "  |  ${formatCurrency(memberPrice)} Member",
                //   style: TextStyle(
                //       color: Colors.black, fontWeight: FontWeight.bold),
                // ),
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
