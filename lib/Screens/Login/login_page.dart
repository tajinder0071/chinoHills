import 'package:chino_hills/Screens/Login/widgets/feature_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../CSS/color.dart';
import '../../common_Widgets/phone_number_firmate.dart';
import '../../util/common_page.dart';
import 'controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    loginController.fetchAndSendAppHash();

    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Top Image
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Logos all-08.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // White Rounded Container with Shadow
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.r),
                    topRight: Radius.circular(50.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 5,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Form(
                  key: loginController.formKey,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        "Can we get your number?",
                        style: GoogleFonts.sarabun(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Enter your phone number below to create your account or login.",
                        style: GoogleFonts.sarabun(
                          color: AppColor().greyColor,
                          fontSize: 14.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 25.h),

                      // Phone Input Field
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: loginController.phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [PhoneNumberFormatter()],
                        maxLength: 14,
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor().greyColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppColor().greyColor),
                          ),
                          labelText: "Phone Number",
                          labelStyle: GoogleFonts.sarabun(),
                          fillColor: AppColor().whiteColor,
                          filled: true,
                        ),
                        autofillHints: [AutofillHints.telephoneNumber],
                        validator: (val) {
                          String cleaned = val!.replaceAll(RegExp(r'\D'), '');
                          if (cleaned.isEmpty) {
                            return 'Please enter phone number';
                          } else if (cleaned.length < 10) {
                            return 'Please enter a complete phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      loginController.isAlreadyRegister.value
                          ? SizedBox.shrink()
                          : SizedBox(
                              width: 300.h,
                              height: 50.h,
                              child: ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : () {
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          FocusScope.of(context).unfocus();
                                          controller.loginUser(context);
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  padding: EdgeInsets.zero,
                                  backgroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.white,
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColor.dynamicColor,
                                        AppColor.dynamicColor,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: controller.isLoading.value
                                        ? CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            "Log in or Sign up",
                                            style: GoogleFonts.sarabun(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),

                      // Already Registered Extra Options
                      loginController.isAlreadyRegister.value
                          ? Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: loginController.isChecked.value,
                                      checkColor: Colors.white,
                                      fillColor: WidgetStateProperty.all<Color>(
                                        loginController.isChecked.value
                                            ? AppColor.dynamicColor
                                            : Colors.white,
                                      ),
                                      onChanged: (value) {
                                        loginController.isChecked.value =
                                            value!;
                                        loginController.update();
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        "By signing up, you agree to receive automated promotional text messages. Message & data rates may apply. Reply STOP to opt out. Consent isn’t required for purchase.",
                                        style: GoogleFonts.sarabun(
                                          color: AppColor().blackColor,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),

                                // Submit Button
                                Container(
                                  width: double.infinity,
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    gradient: loginController.isChecked.value
                                        ? LinearGradient(
                                            colors: [
                                              AppColor.dynamicColor,
                                              AppColor.dynamicColor,
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          )
                                        : null,
                                    color: loginController.isChecked.value
                                        ? null
                                        : Colors.grey.shade400,
                                  ),
                                  child: ElevatedButton(
                                    onPressed: loginController.isChecked.value
                                        ? () {
                                            controller.loginUser(context);
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      disabledBackgroundColor:
                                          Colors.transparent,
                                      overlayColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                      ),
                                    ),
                                    child: controller.isLoading.value
                                        ? Center(
                                            child: commonLoader(
                                              color: AppColor().whiteColor,
                                            ),
                                          )
                                        : Text(
                                            "Send verification code",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: AppColor().whiteColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "By selecting you agree you have read and accepted our",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13.sp,
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      // controller.openTermOfServices();
                                    },
                                    child: Text(
                                      "Terms of service",
                                      style: TextStyle(
                                        color: AppColor.dynamicColor,
                                        fontSize: 13.sp,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),

                      SizedBox(height: 15.h),

                      // Features Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: [
                            FeatureItemWidget(
                              text: "Free reward for new members!",
                              icon: Bootstrap.star,
                            ),
                            FeatureItemWidget(
                              text: "Earn rewards for visits & purchases",
                              icon: Bootstrap.gift,
                            ),
                            FeatureItemWidget(
                              text: "Free birthday gifts",
                              icon: Bootstrap.cake,
                            ),
                            FeatureItemWidget(
                              text: "Member only offers & events",
                              icon: AntDesign.credit_card_outline,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Bottom branding bar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade200],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getBrand(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
