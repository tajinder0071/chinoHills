import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CSS/color.dart';
import '../../../Model/best_selling_model.dart';
import '../../../Model/home_model.dart';
import '../../../Model/packageModel.dart';
import '../../../util/base_services.dart';
import '../../../Model/special_offers_model.dart';
import '../../../Model/visit_model.dart';
import '../../../../../util/local_store_data.dart';
import '../../Dashboard/Home/controller/membership_detail_controller.dart';
import '../Pages/Package Page/controller/package_cotroller.dart';

class ShopController extends GetxController with GetTickerProviderStateMixin {
  static ShopController get shop => Get.find();

  static PackageController get PackController => Get.find();
  late TabController tabController;
  List<PackageDatum> shopDatum = [];
  List<HomeDatum> homeData = [];
  var load = false;
  var userName;
  LocalStorage localStorage = LocalStorage();
  var image;
  int count = 0;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> handleRefresh() async {
    await homeApi();
    await fetchSpecialOfferData();
    await getShopByItem();
    await PackController.memberShipList();
    await PackController.memberShipFetch();
  }

  getShopByItem() async {
    userName = await localStorage.getName();
    var userId = await localStorage.getUId();
    Get.log("Is user_name : $userName  $userId");
    count = await localStorage.getindex() ?? 0;
    Get.log("the get :${count}");
    tabController = TabController(length: 5, vsync: this, initialIndex: count);
    update();
  }

  Future<void> homeApi() async {
    load = true;
    homeData.clear(); // Redundant assignment to [] removed
    update();

    try {
      HomeModel response = await hitHomeApi();
      print("Home Api :: $response");

      homeData.addAll(response.data!);

      // Handle dynamic color from the first item
      String hex = homeData[0].color.toString().replaceAll('#', '');
      if (hex.length == 6) hex = 'FF$hex';
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
    tabController.animateTo(index);
  }

  List<Datum> datum = [];
  bool vload = false;

  Future<void> visitList() async {
    datum.clear();
    datum = [];
    vload = true;
    update();
    try {
      VisitModel response = await hitAllVisitAPI();
      vload = false;
      datum.addAll(response.data!);
      print("response==>${response.data}");
      update();
    } on Exception catch (e) {
      vload = false;
      update();
    }
  }

  //? TODO ?? Method for best selling
  bool isBestLoading = false;
  List<BestTreatment> treatment = [];
  List<BestPackage> package = [];

  Future<void> bestSellingData() async {
    isBestLoading = true;
    update();
    try {
      treatment.clear();
      package.clear();
      BestSellingModel response = await hitBestSellingAPI();
      treatment.addAll(response.treatments!);
      package.addAll(response.packages!);
      print("The::: ${treatment.length}");
      isBestLoading = false;
      update();
    } on Exception catch (e) {
      Get.log("Exception : $e");
      isBestLoading = false;
      update();
    }
  }

  // TODO >> Getting here the Special Offers....
  bool isSpecialOfferLoading = false;
  List<SpecialOffersData> specialDataList = [];

  Future<void> fetchSpecialOfferData() async {
    isSpecialOfferLoading = true;
    specialDataList.clear();
    specialDataList = [];
    // update();
    try {
      SpecialOffersModel response = await hitSpecialOffersAPI();
      specialDataList.addAll(response.data!);
      Get.log("SpecialOffers :$specialDataList");
      isSpecialOfferLoading = false;
      update();
    } on Exception catch (e) {
      Get.log("Exception : $e");
      isSpecialOfferLoading = false;
      update();
    }
  }

  // TODO >> Define here the Special Offers Section...
  late final AnimationController blinkController;
  late final Animation<double> blinkAnimation;
  late final Animation<double> scaleAnimation;

  @override
  void onInit() {
    blinkController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    blinkAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(blinkController);
    scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.4,
    ).animate(blinkController);
    getShopByItem();
    Get.put(MembershipDetailController());
    homeApi();
    bestSellingData();
    fetchSpecialOfferData();
    visitList();
    super.onInit();
  }

  @override
  void onClose() {
    blinkController.dispose();
    super.onClose();
  }
}
