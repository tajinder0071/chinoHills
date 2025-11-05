import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/color.dart';

import '../../../shop/controller/shop_controller.dart';
import 'become_a_member.dart';

class MembershipPageSection extends StatelessWidget {
  MembershipPageSection({super.key, required this.shopAllMemberOnTap});

  final ShopController controller = Get.put(ShopController());
  final VoidCallback shopAllMemberOnTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.dynamicColor,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/new_images/membership_perks_section_background.png"),
            fit: BoxFit.fill)),
        child: controller.homeData.isEmpty
            ? SizedBox.shrink()
            : BecomeAMember(
                onPressed: shopAllMemberOnTap,
                data: controller.homeData[0].memberships,
                perks: controller.homeData[0].membershipPerks,
                membershipPerkHeader:
                    controller.homeData[0].membershipsPerksHeader,
          isBrowse: false,
              ),
      ),
    );
  }
}
