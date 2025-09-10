import 'dart:convert';
import 'dart:io';
import 'package:chino_hills/util/services.dart';
import 'package:get/get.dart';
import '../Model/RewardDetailsModel.dart';
import '../Model/availRewardModel.dart';
import '../Model/best_selling_model.dart';
import '../Model/body_Area.dart';
import '../Model/brows_detail_model.dart';
import '../Model/browse_Model.dart';
import '../Model/card_detail_model.dart';
import '../Model/choose_client_model.dart';
import '../Model/client_list_model.dart';
import '../Model/detail_browse_model.dart';
import '../Model/discover_model.dart';
import '../Model/dynamic_tab_model.dart';
import '../Model/fetch_memberShip_perks.dart';
import '../Model/home_model.dart';
import '../Model/member_ship_details_model.dart';
import '../Model/member_ship_model.dart';
import '../Model/new_browse_model.dart';
import '../Model/offer_detail_model.dart';
import '../Model/offer_list_model.dart';
import '../Model/order_detail_model.dart';
import '../Model/orer_list_model.dart';
import '../Model/packageModel.dart';
import '../Model/package_details_model.dart';
import '../Model/promode_reward_model.dart';
import '../Model/search_client_model.dart';
import '../Model/signup_reward_model.dart';
import '../Model/special_offers_model.dart';
import '../Model/tab_list_model.dart';
import '../Model/term_condition_model.dart';
import '../Model/treatment_details_model.dart';
import '../Model/treatment_list_model.dart';
import '../Model/view_client_model.dart';
import 'common_page.dart';
import 'local_stoage.dart';
import 'local_store_data.dart';

//Todo this page contains all base the base API'S for NIMA app.
LocalStorage localStorage = LocalStorage();

Future hitAllPackageAPI(
  List<String> selectedOptions,
  List<String> selectedArea,
  String selectFilter,
) async {
  String concernId = selectedOptions
      .toString()
      .replaceAll("[", "")
      .replaceAll("]", "")
      .removeAllWhitespace;
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  String bId = selectedArea.toString().replaceAll("[", "").replaceAll("]", "");
  var api =
      "${CommonPage().api1}/packageslist&concern_id=${concernId}&body_area_ids=${bId}&sort_by=${selectFilter}&client_id=${clientId}&user_id=$userId";
  Get.log("Package API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Package API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        // print("Decoded data :=> ${decodedData['data']}");
        return ShopModel.fromJson(decodedData);
      } else {
        // return decodedData['message'];
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//Todo Hit the Treatment API
Future hitAllTreatmentAPI(
  var selectedOptions,
  selectedArea,
  selectFilter,
) async {
  String concernId = selectedOptions
      .toString()
      .replaceAll("[", "")
      .replaceAll("]", "");
  String bId = selectedArea.toString().replaceAll("[", "").replaceAll("]", "");
  //get client id from local storage
  var clientId = await localStorage.getCId();
  var uId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/treatmentslist&user_id=$uId&concern_id=${concernId}&body_area_ids=${bId}&sort=${selectFilter}&client_id=$clientId";
  Get.log("Treatment API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log(" Treatment API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return TreatmentListModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//Todo Treatment Deatails
Future hitAllTreatmentDetailsAPI(var id) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/treatmentdetails&treatment_id=$id&client_id=$clientId&user_id=$userId";
  Get.log("TreatmentDetailsAPI  : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("TreatmentDetailsAPI Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return TreatmentDetailsModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}
// Hit the PackagesDetails API
Future hitPackagesDetailsAPI(var id) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/packagesdetails&package_id=$id&client_id=${clientId}&user_id=${userId}";
  Get.log("Packages DetailsAPI  : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Packages DetailsAPI Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return PackageDetailsModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? TODO :-- Hit the MemberShip Details API
Future hitMemberShipDetailsAPI(var id) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  Get.log("membership : $id");
  var api =
      "${CommonPage().api1}/membership&membership_id=$id&client_id=$clientId&user_id=$userId";
  Get.log("MemberShip DetailsAPI  : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("MemberShip DetailsAPI Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return MemberShipDetailsModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitHomeApi() async {
  //get client id from local storage
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/homePage&client_id=$clientId&user_id=${userId}";
  Get.log("homePage API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Home API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        // print("Decoded data :=> ${decodedData['data']}");
        return HomeModel.fromJson(decodedData);
      } else {
        // return decodedData['message'];
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? Hit the Best Selling API..
Future hitBestSellingAPI() async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api}/bestsellers&client_id=${clientId}&user_id=${userId}";
  Get.log("BesSelling API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("BesSelling API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return BestSellingModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//TODO >>  Hit the Best Selling API..
Future hitSpecialOffersAPI() async {
  try {
    var clientId = await localStorage.getCId();
    var userId = await localStorage.getUId();
    var api =
        "${CommonPage().api}/promocode&user_id=$userId&client_id=${clientId}";
    Get.log("SpecialOffers API : $api");
    var response = await baseServiceGet(api, {}, "");
    Get.log("SpecialOffers API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return SpecialOffersModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAllBrowseAPI() async {
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api1}/browseByConcern&client_id=$clientId";
  Get.log("browseByConcern : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("browseByConcern : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        // print("Decoded data :=> ${decodedData['data']}");
        return BrowseModel.fromJson(decodedData);
      } else {
        // return decodedData['message'];
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAllenabledBrowseAPI(var concern_id, var filterusedat) async {
  String concernId = concern_id
      .toString()
      .replaceAll("[", "")
      .replaceAll("]", "")
      .removeAllWhitespace;
  var clientId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/fetchEnableDisableConcerns&client_id=$clientId&concern_id=$concernId&filter_used_at=$filterusedat";
  Get.log("fetchEnableDisableConcerns API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("fetchEnableDisableConcerns : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        // print("Decoded data :=> ${decodedData['data']}");
        return NewBrowseModel.fromJson(decodedData);
      } else {
        // return decodedData['message'];
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//todo membership API
Future hitAllMemberShipAPI() async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/membershipslist&client_id=$clientId&user_id=$userId";
  Get.log("Package API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      return MemberShipModel.fromJson(decodedData);
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future<DynaminTabModel> getCustomCategoryLists(String dynamicId) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();

  var api =
      "${CommonPage().api1}/customcategorylists&client_id=$clientId&custom_category_id=$dynamicId&user_id=$userId";

  print("API: $api");

  try {
    final response = await baseServiceGet(api, {}, "");
    print("RESPONSE: ${response.body}");

    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return DynaminTabModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitbodyAreaAPI() async {
  var clientId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/fetchBodyAreasForTreatment&client_id=$clientId";
  Get.log("fetchBodyAreasForTreatment: $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    print("fetchBodyAreasForTreatment: " + response.body);

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return BodyAreaModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAllMemberShipFetchAPI() async {
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api}/fetchMemberShipPerks&client_id=$clientId";
  Get.log("Package API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("shop API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return FethMeberShipPerks.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAlBrowsBConcernAPI(String id, sortBy, selectFilter) async {
  //get client id from local storage
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  /*&sort_by=${sortBy}&filter_by=$selectFilter&*/
  var api =
      "${CommonPage().api1}/browseByConcernList&client_id=$clientId&user_id=$userId&concern_id=$id";
  Get.log("brows API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("brows API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return BrowseDetailModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAvailableRewardAPI() async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/rewardslist&user_id=${userId}&client_id=${clientId}";
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("available : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return AvailRewardModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitSearchClient(zipCode, userId) async {
  var api =
      "${CommonPage().api}/clientsLocation&zipcode=${int.parse(zipCode)}&user_id=$userId";
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("hitSearchClient : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return ClientListModell.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitSelectClient(id) async {
  var uId = await localStorage.getUId();
  var api = "${CommonPage().api}/addClients&client_id=$id&user_id=${uId}";
  print(api);
  try {
    var response = await baseServicePost(api, {}, "");
    print("hitSearchClient : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return ChooseClientModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitscanRewardAPI(clinic_id) async {
  //user id call
  var userId = await localStorage.getUId();
  var api = "${CommonPage().api1}/scanRewards";
  Map<String, dynamic> map = {"client_id": clinic_id, "user_id": userId};
  print(api);
  print(map);
  //todo user id call
  try {
    var response = await baseServicePost(api, map, "");
    print("available : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData != null) {
        return decodedData;
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitDiscoverAPI() async {
  try {
    var clientId = await localStorage.getCId();
    var userId = await localStorage.getUId();
    var api = "${CommonPage().api1}/discoverlist&client_id=${clientId}";
    Get.log("Discover Get API :$api");
    var response = await baseServiceGet(api, {}, "");
    Get.log("Discover Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return DiscoverModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitSearchLocationAPI() async {
  try {
    var clientId = await localStorage.getCId();
    var api = "${CommonPage().api}/clientListing&client_id=$clientId";
    var response = await baseServiceGet(api, {}, "");
    Get.log("Discover Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return SearchClientModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitViewClient() async {
  try {
    var userId = await localStorage.getUId();
    var api = "${CommonPage().api}/clientsForUsers&user_id=${userId}";
    print(api);
    var response = await baseServiceGet(api, {}, "");
    Get.log("Discover Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return ViewClientModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAddCartAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api1}/cart";
  print(api);
  try {
    var response = await baseServicePost(api, map, "");
    print("All cart Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return decodedData;
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitTabList() async {
  var cId = await localStorage.getCId();
  var api = "${CommonPage().api1}/getCustomCategories&client_id=$cId";
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("All cart Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return TabListModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitGetProfileDetail() async {
  var uId = await localStorage.getUId();
  var api = "${CommonPage().api}/profileDetails&user_id=$uId";
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("User Data API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        // print("Decoded data :=> ${decodedData['data']}");
        return decodedData;
      } else {
        // return decodedData['message'];
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future<dynamic> hitCartListApi() async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();

  var api = "${CommonPage().api1}/cart&user_id=$userId&client_id=$clientId";
  Get.log("Cartlist API: $api");

  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("CART LIST Response :: ${response.body}");

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      Get.log("Decoded data: $decodedData");

      if (decodedData["cartItems"] != null &&
          decodedData["cartItems"] is List) {
        List cartItems = decodedData["cartItems"];
        Get.log("CartItems List: $cartItems");

        List<int> cartItemIds = [];

        for (var item in cartItems) {
          if (item["cart_item_id"] != null) {
            cartItemIds.add(item["cart_item_id"]);
          }
        }


        Get.log("Extracted Cart Item IDs: $cartItemIds");

        await localStorage.saveData("cart_item_ids", jsonEncode(cartItemIds));
        Get.log("Stored cart item IDs: $cartItemIds");
      }

      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  } catch (e) {
    Get.log("Error in hitCartListApi: $e");
  }

  return null;
}

Future<dynamic> hitLearnDetail(id) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();

  var api =
      "${CommonPage().api1}/offerDetails&offer_id=$id&client_id=$clientId";
  Get.log("offer API: $api");

  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("CART LIST Response :: ${response.body}");

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      Get.log("Decoded data: $decodedData");

      return OfferDetailModel.fromJson(decodedData);
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  } catch (e) {
    Get.log("Error in hitCartListApi: $e");
  }

  return null;
}

hitOrderListApi() async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api = "${CommonPage().api1}/orders&user_id=$userId&client_id=${clientId}";
  Get.log("OrderList :$api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Order LIST Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return OrderListModel.fromJson(decodedData);
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//
hitOrderDetailApi(orderId) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/orders&order_id=$orderId&user_id=$userId&client_id=${clientId}";
  Get.log("OrderList :$api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Order LIST Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return OrderDetailModel.fromJson(decodedData);
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

hitTermConditionApi() async {
  var clientId = await localStorage.getCId();

  var api = "${CommonPage().api}/fetchAggrement&client_id=$clientId";
  Get.log("TermsCondition API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    // Get.log("TermsCondition Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return TermConditionModel.fromJson(decodedData);
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

hitDeleteCartApi(cardID) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/cart&user_id=$userId&cart_item_id=$cardID&client_id=${clientId}";
  print("Delete Cart Item :$api");
  try {
    var response = await baseServiceDelete(api, {}, "");
    print("Delete items from cart  :: ${response.body}");
    if (response.statusCode == 200) {

      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return decodedData;
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitCartDetailAPI(id) async {
  var clientId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/contentCardDetails&id=$id&client_id=${clientId}";
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("All cart Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return CardDetailModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAllOfferAPI() async {
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api}/offerList&client_id=${clientId}";
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("All cart Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return OfferListModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hiRegisterAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api}/login";
  Get.log("Register API : $api");
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Register API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitUpdateProviderAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api}/profileDetails";
  Get.log("Update User Details API : $api");
  print(map);
  try {
    var response = await baseServicePut(api, map, "");
    Get.log("Update User Details API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitOTPApi(phoneNumber, otp) async {
  var api =
      "${CommonPage().api}/loginWithNumber&phone_number=$phoneNumber&otp=$otp";
  Get.log("Verity OTP API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Verity OTP Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//! Hit User Login

Future hiLoginAPI(Map<String, dynamic> map) async {
  // var api = "${CommonPage().api}/userLoginWithNumber";
  var api = "${CommonPage().api1}/loginWithNumber";
  Get.log("Login API : $api");
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Login API  Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitUserAPI() async {
  var api = "${CommonPage().api1}/getClientId&client_email=info@scanacart.com";
  Get.log("Login API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Login API  Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//! Hit the AppLogo APi

Future hitAppLogoAPI() async {
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api}/fetchLogo&client_id=$clientId";
  Get.log("AppLogoAPI : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("AppLogo API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//! Complete Profile User API...
Future hitUserCompleteProfileAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api}/registerDetails";
  Get.log("Complete User Details API : $api");
  print(map);
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Complete User Details API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//! Here we HIt the SignUp Reward
Future hitSignUpRewardAPI() async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api}/signUpRewards&user_id=${userId}&client_id=${clientId}";
  Get.log("SignUpReward API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("SignUpReward API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return SignupRewardModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

// TODO ?? Hit the Reward Details API..
Future hitAllRewardDetailsAPI(var id) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api}/signup_treatments&reward_id=$id&client_id=${clientId}";
  Get.log("Reward Details API  : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("RewardDetails API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return RewardDetailsModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? TODO ??  Hitting the browser API Here ...
Future hitBrowserAPI() async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/browserlist&client_id=${clientId}&user_id=${userId}";
  Get.log("Browser API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Browser API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return DetailBrowseModel.fromJson(decodedData);
        // return HomeModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? TODO ??  Hitting the browser Our Services API Here ...
Future hitOurServicesAPI() async {
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api}/browseServices&client_id=${clientId}";
  Get.log("Our Services API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Our Services API Response : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return decodedData;
        // return HomeModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? Todo ?? Hit here the cart update api..
Future hitUpdateCartListAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api}/showCartList";
  Get.log("Update CartList API : $api");
  try {
    var response = await baseServicePut(api, map, "");
    Get.log("Update CartList API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? Todo ?? Hit here the cart update api..
Future hitCreateOrder(Map<String, dynamic> map) async {
  var api = "${CommonPage().api1}/createOrder";
  Get.log("Update CartList API : $api");
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Update CartList API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? Todo ?? Hit here the clear the cart api..
Future hitClearTheCart(Map<String, dynamic> map) async {
  var api = "${CommonPage().api1}/payment";
  Get.log("Clear CartList API : $api");
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Clear CartList API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

// ? TODO ?? Search API
Future hitManageTrackingSearch(searchText) async {
  try {
    var clientId = await localStorage.getCId();
    var api =
        "${CommonPage().api}/search&searching_for=$searchText&client_id=${clientId}";
    Get.log("Search API : $api");
    var response = await baseServiceGet(api, {}, "");
    Get.log("Search response :: ${response.body}");
    if (response.statusCode == 200) {
      var parseData = jsonDecode(response.body);
      if (parseData['success'] == true) {
        return parseData;
      } else {
        throw Exception(parseData['message']);
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//todo Apply the coupon code ..
Future hiApplyCouponCodeAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api1}/applyPromoCode";
  Get.log("Apply Promo Code API : $api");
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Apply Promo Code API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//todo Apply the Available reward code ...
Future hiApplyAvailableAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api1}/applyReward";
  Get.log("Apply Available Code API : $api");
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Apply Available Code API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hiApplyMembershipAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api1}/applyMembership";
  Get.log("Apply Available Code API : $api");
  try {
    var response = await baseServicePost(api, map, "");
    Get.log("Apply Available Code API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//? Remove the Reard ...
Future hiRemoveCouponCodeAPI(rewardId, cartID) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/applyReward&reward_id=$rewardId&user_id=$userId&cart_id=$cartID&client_id=${clientId}";
  Get.log("Remove Promo Code API : $api");
  try {
    var response = await baseServiceDelete(api, {}, "");
    Get.log("Remove Promo Code API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}
// 4086343220

//? Remove PromoCOde
Future hitRemoveAddedCouponAPI(promoId, cartID) async {
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/applyPromoCode&promo_code_id=$promoId&user_id=$userId&cart_id=$cartID&client_id=${clientId}";
  Get.log("Remove Promo Code API : $api");

  try {
    var response = await baseServiceDelete(api, {}, "");
    Get.log("Remove Promo Code API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      return decodedData;
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

// Todo  >>
Future hitPromoRewardAPI(t_id, p_id, m_id) async {
  // Construct the proper URL
  var clientId = await localStorage.getCId();
  var userId = await localStorage.getUId();
  var api =
      "${CommonPage().api1}/PromoAndRewardOffers&user_id=$userId&client_id=${clientId}";
  Get.log("PromoCode Reward Get APi :$api");
  try {
    var response = await baseServiceGet(api, {}, "");
    print("PromoCode available : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return PromoRewardModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}
