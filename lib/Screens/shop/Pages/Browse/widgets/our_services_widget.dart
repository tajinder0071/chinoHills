import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../util/common_page.dart';
import '../../../controller/shop_controller.dart';
import '../../Package Page/controller/package_cotroller.dart';
import 'our_services_card_widget.dart';

class OurServicesPage extends StatelessWidget {
  const OurServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
      decoration: BoxDecoration(color: AppColor.geryBackGroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Icon(Icons.shopping_bag_outlined,
                  size: 25.h, color: AppColor.dynamicColor)),
          SizedBox(height: 15.h),
          Center(
            child: Text("Our Services",
                style: GoogleFonts.roboto(
                    fontSize: 24.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(height: 25.h),
          GetBuilder<PackageController>(builder: (pCon) {
            return pCon.isServicesLoading
                ? Center(child: commonLoader(color: AppColor.dynamicColor))
                : ListView.builder(
                itemCount: pCon.browseCategory.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx, index) {
                  var data = pCon.browseCategory[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.0.h),
                    child: ServiceCard(
                        imagePath: "${data.headerimage}",
                        title: '${data.categoryHeader}',
                        subtitle: '${data.categoryDescription}',
                        onTap: () {
                          final shop = ShopController.shop;

                          switch (data.categoryTabName?.toLowerCase()) {
                            case "browse":
                              shop.goToTab(0);
                              break;
                            case "membership":
                              shop.goToTab(1);
                              break;
                            case "treatment":
                              shop.goToTab(2);
                              break;
                            case "packages":
                              shop.goToTab(3);
                              break;
                            case "concern":
                            case "browse by concern":
                              shop.goToTab(4);
                              break;
                            default:
                              final index = shop.tabList.indexWhere(
                                    (tab) => tab.toString().toLowerCase() ==
                                    data.categoryTabName?.toLowerCase(),
                              );
                              if (index != -1) {
                                shop.goToTab(index);
                              } else {
                                shop.goToTab(0);
                              }
                          }
                        }

                    ),
                  );
                });
          }),
          SizedBox(height: 15.h),
        ],
      ),
    );
  }
}

