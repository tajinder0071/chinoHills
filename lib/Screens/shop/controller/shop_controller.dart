import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CSS/color.dart';
import '../../../Model/best_selling_model.dart';
import '../../../Model/home_model.dart';
import '../../../Model/tab_list_model.dart';
import '../../../util/base_services.dart';
import '../../../Model/visit_model.dart';
import '../../../util/local_store_data.dart';
import '../../Dashboard/Home/controller/membership_detail_controller.dart';

class ShopController extends GetxController with GetTickerProviderStateMixin {
  static ShopController get shop => Get.find();
  late TabController tabController;
  List<HomeDatum> homeData = [];
  var load = false;
  var userName;
  LocalStorage localStorage = LocalStorage();
  var image;
  int count = 0;
  List<Datum> datum = [];
  bool vload = false;
  bool isSpecialOfferLoading = false;

  //? TODO ?? Method for best selling
  bool isBestLoading = false;
  List<BestTreatment> treatment = [];
  List<BestPackage> package = [];


  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  Future<void> handleRefresh() async {
    await homeApi();
  }

  void goToTabByName(String tabName) {
    final normalized = tabName.toLowerCase().trim();

    String matchName;
    switch (normalized) {
      case "membership":
      case "memberships":
        matchName = "memberships";
        break;
      case "treatment":
      case "treatments":
        matchName = "treatments";
        break;
      case "package":
      case "packages":
        matchName = "packages";
        break;
      case "browse":
        matchName = "browse";
        break;
      case "concern":
      case "browse by concern":
        matchName = "browse by concern";
        break;
      default:
        matchName = normalized;
    }

    final index = tabList.indexWhere(
          (tab) => tab.toString().toLowerCase().trim() == matchName,
    );

    if (index != -1) {
      localStorage.saveData("shopIndex", index);
      goToTab(index);
    } else {
      localStorage.saveData("shopIndex", 0);
      goToTab(0);
    }
  }

  getShopByItem() async {
    userName = await localStorage.getName();
    var userId = await localStorage.getUId();
    Get.log("Is user_name : $userName  $userId");
    count = await localStorage.getindex() ?? 0;
    Get.log("the get :${count}");
    tabController = TabController(
        length: tabList == 0 ? list.length : tabList.length,
        vsync: this,
        initialIndex: count);
    update();
  }

  List<CustomTab> customTabs = [];
  List tabList = [];
  List dynamictab = [];
  List list = [
    "Browse",
    "Memberships",
    "Treatments",
    "Packages",
    "Browse by Concern"
  ];

  //create method for hit tab list apix
  Future<void> initializeTabs() async {
    load = true;
    customTabs.clear();
    tabList.clear();
    dynamictab.clear();
    update();

    try {
      userName = await localStorage.getName();
      var userId = await localStorage.getUId();
      count = await localStorage.getindex() ?? 0;
      TabListModel response = await hitTabList();
      customTabs.addAll(response.customTabs ?? []);

      // always add Browse first
      tabList.add("Browse");

      // insert dynamic tabs right after Browse
      for (var e in customTabs) {
        tabList.add(e.categoryTabName.toString());
        dynamictab.add(e.categoryId.toString());
      }

      // then add remaining static ones
      tabList.addAll([
        "Memberships",
        "Treatments",
        "Packages",
        "Browse by Concern",
      ]);

      if (tabController != null) {
        tabController.dispose();
      }
      tabController = TabController(
        length: tabList.length,
        vsync: this,
        initialIndex: count < tabList.length ? count : 0,
      );

      Get.log("TabList: $tabList");
      load = false;
      update();
    } catch (e) {
      print("Error in initializeTabs(): $e");
      load = false;
      update();
    }
  }

  Future<void> homeApi() async {
    load = true;
    homeData.clear();
    update();
    try {
      HomeModel response = await hitHomeApi();
      print("Home Api :: $response");

      homeData.addAll(response.data!);

      // Handle dynamic color from the first item
      String hex = homeData[0].color.toString().replaceAll('#', '');
      if (hex.length == 6) hex = 'FF$hex';
      // Color dynamicColor = localStorage.readData("dynamicColor");
      // Save and assign color to AppColor
      Color dynamicColor = Color(int.parse(hex, radix: 16));
      AppColor.dynamicColor = dynamicColor;
      load = false;
      update();
    } on Exception catch (e) {
      print("Home API error: $e");
      load = false;
      update();
    }
  }

  void goToTab(int index) {
    if (tabController.index != index && index < tabController.length) {
      tabController.animateTo(index);
      update(); // ensures UI rebuilds with new index
    }
  }

  // TODO >> Define here the Special Offers Section...
  late final AnimationController blinkController;
  late final Animation<double> blinkAnimation;
  late final Animation<double> scaleAnimation;

  PageController pageController = PageController();

  var currentPage = 0;

  @override
  void onInit() {
    blinkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..repeat(reverse: true);

    blinkAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(blinkController);
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.4).animate(blinkController);
    tabController = TabController(length: tabList.length, vsync: this);
    initializeTabs(); // New unified method
    Get.put(MembershipDetailController());
    homeApi();
    super.onInit();
  }

  void updateTabList(List<String> newTabs) {
    tabList = newTabs;
    tabController.dispose();
    tabController = TabController(length: tabList.length, vsync: Get.find());
    update();
  }

  @override
  void onClose() {
    blinkController.dispose();
    tabController.dispose();
    super.onClose();
  }
}
