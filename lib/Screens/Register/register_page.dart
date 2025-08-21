import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../CSS/color.dart';
import '../../util/common_page.dart';
import '../../util/route_manager.dart';
import 'controller/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      body: SafeArea(
        child: Form(
          key: controller.key,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: Column(children: [
                SizedBox(height: 50.h),
                Text("Can we get your number?",
                    style: GoogleFonts.sarabun(
                        fontSize: 20.sp, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                SizedBox(height: 8.h),
                Text(
                  "Sign up using your phone number",
                  style: GoogleFonts.sarabun(color: AppColor().greyColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                //! First Name
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor().greyColor)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor().greyColor)),
                    labelText: "First Name",
                    labelStyle: GoogleFonts.sarabun(),
                    fillColor: AppColor().whiteColor,
                    filled: true,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor().greyColor)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor().greyColor)),
                    labelText: "Last Name",
                    labelStyle: GoogleFonts.sarabun(),
                    fillColor: AppColor().whiteColor,
                    filled: true,
                  ),
                  // validator: (val) {
                  //   if (val!.isEmpty) {
                  //     return 'Please enter your last name';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor().greyColor)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColor().greyColor)),
                    labelText: "Phone Number",
                    labelStyle: GoogleFonts.sarabun(),
                    fillColor: AppColor().whiteColor,
                    filled: true,
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 8.h),

                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: controller.dobController,
                    keyboardType: TextInputType.text,
                    readOnly: true,
                    onTap: () => controller.selectDate(context),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor().greyColor)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor().greyColor)),
                      labelText: "Date of Birth",
                      labelStyle: GoogleFonts.sarabun(),
                      fillColor: AppColor().whiteColor,
                      filled: true,
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your Date of Birth';
                      }
                      return null;
                    },
                  ),

                SizedBox(height: 30.h),
                Obx(() => InkWell(
                      onTap: controller.isLoading.value
                          ? () {}
                          : () {
                              if (controller.key.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                controller.registerUser(context);
                              }
                            },
                      child: controller.isLoading.value
                          ? Center(
                          child: commonLoader(
                              color: AppColor().background))
                          : Container(
                              width: 300.h,
                              height: 40.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColor().gradiant1,
                                        AppColor().gradiant2,
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight)),
                              child: Text(
                                "Sign-up",
                                style: GoogleFonts.sarabun(
                                    color: AppColor().background,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
                              ),
                            ),
                    )),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          controller.phoneController.clear();
                          Get.offNamed(RouteManager.loginPage);
                        },
                        child: Text("Login".toUpperCase())),
                  ],
                ),
                SizedBox(height: 10.h),
              ]),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40.h,
        decoration: BoxDecoration(
            // gradient:
            //     LinearGradient(colors: [Color(0xffEFFEFD), Color(0xffDEF2FF)]),
            color: AppColor().background),
        child: Center(
          child: Text(
            'Powered by: Scanacart™ Technology',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor().blueColor,
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
