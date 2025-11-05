import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../CSS/color.dart';
import '../../../shop/controller/shop_controller.dart';
import 'best_selling_widget.dart';

class BestSellingSection extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback exploreAllServiceOnTap;
  BestSellingSection({super.key,
    required this.onTap,
    required this.exploreAllServiceOnTap,});

  final controller = Get.put(ShopController());

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor().whiteColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/new_images/best_selling_background.png"),
                fit: BoxFit.fill)),
        child: Container(
          color: AppColor().greyColor.withValues(alpha: 0.1),
          padding: EdgeInsets.only(top: mediaQuery.height * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: BestSellingWidget(
                  exploreAllServiceOnTap: exploreAllServiceOnTap,
                  onTap: onTap,
                ),
              ),
              SizedBox(height: mediaQuery.height * 0.03),
            ],
          ),
        ),
      ),
    );

  }
}
