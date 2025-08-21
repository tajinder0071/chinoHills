import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../CSS/color.dart';
import '../../CSS/image_page.dart';
import '../../util/common_page.dart';
import 'controller/complete_profile_controller.dart';

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
    controller.selectClient(id, userId);
    return Scaffold(
      backgroundColor: AppColor().background,
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: ListView(
            children: [
              //todo App Logo
              Center(
                child:
                    Image.asset(AppImages.imageLogo, width: 80.w, height: 80.h),
              ),
              SizedBox(height: 5.h),

              //todo Title
              Center(
                child: Text(
                  "Complete your profile",
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5.h),

              // Subtitle
              Center(
                  child: Text("Tell us a bit more about yourself",
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey))),
              SizedBox(height: 24.h),

              //todo First Name & Last Name Fields
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      label: "First Name",
                      controller: controller.firstNameController,
                      validator: (value) =>
                          value!.isEmpty ? "First name is required" : null,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildTextField(
                      label: "Last Name",
                      controller: controller.lastNameController,
                      validator: (value) =>
                          value!.isEmpty ? "Last name is required" : null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              // Email Field
              _buildTextField(
                label: "Email Address",
                controller: controller.emailController,
                isEmail: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email is required";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10.h),

              // Date of Birth Field
              GestureDetector(
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
                child: AbsorbPointer(
                  child: _buildTextField(
                    label: "Date of birth (optional)",
                    controller: controller.dobController,
                    isDateField: true,
                  ),
                ),
              ),
              SizedBox(height: 5.h),

              Text(
                "You’ll get a bday gift!",
                style: TextStyle(fontSize: 14.sp, color: AppColor().black80),
              ),
              SizedBox(height: 24.h),

              // Complete Profile Button
              Obx(
                () => Container(
                  width: double.infinity,
                  height: 50.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    gradient: LinearGradient(
                      colors: [
                        AppColor.dynamicColor,
                        AppColor.dynamicColor.withAlpha(400),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        userId = controller.chooseList.isNotEmpty
                            ? controller.chooseList[0].userId
                            : userId;

                        controller.completeUserProfile(userId, otp);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      overlayColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: controller.isUpdate.value
                        ? Center(child: commonLoader(color: Colors.white))
                        : Text(
                            "Complete profile",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor().whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    bool isEmail = false,
    bool isDateField = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: isDateField
                ? Icon(Icons.info_outline, color: Colors.grey)
                : null,
          ),
          validator: validator,
        ),
      ],
    );
  }
}

// Custom Wave Shape
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.w, size.height - 60.h); // Start from the left bottom
    path.quadraticBezierTo(
        size.width / 4.w, size.height, size.width / 2.w, size.height - 40.h);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height - 80.h, size.width, size.height - 40.h);
    path.lineTo(size.width, 0.h); // Top right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
