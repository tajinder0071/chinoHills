import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Model/RewardDetailsModel.dart';
import '../../../Model/availRewardModel.dart';
import '../../../util/base_services.dart';
import '../../../util/local_store_data.dart';

class RewardDetailsController extends GetxController {
  static RewardDetailsController get instance => Get.find();

  bool isLoading = false;
  bool show = false;
  bool showMore = false;
  bool load = false;
  bool vload = false;
  var userName = "".obs;

  getUser() async {
    LocalStorage localStorage = LocalStorage();
    userName.value = await localStorage.getName() ?? "";
    // update();
  }

  // Use CommonModel for all types
  List<CommonModel> treatmentsList = <CommonModel>[];
  List<CommonModel> packagesList = <CommonModel>[];
  List<CommonModel> membersList = <CommonModel>[];
  var rewardPoints = "";
  AvailRewardModel response = AvailRewardModel();
  List<Reward> avail = [];
  List<Reward> unloackReward = [];


  Future<void> available() async {
    load = true;
    // update();
    try {
      avail.clear();
      avail = [];
      unloackReward.clear();
      unloackReward = [];
      // visitList();
      response = await hitAvailableRewardAPI();
      load = false;
      avail.addAll(response.unlockedRewards!);
      unloackReward.addAll(response.upcomingRewards!);
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }

  Future<void> fetchRewardData(id) async {
    isLoading = true;
    // Simulated API response
    RewardDetailsModel response = await hitAllRewardDetailsAPI(id);
    if (response.success == true) {
      rewardPoints = response.data?.reward ?? "";
      treatmentsList = (response.data?.treatments ?? [])
          .map<CommonModel>(
              (t) => CommonModel(name: t.treatmentName, id: t.treatmentId))
          .toList();
      packagesList = (response.data?.packages ?? [])
          .map<CommonModel>(
              (p) => CommonModel(name: p.packageName, id: p.packageId))
          .toList();
      membersList = (response.data?.membership ?? [])
          .map<CommonModel>(
              (m) => CommonModel(name: m.membership, id: m.memberId))
          .toList();
      isLoading = false;
      update();
    } else {
      Get.log("APi Response : ${response.message}");
      isLoading = false;
      update();
    }
  }

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> handleRefresh() async {
    await available();
  }
}

class CommonModel {
  String name;
  var id;

  CommonModel({required this.name, required this.id});
}
