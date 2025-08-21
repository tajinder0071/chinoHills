import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletPage extends StatelessWidget {
  final VoidCallback onShopServicesOnTap;

  const WalletPage({super.key, required this.onShopServicesOnTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Card Section
            Container(
              height: 200.h,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: const DecorationImage(
                  image: AssetImage("assets/images/wallet_image.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: Text(
                        "CH BUCKS",
                        style: GoogleFonts.merriweather(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  // Top Left Amount
                  Positioned(
                    top: 0.h,
                    left: 10.w,
                    child: Text(
                      "\$0.00",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  // Bottom Right "Shop Services"
                  Positioned(
                    bottom: 0.h,
                    right: 10.w,
                    child: InkWell(
                      onTap: () => onShopServicesOnTap(),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Shop Services",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 18.h,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Description Text
            Text(
              "Earn CH BUCKS through rewards by checking in or shopping in the app—then spend it like cash for instant savings!",
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
