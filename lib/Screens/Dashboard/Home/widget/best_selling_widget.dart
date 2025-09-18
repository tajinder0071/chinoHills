import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/common_horizontal_list.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../util/common_page.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../../../shop/controller/shop_controller.dart';
import '../../../../Model/home_model.dart';

class BestSellingWidget extends StatelessWidget {
  final bool isEnable;
  final VoidCallback onBrowseByConcernOnTap;

  BestSellingWidget({
    super.key,
    this.isEnable = false,
    required this.onBrowseByConcernOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isEnable
          ? AppColor().greyColor.withValues(alpha: 0.1)
          : AppColor().whiteColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Column(
                children: [
                  _buildTitle(),
                  SizedBox(height: 8.h),
                  isEnable ? _buildSubtitle() : SizedBox.shrink(),
                  SizedBox(height: isEnable ? 16.h : 5.0),
                ],
              ),
            ),
            _buildServiceList(context),
            isEnable
                ? _buildExploreAllServices(onBrowseByConcernOnTap)
                : SizedBox.shrink(),
            SizedBox(height: isEnable ? 24.h : 0.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Icon(
          Icons.star_border_rounded,
          color: AppColor.dynamicColor,
          size: 30.h,
        ),
        SizedBox(height: 10.h),
        Text(
          isEnable
              ? "EXPLORE OUR BEST–SELLING SERVICES"
              : "best-selling services".toUpperCase(),
          style: GoogleFonts.roboto(
            color: AppColor.dynamicColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Text(
        "Your favorite treatments and expertly curated packages—all in one place.",
        style: TextStyle(color: Colors.grey.shade700, fontSize: 14.sp),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildServiceList(BuildContext context) {
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
          return SizedBox.shrink();
        }

        return SizedBox(
          height: isTablet(context)
              ? MediaQuery.of(context).size.height * .38
              : MediaQuery.of(context).size.height < 812
              ? MediaQuery.of(context).size.height * .36
              : 273.h,
          child: CommonHorizontalList(
            items: bestSellingList,
            itemBuilder: (context, data, index) => _buildOfferCard(
              data.itemImage,
              data.itemName,
              '',
              () {
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
              memberPrice: data.membershipOfferPrice.toString(),
              type: data.itemType.toString(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOfferCard(
    imageUrl,
    title,
    var daysLeft,
    VoidCallback onTapDetails, {
    required originalPrice,
    required String memberPrice,
    required String type,
  }) {
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
        child: Column(
          children: [
            // TODO >> Image...
            CommonNetworkImageWidget(
              imageUrl: imageUrl.toString(),
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
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    margin: EdgeInsets.only(left: 5.w),
                    decoration: BoxDecoration(
                      color: AppColor.dynamicColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      type.toUpperCase(),
                      style: GoogleFonts.roboto(
                        color: AppColor.dynamicColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: Text(
                      title.toString().replaceAll(
                        title.toString()[0],
                        title.toString()[0].toUpperCase(),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          originalPrice.toString(),
                          style: GoogleFonts.roboto(
                            color: AppColor().blackColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
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
                                child: Row(
                                  children: [
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          memberPrice.toString(),
                                          style: GoogleFonts.roboto(
                                            color: AppColor().blackColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text("Member"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        Icon(Icons.arrow_forward_ios_sharp),
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

  Widget _buildExploreAllServices(VoidCallback onBrowseByConcernOnTap) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: onBrowseByConcernOnTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(8),
              minimumSize: Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Explore all services",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.dynamicColor,
                  ),
                ),
                SizedBox(width: 6.w),
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
