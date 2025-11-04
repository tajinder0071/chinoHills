import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../CSS/color.dart';
import 'common_agreement_page.dart';

class CommonTermsConditionWidget extends StatelessWidget {
  var isActivated;
  var isneed;
  final ValueChanged<bool?>? onChange;

  CommonTermsConditionWidget(
      {super.key, this.isActivated, this.onChange, this.isneed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isneed!
            ? Checkbox(
                value: isActivated,
                activeColor: AppColor.dynamicColor,
                onChanged: onChange,
              )
            : SizedBox.shrink(),
        Expanded(
          child: Padding(
            padding: isneed ? EdgeInsets.zero : EdgeInsets.all(15.h),
            child: Text.rich(
              textAlign: TextAlign.start,
              TextSpan(
                  text:
                      "View Terms and Conditions and Patient Membership Agreement here"
                          .toString(),
                  style: GoogleFonts.sarabun(
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
          ),
        ),
      ],
    );
  }
}
