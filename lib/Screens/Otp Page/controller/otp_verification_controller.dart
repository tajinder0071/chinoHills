// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nima/Screens/Dashboard/dashboard_screen.dart';
// import 'package:nima/util/base_services.dart';
// import 'package:nima/util/local_stoage.dart';
// import 'package:nima/util/route_manager.dart';
// import 'package:nima/util/services.dart';
// import 'dart:async';
//
// import 'package:pinput/pinput.dart';
// import 'package:sms_autofill/sms_autofill.dart';
//
// class OTPController extends GetxController {
//   var otp = List<String>.filled(6, '').obs;
//   var isButtonEnabled = false.obs;
//   var timerSeconds = 60.obs;
//   RxBool isOtpLoading = false.obs;
//   LocalStorage nLocalStorage = LocalStorage();
//
//   Timer? _timer;
//   GlobalKey<FormState> formKey = GlobalKey();
//   TextEditingController pinController = TextEditingController();
//   FocusNode focusNode = FocusNode();
//   var defaultPinTheme = PinTheme();
//
//   final Dio dio = Dio(); // ✅ Dio for sending HTTP requests
//   late String _appHash;
//
//   @override
//   void onInit() {
//     startResendTimer();
//     listenForCode();
//     fetchAndSendAppHash();
//     defaultPinTheme = PinTheme(
//       width: 56,
//       height: 56,
//       textStyle: const TextStyle(fontSize: 22, color: Colors.black),
//       decoration: BoxDecoration(
//           color: Colors.black12,
//           borderRadius: BorderRadius.circular(5),
//           border: Border.all(color: Colors.blue.withOpacity(0.2))),
//     );
//     super.onInit();
//   }
//
//   // OTP Auto fill
//   // ✅ Get app hash and send to backend
//   Future<void> fetchAndSendAppHash() async {
//     try {
//       _appHash = await SmsAutoFill().getAppSignature;
//       debugPrint("🔐 App Signature Hash: $_appHash");
//
//       await sendHashToBackend("your-phone-number"); // Replace dynamically
//     } catch (e) {
//       debugPrint("❌ Error getting app hash: $e");
//     }
//   }
//
//
//   // ✅ Send app hash + phone number to backend
//   Future<void> sendHashToBackend(String phoneNumber) async {
//     try {
//       const String url = "https://your-backend.com/api/sendOtp"; // Replace
//       final body = {
//         "phone_number": phoneNumber,
//         "app_hash": _appHash,
//       };
//       final response = await dio.post(url, data: body);
//       debugPrint("✅ Sent app hash to backend: ${response.data}");
//     } catch (e) {
//       debugPrint("❌ Failed to send hash to backend: $e");
//     }
//   }
//
//
//   void updateOTP(int index, String value) {
//     otp[index] = value;
//     isButtonEnabled.value = otp.length == 6 ? true : false;
//     // isButtonEnabled.value = otp.every((digit) => digit.isNotEmpty);
//   }
//
//   void startResendTimer() {
//     timerSeconds.value = 60;
//     _timer?.cancel();
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       if (timerSeconds.value > 0) {
//         timerSeconds.value--;
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//
//   void resendOTP() {
//     if (timerSeconds.value == 0) {
//       startResendTimer();
//       // Add logic to resend OTP here
//     }
//   }
//
//   //TODO  OTP Verify method....
//   Future<void> enterOtp(phoneNumber, Otp, context) async {
//     isOtpLoading.value = true;
//     Map<String, dynamic> map = {"phone_number": phoneNumber, "otp": Otp};
//     Get.log("VerityOTP map : $map");
//     update();
//     try {
//       var response = await hitOTPApi(phoneNumber, Otp);
//       Get.log("userData: ${response['data']}");
//       // bool newUser = nLocalStorage.readData("isNewUser");
//       if (response['success'] == true) {
//         if (response['data']['profile_status'] == "incompleted") {
//           // nLocalStorage.saveData("user_uuid", response['data']['user_id']);
//           Get.offAllNamed(RouteManager.completeProfile,
//               arguments: response['data']['user_id']);
//         } else {
//           nLocalStorage.saveData("user_uuid", response['data']['user_id']);
//           nLocalStorage.saveData("user_name",
//               "${response['data']['first_name']} ${response['data']['last_name']}");
//           nLocalStorage.saveData(
//               "phone_number", response['data']['phone_number']);
//           Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
//         }
//
//         isOtpLoading.value = false;
//         update();
//       } else {
//         showMessage("Invalid OTP. Please enter correct OTP", context);
//         isOtpLoading.value = false;
//         update();
//       }
//     } on Exception catch (e) {
//       isOtpLoading.value = false;
//       update();
//     }
//   }
//
//   @override
//   void dispose() {
//     SmsAutoFill().unregisterListener();
//     super.dispose();
//     pinController.dispose();
//   }
// }

// Try fir thr OTP..

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:dio/dio.dart';

import '../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';
import '../../../util/services.dart'; // ✅ For backend API call

class OTPController extends GetxController with CodeAutoFill {
  var otp = List<String>.filled(6, '').obs;
  var isButtonEnabled = false.obs;
  var timerSeconds = 60.obs;
  RxBool isOtpLoading = false.obs;
  LocalStorage nLocalStorage = LocalStorage();

  Timer? _timer;
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController pinController = TextEditingController();
  FocusNode focusNode = FocusNode();
  var defaultPinTheme = PinTheme();

  final Dio dio = Dio(); // ✅ Dio for sending HTTP requests

  @override
  void onInit() {
    super.onInit();
    listenForCode();
    startResendTimer();

    defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
    );
  }

  // ✅ Auto-fill handler
  @override
  void codeUpdated() {
    pinController.text = code ?? '';
    update();
  }

  // TODO ?? for auto otp

  // TODO ?? for Auto end otp

  void updateOTP(int index, String value) {
    otp[index] = value;
    isButtonEnabled.value = otp.length == 6;
  }

  void startResendTimer() {
    timerSeconds.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    if (timerSeconds.value == 0) {
      startResendTimer();
    }
  }
  Future<void> enterOtp(phoneNumber, Otp, context) async {
    // Start the loading indicator
    isOtpLoading.value = true;

    // Prepare the request map for logging or API submission
    Map<String, dynamic> map = {"phone_number": phoneNumber, "otp": Otp};
    Get.log("VerityOTP map : $map");

    // Update the UI (if using GetBuilder or similar)
    update();

    try {
      // Call your OTP verification API
      var response = await hitOTPApi(phoneNumber, Otp);
      Get.log("userData: ${response['data']}");

      // Navigate to CompleteProfile page with query parameters
      // Uncomment this block if you want conditional navigation 7543074253
      if (response['success'] == true) {
        if (response['data']['profile_status'] == "incompleted") {
          // Navigate to CompleteProfile screen if profile is not complete
          Get.offAllNamed(
            RouteManager.completeProfile,
            arguments: {
              "userId": response['data']['user_id'] ?? "",
              "otp": Otp,
              "response": "",
            },
          );
        } else {
          // Save user data locally and navigate to dashboard
          nLocalStorage.saveData("user_uuid", response['data']['user_id'].toString());
          nLocalStorage.saveData(
            "user_name",
            "${response['data']['first_name']} ${response['data']['last_name'].toString()}",
          );
          nLocalStorage.saveData(
              "phone_number", response['data']['phone_number'].toString());
          // nLocalStorage.saveData("client_id", response['data']['client_id']);
          nLocalStorage.saveData("first_name", response['data']['first_name'].toString());
          nLocalStorage.saveData("last_name", response['data']['last_name'].toString());
          nLocalStorage.saveData("email", response['data']['email'].toString());
          update();
          // Go to dashboard and pass initial tab index
          // Otp == "123456"
          //     ? Get.offAllNamed(RouteManager.selectClinic, arguments: "false")
          //     : Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
          Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
        }
      } else {
        // Show error if OTP is invalid
        showMessage("Invalid OTP. Please enter correct OTP", context);
      }
    } catch (e) {
      // Show error message on exception
      showMessage("Something went wrong", context);
    } finally {
      // Stop the loading indicator
      isOtpLoading.value = false;
      update();
    }
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    pinController.dispose();
    super.dispose();
  }
}
