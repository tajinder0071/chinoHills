import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:chino_hills/Model/wallet_membership_active_model.dart';

import '../../../Model/promode_reward_model.dart';
import '../../../util/base_services.dart';

class WalletController extends GetxController {
  RxBool isEditing = false.obs;
  RxBool isViewMode = true.obs;
  RxBool isEditedAmount = false.obs;
  RxBool isAmountApplied= false.obs;
  RxBool isAmountRemoved= false.obs;

  RxDouble enteredAmount = 0.0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingWalletMemberShip = false.obs;

  TextEditingController amountController = TextEditingController();
  WalletMembershipActiveModel walletMembershipActiveModel = WalletMembershipActiveModel();

  PromoRewardModel response = PromoRewardModel();


  Future<void> applyEditedCash(editedAmount) async {
    isLoading.value = true;
    update();
    try {
      response = await hitApplyEditedCash(editedAmount);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false;
      update();
    }
  }

  @override
  void onClose() {
    amountController.dispose();
    super.onClose();
  }
}