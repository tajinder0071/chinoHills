import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import 'package:chino_hills/common_Widgets/common_text_field.dart';
import 'package:chino_hills/util/common_page.dart';
import '../../../CSS/appTypography.dart';
import '../../../CSS/color.dart';
import '../../../common_Widgets/phone_number_firmate.dart';
import '../../../loading/account_detail_loader.dart';
import '../controller/account_detail_controller.dart';

class AccountDetail extends GetView<AccountDetailController> {
  const AccountDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: CommonAppBar(title: "Account Detail"),
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
                            style: AppTypography.hostGroteskSemiBold
                                .copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          CommonTextField(
                              controller: controller.firstNameController,
                              formate: [AllowAllCharactersFormatter()],
                              text: "First Name",
                              autofillHints: [AutofillHints.name],
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter First Name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              isDateField: false),
                          SizedBox(height: 8.h),
                          Text(
                            "LastName",
                            style: AppTypography.hostGroteskSemiBold
                                .copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          CommonTextField(
                              controller: controller.lastNameController,
                              formate: [AllowAllCharactersFormatter()],
                              text: "Last Name",
                              autofillHints: [AutofillHints.name],
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Last Name';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              isDateField: false),
                          SizedBox(height: 8.h),
                          Text(
                            "Phone Number",
                            style: AppTypography.hostGroteskSemiBold
                                .copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          CommonTextField(
                              controller: controller.phoneController,
                              formate: [PhoneNumberFormatter()],
                              text: "Phone Number",
                              autofillHints: [AutofillHints.telephoneNumber],
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Phone Number';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                              isDateField: false),
                          SizedBox(height: 8.h),
                          Text(
                            "Date of Birth",
                            style: AppTypography.hostGroteskSemiBold
                                .copyWith(fontSize: 14.sp),
                          ),
                          SizedBox(height: 8.h),
                          CommonTextField(
                              controller: controller.dobController,
                              formate: [AllowAllCharactersFormatter()],
                              text: "Date of Birth",
                              autofillHints: [AutofillHints.birthday],
                              onTap: () => controller.selectDate(context),
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Date of Birth';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.datetime,
                              isDateField: true),
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
                                          style: AppTypography
                                              .galanoGrostesqueSemiBold
                                              .copyWith(
                                                  color: AppColor().background,
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
