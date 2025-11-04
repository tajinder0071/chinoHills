import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/image_page.dart';
import 'package:chino_hills/common_Widgets/phone_number_firmate.dart';
import '../../CSS/app_strings.dart';
import '../../CSS/color.dart';
import '../../common_Widgets/common_button_widget.dart';
import '../../common_Widgets/common_text_field.dart';
import 'controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    loginController.fetchAndSendAppHash();
    return GetBuilder<LoginController>(
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
                child: ListView(
                  children: [
                    // Top Image
                    Padding(
                      padding: EdgeInsets.all(30.h),
                      child: Center(
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                top: -125.h,
                                right: -40.w,
                                child: Image.asset(
                                  AppImages.login_design,
                                )),
                            Positioned(
                              top: 40.h,
                              left: -30.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  AppImages.image2,
                                  height: 227.17.h,
                                  width: 194.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30.h,
                              right: -30.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  AppImages.image3,
                                  height: 227.17.h,
                                  width: 194.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                AppImages.image1,
                                height: 230.h,
                                width: 194.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: loginController.formKey,
                      child: Column(
                        children: [
                          // Texts
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 40.h),
                            child: Column(
                              children: [
                                Text(
                                  AppStrings.getNumberText.toUpperCase(),
                                  textAlign: TextAlign.center,
                                  style: AppTypography.galanoGrostesqueSemiBold
                                      .copyWith(
                                          fontSize: 30.sp,
                                          color: AppColor().blackColor,
                                          letterSpacing: 1,
                                          height: 1.0),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  AppStrings.enterPhoneNumberText,
                                  textAlign: TextAlign.center,
                                  style:
                                      AppTypography.hostGroteskRegular.copyWith(
                                    fontSize: 16.sp,
                                    letterSpacing: 0.5,
                                    color: AppColor().blackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Input + Button
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 40.h),
                            child: Column(
                              children: [
                                // Phone Field
                                CommonTextField(
                                  controller: loginController.phoneController,
                                  text: AppStrings.phoneNumberText,
                                  autofillHints: [
                                    AutofillHints.telephoneNumber
                                  ],
                                  validator: (val) {
                                    String cleaned =
                                        val!.replaceAll(RegExp(r'\D'), '');
                                    if (cleaned.isEmpty) {
                                      return AppStrings
                                          .enterPhoneNumberHintText;
                                    } else if (cleaned.length < 10) {
                                      return AppStrings
                                          .enterCompletePhoneNumberHintText;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  formate: [PhoneNumberFormatter()],
                                  isDateField: false,
                                ),
                                SizedBox(height: 20.h),
                                // Button
                                controller.isAlreadyRegister.value
                                    ? SizedBox.shrink()
                                    : CommonButtonWidget(
                                        innerColor: AppColor.dynamicColor,
                                        onTap: controller.isLoading.value
                                            ? null
                                            : () {
                                                if (controller
                                                    .formKey.currentState!
                                                    .validate()) {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  controller.loginUser(context);
                                                }
                                              },
                                        buttonName: AppStrings.loginSignupText,
                                        isLoading: controller.isLoading.value,
                                        width: 232.w,
                                      ),
                                controller.isAlreadyRegister.value
                                    ? Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Checkbox(
                                                value:
                                                    controller.isChecked.value,
                                                checkColor: Colors.white,
                                                fillColor: WidgetStateProperty
                                                    .all<Color>(
                                                  controller.isChecked.value
                                                      ? AppColor.dynamicColor
                                                      : Colors.white,
                                                ),
                                                onChanged: (value) {
                                                  controller.isChecked.value =
                                                      value!;
                                                  controller.update();
                                                },
                                              ),
                                              Expanded(
                                                child: Text(
                                                  AppStrings.bySignupAgreeText,
                                                  style: AppTypography
                                                      .hostGroteskRegular
                                                      .copyWith(
                                                    color:
                                                        AppColor().blackColor,
                                                    fontSize: 15.sp,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10.h),
                                          CommonButtonWidget(
                                            innerColor: AppColor.dynamicColor,
                                            onTap: controller.isChecked.value
                                                ? () {
                                                    controller
                                                        .loginUser(context);
                                                  }
                                                : null,
                                            buttonName: AppStrings.sendCodeText,
                                            isLoading:
                                                controller.isLoading.value,
                                            width: 232.w,
                                          ),
                                        ],
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
