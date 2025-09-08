import 'package:chino_hills/Screens/Discover/widgets/discover_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../CSS/app_strings.dart';
import '../../CSS/color.dart';
import '../../common_Widgets/no_record.dart';
import '../../loading/discover_loading_page.dart';
import '../../common_Widgets/common_refer_widget.dart';
import '../../util/route_manager.dart';
import '../cartList/Controller/cart_controller.dart';
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
        final cartController = Get.find<CartController>();
        return Stack(
          children: [
            controller1.load
                ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
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
                : LiquidPullToRefresh(
              animSpeedFactor: 1.5,
              springAnimationDurationInMilliseconds: 400,
              key: controller1.refreshIndicatorKey,
              color: AppColor.dynamicColor,
              showChildOpacityTransition: false,
              backgroundColor: Colors.white,
              onRefresh: controller1.handleRefresh,
              child: ListView(
                children: [
                  ...controller1.cardData
                      .map((item) => CustomCardWidget(
                    imageUrl: item.cloudUrl ?? '',
                    title: item.title ?? '',
                    headline: item.headline ?? '',
                    ctaText: item.callToAction == "custom CTA"
                        ? item.customCallToAction
                        : item.callToAction ?? '',
                    description: item.description,
                    isOffer: false,
                    offerExpiresText: "",
                    onTapCTA: () =>
                    item.callToAction == "Call Now"
                        ? controller1.callNumber(
                        item.customUrl.toString())
                        : controller1
                        .launchURL(item.customUrl),
                    onTapLearnMore: () => Get.toNamed(
                      RouteManager.learnMore,
                      arguments: {
                        "cardData": item,
                        "isExpired": false,
                      },
                    ),
                    isOfferApplied: false,
                  )),
                  CommonReferWidget(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
