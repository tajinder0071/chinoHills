import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/package_details_binding.dart';
import '../../../../binding/treartmentDetailsBinding.dart';
import '../../../../util/common_page.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../../shop/Pages/Treatment Page/widgets/related_package.dart';
import '../../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../../../shop/controller/shop_controller.dart';

class BestSellingWidget extends StatelessWidget {
  //TODO:Variables are declared here
  final bool isEnable;
  final VoidCallback onBrowseByConcernOnTap;

  //TODO: Constructor with optional isEnable parameter
  const BestSellingWidget(
      {super.key, this.isEnable = false, required this.onBrowseByConcernOnTap});

  //TODO: Page begins here.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: isEnable
          ? AppColor().greyColor.withValues(alpha: 0.1)
          : AppColor().whiteColor,
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
          //TODO: Horizontal Scroll Cards
          _buildServiceList(context),
          //TODO: Explore all services section
          // SizedBox(height: 20.h),
          isEnable
              ? _buildExploreAllServices(onBrowseByConcernOnTap)
              : SizedBox.shrink(),
          SizedBox(height: isEnable ? 24.h : 0.0),
        ],
      ),
    );
  }

  //TODO: Widget to build the title section
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

  //TODO: Widget for the subtitle when isEnable is true
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

  // TODO: Handle error cases when the list of packages and treatments is empty
  Widget _buildServiceList(context) {
    return GetBuilder<ShopController>(
      builder: (controller) {
        final totalItems =
            controller.package.length + controller.treatment.length;

        return SizedBox(
          height: isTablet(context)
              ? MediaQuery.of(context).size.height * 0.4
              : MediaQuery.of(context).size.height < 812
                  ? MediaQuery.of(context).size.height * 0.357
                  : MediaQuery.of(context).size.height * 0.34,
          child: ListView.separated(
            padding: EdgeInsets.only(left: 15.w, right: 15.w),
            scrollDirection: Axis.horizontal,
            itemCount: totalItems,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            itemBuilder: (ctx, index) {
              if (index < controller.package.length) {
                final pkg = controller.package[index];
                final imageUrl =
                    (pkg.packageImages == null || pkg.packageImages!.isEmpty)
                        ? "assets/images/placeholder.png"
                        : "${pkg.packageImages![0]}";

                return RelatedPackageCard(
                  imageUrl: imageUrl,
                  title: pkg.packageName ?? "No title",
                  originalPrice: pkg.pricing ?? 0,
                  memberPrice: pkg.membershipFinalPrice?.toString() ?? "0.0",
                  discount: pkg.rewards?.toString() ?? "0",
                  name: "Package",
                  onTap: () {
                    Get.to(
                      () => PackageDetailPage(sectionName: "Package"),
                      arguments: pkg.packageId,
                      binding: PackageDetailsBinding(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                );
              } else {
                final treatIndex = index - controller.package.length;
                final treat = controller.treatment[treatIndex];
                final imageUrl = (treat.treatmentImagePaths == null ||
                        treat.treatmentImagePaths!.isEmpty)
                    ? "assets/images/placeholder.png"
                    : "${treat.treatmentImagePaths![0]}";

                return RelatedPackageCard(
                  imageUrl: imageUrl,
                  title: treat.treatmentName ?? "No title",
                  originalPrice: treat.price ?? 0,
                  memberPrice: treat.membershipPrice ?? 0,
                  discount: treat.reward.toString() ?? "0",
                  name: "Treatment",
                  onTap: () {
                    Get.to(
                      () => TreatmentDetailsPage(),
                      arguments: treat.id,
                      binding: TreatmentDetailsBinding(),
                      transition: Transition.fadeIn,
                      duration: const Duration(milliseconds: 500),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  //TODO: Widget to show the "Explore all services" section
  Widget _buildExploreAllServices(VoidCallback onBrowseByConcernOnTap) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => onBrowseByConcernOnTap(),
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
