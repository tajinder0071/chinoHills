import 'package:get/get.dart';

import '../../../Model/offer_list_model.dart';
import '../../../util/base_services.dart';

class OfferController extends GetxController {
  var load = false;
  var dload = false;
  List<Datum> offerData = [];

  // CardDetailModel model = CardDetailModel();

  Future<void> offerList() async {
    load = true;
    offerData.clear();
    update();
    try {
      OfferListModel response = await hitAllOfferAPI();
      offerData.addAll(response.data!.data!);
      load = false;
      print("response==>${response}");
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    offerList();
  }
}
