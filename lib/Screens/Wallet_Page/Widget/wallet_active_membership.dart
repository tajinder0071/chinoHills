import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/image_page.dart';
import 'package:chino_hills/Screens/Account/widget/manage_membership.dart';
import 'package:shimmer/shimmer.dart';
import '../../../CSS/app_strings.dart';
import '../../../CSS/color.dart';
import '../../../Model/wallet_membership_active_model.dart';
import '../../../loading/browse_Concern_load.dart';
import '../../../util/common_page.dart';
import '../controller/walet_member_controller.dart';
import 'wallet_membership.dart';

class WalletActiveMembership extends StatelessWidget {
  WalletActiveMembership({super.key});

  final WalletMemberController walletController =
      Get.put(WalletMemberController());

  @override
  Widget build(BuildContext context) {
    walletController.fetchWalletMembership();
    return Obx(
      () {
        if (walletController.isLoading.value) {
          return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    color: AppColor().whiteColor,
                  ),
                  Expanded(child: BrowseConcernLoad())
                ],
              )
          );
        }

        final memberships = walletController.activeMembership;
        if (memberships.isEmpty) {
          return WalletMembership();
        }

        return Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Obx(() {
              final current = walletController.currentPage.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: current > 0
                        ? () => walletController.goToPage(current - 1)
                        : null,
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      memberships.length,
                      (dotIndex) => AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: current == dotIndex ? 10 : 8,
                        height: current == dotIndex ? 10 : 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: current == dotIndex
                              ? Colors.black
                              : Colors.grey.shade300,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: current < memberships.length - 1
                        ? () => walletController.goToPage(current + 1)
                        : null,
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              );
            }),
            Expanded(
              child: PageView.builder(
                controller: walletController.pageController,
                onPageChanged: walletController.onPageChanged,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: memberships.length,
                itemBuilder: (context, index) {
                  final membership = memberships[index];

                  return SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Membership Count Indicator
                          Center(
                            child: Text(
                              "Active Membership ${index + 1} of ${memberships.length}",
                              style: AppTypography.hostGroteskRegular.copyWith(
                                  fontSize: 12.sp,
                                  color: AppColor().blackColor.withValues(alpha: 0.5)),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),

                          // Membership Card (Dynamic)
                          _membershipCard(
                            name: membership.membershipTitle ?? "N/A",
                            plan: membership.offerName ?? "N/A",
                            imageUrl: membership.membershipImage ??
                                AppImages.nimaLogo,
                          ),
                          SizedBox(height: 16.h),

                          // Treatment Card (Dynamic count)
                          // _treatmentCard(treatmentCount),

                          SizedBox(height: 20.h),
                          // Benefits Section
                          _buildBenefitsSection(membership),

                          SizedBox(height: 20.h),

                          membership.signupBonus != null &&
                                  membership.signupBonus!.signupBonusTreatments
                                          ?.isNotEmpty ==
                                      true
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "⭐ SIGN-UP BONUS UNLOCKED",
                                        style: AppTypography
                                            .galanoGrostesqueSemiBold
                                            .copyWith(
                                                fontSize: 16,
                                                color: AppColor.dynamicColor),
                                      ),
                                      const SizedBox(height: 4),
                                      if (membership.signupBonus != null &&
                                          membership
                                                  .signupBonus!
                                                  .signupBonusTreatments
                                                  ?.isNotEmpty ==
                                              true)
                                        Text(
                                          "Unlock your choice of ${membership.signupBonus!.signupBonusTreatments!.length} items",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        )
                                      else
                                        SizedBox.shrink(),
                                      const SizedBox(height: 16),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 30,
                                              vertical: 14,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              side: const BorderSide(
                                                  color: Colors.black12),
                                            ),
                                          ),
                                          onPressed: () {
                                            showSignupBonusBottomsheetWithCheckBox(
                                                membership);
                                          },
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Select Now",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(width: 8),
                                              Icon(Icons.arrow_forward,
                                                  size: 18),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox.shrink(),
                          if (walletController.walletData.nimaCashBalance
                                  .toInt() >
                              0)
                            SizedBox(height: 20.h),

                          // BALANCE CARD
                          if (walletController.walletData.nimaCashBalance
                                  .toInt() >
                              0)
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF111827),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "YOUR CHINOCASH BALANCE",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      letterSpacing: 1.1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    formatCurrency(walletController
                                        .walletData.nimaCashBalance),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Divider(color: Colors.white12, height: 30.h),
                                  Text(
                                    "EVERY MONTH YOU EARN",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      letterSpacing: 1.1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    formatCurrency(walletController
                                        .walletData.nimaCashBalance),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          SizedBox(height: 20.h),

                          // MONTHLY BENEFITS
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.card_giftcard,
                                        color: Colors.black54),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        "Enjoy All Of The Following Every MONTH!",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                _buildBulletPoints2(membership
                                    .membershipDescription
                                    .toString()),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          membership.includedTreatments!.isEmpty
                              ? SizedBox.shrink()
                              : ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      membership.includedTreatments!.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10),
                                  itemBuilder: (context, index) {
                                    final treatment =
                                        membership.includedTreatments![index];
                                    return Column(
                                      children: [
                                        (membership.includedTreatments!
                                                    .isEmpty ||
                                                !hasValidTreatment(treatment) ||
                                                membership.benefits == null ||
                                                membership.benefits!.isEmpty ||
                                                membership.benefits!.every(
                                                    (benefit) =>
                                                        (benefit.benefitTitle ??
                                                                "")
                                                            .trim()
                                                            .isEmpty))
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

                          SizedBox(height: 20.h),

                          // NEXT MILESTONE CARD
                          membership.membershipMilestoneBonuses!.isEmpty
                              ? SizedBox.shrink()
                              : ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: membership
                                      .membershipMilestoneBonuses!.length,
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 5.h),
                                  itemBuilder: (context, index) {
                                    final treatment = membership
                                        .membershipMilestoneBonuses![index];
                                    return Column(
                                      children: [
                                        _milestoneBonusSection(
                                            context, membership, treatment,
                                            title: treatment.headertitle!,
                                            desc:
                                                treatment.milestonedescription!,
                                            buttonText: AppStrings.moreDetails,
                                            showIcon: index == 0)
                                      ],
                                    );
                                  },
                                ),

                          SizedBox(height: 32.h),

                          // Manage memberships link
                          Center(
                            child: InkWell(
                              splashFactory: NoSplash.splashFactory,
                              onTap: () {
                                Get.to(ManageMembership());
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Manage memberships",
                                    style: TextStyle(
                                      color: AppColor().blackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(Icons.arrow_forward,
                                      size: 18.h, color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  // ---------------- SIGNUP BONUS SECTION (CHECK BOX)----------------
  void showSignupBonusBottomsheetWithCheckBox(ActiveMembership data,
      {bool isMilestone = false, MembershipMilestoneBonus? milestoneBonus}) {
    final WalletMemberController controller =
        Get.find<WalletMemberController>();

    Get.bottomSheet(
      Container(
        height: Get.height * 0.9,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // HEADER
            Padding(
              padding: EdgeInsets.only(top: 12.h, left: 12.w, right: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        controller.clearSelection();
                      },
                      icon: Icon(Icons.close,
                          size: 25.sp, color: AppColor().blackColor)),
                  Text(
                    AppStrings.signUpBonusCapital,
                    style: GoogleFonts.sarabun(
                        fontSize: 16.sp, fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.close, color: Colors.transparent)
                ],
              ),
            ),
            Divider(thickness: 1, color: AppColor().lightGrey),

            // LIST OF CHECKBOXES
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: data.signupBonus?.signupBonusTreatments?.length ?? 0,
                separatorBuilder: (_, __) => Divider(color: Colors.grey[200]),
                itemBuilder: (context, index) {
                  final treatment =
                      data.signupBonus!.signupBonusTreatments![index];
                  final treatmentName = treatment.treatmentName ?? ' ';

                  return Obx(() => CheckboxListTile(
                        value: controller.selectedTreatmentId.value == index,
                        title: Text(treatmentName,
                            style: AppTypography.galanoGrostesqueRegular
                                .copyWith(fontSize: 14.sp)),
                        activeColor: AppColor.dynamicColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (_) => controller.selectTreatment(index),
                      ));
                },
              ),
            ),

            // FOOTER BUTTONS
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Column(
                  children: [
                    Divider(
                      color: AppColor().lightGrey,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 10.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 45.h,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      color: AppColor().lightBlackColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                  controller.clearSelection();
                                },
                                child: Text(
                                  "Cancel",
                                  style: AppTypography.galanoGrostesqueMedium
                                      .copyWith(
                                    color: AppColor().lightBlackColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: SizedBox(
                              height: 45.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  final selectedIndex =
                                      controller.selectedTreatmentId.value;
                                  if (selectedIndex == null) {
                                    Get.snackbar("Select one",
                                        "Please choose a treatment",
                                        snackPosition: SnackPosition.BOTTOM);
                                    return;
                                  }
                                  final selectedTreatment = data.signupBonus!
                                      .signupBonusTreatments![selectedIndex];
                                  Get.back();
                                  Get.snackbar(
                                    "Selected",
                                    "${selectedTreatment.treatmentName} selected!",
                                    snackPosition: SnackPosition.BOTTOM,
                                  );
                                  // You can handle your API call or logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.dynamicColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                ),
                                child: Text(
                                  "Confirm",
                                  style: AppTypography.galanoGrostesqueMedium
                                      .copyWith(
                                    color: AppColor().whiteColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: false,
    );
  }

  Widget _buildSignUpBonusBulletPoints(String text) {
    if (text.isEmpty || text == "[]") return SizedBox();
    text = text.replaceAll('[', '').replaceAll(']', '');
    List<String> points = text.split(',');
    points = points.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map(_buildSignUpBonusBulletPoint).toList(),
    );
  }

  Widget _buildSignUpBonusBulletPoint(String text) {
    return Row(
      children: [
        Text("* ",
            style: AppTypography.galanoGrostesqueSemiBold
                .copyWith(fontSize: 16.sp, color: AppColor().blackColor)),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            text,
            style: AppTypography.hostGroteskRegular
                .copyWith(fontSize: 12.sp, color: AppColor().blackColor),
          ),
        ),
      ],
    );
  }

  // ---------------- BENEFITS SECTION ----------------
  Widget _buildBenefitsSection(ActiveMembership? data) {
    if (data?.benefits == null ||
        data!.benefits!.isEmpty ||
        data.benefits!
            .every((benefit) => (benefit.benefitTitle ?? "").trim().isEmpty)) {
      return SizedBox.shrink();
    }
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h),
        decoration: BoxDecoration(
          color: AppColor.dynamicColor,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: AppColor().blackColor.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star_border, color: AppColor().whiteColor, size: 25),
                Text(
                  "  Member-Only Benefits",
                  style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                    fontSize: 14.sp,
                    color: AppColor().whiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Enjoy exclusive member-only benefits as a nav membership member",
              style: AppTypography.hostGroteskSemiBold.copyWith(
                fontSize: 13.sp,
                color: AppColor().whiteColor,
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.benefits!.length,
              itemBuilder: (context, index) => _buildBulletPoints(
                data.benefits![index].benefitTitle.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget treatmentSection(
      BuildContext context, IncludedTreatment includedTreatments) {
    final List<SignupBonusTreatment> treatmentItems =
        (includedTreatments.treatmentItems ?? [])
            .where((item) => (item.treatmentName != null &&
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
                    style: AppTypography.hostGroteskSemiBold.copyWith(
                        fontSize: 16.sp,
                        color: AppColor.dynamicColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Starting on your 1st day as a member",
                    style: AppTypography.hostGroteskSemiBold.copyWith(
                        fontSize: 15.sp, color: Colors.black.withValues(alpha: 0.65)),
                    textAlign: TextAlign.center,
                  ),
                  ...treatmentItems.asMap().entries.map((entry) {
                    int idx = entry.key;
                    SignupBonusTreatment treatmentItem = entry.value;

                    return Column(children: [
                      _buildBulletPoints2(
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

  bool hasValidTreatment(IncludedTreatment includedTreatments) {
    return (includedTreatments.treatmentItems ?? []).any((item) =>
        item.treatmentName != null && item.treatmentName!.trim().isNotEmpty);
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

  Widget _buildBulletPoints2(String text) {
    if (text.isEmpty || text == "[]") return SizedBox();
    text = text.replaceAll('[', '').replaceAll(']', '');
    List<String> points = text.split(',');
    points = points.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points.map(_buildBulletPoint2).toList(),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      children: [
        Text("• ",
            style: AppTypography.galanoGrostesqueSemiBold
                .copyWith(fontSize: 16.sp, color: AppColor().whiteColor)),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            text,
            style: AppTypography.hostGroteskRegular
                .copyWith(fontSize: 12.sp, color: AppColor().whiteColor),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint2(String text) {
    return Row(
      children: [
        Text("• ",
            style: AppTypography.galanoGrostesqueSemiBold
                .copyWith(fontSize: 16.sp, color: AppColor().blackColor)),
        SizedBox(width: 5.w),
        Expanded(
          child: Text(
            text,
            style: AppTypography.hostGroteskRegular
                .copyWith(fontSize: 12.sp, color: AppColor().blackColor),
          ),
        ),
      ],
    );
  }

  // ---------------- MEMBERSHIP CARD ----------------
  Widget _membershipCard({
    required String name,
    String? plan,
    required String imageUrl,
  }) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.h,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover)),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w, top: 10.h, right: 5.w),
            child: Text(
              name,
              style: AppTypography.galanoGrostesqueSemiBold
                  .copyWith(fontSize: 16.sp),
            ),
          ),
          plan!.isEmpty
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(left: 8.w, bottom: 10.h),
                  child: Text(
                    plan,
                    style: AppTypography.hostGroteskRegular
                        .copyWith(color: AppColor().black80, fontSize: 12.sp),
                  ),
                )
        ],
      ),
    );
  }

  Widget _milestoneBonusSection(
      context, ActiveMembership data, MembershipMilestoneBonus milestoneBonus,
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
                    color: AppColor.dynamicColor.withValues(alpha: 0.1),
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
                          color: Colors.black.withValues(alpha: 0.65),
                          fontFamily: 'galano-grotesque-alt'),
                      desc == null || desc.isEmpty
                          ? SizedBox.shrink()
                          : commonText(
                              text: desc,
                              fontSize: 16.sp,
                              color: Colors.black.withValues(alpha: 0.65),
                              fontFamily: 'host-grotesk'),
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
                              color: AppColor.dynamicColor,
                              fontFamily: 'host-grotesk'))
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget commonText(
      {required String text,
      fontSize = 0.0,
      color = Colors.black,
      required fontFamily}) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style:
          TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color),
    );
  }

  void showSignupBonusBottomsheet(ActiveMembership data,
      {bool isMilestone = false, MembershipMilestoneBonus? milestoneBonus}) {
    final WalletMemberController controller =
        Get.find<WalletMemberController>();

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
                        controller.clearSelection();
                      },
                      icon: Icon(Icons.close,
                          size: 25.sp, color: AppColor().blackColor)),
                  Text(
                    isMilestone && milestoneBonus != null
                        ? milestoneBonus.headertitle ??
                            AppStrings.signUpBonusCapital
                        : AppStrings.signUpBonusCapital,
                    style: GoogleFonts.sarabun(
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
                              style: GoogleFonts.sarabun(
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
                              style: GoogleFonts.sarabun(
                                  color: Colors.black, fontSize: 16.sp),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${data.signupBonus?.choosedOption}',
                                    style: GoogleFonts.sarabun(
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                  text:
                                      ' bonus treatments from the below when you sign up as a ${data.membershipTitle} member',
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
                            _buildBulletPoints2(
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
                            _buildSignUpBonusBulletPoints(
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
                bottom: true,
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: AppColor().lightGrey,
                    ),
                    SizedBox(
                      width: 232.w,
                      height: 60.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 14,
                          shadowColor: AppColor.dynamicColor.withValues(alpha: 0.6),
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0.r),
                          ),
                          backgroundColor: AppColor.dynamicColor,
                        ),
                        child: Text(
                          AppStrings.addToCart,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.sarabun(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
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
