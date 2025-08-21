import 'package:get/get.dart';
import '../Screens/Account/controller/account_detail_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountDetailController());
  }
}
