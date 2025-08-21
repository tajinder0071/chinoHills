import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../binding/otp_binding.dart';
import '../../../util/base_services.dart';
import '../../../util/services.dart';
import '../../Otp Page/otp_verification_page.dart';

class RegisterController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  GlobalKey<FormState> key = GlobalKey();
  RxBool isLoading = false.obs;
  var dob = "".obs;

  Future<void> registerUser(context) async {
    isLoading.value = true;
    Map<String, dynamic> map = {
      "phone_number": int.parse(phoneController.text),
      "first_name": firstNameController.text.trim(),
      "last_name":
          lastNameController.text.isEmpty ? "" : lastNameController.text.trim(),
      "birthday_date": dob.toString()
    };
    update();
    try {
      Get.log("Register Map : $map");
      var response = await hiRegisterAPI(map);
      if (response['success'] == true) {
        Get.to(OtpVerificationPage(phoneNumber: phoneController.text),
            binding: OTPBindings(),
            duration: Duration(milliseconds: 500),
            transition: Transition.zoom);
        isLoading.value = false;
        phoneController.clear();
        update();
      } else {
        showMessage(response['message'], context);
        isLoading.value = false;
        update();
      }
    } on Exception catch (exception) {
      isLoading.value = false;
      Get.log("Exception : ${exception.toString()}");
      update();
    }
  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      dob.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      dobController.text = dob.value;
    }
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }
}
