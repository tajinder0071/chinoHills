import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../CSS/color.dart';
import '../../util/common_page.dart';
import '../../util/services.dart';
import 'controller/otp_verification_controller.dart';

class OtpVerificationPage extends GetView<OTPController> {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(isLeading: true, title: '', action: []),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/lottie/LoginAnimation.json",
                  repeat: true, height: 200.h),
              SizedBox(height: 20.h),
              Text("Enter verification code",
                  style: GoogleFonts.sarabun(
                      fontSize: 22,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 8.h),
              Text(
                "Verification code should have been sent to your phone number ${'X' * (phoneNumber.length - 7)}-${'X' * (phoneNumber.length - 7)}-${phoneNumber.substring(phoneNumber.length - 4)}",
                style: GoogleFonts.sarabun(color: AppColor().greyColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 25.h),
              Form(
                key: controller.formKey,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please fill OTP";
                      }
                      return null;
                    },
                    onTap: () async {},
                    controller: controller.pinController,
                    scrollPadding: const EdgeInsets.only(
                      bottom: 30,
                    ),
                    focusNode: controller.focusNode,
                    defaultPinTheme: controller.defaultPinTheme,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    length: 6,
                    hapticFeedbackType: HapticFeedbackType.lightImpact,
                    onCompleted: (pin) {},
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: AppColor().blueColor,
                        )
                      ],
                    ),
                    focusedPinTheme: controller.defaultPinTheme.copyWith(
                      decoration:
                          controller.defaultPinTheme.decoration?.copyWith(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColor.dynamicColor),
                      ),
                    ),
                    submittedPinTheme: controller.defaultPinTheme.copyWith(
                      decoration:
                          controller.defaultPinTheme.decoration?.copyWith(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(color: AppColor.dynamicColor),
                      ),
                    ),
                    errorPinTheme: controller.defaultPinTheme.copyBorderWith(
                      border: Border.all(
                        color: Colors.redAccent,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: controller.isOtpLoading.value
                          ? () {}
                          : () {
                              if (controller.formKey.currentState!.validate()) {
                                if (controller.pinController.text.length != 6) {
                                  showMessage("Please fill the otp", context);
                                } else {
                                  controller.enterOtp(phoneNumber,
                                      controller.pinController.text, context);
                                }
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        elevation: 0, // 👈 Visible elevation (shadow effect)
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        backgroundColor:
                            Colors.white, // Needed for elevation to show
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.dynamicColor,
                              AppColor.dynamicColor
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: controller.isOtpLoading.value
                            ? Center(
                                child:
                                    commonLoader(color: AppColor().background))
                            : Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
