import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Model/choose_client_model.dart';
import '../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';

class CompleteProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  RxBool isUpdate = false.obs;
  LocalStorage localStorage = LocalStorage();
  List<ChooseDatum> chooseList = [];

  Future completeUserProfile(userId, otp) async {
    isUpdate.value = true;
    update();

    // Check and assign client_id
    String clientid = await LocalStorage().getCId() ?? "";

    try {
      Map<String, dynamic> map = {
        "user_id": userId,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": emailController.text,
        "birth_date": dobController.text.isEmpty ? "" : dobController.text,
        "client_id": clientid,
      };

      var response = await hitUserCompleteProfileAPI(map);

      if (response['success'] == true) {
        if (response['reward'] == true) {
          // Save user data
          localStorage.saveData(
            "user_uuid",
            response['data']['user_id'].toString(),
          );
          localStorage.saveData(
            "user_name",
            "${response['data']['first_name']} ${response['data']['last_name']}",
          );
          localStorage.saveData("email", response['data']['email'].toString());
          localStorage.saveData(
            "last_name",
            response['data']['last_name'].toString(),
          );
          localStorage.saveData(
            "first_name",
            response['data']['first_name'].toString(),
          ); // corrected
          // localStorage.saveData("client_id", response['data']['client_id'].toString());

          update();

          var clientId = await localStorage.getCId();

          otp.toString() != ""
              ? Get.offAllNamed(
                  RouteManager.rewardUnlockedScreen,
                  parameters: {"client_id": clientId.toString()},
                )
              : Get.offAllNamed(
                  RouteManager.rewardUnlockedScreen,
                  arguments: response['data']['user_id'],
                );
        } else {
          localStorage.saveData(
            "user_uuid",
            response['data']['user_id'].toString(),
          );
          localStorage.saveData(
            "user_name",
            "${response['data']['first_name']} ${response['data']['last_name']}",
          );
          localStorage.saveData("email", response['data']['email'].toString());
          localStorage.saveData(
            "last_name",
            response['data']['last_name'].toString(),
          );
          // localStorage.saveData("client_id", response['data']['client_id'].toString());

          update();
          Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
        }
      }

      isUpdate.value = false;
      update();
    } on Exception catch (e) {
      isUpdate.value = false;
      update();
    }
  }

  var load = false;

  Future<void> selectClient(id, user_id) async {
    load = true;
    chooseList.clear();
    // update();
    try {
      ChooseClientModel response = await hitSelectClient(id);
      chooseList.addAll(response.data!);
      print(response);
      getDetails(userId: user_id);

      //store client id in local storage
      localStorage.saveData("client_id", id.toString());
      load = false;
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }

  void getDetails({required userId}) {
    if (userId == null) {
      userId = chooseList[0].userId ?? "";
    }
    print(userId);
    firstNameController.text = chooseList[0].firstName ?? "";
    lastNameController.text = chooseList[0].lastName ?? "";
    emailController.text = chooseList[0].userEmail ?? "";
    dobController.text = chooseList[0].birthday ?? "";
    update();
  }
}
