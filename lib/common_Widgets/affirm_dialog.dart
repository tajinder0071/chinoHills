import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/color.dart';

class AffirmDialog extends StatelessWidget {
  final VoidCallback? onShopNowTap;
  final bool isButton;

  AffirmDialog({
    Key? key,
    this.onShopNowTap,
    required this.isButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9, // 90% of screen width
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.70,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close,
                      size: 28.sp,
                      color: Colors.black87,
                    ),
                  ),
                ),
                // Affirm with NIMA logos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.w),
                      child: Image.asset(
                        "assets/images/affirm_logo.png",
                        height: 30.h,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Text(
                      "with",
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Image.asset(
                      "assets/images/app_logo.png", // Your NIMA logo
                      height: 35.h,
                    ),
                  ],
                ),

                SizedBox(height: 15.h),

                // Main heading
                Text(
                  "Treat today. Pay later. Earn rewards.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.merriweather(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 8.h),

                // Steps grid
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildStepCard(
                        icon: Icons.shopping_bag_outlined,
                        stepNumber: "Step 1",
                        description: "Choose your favorite services in 'Shop'",
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: _buildStepCard(
                        iconAsset: "assets/images/affirm_logo.png",
                        stepNumber: "Step 2",
                        description: "Select Affirm at checkout",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildStepCard(
                        icon: Icons.calendar_today_outlined,
                        stepNumber: "Step 3",
                        description:
                            "Get approved and choose the payment plan that suits you",
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: _buildStepCard(
                        icon: Icons.star_outline,
                        stepNumber: "Step 4",
                        description:
                            "Checkout now to treat today, pay later. Earn rewards.",
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                // Shop now button
                isButton == false
                    ? SizedBox.shrink()
                    : InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Navigator.pop(context);
                          if (onShopNowTap != null) {
                            onShopNowTap!();
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Shop now",
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor().blueColor,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.keyboard_arrow_right_outlined,
                              color: AppColor().blueColor,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      ),

                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStepCard({
    IconData? icon,
    String? iconAsset,
    required String stepNumber,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          // Icon
          if (icon != null)
            Icon(
              icon,
              size: 30.sp,
              color: AppColor().mediumGreyColor,
            )
          else if (iconAsset != null)
            Image.asset(
              iconAsset,
              height: 22.h,
            ),

          SizedBox(height: 12.h),

          // Step number
          Text(
            stepNumber,
            style: GoogleFonts.merriweather(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: 8.h),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
