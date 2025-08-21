import 'package:get/get.dart';
import '../Screens/Dashboard/Home/controller/membership_detail_controller.dart';
import '../Screens/shop/Pages/Package Page/controller/package_cotroller.dart';

class PackageDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> PackageController());
    // If your page also uses MembershipDetailController, register it here too:
    Get.lazyPut<MembershipDetailController>(
          () => MembershipDetailController(),
    );
  }
}
