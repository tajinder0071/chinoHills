import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/Dashboard/Home/home_page.dart';
import 'package:chino_hills/Screens/cartList/Controller/cart_controller.dart';
import 'package:chino_hills/util/base_services.dart';
import 'package:chino_hills/util/common_page.dart';
import '../../common_Widgets/common_affirm_badge_widget.dart';
import '../../util/local_stoage.dart';
import '../../util/route_manager.dart';
import '../Wallet_Page/wallet_page.dart';
import '../Discover/discover_page.dart';
import '../Reward/reward_page.dart';
import '../shop/controller/shop_controller.dart';
import '../shop/shop_page.dart';

class DashboardScreen extends StatefulWidget {
  final int selectIndex;

  const DashboardScreen({super.key, required this.selectIndex});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  bool isLogoLoading = false;
  String logoPath = "";
  final controller = Get.put(CartController());
  final LocalStorage local = LocalStorage();
  final LocalStorage localStorage = LocalStorage();
  dynamic isUser;

  final ScrollController homeScrollController = ScrollController();
  bool _showBanner = true; // Banner visibility

  final List<IconData> _icons = [
    Iconsax.home_outline,
    Iconsax.discover_1_outline,
    Iconsax.shop_outline,
    Iconsax.gift_outline,
    Iconsax.wallet_1_outline,
  ];
  final List<IconData> _filledIcons = [
    Iconsax.home_bold,
    Iconsax.discover_bold,
    Iconsax.shop_bold,
    Iconsax.gift_bold,
    Iconsax.wallet_bold,
  ];

  final List<String> _labels = [
    "Home",
    "Discover",
    "Shop",
    "Rewards",
    "Wallet",
  ];

  @override
  void initState() {
    super.initState();
    controller.requestPermission();
    _selectedIndex = widget.selectIndex;
    getUser();
    fetchAppLogo();
    controller.cartList();

    // 🔹 Listen to scroll changes
    homeScrollController.addListener(() {
      if (homeScrollController.position.pixels > 10 && _showBanner) {
        setState(() => _showBanner = false);
      } else if (homeScrollController.position.pixels <= 10 && !_showBanner) {
        setState(() => _showBanner = true);
      }
    });
  }

  Future<void> fetchAppLogo() async {
    setState(() => isLogoLoading = true);
    try {
      var response = await hitAppLogoAPI();
      if (response['success'] == true) {
        logoPath = CommonPage().image_url + response['data'][0]['linked_image'];
        log("logoPath$logoPath");
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

  // void _onItemTapped(int index) {
  //   setState(() => _selectedIndex = index);
  //   local.saveData(AppStrings.shopIndex, 0);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
          exploreAllServiceOnTap: () {
            setState(() => _selectedIndex = 2);
            local.saveData(AppStrings.shopIndex, 0);
          },
          onTap: () {
            setState(() => _selectedIndex = 2);
          },
          scrollController: homeScrollController,
          onPageChanged: (pageIndex) {
            setState(() => _showBanner = pageIndex == 0);
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
        return ShopPage(
          onBrowseByConcernOnTap: () {
            setState(() => _selectedIndex = 2);
            ShopController.shop.goToTabByName(AppStrings.browseByConcern);
          },
        );
      case 3:
        return RewardPage();
      case 4:
        return WalletPage(
          onShopServicesOnTap: () {
            setState(() => _selectedIndex = 2);
            local.saveData(AppStrings.shopIndex, 0);
          },
          shopAllMemberOnTap: () {
            setState(() => _selectedIndex = 2);
            ShopController.shop.goToTabByName(AppStrings.membership);
          },
        );

      default:
        return Container();
    }
  }

  PreferredSizeWidget _getAppBar(int index) {
    if (index == 0) return _buildHomeAppBar(context);
    if (index >= 1 && index <= 4) {
      return _buildCommonAppBar(
        title: _getAppBarTitle(index),
        context: context,
      );
    }
    return AppBar(elevation: 0, backgroundColor: AppColor().background);
  }

  PreferredSize _buildCommonAppBar({
    required String title,
    required BuildContext context,
  }) {
    // Dynamic AppBar height
    final double appBarHeight = isTablet(context) ? 60.h : kToolbarHeight;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        elevation: 0,
        backgroundColor: AppColor().background,
        title: Text(
          title,
          style: TextStyle(
            fontSize: isTablet(context) ? 22.sp : 17.sp,
            fontWeight: FontWeight.w500,
            color: AppColor().blackColor,
          ),
        ),
        actions: _buildAppBarActions(context),
        centerTitle: false,
        // optional
        toolbarHeight: appBarHeight, // extra safety
      ),
    );
  }

  PreferredSize _buildHomeAppBar(BuildContext context) {
    final double appBarHeight = isTablet(context) ? 60.h : kToolbarHeight;
    final double bannerHeight = isTablet(context) ? 70.h : 55.h;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight + bannerHeight),
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: _showBanner ? bannerHeight : 0.h,
              child: BannerAffirmBadge(cardView: false, isButton: true),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [
      InkWell(
        splashColor: AppColor().transparent,
        highlightColor: AppColor().transparent,
        onTap: () => Get.toNamed(RouteManager.searchPage),
        child: SizedBox(
          height: 30.h,
          width: 30.w,
          child: Icon(Iconsax.search_normal_outline,
              size: isTablet(context) ? 30.h : 20.h),
        ),
      ),
      SizedBox(width: 10.w),
      GetBuilder<CartController>(
        builder: (cartController) {
          return InkWell(
            splashColor: AppColor().transparent,
            highlightColor: AppColor().transparent,
            child: Badge.count(
              count: cartController.cartItemCount ?? 0,
              backgroundColor: AppColor.dynamicColor,
              textStyle: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: AppColor().whiteColor,
              ),
              child: Icon(
                Iconsax.shopping_bag_outline,
                size: isTablet(context) ? 30.h : 22.h,
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
      InkWell(
        splashColor: AppColor().transparent,
        highlightColor: AppColor().transparent,
        onTap: () => Get.toNamed(RouteManager.settingsTab),
        child: SizedBox(
            height: 30.h,
            width: 30.w,
            child: Icon(Iconsax.user_outline,
                size: isTablet(context) ? 30.h : 20.h)),
      ),
      SizedBox(width: 10.w),
    ];
  }

  Widget _buildBottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: AppColor().transparent,
        highlightColor: AppColor().transparent,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor().whiteColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(40.r),
                border: Border.all(
                  color: AppColor().whiteColor.withValues(alpha: 0.3),
                  width: 1.2.w,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_icons.length, (index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        if (_selectedIndex == 0) {
                          _showBanner = true;
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 16.w : 0,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.dynamicColor
                            : AppColor().transparent,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5.w),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? _filledIcons[index] : _icons[index],
                              color: isSelected
                                  ? AppColor().whiteColor
                                  : AppColor().blackColor.withValues(alpha: 0.8),
                            ),
                            SizedBox(width: 5.w),
                            if (isSelected) ...[
                              SizedBox(width: 6.w),
                              Text(
                                _labels[index],
                                style:
                                    AppTypography.hostGroteskSemiBold.copyWith(
                                  color: AppColor().whiteColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
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
