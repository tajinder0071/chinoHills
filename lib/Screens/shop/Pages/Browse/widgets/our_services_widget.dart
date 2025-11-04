import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/shop/Pages/Package%20Page/controller/package_cotroller.dart';
import 'package:chino_hills/common_Widgets/common_affirm_badge_widget.dart';
import 'package:chino_hills/common_Widgets/common_badge_container.dart';
import 'package:chino_hills/util/common_page.dart';

import '../../../../../CSS/appTypography.dart';
import '../../../controller/shop_controller.dart';
import 'our_services_card_widget.dart';

class OurServicesPage extends StatelessWidget {
  const OurServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(left: 15.w, right: 15.w, bottom: 70.0.h, top: 10.h),
      decoration: BoxDecoration(color: AppColor.geryBackGroundColor),
      child: GetBuilder<PackageController>(builder: (pCon) {
        int itemCount = pCon.showAllServices
            ? pCon.browseCategory.length
            : (pCon.browseCategory.length > 3 ? 3 : pCon.browseCategory.length);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonBadgeContainer(
              icon: Icons.shopping_bag_outlined,
            ),
            SizedBox(height: 10.h),
            Text(
              "OUR\nSERVICES",
              style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                color: Colors.black.withOpacity(0.65),
                fontSize: 26.sp,
                height: 0.9.h,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InlineAffirmBadge(),
              ],
            ),
            if (pCon.browseCategory.length > 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: pCon.toggleShowAllServices,
                    child: Text(
                      pCon.showAllServices ? "Hide" : "See More",
                      style: AppTypography.hostGroteskSemiBold.copyWith(
                        color: AppColor.dynamicColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            // Loader or List
            pCon.isServicesLoading
                ? Center(child: commonLoader(color: AppColor.dynamicColor))
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: itemCount,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) {
                        var data = pCon.browseCategory[index];
                        return ServiceCard(
                          imagePath: "${data.headerimage}",
                          title: '${data.categoryHeader}',
                          subtitle: '${data.categoryDescription}',
                          onTap: () {
                            final shop = ShopController.shop;
                            String tabName = (data.categoryTabName ?? "")
                                .toLowerCase()
                                .trim();

                            if (tabName == "membership") {
                              tabName = "memberships";
                            }
                            if (tabName == "treatment") {
                              tabName = "treatments";
                            }
                            if (tabName == "package") {
                              tabName = "packages";
                            }

                            final index = shop.tabList.indexWhere(
                              (tab) =>
                                  tab.toString().toLowerCase().trim() ==
                                  tabName,
                            );

                            if (index != -1) {
                              shop.goToTab(index);
                            } else {
                              shop.goToTab(0);
                            }
                          },
                        );
                      },
                    ),
                  ),
          ],
        );
      }),
    );
  }
}
