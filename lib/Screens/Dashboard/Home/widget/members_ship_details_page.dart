import 'package:chino_hills/common_Widgets/common_button_widget.dart';
import 'package:chino_hills/common_Widgets/no_record.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/Model/member_ship_details_model.dart';
import '../../../../CSS/color.dart';
import '../../../../CSS/image_page.dart';
import '../../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/controller/shop_controller.dart';
import '../controller/membership_detail_controller.dart';

class MembersShipDetailsPage extends StatelessWidget {
  MembersShipDetailsPage({super.key, required this.onlyShow});

  final bool onlyShow;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipDetailController>(
      init: Get.find<MembershipDetailController>()..fetchMemberShipDetails(),
      builder: (controller) {
        var data = controller.memberDetailsModel.membership;
        return Scaffold(
          backgroundColor: AppColor().background,
          appBar: commonAppBar(
            isLeading: true,
            title: "Memberships",
            action: [],
          ),
          body: controller.isMemberLoading
              ? TreatementLoadDetail()
              : controller.memberDetailsModel.membership == null
              ? NoRecord(
                  "Membership",
                  Icon(Icons.search),
                  "Membership not available",
                )
              : ListView(
                  children: [
                    _buildMembershipImage(context, data),
                    _buildMembershipInfo(data),
                    SizedBox(height: 10.h),
                    _buildBenefitsSection(data),
                    onlyShow ? _buildOnlyShowSection(data!) : SizedBox.shrink(),
                  ],
                ),
          bottomNavigationBar: controller.isMemberLoading
              ? SizedBox.shrink()
              : controller.memberDetailsModel.membership == null
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
                                ShopController.shop.goToTabByName("membership");
                                Get.offAllNamed(
                                  RouteManager.dashBoardPage,
                                  arguments: 2,
                                );
                              },
                              child: Text(
                                "Shop all membership",
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
                          data!.isActive
                              ? SizedBox.shrink()
                              : CommonButtonWidget(
                                  onTap: newController.isAddingCart
                                      ? () {}
                                      : () {
                                          newController.addToCart(
                                            context,
                                            controller
                                                .memberDetailsModel
                                                .membership!
                                                .membershipPricing,
                                            controller
                                                .memberDetailsModel
                                                .membership!
                                                .membershipTitle,
                                          );
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

  Widget _buildMembershipImage(BuildContext context, Membership? data) {
    return Image.network(
      height: isTablet(context) ? 300.h : 250.h,
      width: double.infinity,
      (data!.membershipImage ?? ""),
      fit: BoxFit.contain,
      loadingBuilder:
          (BuildContext ctx, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return SizedBox(
              height: 200.h,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.dynamicColor,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              ),
            );
          },
      errorBuilder: (context, url, error) {
        return Container(
          height: 200.h,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: AppColor.geryBackGroundColor),
          child: Center(
            child: Image.asset(
              AppImages.noAvailableImage,
              color: Colors.black,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMembershipInfo(dynamic data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10, top: 20, bottom: 20),
        color: Color(0xfffafafa),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data?.membershipTitle ?? "",
              style: GoogleFonts.merriweather(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5.h),
            Text(
              "\$${data?.membershipPricing}/month",
              style: GoogleFonts.roboto(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            data!.offerofftext.toString() == ""
                ? SizedBox.shrink()
                : Container(
                    padding: EdgeInsets.all(10.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColor.dynamicColor,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_offer_outlined, color: Colors.white),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            "Save ${data!.offerofftext.toString()} on your first month of membership when you apply ${data.membershipTitle.toString()} in cart!",
                            style: TextStyle(color: AppColor().whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 10.h),
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
            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsSection(Membership? data) {
    if (data?.benefits == null || data!.benefits!.isEmpty) {
      return SizedBox.shrink();
    }
    return data.benefits!.isEmpty
        ? SizedBox.shrink()
        : Center(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor().whiteColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.benefits!.length,
                    itemBuilder: (context, index) => _buildBulletPoints(
                      data.benefits![index].benefitTitle.toString(),
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
          );
  }

  Widget _buildOnlyShowSection(Membership data) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 3.h),
        color: AppColor().whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0.h),
            Icon(Icons.card_giftcard, color: AppColor.dynamicColor, size: 30),
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
              child: _buildBulletPoints(data.membershipDescription.toString()),
            ),
          ],
        ),
      ),
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
    if (text.isEmpty || text == "[]") return SizedBox();
    text = text.replaceAll('[', '').replaceAll(']', '');
    List<String> points = text.split(',');
    points = points.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map(_buildBulletPoint).toList(),
    );
  }
}
