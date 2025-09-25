import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/common_horizontal_list.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../../../shop/controller/shop_controller.dart';
import '../../../../Model/home_model.dart';

class BestSellingWidget extends StatelessWidget {
  final bool isEnable;
  final VoidCallback exploreAllServiceOnTap;
  final VoidCallback onTap;
  final bool showExploreAllService;

  const BestSellingWidget({
    super.key,
    this.isEnable = false,
    required this.exploreAllServiceOnTap,
    required this.onTap,
    this.showExploreAllService = true
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * .02),
          Center(
            child: Column(
              children: [
                _buildTitle(size),
                SizedBox(height: size.height * .02),
                isEnable ? _buildSubtitle(size) : SizedBox.shrink(),
                SizedBox(height: size.height * .01),
              ],
            ),
          ),
          _buildServiceList(context, size),
          showExploreAllService? _buildExploreAllServices(exploreAllServiceOnTap, size):SizedBox.shrink(),
          SizedBox(height: size.height * .01),
        ],
      ),
    );
  }

  // there is no backend developer available to work on the backend api

  Widget _buildTitle(Size size) {
    return Column(
      children: [
        Icon(
          Icons.star_border_rounded,
          color: AppColor.dynamicColor,
          size: size.height * .04,
        ),
        SizedBox(height: size.height * .02),
        Text(
          isEnable
              ? "EXPLORE OUR BEST–SELLING SERVICES"
              : "best-selling services".toUpperCase(),
          style: GoogleFonts.roboto(
            color: AppColor.dynamicColor,
            fontSize: size.height * .025,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSubtitle(Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .1),
      child: Text(
        AppStrings.favTreatmentMessage,
        style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildServiceList(BuildContext context, Size size) {
    return GetBuilder<ShopController>(
      builder: (controller) {
        // Collect all best-selling items from HomeDatum
        List<BestSelling> bestSellingList = [];
        for (var homeDatum in controller.homeData) {
          if (homeDatum.bestSelling != null) {
            bestSellingList.addAll(homeDatum.bestSelling!);
          }
        }

        if (bestSellingList.isEmpty) {
          print(
              "${bestSellingList.any((e) => e.itemType != null && e.itemType.toString().isNotEmpty) ? size.height * .34 : size.height * .2}");
          return SizedBox(
            height: size.height * .2,
            child: Center(
              child: Text(
                AppStrings.noBestSellingText,
                style: TextStyle(color: Colors.grey, fontSize: 14.sp),
              ),
            ),
          );
        }

        return SizedBox(
          height: (bestSellingList.any((e) =>
          e.itemType != null && e.itemType.toString().isNotEmpty))
              ? size.height * .36
              : size.height * .2,
          child: CommonHorizontalList(
            items: bestSellingList,
            itemBuilder: (context, data, index) =>
                _buildOfferCard(data.itemImage, data.itemName, '', () {
                  if (data.itemType?.toLowerCase() == "treatments") {
                    Get.to(
                          () => TreatmentDetailsPage(),
                      arguments: data.itemId,
                      binding: CommonBinding(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  } else {
                    Get.to(
                          () => PackageDetailPage(sectionName: "Package"),
                      arguments: data.itemId,
                      binding: CommonBinding(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  }
                },
                    originalPrice: data.itemPrice,
                    memberPrice: data.membershipOfferPrice?.toString() ?? "",
                    type: data.itemType.toString(),
                    size: size),
          ),
        );
      },
    );
  }

  Widget _buildOfferCard(
      imageUrl, title, var daysLeft, VoidCallback onTapDetails,
      {required originalPrice,
        required String memberPrice,
        required String type,
        required Size size}) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: () => onTapDetails(),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * .001, horizontal: size.width * .002),
        width: size.height * .24,
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
        child: Column(
          children: [
            // TODO >> Image...
            CommonNetworkImageWidget(
              imageUrl: "${imageUrl.toString()}",
              height: 140.0.h,
              width: double.infinity,
              borderRadius: BorderRadius.vertical(top: Radius.circular(6.0.r)),
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
                horizontal: 6.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: AppColor.dynamicColor
                      .withOpacity(.1),
                  borderRadius:
                  BorderRadius.circular(5.r),
                ),
                child: Text(
                  type.toUpperCase(),
                  style: GoogleFonts.roboto(
                    color: AppColor.dynamicColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 10.sp,
                  ),
                ),
                            ),
              ),
                  SizedBox(height: 10.h),
                  SizedBox(
                      height: 50,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          title.toString().replaceAll(title.toString()[0],
                              title.toString()[0].toUpperCase()),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.merriweather(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${originalPrice.toString()}",
                          style: GoogleFonts.roboto(
                              color: AppColor().blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 10.w),
                        memberPrice.toString() == '\$0.00'
                            ? SizedBox.shrink()
                            : Container(
                          height: 20.h,
                          width: 2.w,
                          color: AppColor().blackColor,
                        ),
                        memberPrice.toString() == '\$0.00'
                            ? SizedBox.shrink()
                            : Expanded(
                          child: Column(
                            children: [
                              Text(
                                "${memberPrice.toString()}",
                                style: GoogleFonts.roboto(
                                    color: AppColor().blackColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Member"),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_sharp)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreAllServices(
      VoidCallback onBrowseByConcernOnTap, Size size) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: onBrowseByConcernOnTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(size.height * .015),
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.exploreAllService,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.dynamicColor,
                  ),
                ),
                SizedBox(width: size.width * .01),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.dynamicColor,
                  size: 14.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
