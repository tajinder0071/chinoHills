import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../CSS/color.dart';
import '../../../binding/package_details_binding.dart';
import '../../../binding/treartmentDetailsBinding.dart';
import '../../../loading/reward_load.dart';
import '../../../util/common_page.dart';
import '../../../util/route_manager.dart';
import '../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../controller/reward_details_controller.dart';

class RewardDetailScreen extends StatelessWidget {
  final dynamic id;
  final dynamic title;

  const RewardDetailScreen({super.key, required this.id, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(isLeading: true, title: "Rewards", action: []),
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
                        //Todo ??  This is Reward Section....
                        RewardHeaderWidget(title: title ?? "Reward Details"),

                        //!? Treatment Section
                        GetBuilder<RewardDetailsController>(
                          builder: (builder) {
                            // Build a combined list with section labels
                            List<Map<String, dynamic>> combined = [];

                            if (dController.treatmentsList.isNotEmpty) {
                              combined.add({
                                'type': 'header',
                                'title': 'Treatments',
                              });
                              combined.addAll(
                                dController.treatmentsList.map(
                                  (e) => {
                                    'type': 'item',
                                    'data': e,
                                    'section':
                                        'Treatments', // attach section tag here
                                  },
                                ),
                              );
                            }
                            if (dController.packagesList.isNotEmpty) {
                              combined
                                  .add({'type': 'header', 'title': 'Packages'});
                              combined.addAll(
                                dController.packagesList.map(
                                  (e) => {
                                    'type': 'item',
                                    'data': e,
                                    'section': 'Packages',
                                  },
                                ),
                              );
                            }
                            if (dController.membersList.isNotEmpty) {
                              combined
                                  .add({'type': 'header', 'title': 'Members'});
                              combined.addAll(
                                dController.membersList.map(
                                  (e) => {
                                    'type': 'item',
                                    'data': e,
                                    'section': 'Members',
                                  },
                                ),
                              );
                            }

                            if (combined.isEmpty) {
                              return SizedBox.shrink();
                            }

                            int visibleCount =
                                dController.showMore ? combined.length : 6;
                            List<Map<String, dynamic>> visibleItems =
                                combined.take(visibleCount).toList();

                            return Container(
                              margin: EdgeInsets.all(10.0.h),
                              decoration: BoxDecoration(
                                color: AppColor.geryBackGroundColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10.0.h),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Iconsax.gift_outline,
                                          color: AppColor.dynamicColor,
                                          size: 25.sp,
                                        ),
                                        SizedBox(width: 15.w),
                                        Expanded(
                                          child: Text(
                                            "Apply this reward in cart to receive \$${dController.rewardPoints} off when you purchase at least one of the following services in-app:",
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ...visibleItems.map((entry) {
                                    if (entry['type'] == 'header') {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          top: 10.h,
                                          bottom: 5.h,
                                          left: 10.w,
                                        ),
                                        child: Text(
                                          entry['title'],
                                          style: GoogleFonts.roboto(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      );
                                    } else {
                                      var item = entry['data'];
                                      var section = entry['section'];

                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 5.h,
                                          horizontal: 15.w,
                                        ),
                                        child: InkWell(
                                          overlayColor: WidgetStatePropertyAll(
                                              AppColor().transparent),
                                          onTap: () {
                                            if (section == 'Treatments') {
                                              Get.to(
                                                () => TreatmentDetailsPage(),
                                                binding:
                                                    TreatmentDetailsBinding(),
                                                arguments: item.id,
                                                transition: Transition.fadeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                              );
                                            } else if (section == 'Packages') {
                                              // Navigate to Package Details
                                              Get.log("ok :${item.id}");
                                              Get.to(
                                                () => PackageDetailPage(
                                                  sectionName: "Package",
                                                ),
                                                arguments: item.id,
                                                binding:
                                                    PackageDetailsBinding(),
                                                transition: Transition.fadeIn,
                                                duration:
                                                    Duration(milliseconds: 500),
                                              );
                                            } else if (section == 'Members') {
                                              // Navigate to Membership Details
                                              Get.toNamed(
                                                RouteManager
                                                    .membersShipDetailsPage,
                                                arguments: item.id,
                                                parameters: {"onlyShow": "0"},
                                              );
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text.rich(
                                                  TextSpan(children: [
                                                    TextSpan(
                                                      text: "• ",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14.sp,
                                                              color: AppColor()
                                                                  .blackColor),
                                                    ),
                                                    TextSpan(
                                                      text: "${item.name}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14.sp,
                                                              color: AppColor()
                                                                  .blackColor),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    if (section ==
                                                        'Treatments') {
                                                      Get.to(
                                                        () =>
                                                            TreatmentDetailsPage(),
                                                        binding:
                                                            TreatmentDetailsBinding(),
                                                        arguments: item.id,
                                                        transition:
                                                            Transition.fadeIn,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                      );
                                                    } else if (section ==
                                                        'Packages') {
                                                      // Navigate to Package Details
                                                      Get.log("ok :${item.id}");
                                                      Get.to(
                                                        () => PackageDetailPage(
                                                          sectionName:
                                                              "Package",
                                                        ),
                                                        arguments: item.id,
                                                        binding:
                                                            PackageDetailsBinding(),
                                                        transition:
                                                            Transition.fadeIn,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                      );
                                                    } else if (section ==
                                                        'Members') {
                                                      // Navigate to Membership Details
                                                      Get.toNamed(
                                                        RouteManager
                                                            .membersShipDetailsPage,
                                                        arguments: item.id,
                                                        parameters: {
                                                          "onlyShow": "0"
                                                        },
                                                      );
                                                    }
                                                  },
                                                  icon: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 16,
                                                      color: AppColor
                                                          .dynamicColor))
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                  SizedBox(height: 10.0.h),

                                  // Show More / Hide Rewards
                                  if (combined.length > 6)
                                    InkWell(
                                      onTap: () {
                                        dController.showMore =
                                            !dController.showMore;
                                        dController.update();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.0.w,
                                        ),
                                        height: 45.0.h,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.1),
                                          borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(10.0.r),
                                          ),
                                          boxShadow: dController.showMore
                                              ? []
                                              : [
                                                  BoxShadow(
                                                    offset: Offset(0, -3),
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 1.0,
                                                    blurRadius: 2.0,
                                                  ),
                                                ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              dController.showMore
                                                  ? "Show less"
                                                  : "Show more ",
                                              style: GoogleFonts.merriweather(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17,
                                                  color: AppColor.dynamicColor),
                                            ),
                                            Icon(
                                              dController.showMore
                                                  ? Icons
                                                      .keyboard_arrow_up_outlined
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

                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.h,
                            vertical: 10.h,
                          ),
                          child: Column(
                            spacing: 10.h,
                            children: [
                              Text(
                                "\$${dController.rewardPoints} saving applies to your total purchase amount, not per individual item.",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                              Text(
                                "This reward can only be used once.",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 20.h,
        child: Center(
          child: Text(
            'Powered by: Scanacart™ Technology',
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
}

class RewardHeaderWidget extends StatelessWidget {
  RewardHeaderWidget({super.key, required this.title});

  var title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.dynamicColor,
            AppColor.dynamicColor.withAlpha(150),
            AppColor.dynamicColor,
          ],
          stops: [0.0, 0.3, 4.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.card_giftcard,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 10),
          Text(
            "REWARD UNLOCKED!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
