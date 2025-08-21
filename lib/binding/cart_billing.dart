import 'package:get/get.dart';
import '../Screens/Dashboard/Home/controller/membership_detail_controller.dart';
import '../Screens/cartList/Controller/cart_controller.dart';
import '../Screens/cartList/Controller/shopping_cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CartController());
    Get.lazyPut(() => MembershipDetailController());
  }
}

class ShoppingCartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShoppingCartController());
    Get.lazyPut(() => MembershipDetailController());
  }
}
