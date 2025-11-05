import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/color.dart';

class RewardBankedScreen extends StatelessWidget {
  const RewardBankedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().whiteColor,
      appBar: AppBar(
        title: Text("Wallet"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 220.h,
            decoration: BoxDecoration(color: AppColor().blackColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "REWARD BANKED!",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "\$25 Towards Any Service",
                  style: GoogleFonts.merriweather(
                      color: Colors.white,
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: double.infinity,
              height: 80.h,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(6.r)),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: GoogleFonts.roboto(
                      color: AppColor().blackColor,
                      fontSize: 22.sp,
                    ),
                    children: [
                      const TextSpan(text: "Banked for "),
                      TextSpan(
                        text: "\$25",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: " cash"),
                    ],
                  ),
                ),
              )

            ),
          )
        ],
      ),
    );
  }
}
