import 'package:get/get.dart';
import '../Screens/Account/controller/account_detail_controller.dart';
import '../Screens/Complete Profile/controller/complete_profile_controller.dart';
import '../Screens/Dashboard/Home/controller/membership_detail_controller.dart';
import '../Screens/Otp Page/controller/otp_verification_controller.dart';
import '../Screens/Register/controller/register_controller.dart';
import '../Screens/cartList/Controller/cart_controller.dart';
import '../Screens/cartList/Controller/shopping_cart_controller.dart';
import '../Screens/shop/Pages/Package Page/controller/package_cotroller.dart';
import '../Screens/shop/Pages/Treatment Page/controller/treatment_details_controller.dart';
import '../Screens/shop/controller/shop_controller.dart';

class CommonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => MembershipDetailController());
    Get.lazyPut(() => ShoppingCartController());
    Get.lazyPut(() => CompleteProfileController());
    Get.lazyPut(() => AccountDetailController());
    Get.lazyPut(() => OTPController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut<ShopController>(() => ShopController());
    Get.lazyPut<PackageController>(() => PackageController());
    Get.lazyPut<TreatmentDetailsController>(() => TreatmentDetailsController());
  }
}
