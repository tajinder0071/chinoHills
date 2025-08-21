import 'package:chino_hills/Screens/Discover/widgets/discover_card_widget.dart';
import 'package:chino_hills/Screens/Discover/widgets/offer_unavailable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../CSS/color.dart';
import '../../common_Widgets/no_record.dart';
import '../../loading/discover_loading_page.dart';
import '../../util/common_page.dart';
import '../../common_Widgets/common_refer_widget.dart';
import '../../util/route_manager.dart';
import '../cartList/Controller/cart_controller.dart';
import 'controller/discover_controller.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverPage extends StatelessWidget {
  final VoidCallback goToShopOnTap;

  DiscoverPage({super.key, required this.goToShopOnTap});

  DiscoverController controller = Get.put(DiscoverController());

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    cartController.cartList();

    return GetBuilder<DiscoverController>(
      init: Get.find<DiscoverController>()..fetchDiscoverList(),
      builder: (controller1) {
        final cartController = Get.find<CartController>();
        var isItemInCart = cartController.cartItemCount.value != 0
            ? true
            : false;
        return Stack(
          children: [
            // TODO >> IF list is Empty, show the no record widget.
            controller.load
                ?
                  //add shimmer effect here
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: DiscoverLoadingPage(height: 340.h),
                  )
                : (controller.cardData.isEmpty &&
                      controller.offerCardList.isEmpty)
                ? Center(
                    child: NoRecord(
                      "No Discover Data Found",
                      Icon(Icons.no_accounts),
                      "We're sorry. no discover data available at this moment.\nPlease check back later",
                    ),
                  )
                // TODO >> Want to Refresh The Page..
                : LiquidPullToRefresh(
                    animSpeedFactor: 1.5,
                    springAnimationDurationInMilliseconds: 400,
                    key: controller.refreshIndicatorKey,
                    color: AppColor.dynamicColor,
                    showChildOpacityTransition: false,
                    backgroundColor: Colors.white,
                    onRefresh: controller.handleRefresh,
                    child: ListView(
                      children: [
                        ...controller.offerCardList.map((offerItem) {
                          print("offerItems : ${offerItem.serviceName}");
                          return CustomCardWidget(
                            imageUrl: offerItem.cloudUrl!,
                            title: offerItem.title ?? '',
                            headline: offerItem.description ?? '',
                            description: offerItem.description,
                            ctaText: "Apply offer to cart",
                            isOffer: true,
                            offerExpiresText: offerItem.endDate,
                            onTapCTA: isItemInCart
                                ? () {
                                    controller1.addPromoCode(
                                      offerItem.promoCode ?? '',
                                      goToShopOnTap,
                                      context,
                                      treatement: offerItem.serviceName,
                                    );
                                  }
                                : () {
                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: false,
                                      backgroundColor: AppColor().whiteColor,
                                      builder: (context) =>
                                          OfferUnavailablePage(
                                            onTapShop: () {
                                              Get.back();
                                              goToShopOnTap();
                                            },
                                          ),
                                    );
                                  },
                            onTapLearnMore: () {
                              print(
                                "TreatmentVariationId: ${controller.offerCardList}",
                              );
                              Get.toNamed(
                                RouteManager.learnMore,
                                arguments: {
                                  "offerCard": offerItem,
                                  "isExpired": true,
                                },
                              );
                            },
                            // isOfferApplied: false,
                            isOfferApplied: offerItem.isPromoCodeApplied == null
                                ? false
                                : offerItem.isPromoCodeApplied!,
                          );
                        }),
                        ...controller.cardData.map(
                          (item) => CustomCardWidget(
                            imageUrl: item.cloudUrl!,
                            title: item.title ?? '',
                            headline: item.headline ?? '',
                            ctaText: item.customCallToAction ?? '',
                            description: item.description,
                            isOffer: false,
                            offerExpiresText: "",
                            onTapCTA: () =>
                                controller.launchURL(item.customUrl),
                            onTapLearnMore: () => Get.toNamed(
                              RouteManager.learnMore,
                              arguments: {"cardData": item, "isExpired": false},
                            ),
                            isOfferApplied: false,
                          ),
                        ),
                        CommonReferWidget(),
                      ],
                    ),
                  ),
            // TODO >> Wrap the loading screen in a separate reusable widget.
          ],
        );
      },
    );
  }
}
