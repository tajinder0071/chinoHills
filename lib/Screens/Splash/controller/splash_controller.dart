// controllers/splash_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CSS/color.dart';
import '../../../util/base_services.dart';
import '../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;
  final LocalStorage localStorage = LocalStorage();

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.10, 0.50, curve: Curves.fastOutSlowIn),
      ),
    );
    animationController.forward();
    getUser();
  }

  void navigateNext() async {
    final isUser = await localStorage.getUId();
    if (isUser == null || isUser == "null") {
      Get.offNamed(RouteManager.loginPage);
    } else {
      Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
    }
  }

  RxBool isLoading = false.obs;

  Future<void> getUser() async {
    isLoading.value = true;
    update();
    try {
      var response = await hitUserAPI();
      if (response['success'] == true) {
        if (response['data'] != null) {
          localStorage.saveData(
              "client_id", response['data'][0]['client_id'].toString());
          String hex = response['data'][0]['themeColor'].toString().replaceAll(
            '#',
            '',
          );
          isLoading.value = false;
          if (hex.length == 6) hex = 'FF$hex';
          Color dynamicColor = Color(int.parse(hex, radix: 16));
          AppColor.dynamicColor = dynamicColor;
          print(AppColor.dynamicColor);

          navigateNext();
        }
        update();
      } else {
        isLoading.value = false;

        navigateNext();

        update();
      }
    } on Exception catch (exception) {
      isLoading.value = false;
      navigateNext();
      Get.log("Exception : ${exception.toString()}");
      update();
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
