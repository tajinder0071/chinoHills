import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CSS/color.dart';
import '../../../common_Widgets/common_button_widget.dart';

class OfferAppliedPage extends StatelessWidget {
  final VoidCallback onTapShop, onTapCart;
  final String promoTitle; // Add this field

  const OfferAppliedPage(
    this.promoTitle, {
    super.key,
    required this.onTapShop,
    required this.onTapCart,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 5.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: 10.h),
            Icon(Icons.local_offer_outlined, size: 30.h),
            SizedBox(height: 10.h),
            Text(
              "Offer applied to cart!",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: EdgeInsets.all(16.h),
              child: Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          promoTitle, // Use correct variable
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text("has been applied to your cart."),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            CommonButtonWidget(
              onTap: onTapCart,
              buttonName: "Continue to cart",
            ),
            SizedBox(height: 16.h),
            TextButton(
              onPressed: onTapShop,
              child: Text(
                "Explore shop",
                style: GoogleFonts.roboto(
                  color: AppColor.dynamicColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            SizedBox(height: 10.0.h),
          ],
        ),
      ),
    );
  }
}
