import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../CSS/color.dart';
import '../../util/base_services.dart';
import '../../util/common_page.dart';
import '../../../../../util/local_store_data.dart';
import '../../util/route_manager.dart';
import '../Account/widget/wallet_page.dart';
import '../Discover/discover_page.dart';
import '../Reward/reward_page.dart';
import '../cartList/Controller/cart_controller.dart';
import '../shop/shop_page.dart';
import 'Home/home_page.dart';

class DashboardScreen extends StatefulWidget {
  final int selectIndex;

  const DashboardScreen({super.key, required this.selectIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //TODO: Variables are declared here
  int _selectedIndex = 0;
  bool isLogoLoading = false;
  var logoPath = "";
  final controller = Get.put(CartController());
  LocalStorage local = LocalStorage();
  var isLoading = false;

  // TODO: Refactor the onItemTapped method .
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    local.saveData("shopIndex", 0);
  }

  // TODO: Extract fetchAppLogo method .
  Future<void> fetchAppLogo() async {
    isLogoLoading = true;
    setState(() {});
    try {
      var response = await hitAppLogoAPI();
      Get.log("Response Data : $response");
      if (response['success'] == true) {
        if (response['data'].toString().isNotEmpty) {
          logoPath =
              CommonPage().image_url + response['data'][0]['linked_image'];
        }
        Get.log("Logo Path : $logoPath");
        isLogoLoading = false;
        setState(() {});
      } else {
        Get.log("Failed to Load");
        isLogoLoading = false;
        setState(() {});
      }
    } on Exception catch (e) {
      isLogoLoading = false;
      Get.log(e.toString());
      setState(() {});
    }
  }

  var isUser;
  LocalStorage localStorage = LocalStorage();

  //TODO: This is the initState
  @override
  void initState() {
    super.initState();
    controller.requestPermission();
    _selectedIndex = widget.selectIndex;
    getUser();
    fetchAppLogo();
    controller.cartList();
  }

  getUser() async {
    isUser = await localStorage.getUId();
    Get.log("User ID : $isUser");
  }

  //TODO: The page Starts here
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: _getAppBar(_selectedIndex),
      body: _getPage(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // TODO: Extract all pages as separate widget methods.
  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage(
          logoPath,
          isLogoLoading,
          discoverMoreOnTap: () {
            setState(() {
              _selectedIndex = 1; // Navigate to Discover
            });
          },
          onBrowseByConcernOnTap: () {
            setState(() {
              _selectedIndex = 2;
              LocalStorage local = LocalStorage();
              local.saveData("shopIndex", 4);
              // Navigate to Discover
            });
          },
          shopAllMemberOnTap: () {
            setState(() {
              _selectedIndex = 2;
              LocalStorage local = LocalStorage();
              local.saveData("shopIndex", 1);
              // Navigate to Discover
            });
          },
          exploreAllServiceIOnTap: () {
            setState(() {
              _selectedIndex = 2;
              LocalStorage local = LocalStorage();
              local.saveData("shopIndex", 0);
              // Navigate to Discover
            });
          },
        );
      case 1:
        return DiscoverPage(
          goToShopOnTap: () {
            setState(() {
              _selectedIndex = 2;
              LocalStorage local = LocalStorage();
              local.saveData("shopIndex", 0);
              // Navigate to Discover
            });
          },
        );
      case 2:
        return ShopPage();
      case 3:
        return RewardPage();
      case 4:
        return WalletPage(
          onShopServicesOnTap: () {
            setState(() {
              _selectedIndex = 2;
              LocalStorage local = LocalStorage();
              local.saveData("shopIndex", 0);
              // Navigate to Discover
            });
          },
        );
      default:
        return Container();
    }
  }

  // TODO: Common AppBar for multiple screens.
  PreferredSizeWidget _getAppBar(int index) {
    switch (index) {
      case 0:
        return _buildHomeAppBar();
      case 1:
      case 2:
      case 3:
      case 4:
        return _buildCommonAppBar(
          title: _getAppBarTitle(index),
          context: context,
        );
      default:
        return AppBar(elevation: 0, backgroundColor: AppColor().background);
    }
  }

  // TODO: Common method for AppBar with search, cart, and user icons.
  AppBar _buildCommonAppBar({
    required String title,
    required BuildContext context,
  }) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0,
      backgroundColor: AppColor().background,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w500,
          color: AppColor().blackColor,
        ),
      ),
      actions: _buildAppBarActions(context),
    );
  }

  //TODO: Home-specific AppBar .
  AppBar _buildHomeAppBar() {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0,
      backgroundColor: AppColor().background,
      title: isLogoLoading
          ? SizedBox(
              height: 25.h,
              width: 25.w,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColor.dynamicColorWithOpacity,
                ),
              ),
            )
          : logoPath.isEmpty
          ? SizedBox.shrink()
          : SizedBox(
              height: 45.h,
              child: Image.network(
                logoPath.toString(),
                fit: BoxFit.contain,
                errorBuilder: (context, url, error) {
                  return Container(
                    height: 50.h,
                    width: 50.w,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(child: Icon(Icons.error)),
                  );
                },
              ),
            ),
      actions: _buildAppBarActions(context),
    );
  }

  // TODO: Common action buttons for the AppBar (Search, Cart, User).
  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Get.toNamed(RouteManager.searchPage),
        child: SizedBox(
          height: 30.h,
          width: 30.w,
          child: Icon(
            Iconsax.search_normal_outline,
            size: isTablet(context) ? 30.h : 20.h,
          ),
        ),
      ),
      SizedBox(width: 10.w),
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Get.toNamed(RouteManager.settingsTab),
        child: SizedBox(
          height: 30.h,
          width: 30.w,
          child: Icon(
            Iconsax.user_outline,
            size: isTablet(context) ? 30.h : 20.h,
          ),
        ),
      ),
      SizedBox(width: 10.w),
      GetBuilder<CartController>(
        builder: (cartController) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Badge.count(
              count: cartController.cartItemCount.value,
              backgroundColor: AppColor.dynamicColor,
              child: Icon(
                Iconsax.shopping_cart_outline,
                size: isTablet(context) ? 30.h : 23.h,
              ),
            ),
            onTap: () {
              Get.put(() => CartController());
              Get.toNamed(RouteManager.cartList);
            },
          );
        },
      ),
      SizedBox(width: 10.w),
    ];
  }

  // TODO:  Bottom navigation bar with reusable items.
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: AppColor().whiteColor,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColor.dynamicColor,
      unselectedItemColor: AppColor().black80,
      showUnselectedLabels: true,
      elevation: 3.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.home_2_outline,
            size: isTablet(context) ? 30.h : 23.h,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.discover_outline,
            size: isTablet(context) ? 30.h : 23.h,
          ),
          label: "Discover",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.shop_outline,
            size: isTablet(context) ? 30.h : 23.h,
          ),
          label: "Shop",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.gift_outline,
            size: isTablet(context) ? 30.h : 23.h,
          ),
          label: "Rewards",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Iconsax.wallet_3_outline,
            size: isTablet(context) ? 30.h : 23.h,
          ),
          label: "Wallet",
        ),
      ],
    );
  }

  //TODO: Get the app bar title based on the selected index
  String _getAppBarTitle(int index) {
    switch (index) {
      case 1:
        return "Discover";
      case 2:
        return "Shop";
      case 3:
        return "Rewards";
      case 4:
        return "Wallet";
      default:
        return "Home";
    }
  }
}
