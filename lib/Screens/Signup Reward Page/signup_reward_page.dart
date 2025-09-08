import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import '../../CSS/color.dart';
import '../../common_Widgets/common_button_widget.dart';
import '../../util/route_manager.dart';
import 'controller/signup_reward_controller.dart';

class RewardUnlockedScreen extends StatelessWidget {
  RewardUnlockedScreen({super.key, required this.client_id});

  //controller call
  RewardUnlockedController controller = Get.put(RewardUnlockedController());
  var client_id;

  @override
  Widget build(BuildContext context) {
    controller.getRewardAPI(client_id);
    return GetBuilder<RewardUnlockedController>(builder: (controller) {
      return Scaffold(
        backgroundColor: AppColor().background,
        body: Stack(
          children: [
            // 🎆 Lottie Animation (Reward Blast)
            if (controller.showRewardCard.value)
              Positioned.fill(
                child: Lottie.asset(
                  "assets/lottie/Animation-blast.json",
                  repeat: false,
                  fit: BoxFit.cover,
                ),
              ),
            Positioned(
              bottom: 20.h,
              left: 20.w,
              right: 20.w,
              child: SafeArea(
                  bottom: true,
                  child: CommonButtonWidget(
                      onTap: () {
                        Get.offAllNamed(RouteManager.referFriendPage,
                            arguments: controller.rewardPoints);
                      },
                      buttonName: "REWARD UNLOCKED!")),
            ),
            controller.rewardData.isEmpty
                ? Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundColor: AppColor().whiteColor,
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        // I want here to show Icons opne gift icon
                        opacity:
                        controller.showRewardCard.value ? 1.0 : 0.5,
                        child: Icon(
                            controller.showRewardCard.value
                                ? Bootstrap.gift
                                : Iconsax.gift_outline,
                            size: 50.h,
                            color: AppColor.dynamicColor),
                      ),
                    ),

                    SizedBox(height: 50.h),
                    Text(
                      "No reward available yet.",
                      style: TextStyle(
                          fontSize: 24.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      " Tap next to get started and earn towards your first reward!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 30.h),

                    // 🟢 Next Button
                  ],
                ),
              ),
            )
                : Column(
              children: [
                SizedBox(height: 80.h),

                // 🎁 Gift Icon
                CircleAvatar(
                  radius: 40.r,
                  backgroundColor: AppColor().whiteColor,
                  child: AnimatedOpacity(
                    duration: Duration(milliseconds: 500),
                    // I want here to show Icons opne gift icon
                    opacity: controller.showRewardCard.value ? 1.0 : 0.5,
                    child: Icon(
                        controller.showRewardCard.value
                            ? Bootstrap.gift
                            : Iconsax.gift_outline,
                        size: 50.h,
                        color: AppColor.dynamicColor),
                  ),
                ),

                SizedBox(height: 20.h),

                // 🎖 Reward Container
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  padding: EdgeInsets.all(15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        controller.showRewardCard.value
                            ? "1 Reward Unlocked!"
                            : "Account created!",
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        controller.showRewardCard.value
                            ? "Congratulations on unlocking your first reward! Tap next to get started."
                            : "Tap next to get started and earn towards your first reward!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14.sp, color: Colors.black87),
                      ),
                      SizedBox(height: 30.h),
                      // 🔵 Progress Bar
                      Container(
                        height: 6.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.grey.shade300,
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: controller.sliderValue.value,
                          child: Container(
                            height: 6.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                gradient: AppColor.dynamicButtonColor),
                          ),
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // 🎉 Reward Card
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 800),
                        opacity:
                        controller.showRewardCard.value ? 1.0 : 0.0,
                        child: Transform.scale(
                          scale:
                          controller.showRewardCard.value ? 1.0 : 0.8,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 5,
                                  offset: Offset(0, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.dynamicColor,
                                    borderRadius:
                                    BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    "REWARD UNLOCKED!",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${controller.rewardData.first.rewardTitle ?? ''}",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
