import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../CSS/app_strings.dart';
import '../../CSS/color.dart';
import '../../Model/availRewardModel.dart';
import '../../common_Widgets/common_refer_widget.dart';
import '../../loading/reward_load.dart';
import '../../util/common_page.dart';
import '../../util/route_manager.dart';
import 'controller/reward_details_controller.dart';

class RewardPage extends StatelessWidget {
  RewardPage({super.key});

  RewardDetailsController reward = Get.put(RewardDetailsController());

  bool isRewardsVisible = true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RewardDetailsController>(
      init: Get.find<RewardDetailsController>()
        ..available()
        ..getUser(),
      builder: (controller) => reward.load
          ? RewardLoad()
          : LiquidPullToRefresh(
              animSpeedFactor: 1.5,
              springAnimationDurationInMilliseconds: 400,
              key: controller.refreshIndicatorKey,
              color: AppColor.dynamicColor,
              showChildOpacityTransition: false,
              backgroundColor: Colors.white,
              onRefresh: controller.handleRefresh,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Username section
                        TextSection(
                          text: controller.userName.value.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.dynamicColor,
                          ),
                        ),
                        SizedBox(height: 25.h),

                        // Reward progress section
                        reward.response.nextReward!.unlockAtCount.toString() ==
                                    "0" ||
                                reward.response.nextReward!.unlockAtCount
                                        .toString() ==
                                    ""
                            ? Column(
                                children: [
                                  Icon(
                                    Icons.qr_code_scanner,
                                    size: 70,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: 10.h),
                                  Text(
                                    "New rewards are coming soon. Please stay tuned!",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  TextSection(
                                    text:
                                        'Only ${int.parse(reward.response.nextReward!.unlockAtCount.toString().replaceAll(".0", ""))} more visits or spend \$${reward.response.nextReward!.unlockSpend.toString()} for your next reward',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 15.h),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20.r),
                                    child: LinearProgressIndicator(
                                      minHeight: 12.h,
                                      value:
                                          (double.tryParse(
                                                reward
                                                    .response
                                                    .nextReward!
                                                    .progressPercentage
                                                    .toString(),
                                              ) ??
                                              0) /
                                          100,
                                      semanticsLabel: 'Reward Progress',
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColor.dynamicColor,
                                      ),
                                      backgroundColor: Colors.grey[200],
                                    ),
                                  ),
                                ],
                              ),

                        SizedBox(height: 20.h),

                        // Scan instruction text
                        reward.unloackReward.isEmpty
                            ? SizedBox.shrink()
                            : TextSection(
                                text: AppStrings.scanText,
                                style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  color: Colors.grey,
                                ),
                              ),
                        SizedBox(height: 20.h),

                        // QR Scan button
                        reward.unloackReward.isEmpty
                            ? SizedBox.shrink()
                            : ElevatedButton.icon(
                                onPressed: () =>
                                    Get.toNamed(
                                      RouteManager.qRCodeScannerPage,
                                    )!.then((val) {
                                      controller.available();
                                    }),
                                icon: Icon(
                                  AntDesign.scan_outline,
                                  color: Colors.white,
                                  size: 23.h,
                                ),
                                label: Text(
                                  "Check in for rewards",
                                  style: GoogleFonts.sarabun(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.dynamicColor,
                                  elevation: 3,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 25.w,
                                    vertical: 14.h,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                              ),

                        SizedBox(height: 30.h),

                        // Upcoming rewards section
                        reward.unloackReward.isEmpty
                            ? SizedBox.shrink()
                            : SectionTitle(title: 'Upcoming Rewards'),
                        reward.unloackReward.isEmpty
                            ? SizedBox.shrink()
                            : Container(
                                margin: EdgeInsets.only(top: 20.h),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 15.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 8,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: reward.show
                                          ? reward.unloackReward.length
                                          : (reward.unloackReward.length > 3
                                                ? 3
                                                : reward.unloackReward.length),
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            RouteManager.rewardDetailScreen,
                                            arguments: {
                                              "id": reward
                                                  .unloackReward[index]
                                                  .id,
                                              "title": reward
                                                  .unloackReward[index]
                                                  .rewardTitle
                                                  .toString(),
                                            },
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                            horizontal: 8.w,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    BadgeWidget(
                                                      label:
                                                          "${int.parse(reward.unloackReward[index].visitsNeeded.toString().replaceAll(".0", ""))} MORE VISITS",
                                                      color: AppColor
                                                          .dynamicColor
                                                          .withAlpha(120),
                                                    ),
                                                    SizedBox(height: 8.h),
                                                    Text(
                                                      reward
                                                          .unloackReward[index]
                                                          .rewardTitle
                                                          .toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontSize: 14.sp,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey[700],
                                                          ),
                                                    ),
                                                    reward
                                                                .unloackReward[index]
                                                                .discountAmount !=
                                                            ""
                                                        ? Text(
                                                            "Can convert to \$${reward.unloackReward[index].discountAmount}",
                                                            style:
                                                                GoogleFonts.poppins(
                                                                  fontSize:
                                                                      13.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500,
                                                                ),
                                                          )
                                                        : SizedBox.shrink(),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons.lock,
                                                color: Colors.grey.shade500,
                                                size: 22.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    // See more / Hide button
                                    reward.unloackReward.length > 3
                                        ? InkWell(
                                            onTap: () {
                                              reward.show = !reward.show;
                                              controller.update();
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                top: 10.h,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    reward.show
                                                        ? "Hide"
                                                        : "See more",
                                                    style:
                                                        GoogleFonts.merriweather(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp,
                                                          color: Colors
                                                              .blue
                                                              .shade900,
                                                        ),
                                                  ),
                                                  SizedBox(width: 5.w),
                                                  Icon(
                                                    reward.show
                                                        ? Icons
                                                              .keyboard_arrow_up_outlined
                                                        : Icons
                                                              .keyboard_arrow_down_rounded,
                                                    color: Colors.blue.shade900,
                                                    size: 22,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),

                  // Rewards history section
                  reward.avail.isEmpty
                      ? SizedBox.shrink()
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              SizedBox(height: 30.h),
                              SectionTitle(title: 'Rewards History'),
                              SizedBox(height: 20.h),
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: reward.avail.length,
                                itemBuilder: (context, index) => RewardCard(
                                  discountPercent:
                                      "\$${reward.avail[index].discountAmount}",
                                  discountMessage:
                                      "${reward.avail[index].discountAmount}",
                                  onTap: () => Get.toNamed(
                                    RouteManager.rewardDetailScreen,
                                    arguments: {"id": reward.avail[index].id},
                                  ),
                                  rewardTitle:
                                      '${reward.avail[index].rewardTitle}',
                                ),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(height: 20.h),
                  // Referral + brand
                  CommonReferWidget(),
                  SizedBox(height: 15.h),
                  getBrand(),
                ],
              ),
            ),
    );
  }
}

// Badge Widget
class BadgeWidget extends StatelessWidget {
  final String label;
  final Color color;

  const BadgeWidget({super.key, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Reward Card Widget
class RewardCard extends StatelessWidget {
  final String discountPercent;
  final String rewardTitle;
  final String discountMessage;
  final VoidCallback onTap;

  const RewardCard({
    super.key,
    required this.discountPercent,
    required this.rewardTitle,
    required this.discountMessage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BadgeWidget(
                    label: "REDEEM NOW",
                    color: AppColor.dynamicColor,
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    rewardTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppColor.dynamicColor,
              size: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}

// Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
        color: Colors.grey.shade700,
      ),
    );
  }
}

// Text Section Widget
class TextSection extends StatelessWidget {
  final String text;
  final TextAlign alignment;
  final TextStyle style;

  const TextSection({
    super.key,
    required this.text,
    required this.style,
    this.alignment = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: alignment, style: style);
  }
}
