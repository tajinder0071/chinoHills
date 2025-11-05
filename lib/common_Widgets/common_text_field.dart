import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import '../CSS/color.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool isDateField;
  var formate;
  final GestureTapCallback? onTap;
  final Iterable<String>? autofillHints;
  final FormFieldValidator<String>? validator;
  final String text;
  final TextInputType? keyboardType;

  CommonTextField({
    super.key,
    required this.controller,
    required this.formate,
    required this.text,
    required this.autofillHints,
    required this.validator,
    required this.keyboardType,
    required this.isDateField,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: formate,
      style: AppTypography.hostGroteskRegular.copyWith(
        fontSize: 14.sp,
        color: AppColor().blackColor,
      ),
      decoration: InputDecoration(
        hintText: text,
        hintStyle: AppTypography.hostGroteskRegular.copyWith(
            fontSize: 14.sp, color: AppColor().blackColor.withOpacity(.5)),
        filled: true,
        fillColor: AppColor().mediumGreyColor.withOpacity(.1),
        // light background
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r), // rounded corners
          borderSide: BorderSide.none, // no border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColor.dynamicColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColor().redColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColor().redColor, width: 1.5),
        ),
        suffixIcon: isDateField
            ? Icon(Icons.calendar_today, color: AppColor().greyColor)
            : null,
      ),
      onTap: onTap,
      autofillHints: autofillHints,
      validator: validator,
    );
  }
}
