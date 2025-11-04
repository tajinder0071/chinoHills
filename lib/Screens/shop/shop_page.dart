import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/Dashboard/Home/controller/membership_detail_controller.dart';
import 'Pages/Browse/browse.dart';
import 'Pages/BrowseByConcern/browse_page.dart';
import 'Pages/MemberShip Page/membership_page.dart';
import 'Pages/Package Page/controller/package_cotroller.dart';
import 'Pages/Package Page/packages_page.dart';
import 'Pages/Treatment Page/treatment_page.dart';
import 'Pages/dynamic_data/dynamic_data.dart';
import 'controller/shop_controller.dart';

class ShopPage extends StatelessWidget {
  final VoidCallback onBrowseByConcernOnTap;

  ShopPage({super.key, required this.onBrowseByConcernOnTap});

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
        body: Stack(
          children: [
            controller.dynamictab.isEmpty
                ? const SizedBox.shrink()
                : Positioned.fill(
                    top: 70.h,
                    child: TabBarView(
                      dragStartBehavior: DragStartBehavior.down,
                      controller: controller.tabController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        BrowsePage(
                          onBrowseByConcernOnTap: onBrowseByConcernOnTap,
                          discoverMoreOnTap: () {},
                        ),
                        ...controller.dynamictab.map(
                          (id) => DynamicData(dynamicId: id),
                        ),
                        MembershipPage(),
                        TreatmentPage(),
                        PackagesPage(),
                        BrowseByConcernPage(),
                      ],
                    ),
                  ),
            Positioned(
              top: 8.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.only(bottom: 0.0, top: 10.h, right: 10.w),
                child: AnimatedBuilder(
                  animation: controller.tabController,
                  builder: (context, _) {
                    return TabBar(
                      overlayColor:
                          WidgetStateProperty.all(AppColor().transparent),
                      splashFactory: NoSplash.splashFactory,
                      controller: controller.tabController,
                      isScrollable: true,
                      labelPadding: EdgeInsets.symmetric(horizontal: 6.w),
                      indicator: BoxDecoration(
                        color: AppColor.dynamicColor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      labelColor: AppColor().whiteColor,
                      unselectedLabelColor: AppColor().blackColor,
                      labelStyle: GoogleFonts.sarabun(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedLabelStyle: GoogleFonts.sarabun(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColor().lightBlackColor),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: AppColor().transparent,
                      tabs: List.generate(controller.tabList.length, (index) {
                        bool isSelected =
                            controller.tabController.index == index;
                        return Container(
                          height: 40.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            border: isSelected
                                ? null
                                : Border.all(
                                    color:
                                        AppColor().blackColor.withValues(alpha: .12)),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            controller.tabList[index].toString(),
                            style: GoogleFonts.sarabun(),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
