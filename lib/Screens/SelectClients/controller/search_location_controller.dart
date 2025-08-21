import 'package:get/get.dart';

import '../../../Model/choose_client_model.dart';
import '../../../Model/search_client_model.dart';
import '../../../Model/view_client_model.dart';
import '../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';

class SearchLocationController extends GetxController {
  var load = false;
  List<Datum> searchList = [];
  List<ClientDatum> clientList = [];

  Future<void> searchLocation() async {
    searchList.clear();
    load = true;
    try {
      SearchClientModel response = await hitSearchLocationAPI();
      searchList.addAll(response.data!);
      //store client id in local storage
      load = false;
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }

  // clientsForUsers
  Future<void> viewClient() async {
    clientList.clear();
    load = true;
    try {
      ViewClientModel response = await hitViewClient();
      clientList.addAll(response.data!);
      print(response);
      //store client id in local storage
      load = false;
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }

  List<ChooseDatum> chooseList = [];

  Future<void> selectClient(id, user_id) async {
    load = true;
    chooseList.clear();
    //call local storage
    LocalStorage localStorage = LocalStorage();
    // update();
    try {
      ChooseClientModel response = await hitSelectClient(id);
      chooseList.addAll(response.data!);
      Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0);
      //store client id in local storage
      localStorage.saveData("user_uuid", response.data![0].userId.toString());
      localStorage.saveData("user_name",
          "${response.data![0].firstName} ${response.data![0].lastName}");
      localStorage.saveData("email", response.data![0].userEmail.toString());
      localStorage.saveData("first_name", response.data![0].firstName.toString());
      localStorage.saveData("last_name", response.data![0].lastName.toString());
      localStorage.saveData("client_id", id.toString());
      load = false;
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }
}

//4782733578
