import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import '../../../CSS/appTypography.dart';
import '../../../CSS/app_strings.dart';
import '../../../CSS/color.dart';
import '../../../CSS/image_page.dart';
import '../../../common_Widgets/common_badge_container.dart';
import '../../../common_Widgets/common_button_widget.dart';
import '../../../common_Widgets/common_network_image_widget.dart';
import '../../../common_Widgets/coomon_horizontal_list.dart';
import '../../../loading/become_a_member_loading.dart';
import '../../../loading/browse_Concern_load.dart';
import '../../../util/common_page.dart';
import '../../../util/route_manager.dart';
import '../../Dashboard/dashboard_screen.dart';
import '../../shop/Pages/Package Page/controller/package_cotroller.dart';

class WalletMembership extends StatelessWidget {
  WalletMembership({super.key});

  final PackageController controller = Get.put(PackageController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
      init: Get.find<PackageController>()..getBrowserData(),
      builder: (packageController) => packageController.isBrowserLoading
          ? Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    color: AppColor().whiteColor,
                  ),
                  Expanded(child: BrowseConcernLoad())
                ],
              ))
          : Container(
              padding: EdgeInsets.only(left: 20.w, bottom: 10.h),
              width: double.infinity,
              decoration: BoxDecoration(color: AppColor.dynamicColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  controller.memberships.isEmpty
                      ? SizedBox.shrink()
                      : SizedBox(height: 20.h),
                  controller.memberships.isEmpty
                      ? SizedBox.shrink()
                      : CommonBadgeContainer(
                          icon: Icons.check_rounded,
                          iconSize: 15.h,
                        ),
                  controller.memberships.isEmpty
                      ? SizedBox.shrink()
                      : SizedBox(height: 15.h),
                  // TODO: Make the title part reusable if used in other places
                  controller.memberships.isEmpty
                      ? SizedBox.shrink()
                      : _buildTitle(),
                  SizedBox(height: 10.h),
                  // TODO: Refactor membership list into a separate widget for reusability
                  controller.memberships.isEmpty
                      ? SizedBox.shrink()
                      : _buildMembershipList(context),
                  SizedBox(height: 20.h),
                  // TODO: Extract Membership Perks Section into a reusable widget
                  _buildMembershipPerks(),
                  SizedBox(height: 10.h),
                  // TODO: Reuse this button in other areas, as it might be a common action
                  _buildShopAllButton(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
    );
  }

  Widget _buildTitle() {
    return GetBuilder<PackageController>(
        init: PackageController(),
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Text(
                textAlign: TextAlign.start,
                controller.browseDetailModel.data == null
                    ? "membershipPerkHeader"
                    : controller.browseDetailModel.data!.membershipHeader,
                style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                    fontSize: 22.sp,
                    // fontWeight: FontWeight.bold,
                    color: AppColor().whiteColor,
                    height: 1.h // default color
                    )),
          );
        });
  }

  // TODO: Move this part into its own widget so it can be reused across the app
  Widget _buildMembershipList(context) {
    return GetBuilder<PackageController>(
        init: PackageController(),
        builder: (controller) {
          return controller.isBrowserLoading
              ? SizedBox(
                  height: isTablet(context)
                      ? MediaQuery.of(context).size.height * .39
                      : MediaQuery.of(context).size.height < 812
                          ? MediaQuery.of(context).size.height * .35
                          : 250.h,
                  child: BecomeAMemberLoading())
              : CommonHorizontalList(
                  itemWidth: 330.w,
                  height: isTablet(context)
                      ? MediaQuery.of(context).size.height * .39
                      : MediaQuery.of(context).size.height < 812
                          ? MediaQuery.of(context).size.height * .35
                          : 250.h,
                  items: controller.memberships,
                  itemBuilder: (context, member, index) {
                    final hasImage = member.membershipImage != null &&
                        member.membershipImage!.isNotEmpty;
                    final imageWidget = ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: hasImage
                          ? CommonNetworkImageWidget(
                              imageUrl: member.membershipImage.toString(),
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(6.0.r)),
                            )
                          : Container(
                              color: AppColor.geryBackGroundColor,
                              child: Image.asset(
                                AppImages.noAvailableImage,
                                fit: BoxFit.cover,
                                color: AppColor().blackColor,
                              ),
                            ),
                    );

                    return InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      onTap: () {
                        Get.toNamed(
                          RouteManager.membersShipDetailsPage,
                          arguments: member.membershipId,
                          parameters: {"onlyShow": "0"},
                        );
                      },
                      child: Container(
                        width: 220.w,
                        margin: EdgeInsets.only(left: 8.w, right: 4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: AppColor().whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            )
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: [
                            Positioned.fill(child: imageWidget),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black.withValues(alpha: 0.15),
                                      Colors.black.withValues(alpha: 0.65),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (member.offeroffText != null &&
                                member.offeroffText!.isNotEmpty)
                              Positioned(
                                top: 10.h,
                                left: 10.w,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.dynamicColor,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Text(
                                    member.offeroffText
                                        .toString()
                                        .toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'galano-grotesque-alt',
                                      color: Colors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            Positioned(
                              left: 14.w,
                              right: 14.w,
                              bottom: 12.h,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          member.membershipTitle.toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'galano-grotesque-alt',
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Row(
                                          children: [
                                            Text(
                                              "\$${member.membershipPricing}",
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "/Month",
                                              style: TextStyle(
                                                fontFamily: 'host-grotesk',
                                                color: Colors.white
                                                    .withValues(alpha: 0.9),
                                                fontSize: 13.sp,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _circleButton(
                                        icon: Iconsax.shopping_bag,
                                        color: Colors.white,
                                        bgColor: AppColor.dynamicColor
                                            .withValues(alpha: 0.9),
                                        onTap: () {
                                          Get.toNamed(
                                            RouteManager.membersShipDetailsPage,
                                            arguments: member.membershipId,
                                            parameters: {"onlyShow": "0"},
                                          );
                                        },
                                      ),
                                      SizedBox(width: 8.w),
                                      _circleButton(
                                        icon: Icons.arrow_forward_ios_rounded,
                                        color: Colors.white,
                                        bgColor: AppColor.dynamicColor
                                            .withValues(alpha: 0.9),
                                        onTap: () {
                                          Get.toNamed(
                                            RouteManager.membersShipDetailsPage,
                                            arguments: member.membershipId,
                                            parameters: {"onlyShow": "0"},
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
        });
  }

  // TODO: Membership Perks section
  Widget _buildMembershipPerks() {
    return GetBuilder<PackageController>(builder: (controller) {
      return (controller.membershipPerk.isEmpty)
          ? SizedBox.shrink()
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.membershipPerks,
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                        fontSize: 22.sp,
                        // fontWeight: FontWeight.bold,
                        color: AppColor().whiteColor,
                        height: 1.h // default color
                        )),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  height: 50.h, // enough to fit PerkRow
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.membershipPerk.length,
                    itemBuilder: (context, index) => PerkRow(
                      icon: (controller.membershipPerk[index].membershipIcon ==
                              'reward'
                          ? Icons.card_giftcard
                          : controller.membershipPerk[index].membershipIcon ==
                                  'calendar'
                              ? Iconsax.calendar
                              : Iconsax.tag),
                      text: controller.membershipPerk[index].membershipPerk
                          .toString(),
                    ),
                  ),
                ),
              ],
            );
    });
  }

  Widget _buildShopAllButton() {
    return GetBuilder<PackageController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: CommonButtonWidget(
          innerColor: AppColor.dynamicColor,
          onTap: () {
            Get.to(DashboardScreen(selectIndex: 2));
          },
          isOutlineButton: true,
          buttonName: 'Shop All ${controller.memberShip.length} Memberships',
        ),
      );
    });
  }

  Widget _circleButton({
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30.r),
      child: Container(
        height: 38.w,
        width: 38.w,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 15.sp),
      ),
    );
  }
}

class PerkRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const PerkRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          bottom: 3.0.h,
          right: 10.w,
        ),
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: AppColor().whiteColor.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(30.r),
              border: BoxBorder.fromBorderSide(
                  BorderSide(width: 0.5, color: AppColor().whiteColor))),
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 20.h),
                SizedBox(width: 8.w),
                Text(
                  text,
                  style: AppTypography.hostGroteskSemiBold.copyWith(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
