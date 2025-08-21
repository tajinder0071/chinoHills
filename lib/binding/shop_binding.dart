import 'package:get/get.dart';

import '../Screens/Dashboard/Home/controller/membership_detail_controller.dart';
import '../Screens/shop/Pages/Package Page/controller/package_cotroller.dart';
import '../Screens/shop/controller/shop_controller.dart';

class ShopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopController>(() => ShopController());
    Get.lazyPut<PackageController>(() => PackageController());
    Get.lazyPut<MembershipDetailController>(() => MembershipDetailController());
  }
}
