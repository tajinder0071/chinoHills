import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../Model/member_ship_details_model.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../../common_Widgets/common_terms_condition_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/controller/shop_controller.dart';
import '../controller/membership_detail_controller.dart';

class MembersShipDetailsPage extends StatelessWidget {
  const MembersShipDetailsPage({super.key, required this.onlyShow});

  final bool onlyShow;

  bool hasValidTreatment(IncludedTreatment includedTreatments) {
    return (includedTreatments.treatmentItems ?? []).any((item) =>
    item.treatmentName != null && item.treatmentName!.trim().isNotEmpty);
  }

  bool hasValidSignUpBonus(SignupBonus signUpBonus) {
    return (signUpBonus.signupBonusTreatments ?? []).any((item) =>
    item.treatmentName != null && item.treatmentName!.trim().isNotEmpty);
  }

  bool hasValidMilestoneBonus(MembershipMilestoneBonuses milestoneBonus) {
    return (milestoneBonus.milestoneTreatmentItems ?? []).any((item) =>
    item.treatmentName != null && item.treatmentName!.trim().isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipDetailController>(
      init: Get.find<MembershipDetailController>()
        ..fetchMemberShipDetails(),
      builder: (controller) {
        var data = controller.memberDetailsModel.membership;
        return Scaffold(
          backgroundColor: AppColor().background,
          appBar:
          commonAppBar(isLeading: true, title: "Memberships", action: []),
          body: controller.isMemberLoading
              ? TreatementLoadDetail()
              : controller.memberDetailsModel.membership == null
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
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )
              : ListView(
            children: [
              _buildMembershipImage(context, data),
              _buildMembershipInfo(context, data!),
              _buildBenefitsSection(data),
              data.includedTreatments!.isEmpty
                  ? SizedBox.shrink()
                  : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.includedTreatments!.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final treatment =
                  data.includedTreatments![index];
                  return Column(
                    children: [
                      (data.includedTreatments!.isEmpty ||
                          !hasValidTreatment(treatment) || data.benefits == null || data.benefits!.isEmpty || data.benefits!.every((benefit)=>(benefit.benefitTitle ?? "").trim().isEmpty))
                          ? SizedBox.shrink()
                          : Divider(
                        thickness: 5.h,
                        color: Colors.grey[100],
                      ),
                      treatmentSection(context, treatment),
                    ],
                  );
                },
              ),
              SizedBox(height: 10.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.membershipMilestoneBonuses!.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: 5.h),
                itemBuilder: (context, index) {
                  final treatment =
                  data.membershipMilestoneBonuses![index];
                  return Column(
                    children: [
                      _milestoneBonusSection(context, data, treatment,
                          title: treatment.headertitle!,
                          desc: treatment.milestonedescription!,
                          buttonText: AppStrings.moreDetails,
                          showIcon: index == 0)
                    ],
                  );
                },
              ),
              onlyShow
                  ? _buildOnlyShowSection(data)
                  : SizedBox.shrink(),
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
                          side: BorderSide(
                              color: AppColor.dynamicColor),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          ShopController.shop
                              .goToTabByName("membership");
                          Get.offAllNamed(
                              RouteManager.dashBoardPage,
                              arguments: 2);
                        },
                        child: Text(
                          "Shop all membership",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: AppColor.dynamicColor,
                              fontSize: 16.sp),
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
                    data?.isActive
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
                                .membershipTitle);
                      },
                      buttonName: AppStrings.joinNow,
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

  Widget treatmentSection(BuildContext context,
      IncludedTreatment includedTreatments) {
    final List<TreatmentItem> treatmentItems =
    (includedTreatments.treatmentItems ?? [])
        .where((item) =>
    (item.treatmentName != null &&
        item.treatmentName!.trim().isNotEmpty))
        .toList();

    return treatmentItems.isEmpty
        ? SizedBox.shrink()
        : Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
            left: 20.w, right: 20.w, top: 20.h, bottom: 0),
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (includedTreatments.choosedOption.toString() == "includeall")
                ? Icon(Icons.card_giftcard_outlined,
                color: AppColor.dynamicColor, size: 30)
                : Icon(Icons.star_border,
                color: AppColor.dynamicColor, size: 30),
            SizedBox(height: 8),
            Text(
              includedTreatments.headertitle!,
              style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: AppColor.dynamicColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Starting on your 1st day as a member",
              style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ...treatmentItems
                .asMap()
                .entries
                .map((entry) {
              int idx = entry.key;
              TreatmentItem treatmentItem = entry.value;

              return Column(children: [
                _buildBulletPoints(
                    treatmentItem.treatmentName ?? 'Treatment'),
                idx < treatmentItems.length - 1
                    ? Divider(color: Colors.grey[200])
                    : SizedBox.shrink(),
              ]);
            }),
            SizedBox(height: 25.h),
          ],
        ),
      ),
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
              "assets/images/Image_not_available.png",
              color: Colors.black,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Widget _buildMembershipInfo(BuildContext context, Membership data) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
      color: Color(0xfffafafa),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data.membershipTitle ?? "",
              style: GoogleFonts.merriweather(
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 5.h),
          Text("\$${data.membershipPricing}/month",
              style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center),
          SizedBox(height: 10.h),
          (data.offeroffText.toString() == null || data.offeroffText.toString() == "")
              ? SizedBox.shrink()
              : Container(
            margin: EdgeInsets.all(10.h),
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              color: AppColor.dynamicColor,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.local_offer_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    "Save ${data.offeroffText.toString()} on your first month of membership when you apply "
                        "'${data.offerName.toString()}' in cart!",
                    style: TextStyle(color: AppColor().whiteColor),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "${data.membershipDescription}",
            style: GoogleFonts.roboto(
                fontSize: 15.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Text(
            "12 month commitment required",
            style: GoogleFonts.roboto(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 25.h,
          ),
          _signUpBonusSection(
            context,
            data,
            showIcon: true,
            title: AppStrings.joinNowSignupBonus,
            desc:
            "${AppStrings.joinNowSignupBonusDesc}${data
                .membershipTitle} member",
            buttonText: "More details",
            //data.signupBonus
          )
        ],
      ),
    );
  }

  Widget _buildBenefitsSection(Membership? data) {
    if (data?.benefits == null || data!.benefits!.isEmpty || data.benefits!.every((benefit)=>(benefit.benefitTitle ?? "").trim().isEmpty)) {
      return SizedBox.shrink();
    }
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 0),
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.star_border, color: AppColor.dynamicColor, size: 30),
            SizedBox(height: 8),
            Text(
              "ACCESS MEMBER-ONLY BENEFITS",
              style: GoogleFonts.poppins(
                  fontSize: 16.sp,
                  color: AppColor.dynamicColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Sign up today and enjoy exclusive member-only benefits",
              style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            data.benefits!.isEmpty
                ? SizedBox.shrink()
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: data.benefits!.length,
              itemBuilder: (context, index) =>
                  _buildBulletPoints(
                      data.benefits![index].benefitTitle.toString()),
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
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Starting on your 1st day as a member",
              style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
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
          Text("• ",
              style: TextStyle(fontSize: 20.sp, color: AppColor().blackColor)),
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

  Widget _signUpBonusSection(context, Membership data,
      {required String title,
        String? desc,
        required String buttonText,
        showDesc = true,
        showIcon = false}) {
    return (data.signupBonus?.signupBonusTreatments == null ||
        data.signupBonus?.signupBonusTreatments?.isEmpty == true)
        ? SizedBox.shrink()
        : Center(
      child: Padding(
        padding: EdgeInsets.only(left: 10.h, right: 10.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.dynamicColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r)),
          child: Padding(
            padding: EdgeInsets.all(15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showIcon
                        ? Icon(
                      Icons.verified_rounded,
                      color: AppColor.dynamicColor,
                      size: isTablet(context) ? 35.h : 25.h,
                    )
                        : SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 10.h),
                commonText(
                    text: title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
                showDesc
                    ? commonText(text: desc ?? "", fontSize: 16.sp)
                    : SizedBox.shrink(),
                SizedBox(height: 10.h),
                InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      showSignupBonusBottomsheet(data);
                    },
                    child: commonText(
                        text: buttonText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.dynamicColor))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _milestoneBonusSection(context, Membership data,
      MembershipMilestoneBonuses milestoneBonus,
      {required String title,
        String? desc,
        required String buttonText,
        showIcon = false}) {
    return data.membershipMilestoneBonuses!.every((bonus) =>
    bonus.milestoneTreatmentItems == null ||
        bonus.milestoneTreatmentItems!.isEmpty)
        ? SizedBox.shrink()
        : Center(
      child: Padding(
        padding: EdgeInsets.only(left: 10.h, right: 10.h),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColor.dynamicColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4.r)),
          child: Padding(
            padding: EdgeInsets.all(15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    showIcon
                        ? Icon(
                      Icons.verified_rounded,
                      color: AppColor.dynamicColor,
                      size: isTablet(context) ? 35.h : 25.h,
                    )
                        : SizedBox.shrink(),
                  ],
                ),
                SizedBox(height: 10.h),
                commonText(
                    text: title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
                desc == null || desc.isEmpty
                    ? SizedBox.shrink()
                    : commonText(text: desc, fontSize: 16.sp),
                SizedBox(height: 10.h),
                InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      showSignupBonusBottomsheet(data,
                          isMilestone: true,
                          milestoneBonus: milestoneBonus);
                    },
                    child: commonText(
                        text: buttonText,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.dynamicColor))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonText({required String text,
    fontSize = 0.0,
    fontWeight = FontWeight.normal,
    color = Colors.black}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
          fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }

  void showSignupBonusBottomsheet(Membership data,
      {bool isMilestone = false, MembershipMilestoneBonuses? milestoneBonus}) {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.95,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close,
                          size: 25.sp, color: AppColor().blackColor)),
                  Text(
                    isMilestone && milestoneBonus != null
                        ? milestoneBonus.headertitle ??
                        AppStrings.signUpBonusCapital
                        : AppStrings.signUpBonusCapital,
                    style: GoogleFonts.poppins(
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  Icon(
                    Icons.close,
                    color: Colors.transparent,
                  )
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: AppColor().lightGrey,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    isMilestone && milestoneBonus != null
                        ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontSize: 16.sp),
                        children: <TextSpan>[
                          // TextSpan(
                          //     text: isMilestone && milestoneBonus != null
                          //         ? milestoneBonus.milestonedescription ??
                          //             ""
                          //         : '${data.signupBonus?.choosedOption}',
                          //     style:
                          //         TextStyle(fontWeight: FontWeight.bold)),
                          // TextSpan(
                          //   text: "${milestoneBonus.milestonedescription} member",
                          // ),
                        ],
                      ),
                    )
                        : RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                            color: Colors.black, fontSize: 16.sp),
                        children: <TextSpan>[
                          TextSpan(
                              text: '${data.signupBonus?.choosedOption}',
                              style:
                              TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text:
                            ' bonus treatments from the below when you sign up as a ${data
                                .membershipTitle} member',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    if (isMilestone && milestoneBonus != null)
                      ...(milestoneBonus.milestoneTreatmentItems ?? [])
                          .asMap()
                          .entries
                          .map((entry) {
                        int idx = entry.key;
                        var milestoneTreatmentItem = entry.value;
                        return Column(
                          children: [
                            _buildBulletPoints(
                                milestoneTreatmentItem.treatmentName ??
                                    'Treatment'),
                            idx <
                                (milestoneBonus.milestoneTreatmentItems
                                    ?.length ??
                                    0) -
                                    1
                                ? Divider(color: Colors.grey[200])
                                : SizedBox.shrink(),
                          ],
                        );
                      })
                    else
                      ...(data.signupBonus?.signupBonusTreatments ?? [])
                          .asMap()
                          .entries
                          .map((entry) {
                        int idx = entry.key;
                        var signupBonusTreatmentItem = entry.value;
                        return Column(
                          children: [
                            _buildBulletPoints(
                                signupBonusTreatmentItem.treatmentName ??
                                    'Treatment'),
                            idx <
                                (data.signupBonus?.signupBonusTreatments
                                    ?.length ??
                                    0) -
                                    1
                                ? Divider(color: Colors.grey[200])
                                : SizedBox.shrink(),
                          ],
                        );
                      }),
                  ],
                ),
              ),
            ),
            SafeArea(
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: AppColor().lightGrey,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: CommonButtonWidget(
                          onTap: () {}, buttonName: AppStrings.joinNow),
                    ),
                  ],
                ))
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      isDismissible: true, // Allow dismissal by tapping outside
      enableDrag: true, // Allow dismissal by dragging down
      isScrollControlled: true, // Control full screen height
    );
  }
}
