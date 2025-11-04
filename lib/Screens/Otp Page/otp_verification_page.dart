import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/CSS/image_page.dart';
import 'package:chino_hills/Screens/Otp%20Page/controller/otp_verification_controller.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import 'package:pinput/pinput.dart';
import '../../CSS/appTypography.dart';
import '../../CSS/app_strings.dart';

class OtpVerificationPage extends GetView<OTPController> {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: CommonAppBar(title: ""),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24.h,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Lottie.asset(AppImages.loginAnimation,
                    repeat: true, height: 250.h),
                SizedBox(height: 20.h),
                Text(AppStrings.enterCode,
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 25.sp,
                    )),
                SizedBox(height: 20.h),
                Text(
                  "${AppStrings.verificationSentToPhone} ${'X' * (phoneNumber.length - 7)}-${'X' * (phoneNumber.length - 7)}-${phoneNumber.substring(phoneNumber.length - 4)}",
                  style: AppTypography.hostGroteskRegular
                      .copyWith(color: AppColor().blackColor, fontSize: 15.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25.h),
                Form(
                  key: controller.formKey,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.fillOtp;
                        } else if (value.length != 6) {
                          return AppStrings.otpIsSixDigits;
                        }
                        return null;
                      },
                      onTap: () async {},
                      controller: controller.pinController,
                      scrollPadding: const EdgeInsets.only(bottom: 30),
                      focusNode: controller.focusNode,
                      defaultPinTheme: controller.defaultPinTheme,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      length: 6,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (value) {
                        if (controller.formKey.currentState!.validate()) {
                          controller.enterOtp(phoneNumber,
                              controller.pinController.text, context);
                        }
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 9.h),
                            width: 22.w,
                            height: 1.h,
                            color: AppColor().blueColor,
                          )
                        ],
                      ),
                      focusedPinTheme: controller.defaultPinTheme.copyWith(
                        decoration:
                            controller.defaultPinTheme.decoration?.copyWith(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColor.dynamicColor),
                        ),
                      ),
                      submittedPinTheme: controller.defaultPinTheme.copyWith(
                        decoration:
                            controller.defaultPinTheme.decoration?.copyWith(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(19.r),
                          border: Border.all(color: AppColor.dynamicColor),
                        ),
                      ),
                      errorPinTheme: controller.defaultPinTheme.copyBorderWith(
                        border: Border.all(
                          color: Colors.redAccent,
                          width: 1.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
