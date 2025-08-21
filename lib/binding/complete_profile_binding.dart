import 'package:get/get.dart';
import '../Screens/Complete Profile/controller/complete_profile_controller.dart';

class CompleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => CompleteProfileController());
  }
}
