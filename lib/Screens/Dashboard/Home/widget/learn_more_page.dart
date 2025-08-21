import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../../CSS/color.dart';
import '../../../../Model/discover_model.dart';
import '../../../../binding/package_details_binding.dart';
import '../../../../binding/treartmentDetailsBinding.dart';
import '../../../../common_Widgets/cacheNetworkImage.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../util/common_page.dart';
import '../../../../../util/local_store_data.dart';
import '../../../../util/route_manager.dart';
import '../../../Discover/controller/discover_controller.dart';
import '../../../Discover/widgets/offer_applied_widget.dart';
import '../../../Discover/widgets/offer_unavailable_widget.dart';
import '../../../Reward/controller/reward_details_controller.dart';
import '../../../cartList/Controller/cart_controller.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../../../shop/controller/shop_controller.dart';

class LearnMorePage extends StatelessWidget {
  final bool isExpire;
  final ContentCard? cardData;
  final OfferCard? offerCard;

  const LearnMorePage({
    super.key,
    this.isExpire = false,
    this.cardData,
    this.offerCard,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    cartController.cartList();

    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(isLeading: true, title: "Learn More", action: []),
      body: isExpire
          ? ListView(
              children: [
                //TODO >>  Image And Expire Section
                SizedBox(
                  height: 220.h,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // TODO >> Image
                      CommonNetworkImageWidget(
                        imageUrl: (offerCard?.offerimage ?? ''),
                        height: 200.h,
                        width: double.infinity,
                        borderRadius: BorderRadius.zero,
                        fit: BoxFit.cover,
                        // boxFit: BoxFit.cover,
                      ),
                      // TODO >>  Expires badge on top
                      /*Positioned(
                        top: 10.h,
                        left: 15.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FadeTransition(
                                opacity:
                                    Get.find<ShopController>().blinkAnimation,
                                child: ScaleTransition(
                                  scale:
                                      Get.find<ShopController>().scaleAnimation,
                                  child: Container(
                                    width: 8.w,
                                    height: 8.w,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              // Text(
                              //   'Expire in ${getTimeDifference(offerCard!.endDate.toString())}',
                              //   style: GoogleFonts.roboto(
                              //     color: Colors.white,
                              //     fontSize: 12.sp,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),*/
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offerCard?.title?.capitalizeFirst ?? '',
                        style: GoogleFonts.roboto(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // TODO: Reusable Text Widget for description content across the app.
                      Text(
                        offerCard?.description ?? "",
                        style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400),
                      ),

                      //. TODO >>
                    ],
                  ),
                ),
                // Display here
                GetBuilder<DiscoverController>(
                    init: Get.put(DiscoverController()),
                    builder: (dController) {
                      final List<ServiceName> membershipServices = (offerCard
                                  ?.serviceName ??
                              [])
                          .where((s) => s.serviceType == ServiceType.MEMBERSHIP)
                          .toList();

                      final List<ServiceName> packageServices = (offerCard
                                  ?.serviceName ??
                              [])
                          .where((s) => s.serviceType == ServiceType.PACKAGE)
                          .toList();

                      final List<ServiceName> treatmentServices = (offerCard
                                  ?.serviceName ??
                              [])
                          .where((s) => s.serviceType == ServiceType.TREATMENT)
                          .toList();
                      print('---- MEMBERSHIP ----');
                      membershipServices.forEach((s) => print(s.serviceName));

                      print('---- PACKAGE ----');
                      packageServices.forEach((s) => print(s.serviceName));

                      print('---- TREATMENT ----');
                      treatmentServices.forEach((s) => print(s.serviceName));
                      // 2. Combine with headers
                      List<Map<String, dynamic>> combined = [];

                      if (membershipServices.isNotEmpty) {
                        combined
                            .add({'type': 'header', 'title': 'Memberships'});
                        combined.addAll(membershipServices.map((e) => {
                              'type': 'item',
                              'data': {
                                'id': e.serviceId,
                                'name': e.serviceName
                              },
                              'section': 'Members',
                            }));
                      }
                      if (packageServices.isNotEmpty) {
                        combined.add({'type': 'header', 'title': 'Packages'});
                        combined.addAll(packageServices.map((e) => {
                              'type': 'item',
                              'data': {
                                'id': e.serviceId,
                                'name': e.serviceName
                              },
                              'section': 'Packages',
                            }));
                      }
                      if (treatmentServices.isNotEmpty) {
                        combined.add({'type': 'header', 'title': 'Treatments'});
                        combined.addAll(treatmentServices.map((e) => {
                              'type': 'item',
                              'data': {
                                'id': e.serviceId,
                                'name': e.serviceName
                              },
                              'section': 'Treatments',
                            }));
                      }

// 3. Split visible + hidden items based on controller state
                      final visibleItems = dController.showMore
                          ? combined
                          : combined.take(6).toList();

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
                                      "Apply this reward at checkout to get a discount on eligible in-app services. Don’t forget to redeem it before it expires!",
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
                                      vertical: 5.h, horizontal: 15.w),
                                  child: InkWell(
                                    overlayColor: WidgetStatePropertyAll(
                                        AppColor().transparent),
                                    onTap: () {
                                      if (section == 'Treatments') {
                                        Get.to(() => TreatmentDetailsPage(),
                                            binding: TreatmentDetailsBinding(),
                                            arguments: item['id'],
                                            transition: Transition.fadeIn,
                                            duration:
                                                Duration(milliseconds: 500));
                                      } else if (section == 'Packages') {
                                        Get.to(
                                            () => PackageDetailPage(
                                                sectionName: "Package"),
                                            arguments: item['id'],
                                            binding: PackageDetailsBinding(),
                                            transition: Transition.fadeIn,
                                            duration:
                                                Duration(milliseconds: 500));
                                      } else if (section == 'Members') {
                                        Get.toNamed(
                                          RouteManager.membersShipDetailsPage,
                                          arguments: item['id'],
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
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14.sp,
                                                    color:
                                                        AppColor().blackColor),
                                              ),
                                              TextSpan(
                                                text: "${item['name']}",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14.sp,
                                                    color:
                                                        AppColor().blackColor),
                                              ),
                                            ]),
                                          ),
                                        ),
                                        Icon(Icons.arrow_forward_ios,
                                            size: 16,
                                            color: AppColor.dynamicColor),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }),
                            SizedBox(height: 10.0.h),
                            if (combined.length > 6)
                              InkWell(
                                onTap: () {
                                  dController.showMore = !dController.showMore;
                                  dController.update();
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0.w),
                                  height: 45.0.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10.0.r),
                                    ),
                                    boxShadow: dController.showMore
                                        ? []
                                        : [
                                            BoxShadow(
                                              offset: Offset(0, -3),
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              spreadRadius: 1.0,
                                              blurRadius: 3.0,
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
                                            : "Show more",
                                        style: GoogleFonts.merriweather(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                            color: AppColor.dynamicColor),
                                      ),
                                      Icon(
                                        dController.showMore
                                            ? Icons.keyboard_arrow_up_outlined
                                            : Icons.keyboard_arrow_down_rounded,
                                        color: AppColor.dynamicColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),

                SizedBox(height: 20.0.h),
                Center(child: Text("This offer can be used multiple times.")),
                SizedBox(height: 10.h),
              ],
            )
          : ListView(
              children: [
                ConstantNetworkImage(
                    isLoad: true,
                    imageUrl:
                        CommonPage().image_url + cardData!.imagePath.toString(),
                    width: double.infinity,
                    height: 200.h,
                    boxFit: BoxFit.cover),
                // Divider(color: AppColor().blackColor),

                Padding(
                  padding: EdgeInsets.only(left: 10.0.w, right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offerCard?.title?.capitalizeFirst ?? '',
                        style: GoogleFonts.merriweather(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        cardData?.title?.capitalizeFirst ?? '',
                        style: GoogleFonts.merriweather(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      // TODO: Reusable Text Widget for description content across the app.
                      Text(
                        cardData!.description.toString(),
                        style: GoogleFonts.roboto(
                            fontSize: 15.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(bottom: 8.h),
        child: isExpire
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: CommonButtonWidget(
                    onTap: offerCard!.isPromoCodeApplied == null
                        ? null
                        : () {
                            final cartController = Get.find<CartController>();
                            var isItemInCart =
                                cartController.cartItemCount.value != 0
                                    ? true
                                    : false;
                            isItemInCart
                                ? Get.find<DiscoverController>().addPromoCode(
                                    offerCard?.promoCode ?? "",
                                    () {
                                      Get.offAllNamed(
                                          RouteManager.dashBoardPage,
                                          arguments: 2);
                                      LocalStorage local = LocalStorage();
                                      local.saveData("shopIndex", 0);
                                    },
                                    context,
                                    treatement: offerCard!.serviceName,
                                  )
                                : showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: false,
                                    backgroundColor: AppColor().whiteColor,
                                    builder: (context) => OfferUnavailablePage(
                                      onTapShop: () {
                                        Get.offAllNamed(
                                            RouteManager.dashBoardPage,
                                            arguments: 2);
                                        LocalStorage local = LocalStorage();
                                        local.saveData("shopIndex", 0);
                                      },
                                    ),
                                  );
                          }, //
                    isDisabled: offerCard?.isPromoCodeApplied ?? false,
                    isOutlineButton: false,
                    buttonName: "Apply offer to cart"),
              )
            : GetBuilder<DiscoverController>(builder: (controller) {
                return InkWell(
                  overlayColor: WidgetStatePropertyAll(AppColor().transparent),
                  onTap: () {
                    // TODO: Ensure that launching URL is handled.
                    controller.launchURL(cardData!.customUrl!);
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0.r),
                        color: AppColor.dynamicColor),
                    width: double.infinity,
                    height: 55.h,
                    alignment: Alignment.center,
                    child: Text(
                      cardData!.customCallToAction!.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.h,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }),
      ),
    );
  }
}
