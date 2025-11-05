import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/Screens/Dashboard/Home/widget/special_offers_widget.dart';
import '../../../../CSS/color.dart';
import '../../../shop/controller/shop_controller.dart';

class SpecialOfferSection extends StatelessWidget {
  final VoidCallback discoverMoreOnTap;

  SpecialOfferSection({super.key, required this.discoverMoreOnTap});

  final controller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor().whiteColor,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/new_images/special_offer_section_background.png",
                  ),
                  fit: BoxFit.fill)),
          child: controller.homeData.isEmpty
              ? SizedBox.shrink()
              : controller.homeData[0].offerCards!.isEmpty
                  ? SizedBox.shrink()
                  : SpecialOffersWidget(
                      discoverMoreTap: discoverMoreOnTap,
                      isShowAll: true,
                      offerData: controller.homeData[0].offerCards,
                    ),
        ));
  }
}
