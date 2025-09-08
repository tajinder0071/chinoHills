import 'dart:io';
import 'package:chino_hills/Screens/shop/Pages/Browse/widgets/our_services_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/cart_billing.dart';
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
  BrowsePage({super.key});

  //call shop controller

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        init: Get.find<PackageController>()..getBrowserData(),
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
              : shopController.browseDetailModel.data == null
              ? SizedBox.shrink()
              : ListView(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => TreatmentDetailsPage(),
                      binding: CommonBinding(),
                      transition: Transition.fadeIn,
                      duration: Duration(milliseconds: 500),
                      arguments:
                      shopController.browseDetailModel.data ==
                          null
                          ? 0
                          : shopController.browseDetailModel.data!
                          .headerDetails!.browseServices);
                },
                child: Stack(
                  children: [
                    Image.network(
                      shopController.browseDetailModel.data!
                          .headerDetails ==
                          null
                          ? "https://www.shutterstock.com/image-photo/concentrated-millennial-girl-sit-on-600nw-2473271475.jpg"
                          : "${shopController.browseDetailModel.data!.headerDetails!.headerimage}",
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      errorBuilder: (context, url, error) {
                        return Container(
                          clipBehavior: Clip.antiAlias,
                          height: 280.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius:
                              BorderRadius.circular(8.r)),
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
                                color: AppColor().blueColor),
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
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 20.h),
                              Text(
                                shopController.browseDetailModel.data!
                                    .headerDetails ==
                                    null
                                    ? ""
                                    : "${shopController.browseDetailModel.data!.headerDetails!.mainheader}",
                                style: GoogleFonts.merriweather(
                                    fontSize: 30.sp,
                                    color: AppColor().whiteColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 50.h),
                              Text(
                                shopController.browseDetailModel.data!
                                    .headerDetails ==
                                    null
                                    ? ""
                                    : "${shopController.browseDetailModel.data!.headerDetails!.promotiontitle}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color: AppColor().whiteColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                shopController.browseDetailModel.data!
                                    .headerDetails ==
                                    null
                                    ? ""
                                    : "${shopController.browseDetailModel.data!.headerDetails!.promotiondetails}",
                                style: GoogleFonts.poppins(
                                    fontSize: 16.sp,
                                    color: AppColor().whiteColor,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10.h),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20.w,
                                    right: 20.w,
                                    top: 5.h,
                                    bottom: 5.h),
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(6.r),
                                    border: Border.all(
                                        color: AppColor().whiteColor,
                                        width: 2)),
                                child: Text(
                                  AppStrings.shopNow,
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
                    ShopController.shop
                        .goToTabByName(AppStrings.membership);
                  },
                  data: [],
                  perks: [],
                );
              }),
              //Todo ??  Section is for BestSelling ...
              shopController.browseDetailModel.data == null
                  ? SizedBox.shrink()
                  : shopController.browseDetailModel.data!
                  .bestSelling!.isNotEmpty
                  ? BestSellingWidget(
                onBrowseByConcernOnTap: () {},
              )
                  : SizedBox.shrink(),
              SizedBox(
                height: 10.h,
              ),
              //? TODO?  our services section is here...
              shopController.browseCategory.isEmpty
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
                      AppStrings.browseByConcernInCapital,
                      style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.dynamicColor),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      AppStrings.chooseTreatment,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.merriweather(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      AppStrings.findTheBestOptions,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    InkWell(
                      onTap: () {
                        ShopController.shop.goToTabByName(
                            AppStrings.browseByConcern);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColor.dynamicColor,
                              borderRadius:
                              BorderRadius.circular(5.h)),
                          child: Text(
                            AppStrings.browseByConcernNormal,
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
                return shopController
                    .browseDetailModel.data!.offerCards!.isEmpty
                    ? SizedBox.shrink()
                    : SpecialOffersWidget(
                  discoverMoreTap: () {},
                  isShowAll: false,
                  // offerData: [],
                  offerData: shopController
                      .browseDetailModel.data!.offerCards!,
                );
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
