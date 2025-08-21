import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CSS/color.dart';
import 'common_agreement_page.dart';

class CommonTermsConditionWidget extends StatelessWidget {
  const CommonTermsConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 15.0.w, vertical: 5.0.h),
      child: Text.rich(
        TextSpan(
            text:
            "View Terms and Conditions and Patient Membership Agreement here"
                .toString(),
            style: GoogleFonts.roboto(
                color: Colors.grey,
                fontSize: 11.0.sp,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: AppColor().greyColor),
            mouseCursor: SystemMouseCursors.click,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                Get.bottomSheet(
                  CommonAgreementPage(),
                  isScrollControlled: true,
                );
              }),
      ),
    );
  }
}
