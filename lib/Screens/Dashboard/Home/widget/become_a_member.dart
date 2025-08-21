import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../CSS/color.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/Pages/Package Page/controller/package_cotroller.dart';

class BecomeAMember extends StatelessWidget {
  final VoidCallback onPressed;
  final PackageController controller = Get.put(PackageController());

  BecomeAMember({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.dynamicColor),
      child: Column(
        children: [
          controller.memberShip.isEmpty
              ? SizedBox.shrink()
              : SizedBox(height: 15.h),
          controller.memberShip.isEmpty
              ? SizedBox.shrink()
              : Icon(
                  Icons.verified_outlined,
                  color: AppColor().whiteColor,
                  size: isTablet(context) ? 50.h : 40.h,
                ),
          controller.memberShip.isEmpty
              ? SizedBox.shrink()
              : SizedBox(height: 6.h),
          // TODO: Make the title part reusable if used in other places
          controller.memberShip.isEmpty ? SizedBox.shrink() : _buildTitle(),
          SizedBox(height: 20.h),
          // TODO: Refactor membership list into a separate widget for reusability
          controller.memberShip.isEmpty
              ? SizedBox.shrink()
              : _buildMembershipList(context),
          SizedBox(height: 10.h),
          // TODO: Extract Membership Perks Section into a reusable widget
          _buildMembershipPerks(),
          SizedBox(height: 20.h),
          // TODO: Reuse this button in other areas, as it might be a common action
          _buildShopAllButton(),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // TODO: Make this title widget reusable
  Widget _buildTitle() {
    return GetBuilder<PackageController>(
      init: PackageController(),
      builder: (controller) {
        return controller.response.getMembershipHeader!.isEmpty
            ? SizedBox.shrink()
            : Text(
                textAlign: TextAlign.center,
                "${controller.response.getMembershipHeader.toString()}",
                style: GoogleFonts.merriweather(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor().whiteColor,
                ),
              );
      },
    );
  }

  // TODO: Move this part into its own widget so it can be reused across the app
  Widget _buildMembershipList(context) {
    return GetBuilder<PackageController>(
      init: PackageController(),
      builder: (controller) {
        return SizedBox(
          height: isTablet(context)
              ? MediaQuery.of(context).size.height * 0.33
              : MediaQuery.of(context).size.height < 812
              ? MediaQuery.of(context).size.height * 0.30
              : Platform.isIOS
              ? MediaQuery.of(context).size.height * 0.34
              : MediaQuery.of(context).size.height * 0.33,
          child: controller.bload
              ? BecomeAMemberLoading()
              : controller.memberShip.isEmpty
              ? SizedBox.shrink()
              : ListView.builder(
                  itemCount: controller.memberShip.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    var member = controller.memberShip[index];
                    Widget imageWidget;
                    if (member.membershipImage == null ||
                        member.membershipImage!.isEmpty) {
                      imageWidget = Container(
                        height: 150.h,
                        width: double.infinity,
                        color: AppColor.geryBackGroundColor,
                        child: Image.asset(
                          "assets/images/Image_not_available.png",
                          color: AppColor().blackColor,
                          fit: BoxFit.contain,
                        ),
                      );
                    } else {
                      imageWidget = CommonNetworkImageWidget(
                        imageUrl:
                            CommonPage().image_url +
                            member.membershipImage.toString(),
                        height: 150.0.h,
                        width: double.infinity,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(6.0.r),
                        ),
                        fit: BoxFit.contain,
                      );
                      /*   Image.network(
                                CommonPage().image_url +
                                    member.membershipImage.toString(),
                                height: 150.h,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 150.h,
                                  width: double.infinity,
                                  color: AppColor.geryBackGroundColor,
                                  child: Image.asset(
                                    "assets/images/Image_not_available.png",
                                    color: AppColor().blackColor,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );*/
                    }
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          RouteManager.membersShipDetailsPage,
                          arguments: member.memberId,
                          parameters: {"onlyShow": "0"},
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: 190.w,
                        margin: EdgeInsets.only(left: 5.h, right: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColor().whiteColor,
                        ),
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Center(child: imageWidget),
                            Padding(
                              padding: EdgeInsets.only(left: 5.0, top: 5.h),
                              child: SizedBox(
                                height: 50.h,
                                child: Text(
                                  member.membership.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.merriweather(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${member.price}/month",
                                    style: GoogleFonts.roboto(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        RouteManager.membersShipDetailsPage,
                                        arguments: member.memberId,
                                        parameters: {"onlyShow": "0"},
                                      );
                                    },
                                    child: Icon(
                                      Icons.navigate_next_rounded,
                                      color: AppColor.dynamicColor,
                                      size: 24.h,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  // TODO: Membership Perks section
  Widget _buildMembershipPerks() {
    return GetBuilder<PackageController>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "MEMBERSHIP PERKS INCLUDE:",
              style: GoogleFonts.merriweather(
                fontWeight: FontWeight.w900,
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.perkList.length,
                itemBuilder: (context, index) => PerkRow(
                  icon: controller.perkList[index].membershipIcon == 'reward'
                      ? Icons.card_giftcard
                      : controller.perkList[index].membershipIcon == 'calendar'
                      ? Icons.calendar_month
                      : Icons.local_offer_outlined,
                  text: controller.perkList[index].membershipPerk.toString(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // TODO: Make this button reusable across the app
  Widget _buildShopAllButton() {
    return GetBuilder<PackageController>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: CommonButtonWidget(
            onTap: () => onPressed(),
            isOutlineButton: true,
            buttonName: 'Shop all ${controller.memberShip.length} memberships',
          ),
        );
      },
    );
  } //add elevation on press
}

// TODO: This perk row widget could be used in other places, make it reusable
class PerkRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const PerkRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 40.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 18.h),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 15.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
