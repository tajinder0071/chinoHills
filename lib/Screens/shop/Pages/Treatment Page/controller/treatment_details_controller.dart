import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Model/treatment_details_model.dart';
import '../../../../../common_Widgets/added_to_cart_bottom_sheet.dart';
import '../../../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../../cartList/Controller/cart_controller.dart';

class TreatmentDetailsController extends GetxController {
  // Existing variables
  var selectedIndexKey = 0;
  var treatmentId;
  var isLoading = false;
  var treatmentName = "Select treatment";
  bool isSelectedAny = false;
  bool isMemberChecked = false;
  String? isActive;
  TreatmentDetailsModel treatmentDetailsModel = TreatmentDetailsModel();
  PageController pageController = PageController();
  var currentPage = 0.obs;
  var selectedIndex = 0;
  bool isAddingCart = false;
  LocalStorage localStorage = LocalStorage();
  var memberShipPrice,
      memberShip,
      treatmentPrice,
      discountPrice,
      membershipName,
      discountamount,
      discounttext;
  var membershipId;
  List<Variation> variationList = [];

  var selectedQtyLabel;
  var selectedQtyPrice;
  var selectedMembershipPrice;

  Map<String, dynamic>? selectedtype;

  var isTreatmentCheck = false;

  void selectTreatment(int index) {
    selectedIndex = index;
    update();
  }

  void changePage(int index) {
    currentPage.value = index;
    pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void clearSelectedQuantity() {
    selectedQtyLabel = null;
    selectedQtyPrice = null;
    selectedMembershipPrice = null;
    selectedtype = null;
    update();
  }

  void updateValidQuantity({
    required String qtyLabel,
    required var price,
    required var membershipPrice,
    required String unitType,
    required var qty,
  }) {
    selectedQtyLabel = qtyLabel;
    selectedQtyPrice = price;
    selectedMembershipPrice = membershipPrice;
    // memberShipPrice = membershipPrice;
    selectedtype = {
      "qty": qty,
      "unit_type": unitType,
    };
    update();
  }

  void updateSelectedQuantity({
    required var price,
    required var membershipPrice,
    required String unitType,
    required var qty,
  }) {
    selectedQtyPrice = price;
    selectedMembershipPrice = membershipPrice;
    memberShipPrice = membershipPrice;
    selectedtype = {
      "qty": qty,
      "unit_type": unitType,
    };
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // ✅ fetch treatment details
  fetchDetailsTreatment() async {
    isLoading = true;
    // update();
    try {
      final argID = Get.arguments ?? 0;
      if (argID != 0) {
        treatmentId = argID;
      }

      treatmentDetailsModel = await hitAllTreatmentDetailsAPI(treatmentId);

      // Clear old state
      variationList.clear();
      selectedIndex = 0;
      clearSelectedQuantity();
      isMemberChecked = false;

      variationList.addAll(treatmentDetailsModel.treatment?.variations ?? []);
      if (variationList.isNotEmpty) {
        final firstVariation = variationList.first;

        if (firstVariation.prices != null &&
            firstVariation.prices!.isNotEmpty) {
          final firstPrice = firstVariation.prices!.first;

          // set treatment base price
          treatmentPrice = firstPrice.price ?? 0;

          // ✅ select only these by default
          selectedQtyPrice = firstPrice.price ?? 0;
          selectedtype = {
            "qty": firstPrice.qty ?? "",
            "unit_type": treatmentDetailsModel.treatment?.unitType ?? "",
          };

          // membership info
          if (firstPrice.membershipInfo != null) {
            memberShipPrice =
                firstPrice.membershipInfo!.membershipOfferPrice ?? "";
            memberShip = firstPrice.membershipInfo!.membershipPrice ?? "";
            discountPrice = firstPrice.membershipInfo!.discountedPrice ?? "";
            discountamount = firstPrice.membershipInfo!.discountamount ?? "";
            discounttext = firstPrice.membershipInfo!.discounttext ?? "";
            membershipName = firstPrice.membershipInfo!.membershipName ?? "";
            membershipId = firstPrice.membershipInfo!.membershipId ?? "";
          } else {
            memberShipPrice = 0;
          }
        }
      }

      isLoading = false;
      update();
    } on Exception catch (_) {
      isLoading = false;
      update();
    }
  }

// ✅ add to cart method with new payload
  Future addToCart(var packageId, var treatmentID, var treatmentVarientId,
      var treatmentPriceId, var treatmentPrice, var qty) async {
    isAddingCart = true;
    try {
      var clientId = await localStorage.getCId();
      var userId = await localStorage.getUId();
      print("Tretment price id :$treatmentPriceId");

      Map<String, dynamic> map = isTreatmentCheck
          ? {
        "client_id": clientId,
        "user_id": userId,
        "CartDetails": {
          "type": "Treatments",
          "treatment_id": treatmentID ?? 0,
          "treatment_variation_id": treatmentVarientId ?? 0,
          "treatment_price_id": treatmentPriceId ?? 0,
          "treatment_price": treatmentPrice ?? 0.0,
          "treatment_qty": qty ?? 0.0,
          "become_membership": {
            "membership_id": isTreatmentCheck ? membershipId : "",
            "membership_price": isTreatmentCheck ? memberShip : ""
          }
        }
      }
          : {
        "client_id": clientId,
        "user_id": userId,
        "CartDetails": {
          "type": "Treatments",
          "treatment_id": treatmentID ?? 0,
          "treatment_variation_id": treatmentVarientId ?? 0,
          "treatment_price_id": treatmentPriceId ?? 0,
          "treatment_price": treatmentPrice ?? 0.0,
          "treatment_qty": qty ?? 0.0,
        },
      };
      print(map);

      // include membership details if checked
      if (isMemberChecked) {
        map["become_membership_detail"] = {
          "membership_id": membershipId ?? 0,
          "membership_price": selectedMembershipPrice ?? 0,
          "membership_name": membershipName ?? "",
        };
      }

      var response = await hitAddCartAPI(map);
      print(isTreatmentCheck ?  selectedQtyPrice:memberShipPrice);
      if (response['success'] == true) {
        await Get.bottomSheet(
          AddedToCartBottomSheet(
            titleName: selectedIndex != -1
                ? treatmentDetailsModel
                .treatment!.variations![selectedIndex].variationName
                .toString()
                : "",
            quantityName: selectedQtyLabel ?? 'treatment',
            price: isTreatmentCheck ? memberShipPrice : selectedQtyPrice,
            membeTitleName: isTreatmentCheck ?  membershipName:"",
            memberPrice: isTreatmentCheck ?  "$memberShip.00":"",
            isChecked: isTreatmentCheck,
            quantity: selectedtype != null
                ? "${selectedtype?['qty']} ${selectedtype?['unit_type']}"
                : null,
          ),
          isDismissible: false,
          isScrollControlled: true,
        );
        CartController.cart.cartList();
      }
    } finally {
      isAddingCart = false;
      update();
    }
  }
}
//{
//   "client_id": 5,
//   "user_id": 274,
//   "CartDetails": {
//     "type": "Treatments",
//     "treatment_id": 42,
//     "treatment_variation_id": 101,
//     "treatment_price_id": 1234,
//     "treatment_price": 1500.00
//   }
// "become_membership_detail":{
// "membership_id":1,
// "membership_price":200,
// "membership_name":""
// }
// }
