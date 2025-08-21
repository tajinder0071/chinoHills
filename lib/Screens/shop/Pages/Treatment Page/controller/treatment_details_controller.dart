import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Model/treatment_details_model.dart';
import '../../../../../common_Widgets/added_to_cart_bottom_sheet.dart';
import '../../../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../../cartList/Controller/cart_controller.dart';

class TreatmentDetailsController extends GetxController {
  var treatmentId;
  var isLoading = false;
  var treatmentName = "Select treatment";
  bool isSelectedAny = false;
  bool isMemberChecked = false;

  TreatmentDetailsModel treatmentDetailsModel = TreatmentDetailsModel();

  PageController pageController = PageController();
  var currentPage = 0.obs;
  var selectedIndex = (-1); // -1 means no selection

  bool isAddingCart = false;
  LocalStorage localStorage = LocalStorage();

  void selectTreatment(int index) {
    selectedIndex = index;
    update();
  }

  //? Todo // Scroll the image
  void changePage(int index) {
    currentPage.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Todo ?? Below All Method is define...
  fetchDetailsTreatment() async {
    isLoading = true;
    // update();
    try {
      final argID = Get.arguments ?? 0;
      if (argID != 0) {
        treatmentId = argID;
      }

      treatmentDetailsModel = await hitAllTreatmentDetailsAPI(treatmentId);
      isLoading = false;
      update();
    } on Exception catch (e) {
      isLoading = false;
      update();
    }
  }

  // Let's hit the addToCart API ...
  Future addToCart(packageId, treatmentID, treatmentVarientId) async {
    isAddingCart = true;
    update();
    try {
      var userId = await localStorage.getUId();
      var cId = await localStorage.getCId();
      Map<String, dynamic> map = {
        "user_id": userId,
        "item_type": "Treatments",
        "item_id": treatmentID ?? 0,
        "item_variant_id": treatmentVarientId.toString(),
        "membership_check": isMemberChecked ? "1" : "0",
        "client_id": "${cId}",
      };
      Get.log("Add To Cart Map  :$map");
      var response = await hitAddCartAPI(map);
      if (response['success'] == true) {
        Get.back();
        await Get.bottomSheet(
          AddedToCartBottomSheet(
            titleName: selectedIndex != -1
                ? treatmentDetailsModel
                      .data!
                      .treatmentvarient![selectedIndex]
                      .treatmentVariationName
                      .toString()
                : "",
            quantityName: 'treatment',
            price: selectedIndex != -1
                ? treatmentDetailsModel
                      .data!
                      .treatmentvarient![selectedIndex]
                      .treatmentVariationPrice
                : 0,
            membeTitleName: isMemberChecked
                ? treatmentDetailsModel.data!.membershipData!.membershipTitle
                      .toString()
                : '',
            memberPrice: isMemberChecked
                ? treatmentDetailsModel.data!.membershipData!.membershipPricing
                : "",
            isChecked: isMemberChecked ? true : false,
            quantity: null,
          ),
          isDismissible: false,
          isScrollControlled: true,
        );
        CartController.cart.cartList();

        isAddingCart = false;
      }
      isAddingCart = false;
      update();
    } on Exception catch (e) {
      print("the rror : $e");
      isAddingCart = false;
      update();
    }
  }
}
