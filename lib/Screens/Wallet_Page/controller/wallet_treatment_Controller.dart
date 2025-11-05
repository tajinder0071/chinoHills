import 'package:get/get.dart';
import 'package:chino_hills/Model/wallet_treatement_list_model.dart';
import '../../../util/base_services.dart';
import '../../../util/services.dart';

class WalletTreatmentController extends GetxController {
  var isTLoading = false.obs;

  WalletTreatmentListModel walletTreatmentListModel =
      WalletTreatmentListModel();
  List<TreatmentList> treatmentList = [];

  Future<void> fetchWalletTreatmentList() async {
    isTLoading.value = true;
    treatmentList.clear();
    update();
    try {
      print("object");
      walletTreatmentListModel = await hitWalletTreatmentList();
      treatmentList.addAll(walletTreatmentListModel.treatmentList!);
      isTLoading.value = false;
      update();
    } on Exception catch (e) {
      isTLoading.value = false;
      showMessage(e.toString().replaceAll("Exception:", ""), Get.context!);
      update();
    }
  }
}
