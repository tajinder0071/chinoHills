import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/util/local_stoage.dart';
import 'package:chino_hills/util/route_manager.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/base_services.dart';

class LoginController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool isAlreadyRegister = false.obs;
  RxBool isChecked = false.obs;
  GlobalKey<FormState> formKey = GlobalKey();
  LocalStorage nLocalStorage = LocalStorage();

  Future<void> loginUser(context) async {
    isLoading.value = true;
    String cleanedPhoneNumber =
        phoneController.text.replaceAll(RegExp(r'\D'), '');
    if (cleanedPhoneNumber.length < 10) {
      isLoading.value = false;
      update();
      Get.snackbar(
        'Invalid Phone Number',
        'Phone number must be at least 10 digits.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    Get.log("The Phone Number : $cleanedPhoneNumber");
    Map<String, dynamic> loginMap = {
      "phone_number": int.parse(cleanedPhoneNumber),
      "device_id": _appHash.toString()
    };
    Map<String, dynamic> registerMap = {
      "phone_number": int.parse(cleanedPhoneNumber),
      "privacy_Check": isChecked.value == true ? 1 : 0,
      "device_id": _appHash.toString()
    };
    update();
    try {
      Get.log("Map : ${isChecked.value ? registerMap : loginMap}");
      var response = await hiLoginAPI(isChecked.value ? registerMap : loginMap);
      Get.log("Coming Response :${response['success']}");
      //!This is For the User Login
      if (response['success'] == true) {
        isChecked.value
            ? nLocalStorage.saveData("isNewUser", true)
            : nLocalStorage.saveData("isNewUser", false);
        Get.toNamed(RouteManager.otpVerificationPage, parameters: {
          "phoneNumber": cleanedPhoneNumber,
        });

        isLoading.value = false;
        formKey.currentState?.reset();
        phoneController.clear();

        isAlreadyRegister.value = false;
        isChecked.value = false;
        update();
      } else {
        //!This is For the User Register..
        isAlreadyRegister.value = true;
        // showMessage("User not found. Please register first.", context);
        Get.log("${response['message']}");
        isLoading.value = false;
        update();
      }
    } on Exception catch (exception) {
      isLoading.value = false;
      Get.log("Exception : ${exception.toString()}");
      update();
    }
  }

  //! Open the TermOfServices....
  void openTermOfServices() async {
    //! Open Terms
    final Uri url = Uri.parse("https://myrepeat.com/terms.html");
    Future.delayed(const Duration(seconds: 1), () async {
      await launchUrl(url, mode: LaunchMode.inAppWebView);
    });
  }

// ✅ Get app hash and send to backend
  String _appHash = "";

  Future<void> fetchAndSendAppHash() async {
    try {
      _appHash = await SmsAutoFill().getAppSignature;
      debugPrint("🔐 App Signature Hash: $_appHash");
    } catch (e) {
      debugPrint("❌ Error getting app hash: $e");
    }
  }
}
//add condition such the phone number should not be less then 10 digits
