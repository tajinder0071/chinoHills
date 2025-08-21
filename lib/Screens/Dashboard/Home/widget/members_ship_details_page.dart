import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../CSS/color.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../../../util/local_store_data.dart';
import '../../../../util/route_manager.dart';
import '../controller/membership_detail_controller.dart';

class MembersShipDetailsPage extends StatelessWidget {
  MembersShipDetailsPage({super.key, required this.onlyShow});

  bool onlyShow;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipDetailController>(
      init: Get.find<MembershipDetailController>()..fetchMemberShipDetails(),
      builder: (controller) {
        var data = controller.memberDetailsModel.data;
        return Scaffold(
          backgroundColor: AppColor().background,
          appBar: commonAppBar(
            isLeading: true,
            title: "Memberships",
            action: [],
          ),
          body: controller.isMemberLoading
              ? TreatementLoadDetail()
              : controller.memberDetailsModel.data == null
              ? Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.search_normal),
                        SizedBox(height: 5.0.h),
                        Text(
                          "No Data Found",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView(
                  children: [
                    Image.network(
                      height: isTablet(context) ? 300.h : 250.h,
                      width: double.infinity,
                      CommonPage().image_url + (data?.membershipImage ?? ""),
                      fit: BoxFit.contain,
                      loadingBuilder:
                          (
                            BuildContext ctx,
                            Widget child,
                            ImageChunkEvent? loadingProgress,
                          ) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return SizedBox(
                              height: 200.h,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.dynamicColor,
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                      : null,
                                ),
                              ),
                            );
                          },
                      errorBuilder: (context, url, error) {
                        return Container(
                          height: 200.h,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            color: AppColor.geryBackGroundColor,
                          ),
                          child: Center(
                            child: Center(
                              child: Image.asset(
                                "assets/images/Image_not_available.png",
                                color: Colors.black,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 5.h),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Color(0xfffafafa),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10.h,
                          children: [
                            Text(
                              data?.membershipTitle ?? "",
                              style: GoogleFonts.merriweather(
                                fontSize: 23.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            Text(
                              "\$${data?.membershipPricing}/month",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "${data?.membershipDescription}",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "12 month commitment required",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            //!
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    data!.benefitDescriptions!.isEmpty
                        ? SizedBox.shrink()
                        : Center(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppColor().whiteColor,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10.r),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_border,
                                    color: AppColor.dynamicColor,
                                    size: 30,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "ACCESS MEMBER-ONLY BENEFITS",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      color: AppColor.dynamicColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Sign up today and enjoy exclusive member-only benefits",
                                    style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20.h),
                                  _buildBulletPoints(
                                    data.benefitDescriptions.toString() ?? "",
                                  ),
                                  SizedBox(height: 25.h),
                                ],
                              ),
                            ),
                          ),
                    //Todo : This Section only for display..
                    onlyShow
                        ? Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 3.h),
                              color: AppColor().whiteColor,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 20.0.h),
                                  Icon(
                                    Icons.card_giftcard,
                                    color: AppColor.dynamicColor,
                                    size: 30,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "ENJOY ALL OF THE FOLLOWING\nEVERY MONTH!",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      color: AppColor.dynamicColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "Starting on your 1st day as a member",
                                    style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: _buildBulletPoints(
                                      data.benefitDescriptions.toString() ?? "",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
          bottomNavigationBar: controller.isMemberLoading
              ? SizedBox.shrink()
              : controller.memberDetailsModel.data == null
              ? SizedBox.shrink()
              : onlyShow
              ? SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: Get.height * 0.17,
                      child: Column(
                        children: [
                          CommonButtonWidget(
                            isOutlineButton: false,
                            onTap: () => Get.back(),
                            buttonName: "Back to treatment",
                            margin: 10.0.h,
                            isLoading: false,
                          ),
                          SizedBox(
                            width: Get.width * 0.9,
                            height: 40.h,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColor.dynamicColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                LocalStorage local = LocalStorage();
                                local.saveData("shopIndex", 1);
                                Get.offAllNamed(
                                  RouteManager.dashBoardPage,
                                  arguments: 2,
                                );
                              },
                              child: Text(
                                "Shop all members",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.dynamicColor,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SafeArea(
                  minimum: EdgeInsets.only(bottom: 8.h),
                  child: GetBuilder<MembershipDetailController>(
                    builder: (newController) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonButtonWidget(
                            onTap: newController.isAddingCart
                                ? () {}
                                : () {
                                    newController.addToCart(context,data!.membershipPricing);
                                  },
                            buttonName: "Join now",
                            margin: 10.0.h,
                            isLoading: newController.isAddingCart,
                          ),
                          CommonTermsConditionWidget(),
                        ],
                      );
                    },
                  ),
                ),
        );
      },
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.0.w),
      child: Row(
        children: [
          Text(
            "• ",
            style: TextStyle(fontSize: 20.sp, color: AppColor().blackColor),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoints(String text) {
    // Defensive check: handle null, empty, or "[]" string values
    if (text.isEmpty || text == "[]") return SizedBox();
    // Remove brackets if it's a toString() of a list like "[item1, item2]"
    text = text.replaceAll('[', '').replaceAll(']', '');
    List<String> points = text.split(','); // comma separated
    points = points.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map(_buildBulletPoint).toList(),
    );
  }
}
