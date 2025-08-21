import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CSS/color.dart';
import '../../../Model/offer_list_model.dart';
import '../../../common_Widgets/cacheNetworkImage.dart';
import '../../../util/common_page.dart';

class OfferDetail extends StatelessWidget {
  OfferDetail(this.offerData, {super.key});

  Datum offerData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(isLeading: true, title: 'Learn More', action: []),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstantNetworkImage(
              isLoad: true,
              boxFit: BoxFit.contain,
              imageUrl:
                  CommonPage().image_url + offerData.offerimage.toString(),
              height: 300.h,
              width: double.infinity,
            ),
            SizedBox(height: 10.h),
            Divider(color: AppColor().blackColor),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offerData.title.toString(),
                    style: GoogleFonts.sarabun(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    offerData.headline.toString(),
                    style: GoogleFonts.sarabun(
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "Description",
                    style: GoogleFonts.sarabun(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    offerData.description.toString(),
                    style: GoogleFonts.sarabun(
                      fontSize: 16.sp,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
