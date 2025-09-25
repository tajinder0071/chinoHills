import 'package:get/get.dart';
import 'package:chino_hills/Screens/Dashboard/dashboard_screen.dart';
import 'package:chino_hills/binding/cart_billing.dart';

class ConfirmOrderController extends GetxController {
  var isLoading = false.obs;

  void onNext() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // simulate API call
    isLoading.value = false;

    // Navigate or perform action
    Get.offAll(DashboardScreen(selectIndex: 0),binding: CommonBinding());
  }
}
