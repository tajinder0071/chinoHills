import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/Model/wallet_membership_active_model.dart';
import 'package:chino_hills/util/base_services.dart';
import 'package:chino_hills/util/services.dart';

class WalletMemberController extends GetxController {
  /// Observable variables
  var isLoading = false.obs;
  var isTLoading = false.obs;
  WalletMembershipActiveModel walletData = WalletMembershipActiveModel();
  var errorMessage = ''.obs;
  List<ActiveMembership> activeMembership = [];
  var selectedTreatmentId = RxnInt();

  final PageController pageController = PageController();
  var currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchWalletMembership();
  }

  void goToPage(int index) {
    if (index >= 0 && index < activeMembership.length) {
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      currentPage.value = index;
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }


  /// Check Box
  void selectTreatment(int index) {
    selectedTreatmentId.value = index;
  }

  void clearSelection() {
    selectedTreatmentId.value = null;
  }
  /// Fetch wallet membership status

  Future<void> fetchWalletMembership() async {
    isLoading.value = true;
    activeMembership.clear();
    update();
    try {
      print("object");
      walletData = await walletMembershipActive();
      activeMembership.addAll(walletData.activeMemberships!);
      print(walletData);
      isLoading.value = false;
      update();
    } on Exception catch (e) {
      isLoading.value = false;
      showMessage(e.toString().replaceAll("Exception:", ""), Get.context!);
      update();
    }
  }


}
