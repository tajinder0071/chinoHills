import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../Model/treatment_list_model.dart';
import '../../../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';

class TreatmentController extends GetxController {
  static TreatmentController get instance => Get.find();

  List<Treatment> treatmentData = [];
  var loading = false;
  LocalStorage localStorage = LocalStorage();
  TreatmentListModel treatmentListModel = TreatmentListModel();
  var packageHeaderImage = "";
  var selectFilter = "";
  List<int> selectFilterValue = [];
  List<String> selectedOptions = [];
  List<String> selectedArea = [];
  List filter = [
    /*  {"title": "Featured"},
    {"title": "Best sellers"},
    {"title": "On Sale"},*/
    {"title": "Price: Low to High"},
    {"title": "Price: High to Low"},
    {"title": "Recently added"}
  ];
  List filterBack = [
    /*{"title": "Featured"},
    {"title": "Best_sellers"},
    {"title": "On_sale"},*/
    {"title": "Low_to_high"},
    {"title": "High_to_low"},
    {"title": "Recently_added"}
  ];

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  var isTreatmentCheck = false.obs;

  Future<void> handleRefresh() async {
    await getTreatmentList([], [], "");
  }

  Future<void> getTreatmentList(
      var selectedOptions, selectedArea, selectFilter) async {
    loading = true;
    update();
    try {
      treatmentData.clear();
      treatmentListModel =
      await hitAllTreatmentAPI(selectedOptions, selectedArea, selectFilter);
      treatmentData.addAll(treatmentListModel.treatments!);
      packageHeaderImage = treatmentListModel.headerDetails!.headerimage ??
          "https://assets.repeatmd.app/00005468-656d-6552-6573-6f7572636532.jpg";
      loading = false;
      print("the le : ${treatmentData.length}");
      update();
    } on Exception catch (e) {
      loading = false;
      update();
    }
  }
}
