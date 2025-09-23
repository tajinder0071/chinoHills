import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import '../../../Model/client_list_model.dart';
import '../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';

class SearchbyController extends GetxController {
  var searchQuery = ''.obs;
  List<ClientDatum> clientList = [];

  Debouncer debouncer = Debouncer(
    delay: Duration(milliseconds: 500),
  );

  var load = false;

  TextEditingController searchFieldController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    // Debounce the search input
    ever(searchQuery, (String query) {
      debouncer.call(() {
        searchClient(query);
      });
    });
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  // Modified to accept search query
  Future<void> searchClient(String query) async {
    if (query.isEmpty) return;

    LocalStorage localStorage = LocalStorage();
    var userId =await localStorage.getUId();

    clientList.clear();
    load = true;
    update();

    try {
      ClientListModell response = await hitSearchClient(query, userId);
      clientList.addAll(response.data ?? []);
    } catch (e) {
      // optional: handle error
    } finally {
      load = false;
      update();
    }
  }
}
