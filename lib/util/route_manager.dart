import 'package:get/get.dart';

import '../Model/detail_browse_model.dart';
import '../Model/discover_model.dart' as discover;

import '../Screens/Account/widget/accountDetail.dart';
import '../Screens/Account/widget/setting_page.dart';
import '../Screens/Complete Profile/complete_profile.dart';
import '../Screens/Dashboard/Home/widget/learn_more_page.dart';
import '../Screens/Dashboard/Home/widget/members_ship_details_page.dart';
import '../Screens/Dashboard/Home/widget/scqn_qr.dart';
import '../Screens/Dashboard/Home/widget/search_page.dart';
import '../Screens/Dashboard/dashboard_screen.dart';
import '../Screens/Login/login_page.dart';
import '../Screens/Offers/offerPage.dart';
import '../Screens/Offers/widget/offer_dfetail.dart';
import '../Screens/Otp Page/otp_verification_page.dart';
import '../Screens/Register/controller/register_controller.dart';
import '../Screens/Register/register_page.dart';
import '../Screens/Reward/widget/reward_detail_screen.dart';
import '../Screens/SelectClients/select_location.dart';
import '../Screens/SelectClients/widget/find_your_location.dart';
import '../Screens/SelectClients/widget/search_by_client.dart';
import '../Screens/Signup Reward Page/signup_reward_page.dart';
import '../Screens/Signup Reward Page/widgets/refer_friends_widgets.dart';
import '../Screens/cartList/cart_list.dart';
import '../Screens/order/order_list.dart';
import '../Screens/shop/Pages/BrowseByConcern/widgets/brows_concern_detail.dart';
import '../Screens/shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../binding/cart_billing.dart';

class RouteManager {
  //TODO >> define route name
  static const loginPage = "/LoginPage";
  static const registerPage = "/RegisterPage";
  static const dashBoardPage = "/DashboardPage";
  static const completeProfile = "/CompleteProfile";
  static const otpVerificationPage = "/OTPVerificationPage";
  static const qRCodeScannerPage = "/QRCodeScannerPage";
  static const selectLocationPage = "/selectLocationPage";
  static const offersPage = "/OffersPage";
  static const accountDetail = "/accountDeatil";
  static const orderHistory = '/order-history';
  static const cartList = '/cart_list';
  static const learnMore = '/learnMore';
  static const offerDataLearnMore = '/offerDataLearnMore';
  static const shoppingCart = '/shopping_cart';

  //select clinic
  static const selectClinic = '/selectClinic';
  static const rewardUnlockedScreen = '/RewardUnlockedScreen';
  static const referFriendPage = '/ReferFriendPage';
  static const membersShipDetailsPage = '/MembersShipDetailsPage';
  static const browseConcernDetail = '/browseConcernDetail';

  static const treatmentDetails = '/treatmentDetails';
  static const searchPage = '/searchPage';
  static const settingsTab = '/SettingsTab';
  static const orderPage = '/orderPage';
  static const rewardDetailScreen = '/rewardDetailScreen';

  // TODO >> define route page
  static final routes = [
    // TODO << SearchPage

    GetPage(
      name: searchPage,
      page: () => SearchPage(),
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: rewardDetailScreen,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        var id = args['id'];
        var title = args['title'];
        return RewardDetailScreen(
            id: id, title: title); // Pass `id` if required by the screen
      },
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    //select clinic page
    GetPage(
      name: selectClinic,
      page: () {
        var fromSomeFlow = Get.arguments.toString() ?? "false";
        print("fromSomeFlow$fromSomeFlow");
        return SearchByClient(fromSomeFlow);
      },
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: selectLocationPage,
      page: () => SelectLocation(),
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: settingsTab,
      page: () => SettingsTab(),
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: orderPage,
      page: () => OrderList(),
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),

    GetPage(
      name: membersShipDetailsPage,
      page: () {
        var onlyShow = Get.parameters['onlyShow'];
        return MembersShipDetailsPage(
          onlyShow: onlyShow == "0" ? false : true,
        );
      },
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: browseConcernDetail,
      page: () {
        var uid = Get.arguments;
        return BrowsConcernDetail(uid);
      },
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: offersPage,
      page: () => OffersPage(),
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: cartList,
      page: () => CartList(),
      transition: Transition.fadeIn,
      maintainState: true,
      binding: CommonBinding(),
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: learnMore,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final OfferCards? data = args['specialOffer'];
        final int? id = args['id'];
        final discover.ContentCard? cardData = args['cardData'];
        final bool isExpired = args['isExpired'] ?? false;
        if (args.containsKey('specialOffer')) {
          discover.ServiceType parseServiceType(String? value) {
            if (value == null) return discover.ServiceType.PACKAGE;

            return discover.ServiceType.values.firstWhere(
                  (val) =>
              val.name.toUpperCase() ==
                  value.replaceAll("ServiceType.", "").trim().toUpperCase(),
              orElse: () {
                print("Unknown type: $value");
                return discover.ServiceType.PACKAGE;
              },
            );
          }
        }
        return LearnMorePage(
          isExpire: isExpired,
          id: id,
          cardData: cardData,
        );
      },
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),

    GetPage(
      name: offerDataLearnMore,
      page: () {
        var offerData = Get.arguments;
        return OfferDetail(offerData);
      },
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),

    GetPage(
      name: accountDetail,
      page: () {
        return AccountDetail();
      },
      transition: Transition.fadeIn,
      maintainState: false,
      binding: CommonBinding(),
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: orderHistory,
      page: () {
        return OrderList();
      },
      transition: Transition.fadeIn,
      maintainState: false,
      binding: CommonBinding(),
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: qRCodeScannerPage,
      page: () => QRCodeScannerPage(),
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: true,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: otpVerificationPage,
      page: () {
        var phoneNumber = Get.parameters['phoneNumber'] ?? '';
        return OtpVerificationPage(phoneNumber: phoneNumber.toString());
      },
      transition: Transition.fadeIn,
      maintainState: false,
      binding: CommonBinding(),
      transitionDuration: Duration(milliseconds: 100),
      popGesture: false,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: loginPage,
      page: () => LoginPage(),
      transition: Transition.fadeIn,
      maintainState: false,
      transitionDuration: Duration(seconds: 1),
      popGesture: false,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: registerPage,
      page: () => RegisterPage(),
      transition: Transition.fadeIn,
      maintainState: false,
      binding: BindingsBuilder(() {
        Get.lazyPut(() => RegisterController());
      }),
      transitionDuration: Duration(seconds: 2),
      popGesture: false,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: dashBoardPage,
      page: () {
        var selectedIndex = Get.arguments ?? 0;
        return DashboardScreen(selectIndex: selectedIndex);
      },
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: false,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: completeProfile,
      page: () {
        final args = Get.arguments as Map<String, dynamic>;
        final userId = args['userId'] ?? '';
        final otp = args['otp'] ?? '';
        var id = args['id'] ?? null;
        print("User ID: $userId | OTP: $otp");

        return CompleteProfile(
            userId: userId, otp: otp, id: id); // assuming both are needed
      },
      binding: CommonBinding(),
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: false,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: rewardUnlockedScreen,
      page: () {
        var client_id = Get.parameters['client_id'] ?? '';
        return RewardUnlockedScreen(client_id: client_id);
        //4086343220
      },
      // binding: CompleteProfileBinding(),
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: false,
      showCupertinoParallax: true,
    ),
    // 6163193856
    // TODO ??  The Page is Share is Caring...

    GetPage(
      name: referFriendPage,
      page: () {
        var rewardPoint = Get.arguments ?? 0;
        return ReferFriendPage(rewardPoints: rewardPoint);
      },
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: false,
      showCupertinoParallax: true,
    ),
    GetPage(
      name: findYourLocationPage,
      page: () {
        return FindYourLocation();
      },
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: false,
      showCupertinoParallax: true,
    ),

    //Todo ??  Treatment Details Page.

    GetPage(
      name: treatmentDetails,
      page: () => TreatmentDetailsPage(),
      binding: CommonBinding(),
      transition: Transition.fadeIn,
      maintainState: true,
      transitionDuration: Duration(milliseconds: 500),
      popGesture: false,
      showCupertinoParallax: true,
    ),
  ];

  static const findYourLocationPage = '/findYourLocation';
}
