import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../util/common_page.dart';
import '../controller/package_cotroller.dart';

class PackageBottomSheet extends StatelessWidget {
  final VoidCallback onApply;
  final List treatmentList;

  const PackageBottomSheet({
    super.key,
    required this.onApply,
    required this.treatmentList,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PackageController>();

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
            child: GetBuilder<PackageController>(
              builder: (ctn) {
                return ListView.builder(
                  itemCount: treatmentList.length,
                  itemBuilder: (ctx, index) {
                    var treatmentData = treatmentList[index];
                    // bool isSelected = controller.selectedIndex == index;

                    return _buildServiceOption(
                      "${treatmentData.qty.toInt()} package",
                      treatmentData.pricing,
                      true,
                      () {
                        // controller.selectTreatment(index);
                      },
                    );
                  },
                );
              },
            ),
          ),
          SizedBox(height: 20.h),
          //! Bottom Button
          GetBuilder<PackageController>(
            builder: (co) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(10.h),
                  child: InkWell(
                    onTap: onApply,
                    overlayColor: WidgetStatePropertyAll(
                      AppColor().transparent,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        gradient: AppColor.dynamicButtonColor,
                      ),
                      child: ElevatedButton(
                        onPressed: onApply,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          disabledBackgroundColor: Colors.transparent,
                          overlayColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: co.isAddingCart
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColor().whiteColor,
                                ),
                              )
                            : Text(
                                "Add To Cart",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColor().whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _buildServiceOption(
  String title,
  var originalPrice,
  bool isSelected,
  VoidCallback onTap,
) {
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
        title: Text(
          "$title",
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: EdgeInsets.only(top: 4.0.h),
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.merriweather(
                fontSize: 12.sp,
                color: Colors.grey,
              ),
              children: [
                TextSpan(text: ""),
                TextSpan(
                  text: formatCurrency(originalPrice),
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    color: Colors.black54,
                  ),
                ),
                /* TextSpan(
                  text: "  |  ${formatCurrency(memberPrice)} Member",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),*/
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
