import 'dart:async';
import 'package:get/get.dart';
import '../../../Model/signup_reward_model.dart';
import '../../../util/base_services.dart';
import '../../../util/local_store_data.dart';

class RewardUnlockedController extends GetxController {
  var sliderValue = 0.0.obs;
  var showRewardCard = false.obs;
  var isLoading = false.obs;
  var rewardPoints = "".obs;
  Timer? _timer;
  LocalStorage localStorage = LocalStorage();
  List<RewardDatum> rewardData = [];

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void startAutoSlider() {
    _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (sliderValue.value < 1.0) {
        sliderValue.value += 0.02;
        update();
      } else {
        showRewardCard.value = true;
        timer.cancel();
        update();
      }
    });
  }

  //! 🔹 Fetch Rewards API and Manage Slider
  Future<void> getRewardAPI(client_id) async {
    isLoading.value = true;
    startAutoSlider();
    rewardData.clear();
    try {
      SignupRewardModel response = await hitSignUpRewardAPI();
      if (response.success == true) {
        rewardData.addAll(response.data!);
        rewardPoints.value =
        "\$ ${rewardData[0].discountType == "btn-amount" ? "\$" : ""}${rewardData[0].discountAmount!}${rewardData[0].discountType == "btn-amount" ? "" : ""}";
        localStorage.saveData("rewardPoints", rewardPoints.value.toString());
        localStorage.saveData("client_id", response.clientId.toString());
        //read user_id from local storage

        //! 🔹 Delay before stopping slider (smooth transition)
        await Future.delayed(Duration(milliseconds: 300));

        sliderValue.value = 1.0; // Complete the slider
        showRewardCard.value = true;
        isLoading.value = false;

        update();
      } else {
        isLoading.value = false;
        Get.log("API Error: ${response.message}");
        update();
      }
    } catch (e) {
      isLoading.value = false;
      Get.log("Exception: $e");
    } finally {
      isLoading.value = false;
      _timer?.cancel();
    }
  }
}
