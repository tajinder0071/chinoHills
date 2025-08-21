import 'package:get/get.dart';
import '../Screens/Dashboard/Home/controller/membership_detail_controller.dart';
import '../Screens/shop/Pages/Treatment Page/controller/treatment_details_controller.dart';

class TreatmentDetailsBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy‐put the controller so it’s created only when needed
    Get.lazyPut<TreatmentDetailsController>(
          () => TreatmentDetailsController(),
    );

    // If your page also uses MembershipDetailController, register it here too:
    Get.lazyPut<MembershipDetailController>(
          () => MembershipDetailController(),
    );

  }
}
