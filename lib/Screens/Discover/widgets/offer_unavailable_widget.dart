import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CSS/color.dart';
import '../../../common_Widgets/common_button_widget.dart';

class OfferUnavailablePage extends StatelessWidget {
  final VoidCallback onTapShop;

  const OfferUnavailablePage({super.key, required this.onTapShop});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 5.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "This offer cannot be redeemed yet.",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              "You can redeem it once you have at least one valid item in your cart – shop now to add to your cart and redeem this offer!",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 16.sp,
                color: AppColor().black80,
              ),
            ),
            SizedBox(height: 20.h),
            CommonButtonWidget(onTap: onTapShop, buttonName: "Shop Now"),
            SizedBox(height: 15.0.h),
          ],
        ),
      ),
    );
  }
}
