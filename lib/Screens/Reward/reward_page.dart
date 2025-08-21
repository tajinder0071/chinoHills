import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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
              backgroundColor: Colors.white,
              onRefresh: controller.handleRefresh,
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(16.h),
                    child: Column(
                      children: [
                        //TODO: User name section
                        TextSection(
                          text: controller.userName.value.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.dynamicColor,
                          ),
                        ),
                        SizedBox(height: 25.h),
                        //TODO: Reward progress section
                        reward.datum.isEmpty
                            ? Column(
                                children: [
                                  Icon(Icons.qr_code_scanner, size: 60),
                                  SizedBox(height: 5.h),
                                  Text(
                                    "New rewards are coming soon. Please stay tuned!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            : TextSection(
                                text:
                                    'Only ${int.parse(reward.datum[0].visitLeft.toString().replaceAll(".0", ""))} more visits or spend \$${reward.datum[0].repeatcashvalue} for your next reward',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        SizedBox(height: 10.h),
                        reward.datum.isEmpty
                            ? SizedBox.shrink()
                            : LinearProgressIndicator(
                                minHeight: 10.h,
                                value: reward.datum[0].visitLeft == 0
                                    ? 0.0
                                    : (reward.datum[0].unlocksAt -
                                              int.parse(
                                                reward.datum[0].visitLeft
                                                    .toString()
                                                    .replaceAll(".0", ""),
                                              )) /
                                          reward.datum[0].unlocksAt,
                                semanticsLabel: 'Reward Progress',
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColor.dynamicColor,
                                ),
                                backgroundColor: Colors.grey[300],
                              ),
                        SizedBox(height: 10.h),
                        reward.datum.isEmpty
                            ? SizedBox.shrink()
                            : TextSection(
                                text:
                                    "Scan in store or shop in-app to get closer to your next reward.",
                                style: TextStyle(
                                  fontSize: 13.h,
                                  color: Colors.grey,
                                ),
                              ),
                        SizedBox(height: 20.h),

                        //TODO: QR Scan button
                        reward.datum.isEmpty
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
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.h,
                                    vertical: 12.w,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.r),
                                  ),
                                ),
                              ),
                        // Available rewards section
                        reward.avail.isEmpty
                            ? SizedBox.shrink()
                            : SizedBox(height: 30.h),
                        // Available rewards section
                        reward.avail.isEmpty
                            ? SizedBox.shrink()
                            : SectionTitle(title: 'Available Rewards'),
                        SizedBox(height: 20.h),
                        reward.avail.isEmpty
                            ? SizedBox.shrink()
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: reward.avail.length,
                                itemBuilder: (context, index) => RewardCard(
                                  discountPercent:
                                      "\$${reward.avail[index].discountType == "btn-amount" ? "\$" : ""}${reward.avail[index].discountAmount!}${reward.avail[index].discountType == "btn-amount" ? "" : ""}",
                                  discountMessage:
                                      "${reward.avail[index].discountAmount}",
                                  onTap: () => Get.toNamed(
                                    RouteManager.rewardDetailScreen,
                                    arguments: {
                                      "id": reward.avail[index].id,
                                    }, // or any unique identifier
                                  ),
                                  rewardTitle:
                                      '${reward.avail[index].rewardTitle}',
                                ),
                              ),
                        SizedBox(height: 20.h),
                        // Upcoming rewards section
                        reward.datum.isEmpty
                            ? SizedBox.shrink()
                            : SectionTitle(title: 'Upcoming Rewards'),
                        reward.datum.isEmpty
                            ? SizedBox.shrink()
                            : Container(
                                margin: EdgeInsets.only(top: 20.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: reward.show
                                          ? reward.datum.length
                                          : (reward.datum.length > 3
                                                ? 3
                                                : reward.datum.length),
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          Get.toNamed(
                                            RouteManager.rewardDetailScreen,
                                            arguments: {
                                              "id": reward.datum[index].id,
                                              "title": reward
                                                  .datum[index]
                                                  .rewardTitle
                                                  .toString(),
                                            }, // or any unique identifier
                                          );
                                        },
                                        child: Column(
                                          children: [
                                            SizedBox(height: 5.h),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                top: 10.h,
                                                left: 10.w,
                                                right: 10.w,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        BadgeWidget(
                                                          label:
                                                              "${int.parse(reward.datum[index].visitLeft.toString().replaceAll(".0", ""))} MORE VISITS",
                                                          color: AppColor
                                                              .dynamicColor
                                                              .withAlpha(100),
                                                        ),
                                                        SizedBox(height: 8.h),
                                                        Text(
                                                          reward
                                                              .datum[index]
                                                              .rewardTitle
                                                              .toString(),
                                                          style:
                                                              GoogleFonts.poppins(
                                                                fontSize: 13.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                          overflow: TextOverflow
                                                              .visible,
                                                        ),
                                                        reward
                                                                    .datum[index]
                                                                    .discountAmount !=
                                                                ""
                                                            ? Text(
                                                                "Can convert to \$${reward.datum[index].discountAmount}",
                                                                style: GoogleFonts.poppins(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey
                                                                      .shade300,
                                                                ),
                                                              )
                                                            : SizedBox.shrink(),
                                                      ],
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.lock,
                                                    color: Colors.grey,
                                                    size: 20.w,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            Divider(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    reward.datum.length > 3
                                        ? InkWell(
                                            onTap: () {
                                              reward.show = !reward.show;
                                              controller
                                                  .update(); // make sure this is a GetX controller
                                            },
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
                                                  size: 20,
                                                ),
                                                SizedBox(width: 10.w),
                                              ],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  reward.datum.isEmpty
                      ? SizedBox(height: 108.h)
                      : SizedBox(height: 20.h),
                  CommonReferWidget(),
                  SizedBox(height: 10.h),
                  getBrand(),
                ],
              ),
            ),
    );
  }
}

//TODO: Common Badge Widget
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
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

//TODO: Common Reward Card Widget
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
        margin: EdgeInsets.symmetric(vertical: 5.h),
        width: double.infinity,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BadgeWidget(
                    label: "REDEEM NOW",
                    color: AppColor.dynamicColor,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    maxLines: 2,
                    "$rewardTitle",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(
                Icons.arrow_forward_ios,
                color: AppColor.dynamicColor,
                size: 20.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//TODO: Common Section Title Widget
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
        color: Colors.grey.shade600,
      ),
    );
  }
}

//TODO: Common Text Section Widget
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
