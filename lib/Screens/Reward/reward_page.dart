import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import '../../CSS/app_strings.dart';
import '../../CSS/color.dart';
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
              backgroundColor: AppColor().whiteColor,
              onRefresh: controller.handleRefresh,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                            color: AppColor.dynamicColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextSection(
                                text: "Hi, ${controller.userName.value}",
                                style: AppTypography.galanoGrostesqueSemiBold
                                    .copyWith(
                                  fontSize: 17.sp,
                                  color: AppColor().whiteColor,
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              reward.response == null
                                  ? Column(
                                      children: [
                                        Icon(Icons.qr_code_scanner,
                                            size: 70,
                                            color: AppColor().greyColor.withValues(alpha: .4)),
                                        SizedBox(height: 10.h),
                                        Text(
                                          "New rewards are coming soon. Please stay tuned!",
                                          textAlign: TextAlign.center,
                                          style: AppTypography
                                              .galanoGrostesqueRegular
                                              .copyWith(
                                            fontSize: 15.sp,
                                            color: AppColor().greyColor.withValues(alpha: .7),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                style: AppTypography
                                                    .hostGroteskBold
                                                    .copyWith(
                                                  fontSize: 17.sp,
                                                  color: AppColor().whiteColor,
                                                ),
                                                children: [
                                                  TextSpan(text: 'Only\n'),
                                                  TextSpan(
                                                    text: reward.response
                                                                .nextReward ==
                                                            null
                                                        ? ''
                                                        : '${int.parse(
                                                            reward
                                                                .response
                                                                .nextReward!
                                                                .unlockAtCount
                                                                .toString()
                                                                .replaceAll(
                                                                    ".0", ""),
                                                          )} More Visit',
                                                    style: AppTypography
                                                        .hostGroteskBold
                                                        .copyWith(
                                                      fontSize: 17.sp,
                                                      color:
                                                          AppColor().whiteColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextSection(
                                              text: "Or",
                                              style: AppTypography
                                                  .galanoGrostesqueSemiBold
                                                  .copyWith(
                                                fontSize: 19.sp,
                                                color: AppColor().whiteColor,
                                              ),
                                            ),
                                            RichText(
                                              textAlign: TextAlign.start,
                                              text: TextSpan(
                                                style: AppTypography
                                                    .hostGroteskRegular
                                                    .copyWith(
                                                  fontSize: 18.sp,
                                                  color: AppColor().whiteColor,
                                                ),
                                                children: [
                                                  const TextSpan(
                                                      text: "Spend "),
                                                  TextSpan(
                                                    text:
                                                        "\$${reward.response.nextReward!.unlockSpend.toString()}",
                                                    style: AppTypography
                                                        .hostGroteskBold
                                                        .copyWith(
                                                      fontSize: 18.sp,
                                                      color:
                                                          AppColor().whiteColor,
                                                    ),
                                                  ),
                                                  const TextSpan(
                                                      text:
                                                          "\nFor Your Next\nReward"),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 10.h),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: LinearProgressIndicator(
                                  minHeight: 5.h,
                                  value: (double.tryParse(reward.response
                                              .nextReward!.progressPercentage
                                              .toString()) ??
                                          0) /
                                      100,
                                  semanticsLabel: 'Reward Progress',
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColor().whiteColor),
                                  backgroundColor:
                                      AppColor().whiteColor.withValues(alpha: 0.3),
                                ),
                              ),
                              SizedBox(height: 5.h),

                              // Scan instruction text
                              reward.unloackReward.isEmpty
                                  ? SizedBox.shrink()
                                  : TextSection(
                                      text: AppStrings.scanText,
                                      style: AppTypography.hostGroteskRegular
                                          .copyWith(
                                        fontSize: 14.sp,
                                        color: AppColor().whiteColor,
                                      ),
                                      alignment: TextAlign.start,
                                    ),
                              SizedBox(height: 10.h),

                              // QR Scan button
                              reward.unloackReward.isEmpty
                                  ? SizedBox.shrink()
                                  : ElevatedButton.icon(
                                      onPressed: () => Get.toNamed(
                                              RouteManager.qRCodeScannerPage)!
                                          .then((val) {
                                        controller.available();
                                      }),
                                      label: Text(
                                        AppStrings.checkInForRewards,
                                        style: AppTypography.hostGroteskSemiBold
                                            .copyWith(
                                          color: AppColor().whiteColor,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColor()
                                              .whiteColor
                                              .withValues(alpha: 0.3),
                                          elevation: 3,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 18.w, vertical: 5.h),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.r),
                                          ),
                                          side: BorderSide(
                                              width: 0.8,
                                              color: AppColor().whiteColor)),
                                    ),
                            ],
                          ),
                        ),

                        SizedBox(height: 15.h),
                        // Upcoming rewards section
                        reward.unloackReward.isEmpty
                            ? SizedBox.shrink()
                            : SectionTitle(title: 'Upcoming Rewards'),
                        SizedBox(height: 10.h),
                        reward.unloackReward.isEmpty
                            ? SizedBox.shrink()
                            : Column(
                                children: [
                                  ListView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: reward.show
                                        ? reward.unloackReward.length
                                        : (reward.unloackReward.length > 3
                                            ? 3
                                            : reward.unloackReward.length),
                                    itemBuilder: (context, index) {
                                      final item = reward.unloackReward[index];
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5.h),
                                        child: InkWell(
                                          splashColor: AppColor().transparent,
                                          highlightColor:
                                              AppColor().transparent,
                                          onTap: () {
                                            Get.toNamed(
                                              RouteManager.rewardDetailScreen,
                                              arguments: {
                                                "id": reward
                                                    .unloackReward[index].id,
                                                "title": reward
                                                    .unloackReward[index]
                                                    .rewardTitle
                                                    .toString(),
                                                "hideButtons": true,
                                              },
                                            );
                                          },
                                          child: RewardRowWidget(
                                            visitsNeeded:
                                                item.visitsNeeded.toString(),
                                            rewardTitle:
                                                item.rewardTitle.toString(),
                                            discountAmount:
                                                item.discountAmount.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                  // See more / Hide button
                                  reward.unloackReward.length > 3
                                      ? InkWell(
                                          onTap: () {
                                            reward.show = !reward.show;
                                            controller.update();
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 10.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  reward.show
                                                      ? "Hide"
                                                      : "See more",
                                                  style: AppTypography
                                                      .hostGroteskRegular
                                                      .copyWith(
                                                          fontSize: 14.sp,
                                                          color: AppColor()
                                                              .blueColor
                                                              .withValues(alpha: .9)),
                                                ),
                                                SizedBox(width: 5.w),
                                                Icon(
                                                  reward.show
                                                      ? Icons
                                                          .keyboard_arrow_up_outlined
                                                      : Icons
                                                          .keyboard_arrow_down_rounded,
                                                  color: AppColor()
                                                      .blueColor
                                                      .withValues(alpha: .9),
                                                  size: 22,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : SizedBox.shrink(),
                                ],
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
                                    arguments: {
                                      "id": reward.avail[index].id,
                                      "hideButtons": false,
                                    },
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
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: AppTypography.galanoGrostesqueSemiBold.copyWith(
          color: AppColor().whiteColor,
          fontSize: 12.sp,
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
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: AppColor().blackColor.withValues(alpha: .2),
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
                      label: "REDEEM NOW", color: AppColor.dynamicColor),
                  SizedBox(height: 10.h),
                  Text(
                    rewardTitle,
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 15.sp,
                      color: AppColor().greyColor.withValues(alpha: .8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: AppColor.dynamicColor, size: 20.w),
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
      style: AppTypography.hostGroteskBold.copyWith(
        fontSize: 15.sp,
        color: AppColor().lightBlackColor,
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

class RewardRowWidget extends StatelessWidget {
  final String visitsNeeded;
  final String rewardTitle;
  final String discountAmount;

  const RewardRowWidget({
    super.key,
    required this.visitsNeeded,
    required this.rewardTitle,
    required this.discountAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColor().lightGrey,
          borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BadgeWidget(
                    label:
                        "${int.parse(visitsNeeded.replaceAll(".0", ""))} MORE VISITS",
                    color: AppColor.dynamicColor.withAlpha(120),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    rewardTitle,
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 14.sp,
                      color: AppColor().greyColor.withValues(alpha: .7),
                    ),
                  ),
                  discountAmount.isNotEmpty
                      ? Text(
                          "Can convert to \$${discountAmount}",
                          style: AppTypography.hostGroteskSemiBold.copyWith(
                            fontSize: 13.sp,
                            color: AppColor().greyColor.withValues(alpha: .5),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            ),
            Icon(
              Icons.lock,
              color: AppColor().greyColor.withValues(alpha: .5),
              size: 22.w,
            ),
          ],
        ),
      ),
    );
  }
}
