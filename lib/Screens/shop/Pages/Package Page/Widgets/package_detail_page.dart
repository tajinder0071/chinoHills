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
        title: Text(sectionName!,
            style: GoogleFonts.sarabun(fontWeight: FontWeight.w700)),
        centerTitle: false,
      ),
      body: DetailBody(),
      bottomNavigationBar:
      GetBuilder<PackageController>(builder: (packageController) {
        return packageController.isLoading
            ? SizedBox.shrink()
            : packageController.packageDetailsModel.package == null
            ? SizedBox.shrink()
            : SafeArea(
          child: SizedBox(
            height: 60.h,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: controller.isAddingCart
                    ? null
                    : () {
                  controller.addToCart(false,
                      memberShipPrice: packageController
                          .memprice
                          .toString() !=
                          '' ||
                          packageController.memprice
                              .toString() ==
                              '0'
                          ? packageController.memprice
                          : packageController
                          .packageDetailsModel
                          .package!
                          .membershipInfo ==
                          null
                          ? ""
                          : packageController
                          .packageDetailsModel
                          .package!
                          .membershipInfo!
                          .membershipPrice,
                      membershipId: packageController
                          .packageDetailsModel
                          .package!
                          .membershipInfo ==
                          null
                          ? ""
                          : packageController
                          .packageDetailsModel
                          .package!
                          .membershipInfo!
                          .membershipId);
                },
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
          ),
        );
      }),
    );
  }
}
