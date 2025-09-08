import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../CSS/color.dart';
import '../../../Model/discover_model.dart';
import '../../../util/base_services.dart';
import '../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';
import '../../../util/services.dart';
import '../../cartList/Controller/cart_controller.dart';
import '../widgets/offer_applied_widget.dart';

class DiscoverController extends GetxController {
  var load = false;
  var dload = false;
  List<ContentCard> cardData = [];
  List<ServiceName> allServices = <ServiceName>[];
  LocalStorage localStorage = LocalStorage();

  bool showMore = false;
  bool isAddingPromo = false;

  DiscoverModel model = DiscoverModel();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> handleRefresh() async {
    await fetchDiscoverList();
  }

  Future<void> fetchDiscoverList() async {
    load = true;
    cardData.clear();
    try {
      DiscoverModel response = await hitDiscoverAPI();
      cardData.addAll(response.data!);
      load = false;
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }

  Future<void> cardDetail(id) async {
    dload = true;
    try {
      model = await hitCartDetailAPI(id);
      dload = false;
      print("response==>${model}");
      update();
    } on Exception catch (e) {
      dload = false;
      update();
    }
  }

  Future<void> launchURL(customUrl) async {
    final Uri url = Uri.parse(customUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $customUrl';
    }
  }

  callNumber(String customUrl) async {
    final number = customUrl.toString();
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  Future<void> addPromoCode(
      String promoCode,
      VoidCallback goToShop,
      BuildContext context, {
        List<ServiceName>? treatement,
      }) async {
    isAddingPromo = true;
    update();
    try {
      var userId = await localStorage.getUId();
      var clientId = await localStorage.getCId();

      // using find method to call CartController
      var cartController = Get.find<CartController>();
      // Get cart data
      String cartData = cartController.sendCartID.toString();
      print("cartData: $cartData");
      if (cartData.isEmpty) {
        showMessage("Promo code not applicable for this service", context);
        isAddingPromo = false;
        update();
        return;
      }

      // Prepare request map
      Map<String, dynamic> map = {
        "promo_code": promoCode,
        "cart_id": int.parse(cartData),
        "user_id": userId,
        "client_id": "${clientId}"
      };

      Get.log("Apply Promo Code Request: $map");

      // Make API call
      var response = await hiApplyCouponCodeAPI(map);

      if (response['success'] == true) {
        String promoTitle = '';
        if (response['promo_codes'] != null &&
            response['promo_codes'].isNotEmpty) {
          promoTitle = response['promo_codes'][0]['title'] ?? '';
        }
        // Show success bottom sheet
        showModalBottomSheet(
          context: Get.context!,
          isScrollControlled: false,
          backgroundColor: AppColor().whiteColor,
          builder: (context) => OfferAppliedPage(
            promoTitle,
            onTapShop: () {
              Get.back();
              goToShop();
            },
            onTapCart: () {
              Get.back();
              Get.toNamed(RouteManager.cartList);
            },
          ),
        );
        fetchDiscoverList();
      } else {
        // Show error from API response
        showMessage(response['message'] ?? "Something went wrong", context);
      }

      isAddingPromo = false;
      update();
    } on Exception catch (e) {
      showMessage(
        e.toString().replaceAll("Exception: ", "").toUpperCase(),
        context,
      );
      isAddingPromo = false;
      update();
    }
  }

// @override
// void onInit() {
//   // TODO: implement onInit
//   super.onInit();
//   cartList();
// }
}
