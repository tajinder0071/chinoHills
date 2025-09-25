import 'package:chino_hills/Screens/shop/widgets/discover_dart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../CSS/color.dart';
import '../Dashboard/Home/controller/membership_detail_controller.dart';
import 'Pages/Browse/browse.dart';
import 'Pages/BrowseByConcern/browse_page.dart';
import 'Pages/MemberShip Page/membership_page.dart';
import 'Pages/Package Page/controller/package_cotroller.dart';
import 'Pages/Package Page/packages_page.dart';
import 'Pages/Treatment Page/treatment_page.dart';
import 'Pages/dynamic_data/dynamic_data.dart';
import 'controller/shop_controller.dart';

class ShopPage extends StatelessWidget {
  ShopPage({super.key});

  final controller = Get.put(ShopController());
  final packageController = Get.put(PackageController());
  final member = Get.put(MembershipDetailController());

  @override
  Widget build(BuildContext context) {
    controller.getShopByItem();

    return GetBuilder<ShopController>(builder: (controller) {
      if (controller.tabController == null) {
        return const Center(child: SizedBox.shrink());
      }
      return Scaffold(
        backgroundColor: AppColor().background,
        appBar: AppBar(
          toolbarHeight: 10.h,
          backgroundColor: AppColor().background,
          elevation: 0.5,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: TabBar(
              isScrollable: true,
              controller: controller.tabController,
              indicatorColor: AppColor.dynamicColor,
              labelColor: AppColor.dynamicColor,
              unselectedLabelColor: Colors.black54,
              labelStyle:
              TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              unselectedLabelStyle: TextStyle(fontSize: 13.sp),
              overlayColor: WidgetStatePropertyAll(
                AppColor.dynamicColor.withOpacity(0.1),
              ),
              dividerColor: Colors.transparent,
              tabs: [
                ...controller.tabList.map(
                      (tabTitle) =>
                      Tab(child: FittedBox(child: Text(tabTitle.toString()))),
                ),
              ],
            ),
          ),
        ),
        body: controller.dynamictab.isEmpty
            ? SizedBox.shrink()
            : TabBarView(
          dragStartBehavior: DragStartBehavior.down,
          controller: controller.tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            BrowsePage(),
            ...controller.dynamictab.map(
                  (id) => DynamicData(dynamicId: id),
            ),
            MembershipPage(),
            TreatmentPage(),
            PackagesPage(),
            BrowseByConcernPage(),
          ],
        ),
      );
    });
  }
}
