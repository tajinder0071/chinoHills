import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../Model/browse_Model.dart';
import '../../../../../Model/detail_browse_model.dart';
import '../../../../../Model/member_ship_model.dart' hide Membership;
import '../../../../../Model/body_Area.dart';
import '../../../../../Model/fetch_memberShip_perks.dart';
import '../../../../../Model/new_browse_model.dart';
import '../../../../../Model/packageModel.dart';
import '../../../../../Model/package_details_model.dart';
import '../../../../../common_Widgets/added_to_cart_bottom_sheet.dart';
import '../../../../../util/base_services.dart';
import '../../../../../util/local_store_data.dart';
import '../../../../cartList/Controller/cart_controller.dart';

class PackageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static PackageController get instance => Get.find();

  //TODO >>  Variable Declarations
  bool isMemberChecked = false;
  final List bodyValue = [];
  final List concernValue = [];
  List<Packages> shopDatum = [];
  List<ConcernDatum> browseDatum = [];
  List<NewDatum> Datum = [];
  List<DatumMemeber> perkList = [];
  List concern = [];
  List concern1 = [];
  List<BodyDatum> bodyList = [];
  List bodyArea = [];
  List<MembershipPerk> membershipPerk = [];
  List<Membership> memberships = [];
  List<BrowseCategory> browseCategory = [];
  List<ConcernImageDatum> browseImageDatum = [];
  List<OfferCards> offerCards = [];
  var discountPrice = "".obs;
  var load = false;
  var bload = false;
  var isLoading = false;
  List<MembershipData> memberShip = [];
  LocalStorage localStorage = LocalStorage();
  PackageDetailsModel packageDetailsModel = PackageDetailsModel();
  PageController pageController = PageController();
  MemberShipModel response = MemberShipModel();
  DetailBrowseModel browseDetailModel = DetailBrowseModel();
  ShopModel model = ShopModel();
  var currentPage = 0.obs;
  bool isAddingCart = false;
  var selectFilter = "";
  List<int> selectFilterValue = [];
  List filter = [
    {"title": "Price: Low to High"},
    {"title": "Price: High to Low"},
    {"title": "Recently added"},
  ];
  List filterBack = [
    {"title": "Low_to_high"},
    {"title": "High_to_low"},
    {"title": "Recently_added"},
  ];

  var packageHeaderImage = "";

  @override
  onInit() {
    super.onInit();
    memberShipList();
    memberShipFetch();
    browseList();
    memprice = '';
  }

  int selectedIndex = 0;
  var price;
  var memprice;

  void selectTreatment(int index, var pkgPrice, memberPrice) {
    selectedIndex = index;
    quantity = index + 1;
    price = pkgPrice;
    memprice = memberPrice;
    update(); // This triggers GetBuilder to rebuild
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  String? selectedSort;

  var totalCount = 0;

  List<String> selectedOptions = [];
  List<String> selectedArea = [];

  void updateSort(String? value) {
    selectedSort = value;
    update();
  }

  Future<void> packageList(
    List<String> selectedOptions,
    List<String> selectedArea,
    String selectFilter,
  ) async {
    load = true;
    // update();
    try {
      shopDatum.clear();
      model = await hitAllPackageAPI(
        selectedOptions,
        selectedArea,
        selectFilter,
      );
      shopDatum.addAll(model.packages!);
      packageHeaderImage = model.headerDetails!.headerImage ?? "";
      load = false;
      update();
    } on Exception catch (e) {
      load = false;
      update();
    }
  }

  Future<void> browseList() async {
    bload = true;

    // update();
    try {
      BrowseModel response = await hitAllBrowseAPI();
      browseImageDatum.clear();
      browseImageDatum = [];
      browseDatum.clear();
      browseDatum = [];
      concern.clear();
      browseDatum.addAll(response.data!);
      browseImageDatum.addAll(response.concernImageData!);
      browseDatum.forEach((e) {
        concern.add({"id": e.id.toString(), "title": e.concernName.toString()});
      });
      bodyAreaList();
      bload = false;
      print("response==>${response}");
      update();
    } on Exception catch (e) {
      bload = false;
      bodyAreaList();
      update();
    }
  }

  Future<void> enabledBrowseAPI(String name) async {
    bload = true;

    try {
      String filterusedat = name;
      var concern_id = selectedOptions.toString();
      NewBrowseModel response = await hitAllenabledBrowseAPI(
        concern_id,
        filterusedat,
      );

      Datum.clear();

      if (response.data != null) {
        Datum.addAll(response.data!); // ✅ Fixed here
      }

      // bodyAreaList();
      bload = false;
      print("response==>${response}");
      update();
    } on Exception catch (e) {
      bload = false;
      // bodyAreaList();
      update();
    }
  }

  Future<void> bodyAreaList() async {
    bload = true;
    bodyList.clear();
    bodyList = [];
    bodyArea.clear();
    // update();
    try {
      BodyAreaModel response = await hitbodyAreaAPI();
      bodyList.addAll(response.data!);
      bodyList.forEach((e) {
        bodyArea.add({"id": e.id.toString(), "title": e.bodyName.toString()});
      });
      bload = false;
      update();
    } on Exception catch (e) {
      bload = false;
      update();
    }
  }

  Future<void> memberShipList() async {
    bload = true;
    try {
      memberShip.clear();
      response = await hitAllMemberShipAPI();
      memberShip.addAll(response.memberships!);
      bload = false;
      update();
    } on Exception catch (e) {
      bload = false;
      update();
    }
  }

  Future<void> memberShipFetch() async {
    bload = true;
    perkList.clear();
    perkList = [];
    // update();
    try {
      FethMeberShipPerks response = await hitAllMemberShipFetchAPI();
      perkList.addAll(response.data!);
      totalCount = int.tryParse(response.totalCount.toString())!;
      bload = false;
      print("response memberShipFetch==>${response.data!}");
      update();
    } on Exception catch (e) {
      bload = false;
      update();
    }
  }

  var quantity;

  // Todo ?? Package details Page..
  Future<void> fetchDetailsPackages() async {
    isLoading = true;
    isMemberChecked = false;
    try {
      var packageId = Get.arguments ?? 0;
      print("Package IS :$packageId");
      packageDetailsModel = await hitPackagesDetailsAPI(packageId);
      var qt = packageDetailsModel.package!.packageQty.toInt();
      price = packageDetailsModel.package!.price;
      selectedIndex = 0;
      quantity = 0;
      for (int i = 0; qt > 0; i++) {
        quantity = i + 1;
        print(quantity);
        break;
      }
      isLoading = false;
      update();
    } on Exception catch (e) {
      isLoading = false;
      update();
      print("Excee  :$e");
    }
  }

  //? Todo // Scroll the image
  void changePage(int index) {
    currentPage.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Let's hit the addToCart API ...
  Future addToCart(
    bool isPackagebottom, {
    membershipId,
    memberShipPrice,
  }) async {
    isAddingCart = true;
    print("member==> $membershipId,$memberShipPrice");
    try {
      var clientId = await localStorage.getCId();
      var userId = await localStorage.getUId();
      Map<String, dynamic> map = isMemberChecked == true
          ? {
              "client_id": clientId,
              "user_id": userId,
              "CartDetails": {
                "type": "Packages",
                "package_id": packageDetailsModel.package!.packageId.toString(),
                "package_price": price,
                "package_qty": quantity,
                "become_membership": {
                  "membership_id": isMemberChecked ? membershipId : "",
                  "membership_price": isMemberChecked ? memberShipPrice : "",
                },
              },
            }
          : {
              "client_id": clientId,
              "user_id": userId,
              "CartDetails": {
                "type": "Packages",
                "package_id": packageDetailsModel.package!.packageId.toString(),
                "package_price": price,
                "package_qty": quantity,
              },
            };
      Get.log("Add To Cart Map  :$map");
      var response = await hitAddCartAPI(map);

      if (response['success'] == true) {
        if (isPackagebottom == true) {
          Get.back();
        }
        await Get.bottomSheet(
          AddedToCartBottomSheet(
            titleName: packageDetailsModel.package!.packageName ?? "",
            quantityName: 'package',
            price: price,
            isChecked: isMemberChecked ? true : false,
            membeTitleName: !isMemberChecked
                ? ""
                : packageDetailsModel.package!.membershipInfo!.membershipName ??
                      "",
            memberPrice: memberShipPrice ?? "",
            quantity: quantity,
          ),
          isDismissible: false,
          isScrollControlled: true,
        );
        CartController.cart.cartList();
        isAddingCart = false;
        update();
      }
      // Get.toNamed(RouteManager.cartList);
      isAddingCart = false;
      update();
    } on Exception catch (e) {
      print("the rror : $e");
      isAddingCart = false;

      update();
    }
  }

  // ? Todo ?? Getting here Browser Data..

  bool isBrowserLoading = false;
  List browserData = [];

  Future<void> getBrowserData() async {
    isBrowserLoading = true;
    try {
      memberships.clear();
      membershipPerk.clear();
      browseCategory.clear();
      offerCards.clear();
      print("membershipPerk===>${membershipPerk.length}");
      browseDetailModel = await hitBrowserAPI();
      membershipPerk.addAll(browseDetailModel.data!.membershipPerks!);
      browseCategory.addAll(browseDetailModel.data!.browseCategories!);
      memberships.addAll(browseDetailModel.data!.memberships!);
      offerCards.addAll(browseDetailModel.data!.offerCards!);
      print("membershipPerk==>${membershipPerk.length}");
      isBrowserLoading = false;
      update();
    } on Exception catch (e) {
      isBrowserLoading = false;
      update();
    }
  }

  //? Todo :-  Getting here Our Services ..
  bool isServicesLoading = false;
  List ourServicesData = [];

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool isclick = false;

  Future<void> handleRefresh() async {
    await getOurServices();
  }

  Future<void> handleRefreshPackage() async {
    await packageList([], [], "");
  }

  Future<void> handleRefreshBrows() async {
    await browseList();
  }

  Future<void> getOurServices() async {
    isServicesLoading = true;
    // update();
    try {
      var response = await hitOurServicesAPI();
      ourServicesData.clear();

      Get.log("Coming Services response  ::${response['success']}");
      ourServicesData.addAll(response['data']);
      isServicesLoading = false;
      update();
    } on Exception catch (e) {
      isServicesLoading = false;
      update();
    }
  }

  // Add: Reset filters and selections
  void resetFilters() {
    selectedOptions.clear();
    selectedArea.clear();
    selectFilter = "";
    selectFilterValue.clear();
    update();
  }

  void onClick() {
    if (isclick == false) {
      isclick = true;
      update();
    } else {
      isclick = false;
      update();
    }
  }
}
