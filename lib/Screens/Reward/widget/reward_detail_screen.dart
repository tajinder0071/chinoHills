import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import 'package:chino_hills/common_Widgets/common_button_widget.dart';
import '../../../CSS/color.dart';
import '../../../binding/cart_billing.dart';
import '../../../loading/reward_load.dart';
import '../../../util/common_page.dart';
import '../../../util/route_manager.dart';
import '../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../../shop/controller/shop_controller.dart';
import '../controller/reward_details_controller.dart';

class RewardDetailScreen extends StatelessWidget {
  final dynamic id;
  final dynamic title;
  final bool hideButtons;

  const RewardDetailScreen(
      {super.key, required this.id, this.title, this.hideButtons = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Rewards"),
      backgroundColor: AppColor().background,
      body: GetBuilder<RewardDetailsController>(
        init: Get.find<RewardDetailsController>()..fetchRewardData(id),
        builder: (dController) {
          return dController.isLoading
              ? RewardDetail()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// --- Reward Header ---
                        RewardHeaderWidget(title: title ?? "Reward Details"),

                        /// --- Services Section ---
                        GetBuilder<RewardDetailsController>(
                          builder: (_) {
                            List<Map<String, dynamic>> combined = [];

                            if (dController.treatmentsList.isNotEmpty) {
                              combined.add({
                                'type': 'header',
                                'title': '✨ Treatments',
                              });
                              combined.addAll(dController.treatmentsList.map(
                                (e) => {
                                  'type': 'item',
                                  'data': e,
                                  'section': 'Treatments',
                                },
                              ));
                            }
                            if (dController.packagesList.isNotEmpty) {
                              combined.add(
                                  {'type': 'header', 'title': '📦 Packages'});
                              combined.addAll(dController.packagesList.map(
                                (e) => {
                                  'type': 'item',
                                  'data': e,
                                  'section': 'Packages',
                                },
                              ));
                            }
                            if (dController.membersList.isNotEmpty) {
                              combined.add({
                                'type': 'header',
                                'title': '👥 Memberships'
                              });
                              combined.addAll(dController.membersList.map(
                                (e) => {
                                  'type': 'item',
                                  'data': e,
                                  'section': 'Members',
                                },
                              ));
                            }

                            if (combined.isEmpty) return SizedBox.shrink();

                            int visibleCount =
                                dController.showMore ? combined.length : 6;
                            List<Map<String, dynamic>> visibleItems =
                                combined.take(visibleCount).toList();

                            return Container(
                              margin: EdgeInsets.all(12.h),
                              decoration: BoxDecoration(
                                color: AppColor().whiteColor,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        AppColor().blackColor.withValues(alpha: .2),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// --- Intro Section ---
                                  Container(
                                    padding: EdgeInsets.all(14.h),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColor.dynamicColor
                                              .withValues(alpha: 0.15),
                                          AppColor().whiteColor,
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16.r)),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Icon(Iconsax.gift,
                                            color: AppColor.dynamicColor,
                                            size: 28.sp),
                                        SizedBox(width: 12.w),
                                        Expanded(
                                          child: Text(
                                            "Apply this reward in cart to receive \$${dController.rewardPoints} off when you purchase at least one of the following services:",
                                            style: AppTypography
                                                .hostGroteskSemiBold
                                                .copyWith(
                                              fontSize: 14.5.sp,
                                              color: AppColor().black80,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// --- Items Section ---
                                  ...visibleItems.map((entry) {
                                    if (entry['type'] == 'header') {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8.h, horizontal: 16.w),
                                        child: Text(
                                          entry['title'],
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.5.sp,
                                            color: AppColor.dynamicColor,
                                          ),
                                        ),
                                      );
                                    } else {
                                      var item = entry['data'];
                                      var section = entry['section'];
                                      return Material(
                                        color: AppColor().transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(12.r),
                                          onTap: () =>
                                              _navigateToSection(section, item),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                                horizontal: 18.w),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "• ${item.name}",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 14.sp,
                                                      color: AppColor().black80,
                                                    ),
                                                  ),
                                                ),
                                                Icon(Icons.arrow_forward_ios,
                                                    size: 16,
                                                    color:
                                                        AppColor.dynamicColor),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  }),

                                  /// --- Show More / Less ---
                                  if (combined.length > 6)
                                    InkWell(
                                      onTap: () {
                                        dController.showMore =
                                            !dController.showMore;
                                        dController.update();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15.w),
                                        height: 48.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColor()
                                                  .greyColor
                                                  .withValues(alpha: .2),
                                              AppColor()
                                                  .greyColor
                                                  .withValues(alpha: .1),
                                            ],
                                          ),
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(16.r),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              dController.showMore
                                                  ? "Show less"
                                                  : "Show more",
                                              style: GoogleFonts.merriweather(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.sp,
                                                color: AppColor.dynamicColor,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                            Icon(
                                              dController.showMore
                                                  ? Icons
                                                      .keyboard_arrow_up_rounded
                                                  : Icons
                                                      .keyboard_arrow_down_rounded,
                                              color: AppColor.dynamicColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),

                        /// --- Bottom Info ---
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18.w, vertical: 12.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dController.rewardPoints.isEmpty
                                  ? SizedBox.shrink()
                                  : _infoText(
                                      "\$${dController.rewardPoints} saving applies to your total purchase amount, not per individual item."),
                              SizedBox(height: 4.h),
                              _infoText("This reward can only be used once.",
                                  italic: true),
                              SizedBox(height: 25.h),
                              if (!hideButtons) ...[
                                (dController.repeatNimaCash == "0" ||
                                        dController.repeatNimaCash == "")
                                    ? SizedBox.shrink()
                                    : CommonButtonWidget(
                                        innerColor: AppColor.dynamicColor,
                                        isOutlineButton: true,
                                        outlineColor: AppColor.dynamicColor,
                                        onTap: () {
                                          _showBankYourRewardBottomSheet(
                                            context,
                                            formatCurrency(
                                                dController.repeatNimaCash),
                                            rewardId: id,
                                          );
                                        },
                                        buttonName:
                                            "Bank for ${formatCurrency(dController.repeatNimaCash)} in ChinoCash",
                                      ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 4.h),
          child: Text(
            'Powered by: Birdhaus™ Technology',
            textAlign: TextAlign.center,
            style: GoogleFonts.cabin(
              color: AppColor().black80,
              fontWeight: FontWeight.w600,
              fontSize: 10.sp,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToSection(String section, dynamic item) {
    if (section == 'Treatments') {
      Get.to(() => TreatmentDetailsPage(),
          binding: CommonBinding(),
          arguments: item.id,
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 500));
    } else if (section == 'Packages') {
      Get.to(() => PackageDetailPage(sectionName: "Package"),
          binding: CommonBinding(),
          arguments: item.id,
          transition: Transition.fadeIn,
          duration: Duration(milliseconds: 500));
    } else if (section == 'Members') {
      Get.toNamed(RouteManager.membersShipDetailsPage,
          arguments: item.id, parameters: {"onlyShow": "0"});
    }
  }

  Widget _infoText(String text, {bool italic = false}) {
    return Text(
      text,
      style: AppTypography.hostGroteskSemiBold.copyWith(
        fontSize: 13.sp,
        color: AppColor().greyColor.withValues(alpha: .8),
        fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}

class RewardHeaderWidget extends StatelessWidget {
  final String title;

  const RewardHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: double.infinity,
      padding: EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.dynamicColor,
            AppColor.dynamicColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: AppColor.dynamicColor.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: Offset(0, 4))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.card_giftcard, color: AppColor().whiteColor, size: 60.h),
          SizedBox(height: 8),
          Text(
            "🎉 REWARD UNLOCKED!",
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
              color: AppColor().whiteColor,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: AppTypography.hostGroteskSemiBold.copyWith(
              color: AppColor().whiteColor,
              fontSize: 20.sp,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

void _showBankYourRewardBottomSheet(
  BuildContext context,
  String nimaCash, {
  required dynamic rewardId,
}) {
  final RewardDetailsController controller =
      Get.find<RewardDetailsController>();

  showModalBottomSheet(
    context: context,
    backgroundColor: AppColor().transparent,
    isScrollControlled: true,
    builder: (context) => GetBuilder<RewardDetailsController>(
      builder: (_) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close,
                    color: AppColor().blackColor.withValues(alpha: .5)),
              ),
            ),
            Icon(Icons.monetization_on_outlined,
                color: AppColor().lightBlackColor, size: 35.sp),
            SizedBox(height: 16.h),
            Text(
              "Bank your reward for NimaCash?",
              textAlign: TextAlign.center,
              style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                fontSize: 26.sp,
                color: AppColor().lightBlackColor,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "You will exchange your reward for $nimaCash worth of NimaCash which can be used for in-app purchases only.",
              textAlign: TextAlign.center,
              style: AppTypography.galanoGrostesqueMedium.copyWith(
                fontSize: 15.sp,
                color: AppColor().greyColor,
              ),
            ),
            SizedBox(height: 24.h),
            CommonButtonWidget(
              innerColor: AppColor.dynamicColor,
              onTap: controller.isUpdate
                  ? null
                  : () async {
                      final success =
                          await controller.convertNimaCash(rewardId);

                      if (success) {
                        Navigator.pop(context);
                        Future.delayed(const Duration(milliseconds: 300), () {
                          showRewardBankedBottomSheet(Get.context!);
                        });
                      }
                    },
              buttonName:
                  controller.isUpdate ? "Please wait..." : "Yes, bank reward",
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Not now',
                style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                  color: AppColor.dynamicColor,
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 16.h),
          ],
        ),
      ),
    ),
  );
}

void showRewardBankedBottomSheet(BuildContext context) {
  final ShopController shopController = Get.find<ShopController>();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColor().transparent,
    builder: (context) {
      return GetBuilder<ShopController>(
        builder: (_) => FractionallySizedBox(
          heightFactor: 0.5,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor().whiteColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              boxShadow: [
                BoxShadow(
                  color: AppColor().blackColor.withValues(alpha: .2),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close,
                          color: AppColor().blackColor.withValues(alpha: .5)),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Reward banked!",
                    textAlign: TextAlign.center,
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 26.sp,
                      color: AppColor().lightBlackColor,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "YOUR NEW BALANCE",
                    textAlign: TextAlign.center,
                    style: AppTypography.galanoGrostesqueMedium.copyWith(
                      fontSize: 15.sp,
                      color: AppColor().greyColor,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColor().greyColor.withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style:
                                AppTypography.galanoGrostesqueRegular.copyWith(
                              fontSize: 18.sp,
                              color: AppColor().blackColor,
                            ),
                            children: [
                              TextSpan(
                                text: "\$${shopController.nimaCashBalance} ",
                                style: AppTypography.galanoGrostesqueSemiBold
                                    .copyWith(
                                  color: AppColor().blackColor,
                                ),
                              ),
                              TextSpan(
                                text: "cash",
                                style:AppTypography.hostGroteskSemiBold.copyWith(
                                  color: AppColor().greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Icon(Icons.info_outline, size: 16.h, color: AppColor().greyColor),
                            SizedBox(width: 6.w),
                            Text(
                              "Apply cash in cart to save on treatments",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                color: AppColor().greyColor.withValues(alpha: .6),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  CommonButtonWidget(
                    innerColor: AppColor.dynamicColor,
                    onTap: () {
                      Get.offAllNamed(RouteManager.dashBoardPage, arguments: 2);
                    },
                    buttonName: "Explore shop",
                  ),
                  SizedBox(height: 14.h),
                  TextButton(
                    onPressed: () {
                      Get.offAllNamed(RouteManager.dashBoardPage, arguments: 3);
                    },
                    child: Text(
                      "View rewards",
                      style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                        color: AppColor.dynamicColor,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
