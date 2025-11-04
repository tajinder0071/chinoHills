import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/util/base_services.dart';
import 'package:chino_hills/util/local_stoage.dart';
import 'package:chino_hills/util/route_manager.dart';

import '../../../Model/choose_client_model.dart';

class CompleteProfileController extends GetxController {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxBool isUpdate = false.obs;
  final LocalStorage localStorage = LocalStorage();
  final List<ChooseDatum> chooseList = [];
  bool load = false;

  Future<void> completeUserProfile(String userId, String otp) async {
    isUpdate.value = true;
    String? clientid = await localStorage.getCId();
    print("client id : $clientid");
    update();
    try {
      final map = {
        "user_id": userId,
        "first_name": firstNameController.text.trim(),
        "last_name": lastNameController.text.trim(),
        "email": emailController.text.trim(),
        "birth_date": dobController.text.trim(),
        "client_id": clientid,
      };
      final response = await hitUserCompleteProfileAPI(map);
      if (response['success'] == true) {
        _saveUserData(response['data']);
        update();
        if (response['reward'] == true) {
          if (otp.isNotEmpty) {
            Get.offAllNamed(RouteManager.rewardUnlockedScreen, parameters: {
              "client_id": clientid ?? "",
            });
          } else {
            Get.offAllNamed(RouteManager.rewardUnlockedScreen,
                arguments: response['data']['user_id']);
          }
        } else {
          Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
        }
      }
    } catch (e) {
      Get.log(e.toString());
    } finally {
      isUpdate.value = false;
      update();
    }
  }

  void _saveUserData(Map<String, dynamic> data) {
    localStorage.saveData("user_uuid", data['user_id'].toString());
    localStorage.saveData("user_name", "${data['first_name']} ${data['last_name']}");
    localStorage.saveData("email", data['email']);
    localStorage.saveData("last_name", data['last_name']);
    localStorage.saveData("first_name", data['first_name']);
  }

  Future<void> selectClient(String id, String? userId) async {
    load = true;
    chooseList.clear();
    update();
    try {
      final response = await hitSelectClient(id);
      chooseList.addAll(response.data ?? []);
      // localStorage.saveData("client_id", id);
      load = false;
      update();
      getDetails(userId: userId);
    } catch (e) {
      load = false;
      update();
      Get.log(e.toString());
    }
  }

  void getDetails({String? userId}) {
    final ChooseDatum? datum = chooseList.isNotEmpty ? chooseList.first : null;
    if (datum == null) return;
    firstNameController.text = datum.firstName ?? "";
    lastNameController.text = datum.lastName ?? "";
    emailController.text = datum.userEmail ?? "";
    dobController.text = datum.birthday ?? "";
    update();
  }
}
