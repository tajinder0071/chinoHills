
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/Screens/Discover/widgets/discover_card_widget.dart';
import 'package:chino_hills/Screens/cartList/Controller/cart_controller.dart';
import 'package:chino_hills/common_Widgets/no_record.dart';
import 'package:chino_hills/loading/discover_loading_page.dart';
import 'package:chino_hills/util/route_manager.dart';
import '../../CSS/color.dart';
import '../../common_Widgets/common_refer_widget.dart';
import 'controller/discover_controller.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverPage extends StatelessWidget {
  final VoidCallback goToShopOnTap;

  DiscoverPage({super.key, required this.goToShopOnTap});

  final DiscoverController controller = Get.put(DiscoverController());

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    cartController.cartList();

    return GetBuilder<DiscoverController>(
      init: Get.find<DiscoverController>()..fetchDiscoverList(),
      builder: (controller1) {
        return Scaffold(
          backgroundColor: AppColor().transparent,
          body: controller1.load
              ? Shimmer.fromColors(
                  baseColor: AppColor().greyColor.withValues(alpha: .3),
                  highlightColor: AppColor().greyColor.withValues(alpha: .1),
                  child: DiscoverLoadingPage(height: 340.h),
                )
              : (controller1.cardData.isEmpty)
                  ? Center(
                      child: NoRecord(
                        AppStrings.noDiscoverDataFound,
                        Icon(Icons.no_accounts),
                        AppStrings.weAreSorryNoDiscoverDataAvailable,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Discover Cards
                          ...controller1.cardData.asMap().entries.map((entry) {
                            final index = entry.key;
                            final item = entry.value;
                            return CustomCardWidget(
                              index: index,
                              imageUrl: item.cloudUrl ?? '',
                              title: item.title ?? '',
                              headline: item.headline ?? '',
                              ctaText: item.callToAction == "custom CTA"
                                  ? item.customCallToAction
                                  : item.callToAction ?? '',
                              description: item.description,
                              isOffer: false,
                              offerExpiresText: "",
                              onTapCTA: () => item.callToAction == "Call Now"
                                  ? controller1
                                      .callNumber(item.customUrl.toString())
                                  : controller1.launchURL(item.customUrl),
                              onTapLearnMore: () => Get.toNamed(
                                RouteManager.learnMore,
                                arguments: {
                                  "cardData": item,
                                  "isExpired": false,
                                },
                              ),
                              isOfferApplied: false,
                            );
                          }),
                          SizedBox(height: 10.h),
                          CommonReferWidget(),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
