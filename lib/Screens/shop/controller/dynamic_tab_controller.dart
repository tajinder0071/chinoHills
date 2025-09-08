import 'package:get/get.dart';
import '../../../Model/dynamic_tab_model.dart';
import '../../../util/base_services.dart';

class DynamicTabController extends GetxController {
  String dynamicId;

  DynamicTabController(this.dynamicId);

  RxBool isLoading = false.obs;
  Rx<DynaminTabModel?> dynamicTabModel = Rx<DynaminTabModel?>(null);
  @override
  void onInit() {
    super.onInit();
    fetchDynamicTabData();
  }

  Future<void> fetchDynamicTabData() async {
    isLoading.value = true;
    try {
      dynamicTabModel.value = await getCustomCategoryLists(dynamicId);
    } catch (e) {
      print("Error fetching dynamic tab data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 🔑 Update ID and refetch data when switching tabs
  Future<void> updateDynamicId(String newId) async {
    if (newId != dynamicId) {
      dynamicId = newId;
      await fetchDynamicTabData();
    }
  }
}
