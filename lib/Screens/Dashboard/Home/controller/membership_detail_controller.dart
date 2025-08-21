import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../CSS/color.dart';
import '../../../../Model/member_ship_details_model.dart';
import '../../../../Model/term_condition_model.dart';
import '../../../../common_Widgets/added_to_cart_bottom_sheet.dart';
import '../../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../../util/route_manager.dart';
import '../../../../util/services.dart';
import '../../../cartList/Controller/cart_controller.dart';

class MembershipDetailController extends GetxController {
  static MembershipDetailController get instance => Get.find();
  bool _isLoading = false;
  bool isAddingCart = false;
  var membershipId;
  MemberShipDetailsModel memberDetailsModel = MemberShipDetailsModel();

  TermConditionModel response = TermConditionModel();
  LocalStorage localStorage = LocalStorage();

  bool get isLoading => _isLoading;

  //get term and condition
  getTermAndCondition() async {
    _isLoading = true;
    try {
      print("object");
      response = await hitTermConditionApi();
      print(response);
      _isLoading = false;
      update();
    } on Exception catch (e) {
      _isLoading = false;
      update();
    }
  }

  Future addToCart(BuildContext context, int? membershipPricing) async {
    isAddingCart = true;
    update();

    try {
      if (CartController.cart.isMemberAvailable) {
        Future.delayed(Duration(seconds: 1), () {
          Get.offAndToNamed(RouteManager.cartList);
          isAddingCart = false;
          update();
        });
      } else {
        var userId = await localStorage.getUId();
        var cId = await LocalStorage().getCId();
        Map<String, dynamic> map = {
          "user_id": userId,
          "item_type": "Memberships",
          "item_id": membershipId ?? 0,
          "item_variant_id": "0",
          "membership_check": "0",
          "client_id": "${cId}",
        };

        Get.log("Add To Cart Map  :$map");
        var response = await hitAddCartAPI(map);

        if (response['success'] == true) {
          CartController.cart.cartList();
          await Get.bottomSheet(
            backgroundColor: AppColor().whiteColor,
            AddedToCartBottomSheet(
              titleName: response['item_name'] ?? "",
              quantityName: 'Membership',
              price: membershipPricing ?? 0,
              membeTitleName: '',
              memberPrice: null,
              isChecked: false,
              quantity: null,
            ),
            isDismissible: false,
            isScrollControlled: true,
          );
        }

        isAddingCart = false;
        update();
      }
    } on Exception catch (e) {
      print("the rror : $e");
      showMessage(
        e.toString().replaceAll("Exception: ", "").toUpperCase(),
        context,
      );
      isAddingCart = false;
      update();
    }
  }

  //? TODO ??  here we show the Members Details API....
  bool isMemberLoading = false;

  Future<void> fetchMemberShipDetails() async {
    isMemberLoading = true;
    // update();

    try {
      var memberShipID = Get.arguments ?? 0;
      membershipId = memberShipID;
      print("memberShip ID :$memberShipID");
      memberDetailsModel = await hitMemberShipDetailsAPI(memberShipID);
      Get.log("Member Data :${memberDetailsModel.data}");
      isMemberLoading = false;
      update();
    } on Exception catch (e) {
      isMemberLoading = false;
      update();
      Get.log("Exception  :$e");
    }
  }
}
