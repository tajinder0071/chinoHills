import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../Model/detail_browse_model.dart';
import '../../../../common_Widgets/common_horizontal_list.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/controller/shop_controller.dart';

class SpecialOffersWidget extends StatelessWidget {
  final VoidCallback discoverMoreTap;
  bool isShowAll;
  List<OfferCards>? offerData;

  SpecialOffersWidget({
    super.key,
    required this.discoverMoreTap,
    this.isShowAll = false,
    this.offerData,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      builder: (controller) {
        return Container(
          padding: EdgeInsets.only(top: 25.h, left: 0.w, bottom: 10.0.h),
          width: double.infinity,
          color: AppColor().greyColor.withValues(alpha: 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Todo >> Icons and Text...
              Icon(
                Icons.local_offer_outlined,
                color: AppColor.dynamicColor,
                size: 20.w,
              ),
              SizedBox(height: 8.h),
              Text(
                AppStrings.specialOffer,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.sp,
                  color: AppColor.dynamicColor,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 10.h),
              // Todo >>  Show here the list...
              SizedBox(
                height: isTablet(context)
                    ? MediaQuery.of(context).size.height * .38
                    : MediaQuery.of(context).size.height < 812
                    ? MediaQuery.of(context).size.height * .36
                    : 280.h,
                child: controller.isSpecialOfferLoading
                    ? SizedBox(
                        height: isTablet(context)
                            ? MediaQuery.of(context).size.height * .38
                            : MediaQuery.of(context).size.height < 812
                            ? MediaQuery.of(context).size.height * .36
                            : 280.h,
                        child: BecomeAMemberLoading(),
                      )
                    : offerData!.isEmpty || offerData == null
                    ? CommonHorizontalList(
                        items: offerData!,
                        itemBuilder: (context, data, index) => _buildOfferCard(
                          data.image,
                          data.title,
                          getTimeDifference(data.endDate ?? ""),
                          () {
                            Get.log("Is tapped");
                            Get.toNamed(
                              RouteManager.learnMore,
                              arguments: {
                                "specialOffer": [],
                                "isExpired": true,
                                "cartData": [],
                                "cartDatas": offerData![index],
                                "id": offerData![index].id,
                              },
                            );
                          },
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.only(left: 5.h),
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: offerData!.length,
                        itemBuilder: (context, index) {
                          var data = offerData![index];
                          return _buildOfferCard(
                            data.image,
                            data.title,
                            getTimeDifference(data.endDate ?? ""),
                            () {
                              Get.log("Is tapped");
                              Get.toNamed(
                                RouteManager.learnMore,
                                arguments: {
                                  "specialOffer": data,
                                  "isExpired": true,
                                  "cartData": [],
                                  "id": data.id,
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
              SizedBox(height: 20.h),
              // 364926490
              // Todo >> move to discover sections...
              isShowAll
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: discoverMoreTap,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(8),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Discover more offers",
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColor.dynamicColor,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColor.dynamicColor,
                                size: 15.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(height: isShowAll ? 10.h : 0.0),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOfferCard(
    imageUrl,
    title,
    var daysLeft,
    VoidCallback onTapDetails,
  ) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: () => onTapDetails(),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0.h, horizontal: 7.0.w),
        width: 200.w,
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: AppColor().greyColor,
              blurRadius: 2.r,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                // TODO >> Image...
                CommonNetworkImageWidget(
                  imageUrl: "${imageUrl.toString()}",
                  height: 150.0.h,
                  width: double.infinity,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(6.0.r),
                  ),
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.dynamicColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            'PROMOTION',
                            style: GoogleFonts.roboto(
                              color: AppColor.dynamicColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w),
                          child: Text(
                            title.toString().replaceAll(
                              title.toString()[0],
                              title.toString()[0].toUpperCase(),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.merriweather(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                          top: 5.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'View Offer',
                              style: GoogleFonts.roboto(
                                color: AppColor.dynamicColor,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.dynamicColor,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /// it's rendered **above**
            Positioned(
              top: 8.h,
              left: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FadeTransition(
                      opacity: Get.find<ShopController>().blinkAnimation,
                      child: ScaleTransition(
                        scale: Get.find<ShopController>().scaleAnimation,
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
                    SizedBox(width: 4.w),
                    Text(
                      'Expires in $daysLeft',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
