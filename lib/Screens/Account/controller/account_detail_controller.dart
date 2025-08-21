import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../CSS/color.dart';
import '../../../util/services.dart';

class AccountDetailController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool isUpdate = false.obs;
  var dob = "".obs;

  GlobalKey<FormState> key = GlobalKey();

  Future getDetail() async {
    isLoading.value = true;
    update();
    try {
      var response = await hitGetProfileDetail();
      print(response);
      phoneController.text = response["data"][0]["phone"];
      // userNameController.text = response["data"][0]["user_name"];
      // List<String> nameParts = userNameController.text.split(' ');
      // lastNameController.text =
      //       //     nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';
      firstNameController.text = response["data"][0]["first_name"];
      lastNameController.text = response["data"][0]["last_name"];

      String rawDate =
          response["data"][0]["birthday"]; // Example: "March, 03 2025 00:00:00"
      try {
        DateTime parsedDate =
            DateFormat("MMMM, dd yyyy HH:mm:ss").parse(rawDate);
        String formattedDate = DateFormat('yyyy-MM-dd').format(parsedDate);

        dob.value = formattedDate;
        dobController.text = dob.value;
      } catch (e) {
        print("Date parsing error: $e");
      }

      isLoading.value = false;
      update();
    } on Exception catch (e) {
      isLoading.value = false;
      update();
      return Exception(e.toString());
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDetail();
  }

  Future updateUser() async {
    LocalStorage localStorage = LocalStorage();
    var userId =await localStorage.getUId();
    isUpdate.value = true;
    update();
    Map<String, dynamic> map = {
      "user_id": userId,
      "phone": phoneController.text,
      "first_name": firstNameController.text.trim(),
      "last_name": lastNameController.text.trim(),
      "birthday_date": dob.toString().trim(),
    };
    try {
      var response = await hitUpdateProviderAPI(map);
      print(response);
      if (response['success'] == true) {
        showMessage("${response['message']}", Get.context!);
        Get.back();
      }
      localStorage.saveData("user_name",
          "${firstNameController.text.trim()} ${lastNameController.text.trim()}");
      isUpdate.value = false;
      update();
    } on Exception catch (e) {
      isUpdate.value = false;
      update();
    }
  }

  void selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
                primary: AppColor.dynamicColor,
                onPrimary: AppColor().whiteColor,
                onSurface: AppColor().blackColor,
                onSecondary: AppColor.dynamicColor),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColor().blackColor,
              ),
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      dob.value = DateFormat('yyyy-MM-dd').format(pickedDate);
      dobController.text = dob.value;
    }
  }
}
