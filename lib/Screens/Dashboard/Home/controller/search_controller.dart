import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Model/search_model.dart';
import '../../../../util/base_services.dart';
import '../../../../util/common_page.dart';

class SearchGlobalController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<dynamic> treatmentList = [].obs;
  RxList<Package> packageList = <Package>[].obs;
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
      if (response['success'] == true) {
        Get.log("Ok :${response['success']}");
        treatmentList.clear();
        packageList.clear();

        if (response['treatments'] != null &&
            response['treatments']!.isNotEmpty) {
          treatmentList.addAll(response['treatments']!);
        }
        if (response['packages'] != null && response['packages']!.isNotEmpty) {
          final List<Package> packages = List<Package>.from(
            response['packages']!.map((x) => Package.fromJson(x)),
          );
          packageList.addAll(packages);
        }
        isLoading.value = false;

        Get.log("Package:$packageList");
        Get.log("Treat: $treatmentList");
      } else {
        print("No search results found");
        treatmentList.clear();
        packageList.clear();
        isLoading.value = false;
      }
    } catch (e) {
      print("Search error: $e");
      treatmentList.clear();
      packageList.clear();
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
