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
import '../Model/card_list_model.dart';
import '../Model/choose_client_model.dart';
import '../Model/client_list_model.dart';
import '../Model/discover_model.dart';
import '../Model/fetch_memberShip_perks.dart';
import '../Model/home_model.dart';
import '../Model/member_ship_details_model.dart';
import '../Model/member_ship_model.dart';
import '../Model/new_browse_model.dart';
import '../Model/offer_list_model.dart';
import '../Model/order_detail_model.dart';
import '../Model/orer_list_model.dart';
import '../Model/packageModel.dart';
import '../Model/package_details_model.dart';
import '../Model/promode_reward_model.dart';
import '../Model/search_client_model.dart';
import '../Model/signup_reward_model.dart';
import '../Model/special_offers_model.dart';
import '../Model/term_condition_model.dart';
import '../Model/treatment_details_model.dart';
import '../Model/treatment_list_model.dart';
import '../Model/treatment_model.dart';
import '../Model/view_client_model.dart';
import '../Model/visit_model.dart';
import 'common_page.dart';
import 'local_stoage.dart';
import 'local_store_data.dart';

//Todo this page contains all base the base API'S for NIMA app.

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
  String bId = selectedArea.toString().replaceAll("[", "").replaceAll("]", "");
  var cId = await LocalStorage().getCId();
  var api =
      "${CommonPage().api}/packages&concern_id=${concernId}&body_area_ids=${bId}&sort=${selectFilter}&client_id=${cId}";
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
  print(concernId);
  //get client id from local storage
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/fetchTreatments&concern_id=${concernId}&body_area_ids=${bId}&sort=${selectFilter}&client_id=$clientId";
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
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/treatmentsDetails&treatment_id=$id&client_id=$clientId";
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
  var cId = await LocalStorage().getCId();
  var api =
      "${CommonPage().api}/packageDetails&package_id=$id&client_id=${cId}";
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
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/membershipDetails&membership_id=$id&client_id=$clientId";
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
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var user_id = await localStorage.getUId();
  var api =
      "${CommonPage().api}/homePage&client_id=$clientId&user_id=${user_id}";
  Get.log("homePage API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Package API Response : ${response.body}");
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
  var clientId = await LocalStorage().getCId();
  var user_id = await LocalStorage().getUId();
  var api =
      "${CommonPage().api}/bestsellers&client_id=${clientId}&user_id=${user_id}";
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
    LocalStorage localStorage = LocalStorage();
    var userId = await localStorage.getUId();
    var client_id = await LocalStorage().getCId();
    var api =
        "${CommonPage().api}/promocode&user_id=$userId&client_id=${client_id}";
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
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api}/browseByConcern&client_id=$clientId";
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
  LocalStorage localStorage = LocalStorage();
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
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api}/membershipListing&client_id=$clientId";
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

Future hitbodyAreaAPI() async {
  LocalStorage localStorage = LocalStorage();
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
  LocalStorage localStorage = LocalStorage();
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
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/browseByConcernListing&concern_id=$id&sort_by=${sortBy}&filter_by=$selectFilter&client_id=$clientId";
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

Future hitAllVisitAPI() async {
  //get user id from local storage
  LocalStorage localStorage = LocalStorage();
  var userId = await localStorage.getUId();
  var cId = await localStorage.getCId();
  var api = "${CommonPage().api}/visitRewards&user_id=$userId&client_id=${cId}";
  //https://devnima.scanacart.com/api/index.cfm?endpoint=/signUpRewards&user_id=332&client_id=1
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("VISTI RESPONE : ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return VisitModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAvailableRewardAPI() async {
  var user_id = await LocalStorage().getUId();
  var cId = await LocalStorage().getCId();
  var api =
      "${CommonPage().api}/signUpRewards&user_id=${user_id}&client_id=${cId}";
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
  var user_id = await LocalStorage().getUId();
  var api = "${CommonPage().api}/addClients&client_id=$id&user_id=${user_id}";
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
  LocalStorage localStorage = LocalStorage();
  var userId = await localStorage.getUId();
  var api = "${CommonPage().api}/visit_reward_history";
  Map<String, dynamic> map = {
    "client_id": clinic_id,
    "user_id": userId,
    "visit_type": "btn-in-office",
  };
  print(api);
  print(map);
  //todo user id call
  try {
    var response = await baseServicePost(api, map, "");
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

Future hitDiscoverAPI() async {
  try {
    LocalStorage localStorage = LocalStorage();
    var userId = await localStorage.getUId();
    var client_id = await LocalStorage().getCId();
    var api =
        "${CommonPage().api}/contentCardList&client_id=${client_id}&user_id=$userId";
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
    var api = "${CommonPage().api}/clientListing";
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
    var user_id = await LocalStorage().getUId();
    var api = "${CommonPage().api}/clientsForUsers&user_id=${user_id}";
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

Future hitSelectLocationAPI(map) async {
  try {
    var api = "${CommonPage().api}/clientListing";
    var response = await baseServiceGet(api, map, "");
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

Future hitAddCartAPI(Map<String, dynamic> map) async {
  var api = "${CommonPage().api}/showCartList";
  print(api);
  try {
    var response = await baseServicePost(api, map, "");
    print("All cart Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body.toString().toLowerCase());
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

Future hitGetProfileDetail() async {
  LocalStorage localStorage = LocalStorage();
  var userId = await localStorage.getUId();
  var api = "${CommonPage().api}/profileDetails&user_id=$userId";
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
  LocalStorage localStorage = LocalStorage();
  var userId = await localStorage.getUId();
  var clientId = await localStorage.getCId();

  var api = "${CommonPage().api}/ViewCart&user_id=$userId&client_id=$clientId";
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

hitOrderListApi(userId) async {
  var clientId = await LocalStorage().getCId();
  var api = "${CommonPage().api}/orders&user_id=$userId&client_id=${clientId}";
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
  LocalStorage localStorage = LocalStorage();
  var userId = await localStorage.getUId();
  var cId = await localStorage.getCId();
  var api =
      "${CommonPage().api}/orders&order_id=$orderId&user_id=$userId&client_id=${cId}";
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
  LocalStorage localStorage = LocalStorage();
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

hitDeleteCartApi(userID, cardID) async {
  var cId = await LocalStorage().getCId();
  var api =
      "${CommonPage().api}/showCartList&user_id=$userID&cart_item_id=$cardID&client_id=${cId}";
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
  var cId = await LocalStorage().getCId();
  var api = "${CommonPage().api}/contentCardDetails&id=$id&client_id=${cId}";
  print(api);
  try {
    var response = await baseServiceGet(api, {}, "");
    print("All cart Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        // print("Decoded data :=> ${decodedData['data']}");
        return CardDetailModel.fromJson(decodedData);
      } else {
        // return decodedData['message'];
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

Future hitAllOfferAPI() async {
  var cId = await LocalStorage().getCId();
  var api = "${CommonPage().api}/offerList&client_id=${cId}";
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

/*this is just to practice my typing speed nothing much just some random texts are write my a flutter developer*/
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
      "${CommonPage().api1}/loginWithNumber&phone_number=$phoneNumber&otp=$otp";
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

//! Hit the TreatmentAPI
Future hitTreatmentAPI() async {
  LocalStorage localStorage = LocalStorage();
  var clientId = await localStorage.getCId();
  var api = "${CommonPage().api}/fetchTreatment&client_id=$clientId";
  Get.log("TreatmentAPI : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Treatment API Response :: ${response.body}");
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      if (decodedData['success'] == true) {
        return TreatmentModel.fromJson(decodedData);
      } else {
        throw Exception(decodedData['message'] ?? 'Unknown error');
      }
    }
  } on SocketException {
    throw Exception('No Internet Connection');
  }
}

//! Hit the AppLogo APi

Future hitAppLogoAPI() async {
  LocalStorage localStorage = LocalStorage();
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
Future hitSignUpRewardAPI(client_id) async {
  var cId = await LocalStorage().getCId();
  var uId = await LocalStorage().getUId();
  var api =
      "${CommonPage().api}/signUpRewards&user_id=${uId}&client_id=${client_id == null || client_id == "" ? cId : client_id}";
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
  var cId = await LocalStorage().getCId();
  var api =
      "${CommonPage().api}/signup_treatments&reward_id=$id&client_id=${cId}";
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
  var cId = await LocalStorage().getCId();
  var api = "${CommonPage().api}/shopBrowse&client_id=${cId}";
  Get.log("Browser API : $api");
  try {
    var response = await baseServiceGet(api, {}, "");
    Get.log("Browser API Response : ${response.body}");
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

//? TODO ??  Hitting the browser Our Services API Here ...
Future hitOurServicesAPI() async {
  var cId = await LocalStorage().getCId();
  var api = "${CommonPage().api}/browseServices&client_id=${cId}";
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
  var api = "${CommonPage().api}/createOrder";
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
  var api = "${CommonPage().api}/payment";
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
  var cId = await LocalStorage().getCId();
  try {
    var api =
        "${CommonPage().api}/search&searching_for=$searchText&client_id=${cId}";
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
  var api = "${CommonPage().api}/promoCode";
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
  var api = "${CommonPage().api}/rewardOffer";
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
Future hiRemoveCouponCodeAPI(rewardId, userId, cartID) async {
  var cId = await LocalStorage().getCId();
  var api =
      "${CommonPage().api}/rewardOffer&reward_id=$rewardId&user_id=$userId&cart_id=$cartID&client_id=${cId}";
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
Future hitRemoveAddedCouponAPI(promoId, userId, cartID) async {
  var cId = await LocalStorage().getCId();
  var api =
      "${CommonPage().api}/promoCode&promo_code_id=$promoId&user_id=$userId&cart_id=$cartID&client_id=${cId}";
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
Future hitPromoRewardAPI(userID, t_id, p_id, m_id) async {
  var cId = await LocalStorage().getCId();
  // Construct the proper URL
  var api =
      "${CommonPage().api}/PromoAndRewardOffers&user_id=$userID&treatment_variation_id=${t_id.toString().replaceAll("[", "").replaceAll("]", "").removeAllWhitespace ?? 0}&package_id=${p_id.toString().replaceAll("[", "").replaceAll("]", "").removeAllWhitespace ?? 0}&membership_id=${m_id.toString().replaceAll("[", "").replaceAll("]", "").removeAllWhitespace ?? 0}&client_id=${cId}";
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
