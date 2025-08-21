import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../controller/package_cotroller.dart';
import 'detai_body.dart';

class PackageDetailPage extends GetView<PackageController> {
  final String? sectionName;

  var controller = Get.put(PackageController());

  PackageDetailPage({super.key, this.sectionName});

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: AppBar(
        backgroundColor: AppColor().background,
        scrolledUnderElevation: 0.0,
        title: Text(
          sectionName!,
          style: GoogleFonts.sarabun(fontWeight: FontWeight.w700),
        ),
        centerTitle: false,
      ),
      body: DetaiBody(),
      bottomNavigationBar: GetBuilder<PackageController>(
        builder: (packageController) {
          return packageController.isLoading
              ? SizedBox.shrink()
              : packageController.packageDetailsModel.data?[0] == null
              ? SizedBox.shrink()
              : SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 10.h,
                      left: 10.w,
                      right: 10.w,
                    ),
                    height: 45.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isAddingCart
                          ? null
                          : () => controller.addToCart(false),
                      style: ElevatedButton.styleFrom(
                        elevation: 0, // for shadow effect
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0.r),
                        ),
                        backgroundColor: AppColor
                            .dynamicColor, // background to support elevation
                      ),
                      child: controller.isAddingCart
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
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
                );
        },
      ),
    );
  }
}
