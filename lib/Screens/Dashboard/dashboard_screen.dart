import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../CSS/app_strings.dart';
import '../../CSS/color.dart';
import '../../util/base_services.dart';
import '../../util/common_page.dart';
import '../../util/local_store_data.dart';
import '../../util/route_manager.dart';
import '../Account/widget/wallet_page.dart';
import '../Discover/discover_page.dart';
import '../Reward/reward_page.dart';
import '../cartList/Controller/cart_controller.dart';
import '../shop/controller/shop_controller.dart';
import '../shop/shop_page.dart';
import 'Home/home_page.dart' hide AppStrings;

class DashboardScreen extends StatefulWidget {
  final int selectIndex;

  const DashboardScreen({super.key, required this.selectIndex});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool isLogoLoading = false;
  String logoPath = "";
  final controller = Get.put(CartController());
  final LocalStorage local = LocalStorage();
  final LocalStorage localStorage = LocalStorage();
  dynamic isUser;

  @override
  void initState() {
    super.initState();
    controller.requestPermission();
    _selectedIndex = widget.selectIndex;
    getUser();
    fetchAppLogo();
    controller.cartList();
  }

  Future<void> fetchAppLogo() async {
    setState(() => isLogoLoading = true);
    try {
      var response = await hitAppLogoAPI();
      if (response['success'] == true) {
        logoPath = CommonPage().image_url + response['data'][0]['linked_image'];
      }
    } catch (e) {
      Get.log(e.toString());
    } finally {
      setState(() => isLogoLoading = false);
    }
  }

  Future<void> getUser() async {
    isUser = await localStorage.getUId();
    Get.log("User ID : $isUser");
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    local.saveData(AppStrings.shopIndex, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: _getAppBar(_selectedIndex),
      body: _getPage(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomePage(
          logoPath,
          isLogoLoading,
          discoverMoreOnTap: () => setState(() => _selectedIndex = 1),
          onBrowseByConcernOnTap: () {
            setState(() => _selectedIndex = 2);
            ShopController.shop.goToTabByName(AppStrings.browseByConcern);
          },
          shopAllMemberOnTap: () {
            setState(() => _selectedIndex = 2);
            ShopController.shop.goToTabByName(AppStrings.membership);
          },
          exploreAllServiceIOnTap: () {
            setState(() => _selectedIndex = 2);
            local.saveData(AppStrings.shopIndex, 0);
          },
        );
      case 1:
        return DiscoverPage(
          goToShopOnTap: () {
            setState(() => _selectedIndex = 2);
            local.saveData(AppStrings.shopIndex, 0);
          },
        );
      case 2:
        return ShopPage();
      case 3:
        return RewardPage();
      case 4:
        return WalletPage(
          onShopServicesOnTap: () {
            setState(() => _selectedIndex = 2);
            local.saveData(AppStrings.shopIndex, 0);
          },
        );
      default:
        return Container();
    }
  }

  PreferredSizeWidget _getAppBar(int index) {
    if (index == 0) return _buildHomeAppBar();
    if (index >= 1 && index <= 4) {
      return _buildCommonAppBar(
        title: _getAppBarTitle(index),
        context: context,
      );
    }
    return AppBar(elevation: 0, backgroundColor: AppColor().background);
  }

  AppBar _buildCommonAppBar(
      {required String title, required BuildContext context}) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      elevation: 0,
      backgroundColor: AppColor().background,
      title: Text(title,
          style: TextStyle(
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
              color: AppColor().blackColor)),
      actions: _buildAppBarActions(context),
    );
  }

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
              color: AppColor.dynamicColorWithOpacity),
        ),
      )
          : logoPath.isEmpty
          ? SizedBox.shrink()
          : SizedBox(
        height: 60.h,
        width: 80.w,
        child: Image.network(
          logoPath,
          fit: BoxFit.contain,
          errorBuilder: (context, url, error) {
            return Container(
              height: 50.h,
              width: 50.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10.r)),
              child: Center(child: Icon(Icons.error)),
            );
          },
        ),
      ),
      actions: _buildAppBarActions(context),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () => Get.toNamed(RouteManager.searchPage),
        child: SizedBox(
          height: 30.h,
          width: 30.w,
          child: Icon(Iconsax.search_normal_outline,
              size: isTablet(context) ? 30.h : 20.h),
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
            child: Icon(Iconsax.user_outline,
                size: isTablet(context) ? 30.h : 20.h)),
      ),
      SizedBox(width: 10.w),
      GetBuilder<CartController>(
        builder: (cartController) {
          return InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Badge.count(
              count: cartController.cartItemCount ?? 0,
              backgroundColor: AppColor.dynamicColor,
              child: Icon(Iconsax.shopping_cart_outline,
                  size: isTablet(context) ? 30.h : 23.h),
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

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColor().whiteColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        elevation: 8.0,
        selectedItemColor: AppColor.dynamicColor,
        unselectedItemColor: AppColor().black80,
        showUnselectedLabels: true,
        selectedFontSize: 13,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 0 ? 1.1 : 1.0, // magnify selected
              child: Icon(
                Iconsax.home_2_outline,
                size: isTablet(context) ? 30.h : 23.h,
              ),
            ),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 1 ? 1.1 : 1.0,
              child: Icon(
                Iconsax.discover_outline,
                size: isTablet(context) ? 30.h : 23.h,
              ),
            ),
            label: AppStrings.discover,
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 2 ? 1.1 : 1.0,
              child: Icon(
                Iconsax.shop_outline,
                size: isTablet(context) ? 30.h : 23.h,
              ),
            ),
            label: AppStrings.shop,
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 3 ? 1.1 : 1.0,
              child: Icon(
                Iconsax.gift_outline,
                size: isTablet(context) ? 30.h : 23.h,
              ),
            ),
            label: AppStrings.rewards,
          ),
          BottomNavigationBarItem(
            icon: Transform.scale(
              scale: _selectedIndex == 4 ? 1.1 : 1.0,
              child: Icon(
                Iconsax.wallet_3_outline,
                size: isTablet(context) ? 30.h : 23.h,
              ),
            ),
            label: AppStrings.wallet,
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 1:
        return AppStrings.discover;
      case 2:
        return AppStrings.shop;
      case 3:
        return AppStrings.rewards;
      case 4:
        return AppStrings.wallet;
      default:
        return AppStrings.home;
    }
  }
}
