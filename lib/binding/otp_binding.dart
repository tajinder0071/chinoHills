import 'package:get/get.dart';
import '../Screens/Otp Page/controller/otp_verification_controller.dart';

class OTPBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OTPController());
  }
}
