import 'dart:io';
import 'package:chino_hills/Screens/shop/Pages/Browse/widgets/our_services_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/treartmentDetailsBinding.dart';
import '../../../../common_Widgets/common_refer_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../Dashboard/Home/widget/become_a_member.dart';
import '../../../Dashboard/Home/widget/best_selling_widget.dart';
import '../../../Dashboard/Home/widget/special_offers_widget.dart';
import '../../controller/shop_controller.dart';
import '../Package Page/controller/package_cotroller.dart';
import '../Treatment Page/widgets/treatment_details_page.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        init: Get.find<PackageController>()
          ..getBrowserData()
          ..getOurServices(),
        builder: (shopController) {
          return shopController.isBrowserLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: ListView(
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        color: AppColor().whiteColor,
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 200.h,
                        child: BecomeAMemberLoading(),
                      ),
                      SizedBox(height: 20.h),
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        color: AppColor().whiteColor,
                      ),
                    ],
                  ))
              : ListView(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => TreatmentDetailsPage(),
                            binding: TreatmentDetailsBinding(),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 500),
                            arguments: shopController.browserData.isEmpty
                                ? 0
                                : shopController.browserData[0]
                                    ['browse_service']);
                      },
                      child: Stack(
                        children: [
                          Image.network(
                            shopController.browserData.isEmpty
                                ? "https://www.shutterstock.com/image-photo/concentrated-millennial-girl-sit-on-600nw-2473271475.jpg"
                                : "${shopController.browserData[0]['browse_header_image_cloudUrl']}",
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.contain,
                            errorBuilder: (context, url, error) {
                              return Container(
                                clipBehavior: Clip.antiAlias,
                                height: 280.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: Center(child: Icon(Icons.error)),
                              );
                            },
                            loadingBuilder: (BuildContext ctx, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) {
                                return child; // Return the fully loaded image
                              }
                              return SizedBox(
                                height: 280.h,
                                width: double.infinity,
                                child: Center(
                                  child: Platform.isAndroid
                                      ? Center(
                                          child: commonLoader(
                                              color: AppColor().background))
                                      : CupertinoActivityIndicator(
                                          color: AppColor().blueColor,
                                        ),
                                ),
                              );
                            },
                            height: 280.h,
                            width: double.infinity,
                          ),
                          Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: AppColor().black80.withOpacity(.15),
                              )),
                          Positioned(
                              child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 20.h),
                                Text(
                                  shopController.browserData.isEmpty
                                      ? ""
                                      : "${shopController.browserData[0]['main_header']}",
                                  style: GoogleFonts.merriweather(
                                      fontSize: 30.sp,
                                      color: AppColor().whiteColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 120.h),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 20.w,
                                      right: 20.w,
                                      top: 5.h,
                                      bottom: 5.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                          color: AppColor().whiteColor,
                                          width: 2)),
                                  child: Text(
                                    "Shop Now",
                                    style: GoogleFonts.poppins(
                                        color: AppColor().whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.sp),
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    //? TODO ?? Become a member Part
                    GetBuilder<ShopController>(builder: (shopController) {
                      return BecomeAMember(
                        onPressed: () {
                          shopController.goToTab(1);
                        },
                      );
                    }),
                    //Todo ??  Section is for BestSelling ...
                    GetBuilder<ShopController>(builder: (shopController) {
                      return (shopController.package.isEmpty &&
                              shopController.treatment.isEmpty)
                          ? SizedBox.shrink()
                          : BestSellingWidget(
                              onBrowseByConcernOnTap: () {},
                            );
                    }),

                    //? TODO?  our services section is here...
                    shopController.ourServicesData.isEmpty
                        ? SizedBox.shrink()
                        : OurServicesPage(),

                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.help_outline,
                              color: AppColor.dynamicColor, size: 28.sp),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "BROWSE BY CONCERN",
                            style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.dynamicColor),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Not sure which\ntreatment to choose?",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.merriweather(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Find the best options for you in just a few clicks.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          InkWell(
                            onTap: () {
                              ShopController.shop.goToTab(4);
                            },
                            child: SizedBox(
                              width: double.infinity,
                              height: 40.h,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    // color: AppColor.dynamicColor,
                                    color: AppColor.dynamicColor,
                                    borderRadius: BorderRadius.circular(5.h)),
                                child: Text(
                                  "Browse by Concern",
                                  style: GoogleFonts.poppins(
                                      color: AppColor().whiteColor,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // TODO >>  Special Offers
                    GetBuilder<ShopController>(builder: (controller) {
                      return controller.specialDataList.isNotEmpty
                          ? SpecialOffersWidget(
                              discoverMoreTap: () {}, isShowAll: false)
                          : SizedBox.shrink();
                    }),
                    CommonReferWidget(),
                    SizedBox(height: 10.h),
                    getBrand(),
                    SizedBox(height: 5.h),
                  ],
                );
        });
  }
}
