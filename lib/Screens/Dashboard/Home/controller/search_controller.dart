import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/util/base_services.dart';

import '../../../../Model/search_model.dart';
import '../../../../util/common_page.dart';

class SearchGlobalController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SearchDatum> treatmentList = <SearchDatum>[].obs;
  RxList<SearchDatum> packageList = <SearchDatum>[].obs;
  RxString searchText = ''.obs;
  final focusNode = FocusNode();
  final isFocused = false.obs;
  Debouncer debouncer = Debouncer();

  final TextEditingController searchController = TextEditingController();

  void clearText() {
    searchController.clear();
    searchText.value = '';
    treatmentList.clear();
    packageList.clear();
    unfocus();
  }

  void unfocus() {
    focusNode.unfocus();
  }

  void onChanged(String value) {
    searchText.value = value;
    if (value.isEmpty) {
      treatmentList.clear();
      packageList.clear();
    }
  }

  Future<void> searchManageTracking(String value) async {
    if (value.isEmpty) return;
    isLoading.value = true;
    try {
      final response = await hitManageTrackingSearch(value);
      if (response['success'] == true && response['data'] != null) {
        treatmentList.clear();
        packageList.clear();
        List<SearchDatum> results = List<SearchDatum>.from(
          response['data'].map((x) => SearchDatum.fromJson(x)),
        );
        // Separate treatments and packages
        for (var item in results) {
          if (item.serviceType == "Treatment") {
            treatmentList.add(item);
          } else if (item.serviceType == "Package") {
            packageList.add(item);
          }
        }

      } else {
        treatmentList.clear();
        packageList.clear();
      }
    } catch (e) {
      print("Search error: $e");
      treatmentList.clear();
      packageList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
