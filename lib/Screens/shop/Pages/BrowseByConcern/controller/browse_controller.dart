import 'package:get/get.dart';

import '../../../../../Model/brows_detail_model.dart';
import '../../../../../util/base_services.dart';

class BrowseController extends GetxController {
  bool isLoading = false;
  List<BrowseDatum> treatment = [];
  BrowseDetailModel? response;
  bool _isBothEmpty = false;

  bool get isBothEmpty => _isBothEmpty;

  // Lets Define the Variable..
  var loading = false;
  var selectFilter = "";
  var selectService = "";
  List<int> selectFilterValue = [];
  List<int> selectServiceFilterValue = [];
  List<String> selectedOptions = [];
  List<String> selectedArea = [];
  List filter = [
    /* {"title": "Featured"},
    {"title": "Best sellers"},
    {"title": "On Sale"},*/
    {"title": "Price: Low to High"},
    {"title": "Price: High to Low"},
    {"title": "Recently added"}
  ];
  List serviceType = [
    {"title": "Packages"},
    {"title": "Treatments"},
  ];
  List serviceBackType = [
    {"title": "Packages"},
    {"title": "Treatments"},
  ];

  List filterBack = [
    /* {"title": "Featured"},
    {"title": "Best_sellers"},
    {"title": "On_sale"},*/
    {"title": "Low_to_high"},
    {"title": "High_to_low"},
    {"title": "Recently_added"}
  ];

  //? Here is the Browser by Concerns
  Future<void> getBrowserbyConcernsList(
      uid, var selectedArea, selectFilter, bool isSearch) async {
    isLoading = true;
    update();
    if (!isSearch) {
      try {
        treatment.clear();
        response = await hitAlBrowsBConcernAPI(
            uid.toString(), selectedArea, selectFilter);
        treatment.addAll(response!.data!);
        _isBothEmpty = treatment.isNotEmpty;
        Get.log("is both : ${_isBothEmpty}");
        isLoading = false;
        print("the length : ${treatment.length}");
        update();
      } on Exception catch (e) {
        isLoading = false;
        update();
      }
    } else {
      try {
        treatment.clear();

        response = await hitAlBrowsBConcernAPI(
            uid.toString(), selectedArea, selectFilter);
        treatment.addAll(response!.data!);
        isLoading = false;
        print("the le : ${treatment.length}");
        update();
      } on Exception catch (e) {
        isLoading = false;
        update();
      }
    }
  }

//!  Getting here the Browse Data....
// Future<void> fetchBrowseData(uid) async {
//   isLoading.value = true;
//   treatment.clear();
//   package.clear();
//   update();
//   try {
//     response = await hitAlBrowsBConcernAPI();
//     treatment.addAll(response!.treatments!);
//     package.addAll(response!.packages!);
//     isLoading.value = false;
//     update();
//   } on Exception catch (e) {
//     isLoading.value = false;
//     update();
//     print("Exception : $e");
//   }
// }
}
