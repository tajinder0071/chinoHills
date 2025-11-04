import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/CSS/image_page.dart';
import 'package:chino_hills/Screens/Complete%20Profile/controller/complete_profile_controller.dart';
import '../../common_Widgets/common_button_widget.dart';
import '../../common_Widgets/common_text_field.dart';
import '../../common_Widgets/phone_number_firmate.dart';

class CompleteProfile extends GetView<CompleteProfileController> {
  var userId, otp;
  var id;

  CompleteProfile({
    super.key,
    required this.userId,
    required this.otp,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().whiteColor,
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        top: -95.h,
                        right: -60.w,
                        child: Image.asset(AppImages.completeProfile)),
                    Image.asset(AppImages.imageLogo)
                  ],
                ),
                SizedBox(height: 50.h),

                // Title
                Text(
                  "COMPLETE\nYOUR PROFILE",
                  textAlign: TextAlign.center,
                  style: AppTypography.galanoGrostesqueSemiBold
                      .copyWith(fontSize: 30.sp, height: 1.h),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Tell Us A Bit More About Yourself",
                  textAlign: TextAlign.center,
                  style: AppTypography.hostGroteskRegular.copyWith(
                    fontSize: 16.sp,
                    color: AppColor().blackColor,
                  ),
                ),
                SizedBox(height: 30.h),

                // First + Last Name
                Row(
                  children: [
                    Expanded(
                      child: CommonTextField(
                        controller: controller.firstNameController,
                        text: "First Name",
                        autofillHints: [AutofillHints.name],
                        validator: (value) =>
                            value!.isEmpty ? "First name is required" : null,
                        keyboardType: TextInputType.name,
                        formate: [AllowAllCharactersFormatter()],
                        isDateField: false,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CommonTextField(
                        controller: controller.lastNameController,
                        text: "Last Name",
                        autofillHints: [AutofillHints.name],
                        validator: (value) =>
                            value!.isEmpty ? "Last name is required" : null,
                        keyboardType: TextInputType.name,
                        formate: [AllowAllCharactersFormatter()],
                        isDateField: false,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),

                // Email
                CommonTextField(
                  controller: controller.emailController,
                  text: "Email Address",
                  autofillHints: [AutofillHints.email],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  formate: [EmailInputFormatter()],
                  isDateField: false,
                ),
                SizedBox(height: 15.h),

                // Date of Birth
                CommonTextField(
                  controller: controller.dobController,
                  text: "Date of birth (optional)",
                  autofillHints: [AutofillHints.name],
                  validator: (val) {},
                  keyboardType: TextInputType.text,
                  formate: [AllowAllCharactersFormatter()],
                  isDateField: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      controller.dobController.text =
                          "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                    }
                  },
                ),

                SizedBox(height: 50.h),

                Obx(() => CommonButtonWidget(
                      innerColor: AppColor.dynamicColor,
                      onTap: controller.isUpdate.value
                          ? null
                          : () {
                              if (controller.formKey.currentState!.validate()) {
                                userId = userId.toString();

                                controller.completeUserProfile(userId, otp);
                              }
                            },
                      buttonName: 'Submit',
                      isLoading: controller.isUpdate.value,
                      width: 232.w,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
