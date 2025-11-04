import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/Model/RewardDetailsModel.dart';
import 'package:chino_hills/Screens/shop/controller/shop_controller.dart';
import 'package:chino_hills/util/base_services.dart';
import '../../../Model/availRewardModel.dart';
import '../../../util/local_stoage.dart';

class RewardDetailsController extends GetxController {
  static RewardDetailsController get instance => Get.find();
  ShopController shopController = Get.put(ShopController());


  bool isLoading = false;
  bool show = false;
  bool showMore = false;
  bool load = false;
  bool vload = false;
  var userName = "".obs;
  bool isUpdate = false;


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
  late var repeatNimaCash;
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
  Future<bool> convertNimaCash(id) async {
    isUpdate = true;
    update();

    var clientId = await localStorage.getCId();
    var userId = await localStorage.getUId();

    Map<String, dynamic> map = {
      "user_id": userId,
      "client_id": "$clientId",
      "reward_id": id.toString() == "null" || id.toString().isEmpty ? "" : id,
    };

    try {
      var response = await hitRewardConvertNimaCash(map);
      if (response['success'] == true) {
        await shopController.fetchWalletNimaCash();
        isUpdate = false;
        update();
        return true;
      } else {
        isUpdate = false;
        update();
        return false;
      }
    } catch (e) {
      isUpdate = false;
      update();
      print(e);
      return false;
    }
  }


  Future<void> fetchRewardData(id) async {
    isLoading = true;
    // Simulated API response
    RewardDetailsModel response = await hitAllRewardDetailsAPI(id);
    if (response.success == true) {
      rewardPoints = response.data?.discountAmount ?? "";
      repeatNimaCash = response.data?.repeatCashValue?? "";
      treatmentsList = (response.data?.treatments ?? [])
          .map<CommonModel>(
              (t) => CommonModel(name: t.treatmentName ?? "", id: t.treatmentId))
          .toList();
      packagesList = (response.data?.packages ?? [])
          .map<CommonModel>(
              (p) => CommonModel(name: p.packageName?? "", id: p.packageId))
          .toList();
      membersList = (response.data?.memberships ?? [])
          .map<CommonModel>(
              (m) => CommonModel(name: m.membershipName?? "", id: m.membershipId))
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
