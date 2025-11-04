import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../CSS/color.dart';
import '../../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../../common_Widgets/price_section_widget.dart';
import '../../../../../util/common_page.dart';

class RelatedPackageCard extends StatelessWidget {
  //TODO: Variable are declared here
  final String imageUrl;
  final String title;
  final dynamic originalPrice;
  final dynamic memberPrice;
  final String discount;
  final VoidCallback onTap;
  final String name;

  RelatedPackageCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.originalPrice,
    required this.memberPrice,
    required this.discount,
    required this.onTap,
    this.name = "Package",
  });

  //TODO: Widgets begins here
  @override
  Widget build(BuildContext context) {
    print("====>${originalPrice},${memberPrice}");
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor().whiteColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(2, 2), blurRadius: 5.r),
            ]),
        width: 200.w,
        margin: EdgeInsets.only(right: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TODO: Image loading and error handling can be moved to a separate widget
            _buildImageSection(),
            // TODO: Discount and Category badge can be a separate reusable widget
            Padding(
              padding: EdgeInsets.all(5.h),
              child: _buildDiscountAndCategoryBadge(),
            ),
            // TODO: Title could be a common widget if used elsewhere in the app
            _buildTitleSection(),
            // TODO: Price display and arrow can be moved to a separate widget
            _buildPriceAndArrowSection(originalPrice, memberPrice),
          ],
        ),
      ),
    );
  }

  //TODO: Widgets ends here

  // TODO: Image Section: Extract image loading logic into a reusable widget
  Widget _buildImageSection() {
    return CommonNetworkImageWidget(
      imageUrl: "${imageUrl.toString()}",
      height: 138.4.h,
      width: double.infinity,
      borderRadius: BorderRadius.vertical(top: Radius.circular(6.0.r)),
      fit: BoxFit.cover,
    );
  }

  // TODO: Create a method for displaying a default error image
  Widget _buildImageError() {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 150.h,
      decoration: BoxDecoration(
        color: AppColor.geryBackGroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0.r)),
      ),
      child: Center(
          child: Image.asset(
        "assets/images/Image_not_available.png",
        color: AppColor().blackColor,
        fit: BoxFit.cover,
      )),
    );
  }

  // TODO: Extract this to a separate badge widget for discount and category
  Widget _buildDiscountAndCategoryBadge() {
    return Row(
      children: [
        if (discount.isNotEmpty && discount != "0") _buildDiscountBadge(),
        if (discount.isNotEmpty && discount != "0") SizedBox(width: 8.w),
        _buildCategoryBadge(),
      ],
    );
  }

  // TODO: Create a reusable discount badge widget
  Widget _buildDiscountBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.dynamicColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        '$discount% OFF',
        style: TextStyle(
            color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  // TODO: Create a reusable category badge widget
  Widget _buildCategoryBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.dynamicColorWithOpacity,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        name,
        style: TextStyle(
            color: AppColor.dynamicColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  // TODO: Title Section - Can be extracted to a reusable widget if used often in your app
  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  // TODO: Price and Arrow Section - Move price and arrow into a separate reusable widget
  Widget _buildPriceAndArrowSection(
    originalPrice,
    memberPrice,
  ) {
    print("object=>${originalPrice}${memberPrice}");
    return PriceSection(
      originalPrice: originalPrice,
      memberPrice: memberPrice,
      onPressed: onTap,
    );
  }
}
