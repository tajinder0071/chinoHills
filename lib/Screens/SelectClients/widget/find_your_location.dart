import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../util/common_page.dart';
import '../../Account/widget/Search_by_location.dart';

class FindYourLocation extends StatelessWidget {
  const FindYourLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppBar(
          isLeading: true,
          title: "",
          action: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SafeArea(
              child: Column(
                children: [
                  Icon(Icons.location_on_outlined,
                      size: 50.h, color: Colors.black),
                  SizedBox(height: 30.h),
                  Text(
                    "Find your location",
                    style: GoogleFonts.merriweather(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Find your location now tp shop your favorite services,and start earning rewards with every purchase and visit!",
                    style: GoogleFonts.merriweather(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  /*ElevatedButton.icon(
                    onPressed: () {
                      Get.to(ScanQr());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.dynamicColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
                    ),
                    icon: Icon(Icons.qr_code_scanner,
                        color: Colors.white, size: 20.sp),
                    label: Text(
                      "Scan QR Code in location",
                      style: GoogleFonts.merriweather(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                  InkWell(
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    onTap: () {
                      Get.to(SearchByLocation());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      margin:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on_outlined, size: 20.sp),
                          SizedBox(width: 10.w),
                          Text(
                            "Search by location",
                            style: GoogleFonts.merriweather(fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
