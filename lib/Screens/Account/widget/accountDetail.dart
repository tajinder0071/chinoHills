import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CSS/color.dart';
import '../../../loading/account_detail_loader.dart';
import '../../../util/common_page.dart';
import '../controller/account_detail_controller.dart';

class AccountDetail extends GetView<AccountDetailController> {
  const AccountDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar:
          commonAppBar(isLeading: true, title: "Account Detail", action: []),
      body: SingleChildScrollView(
        child: Form(
            key: controller.key,
            child: Obx(
              () => Padding(
                padding: EdgeInsets.all(20.h),
                child: controller.isLoading.isTrue
                    ? AccountDetailLoader()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "First Name",
                            style: GoogleFonts.sarabun(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller.firstNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor().greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColor().greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.dynamicColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "First Name",
                              hintStyle: GoogleFonts.sarabun(),
                              fillColor: AppColor().whiteColor,
                              filled: true,
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter First Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "LastName",
                            style: GoogleFonts.sarabun(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller.lastNameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor().greyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor().greyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.dynamicColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Last Name",
                              hintStyle: GoogleFonts.sarabun(),
                              fillColor: AppColor().whiteColor,
                              filled: true,
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Enter Last Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Phone Number",
                            style: GoogleFonts.sarabun(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          TextFormField(
                            readOnly: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            decoration: InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor().greyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor().greyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.dynamicColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Phone Number",
                              hintStyle: GoogleFonts.sarabun(),
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
                          Text(
                            "Date of Birth",
                            style: GoogleFonts.sarabun(
                                fontWeight: FontWeight.w600, fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: controller.dobController,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: () => controller.selectDate(context),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor().greyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColor().greyColor),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.dynamicColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Date of Birth",
                              hintStyle: GoogleFonts.sarabun(),
                              fillColor: AppColor().whiteColor,
                              filled: true,
                            ),
                          ),
                          SizedBox(height: 100.h),
                          Obx(() => InkWell(
                                overlayColor: WidgetStatePropertyAll(
                                    AppColor().transparent),
                                onTap: controller.isUpdate.value
                                    ? () {}
                                    : () {
                                        controller.update();
                                        if (controller.key.currentState!
                                            .validate()) {
                                          FocusScope.of(context).unfocus();
                                          controller.updateUser();
                                        }
                                      },
                                child: Container(
                                  height: 50.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: AppColor.dynamicColor),
                                  child: controller.isUpdate.value
                                      ? Center(
                                          child: commonLoader(
                                              color: AppColor().background))
                                      : Text(
                                          "Update",
                                          style: GoogleFonts.sarabun(
                                              color: AppColor().background,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15.sp),
                                        ),
                                ),
                              ))
                        ],
                      ),
              ),
            )),
      ),
    );
  }
}
