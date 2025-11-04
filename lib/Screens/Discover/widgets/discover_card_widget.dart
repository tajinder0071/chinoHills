import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/common_Widgets/common_back_and_forward_button.dart';
import 'package:chino_hills/common_Widgets/common_network_image_widget.dart';
import '../../../CSS/color.dart';
import '../../../util/common_page.dart';
import '../../shop/controller/shop_controller.dart';

class CustomCardWidget extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String headline;
  final String ctaText;
  final String? description;
  final VoidCallback onTapCTA;
  final VoidCallback? onTapLearnMore;
  final bool isOffer;
  final String? offerExpiresText;
  bool isOfferApplied;
  final int index;

  CustomCardWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.headline,
    required this.ctaText,
    required this.onTapCTA,
    required this.isOfferApplied,
    this.description,
    this.onTapLearnMore,
    this.isOffer = false,
    this.offerExpiresText,
    required this.index,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();
}

class _CustomCardWidgetState extends State<CustomCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController acontroller;

  @override
  void initState() {
    super.initState();

    // Create an animation controller
    acontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // 🔁 repeat to create blinking effect
  }

  @override
  void dispose() {
    acontroller.dispose();
    super.dispose();
  }

  IconData? getCTAIcon(String text) {
    switch (text.toLowerCase()) {
      case "call now":
        return Iconsax.call;
      case "leave a review":
        return Icons.rate_review_outlined;
      case "book now":
        return Iconsax.calendar;
      case "Learn More":
        return Iconsax.link;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ShopController controller = Get.find();
    //print("offerExpiresText:$offerExpiresText");
    return Container(
      margin: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColor().whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColor().blackColor.withValues(alpha: .2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            // 🔹 Image
            CommonNetworkImageWidget(
              imageUrl: widget.imageUrl,
              height: 220.h,
              width: double.infinity,
              borderRadius: BorderRadius.circular(0),
              fit: BoxFit.cover,
            ),

            // 🔹 Gradient Overlay
            Container(
              width: double.infinity,
              height: 220.h,
              decoration: BoxDecoration(
                color: AppColor().blackColor.withValues(alpha: 0.35),
              ),
            ),

            // 🔹 Offer Expiration Tag
            if (widget.offerExpiresText != null && widget.isOffer)
              Positioned(
                top: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColor().blackColor.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FadeTransition(
                        opacity: acontroller.drive(
                          Tween(begin: 1.0, end: 0.0)
                              .chain(CurveTween(curve: Curves.easeInOut)),
                        ),
                        child: ScaleTransition(
                          scale: acontroller.drive(
                            Tween(begin: 1.0, end: 0.8)
                                .chain(CurveTween(curve: Curves.easeInOut)),
                          ),
                          child: Container(
                            width: 8.w,
                            height: 8.w,
                            decoration:  BoxDecoration(
                              color: AppColor().redColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Expire in ${getTimeDifference(widget.offerExpiresText!)}",
                        style: AppTypography.hostGroteskSemiBold.copyWith(
                          color: AppColor().whiteColor,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // 🔹 Main Text & Button
            Positioned(
              bottom: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 200.w,
                          child: Column(
                            children: [
                              // Title
                              Text(
                                widget.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'GalanoGrotesque-SemiBold',
                                    color: AppColor().whiteColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    height: 1),
                              ),
                              SizedBox(height: 4.h),
                              // Headline
                              Text(
                                widget.headline,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Host Grotesk',
                                  color: AppColor().whiteColor.withValues(alpha: 0.9),
                                  fontSize: 13.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CommonRoundedButton(
                                  onTap: widget.isOfferApplied
                                      ? null
                                      : widget.onTapCTA,
                                  icon:
                                      getCTAIcon(widget.ctaText) ?? Icons.link,
                                ),
                                SizedBox(width: 10.w),
                                CommonForwardButton(
                                  onTap: widget.onTapLearnMore,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
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
