import 'package:get/get.dart';

import '../../../Model/wallet_treatment_list_model.dart';
import '../../../util/base_services.dart';
import '../../../util/services.dart';

class WalletTreatmentController extends GetxController{
  var isTLoading = false.obs;
  WalletTreatmentListModel treatmentModel = WalletTreatmentListModel();
  List<TreatmentList> treatmentList = [];
  Future<void> fetchWalletTreatmentList() async {
    isTLoading.value = true;
    update();
    try {
      treatmentList.clear();
      print("object");
      treatmentModel = await hitWalletTreatmentList();
      print('walletData:: $treatmentModel');
      treatmentList.addAll(treatmentModel.treatmentList!);
      isTLoading.value = false;
      update();
    } on Exception catch (e) {
      isTLoading.value = false;
      showMessage(e.toString().replaceAll("Exception:", ""), Get.context!);
      update();
    }
  }
}