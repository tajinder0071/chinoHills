import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';

class WalletTreatmentDetails extends StatelessWidget {
  const WalletTreatmentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Wallet Treatment Details"),
      backgroundColor: AppColor().whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Image Section ---
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/new_images/nima_logo.png", // Replace with your image asset
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 20.h),

              // --- Title ---
              Center(
                child: Text(
                  "20 GOLD PLATED NEEDLES",
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // --- Purchase Info ---
              Center(
                child: Column(
                  children: [
                    Text(
                      "Purchased October 29, 2025",
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      "Redeemable at all locations",
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "1 of 1 treatment remaining",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[800],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // --- Buttons ---
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    icon: Icon(Icons.qr_code_2, color: Colors.white),
                    label: Text(
                      "Scan in office to redeem",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      side: BorderSide(color: Colors.black, width: 1),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: Text(
                      "Book appointment",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // --- What's Included ---
              Text(
                "What's Included",
                style: GoogleFonts.poppins(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                "An AquaGold Botox® Facial is a superficial micro-needling procedure that deposits hyaluronic acid and fillers like Juvederm® and Botox® into the top layers of the skin to create a smooth texture with reduced pore size. This technique produces a natural-appearing outcome without any tell-tale signs of being injected.",
                style: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  height: 1.6,
                  color: Colors.grey[800],
                ),
              ),

              SizedBox(height: 20.h),

              // --- More Info ---
              GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "More treatment info",
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal[700],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal[700]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // SizedBox(
      //   width: double.infinity,
      //   height: double.infinity,
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: [
      //       Text("Wallet Treatment Details")
      //     ],
      //   ),
      // ),
    );
  }
}
