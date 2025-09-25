import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/CSS/image_page.dart';
import 'package:chino_hills/Model/home_model.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../../common_Widgets/common_horizontal_list.dart';
import '../../../../common_Widgets/common_network_image_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/Pages/Package Page/controller/package_cotroller.dart';
class BecomeAMember extends StatelessWidget {
  final VoidCallback onPressed;
  List<Membership>? data;
  List<MembershipPerk>? perks;
  var membershipPerkHeader;
  final PackageController controller = Get.put(PackageController());

  BecomeAMember(
      {super.key,
        required this.onPressed,
        this.data,
        this.perks,
        this.membershipPerkHeader});

  @override
  Widget build(BuildContext context) {
    print(controller.memberships.length);
    return data!.isEmpty || data == null
        ? Container(
      padding: EdgeInsets.only(top: 5.h, left: 0.w, bottom: 10.0.h),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.dynamicColor),
      child: Column(
        children: [
          controller.memberships.isEmpty
              ? SizedBox.shrink()
              : SizedBox(height: 20.h),
          controller.memberships.isEmpty
              ? SizedBox.shrink()
              : Icon(
            Icons.verified_outlined,
            color: AppColor().whiteColor,
            size: isTablet(context) ? 40.h : 30.h,
          ),
          controller.memberships.isEmpty
              ? SizedBox.shrink()
              : SizedBox(height: 6.h),
          // TODO: Make the title part reusable if used in other places
          controller.memberships.isEmpty
              ? SizedBox.shrink()
              : _buildTitle(),
          SizedBox(height: 20.h),
          // TODO: Refactor membership list into a separate widget for reusability
          controller.memberships.isEmpty
              ? SizedBox.shrink()
              : _buildMembershipList(context),
          SizedBox(height: 20.h),
          // TODO: Extract Membership Perks Section into a reusable widget
          _buildMembershipPerks(),
          SizedBox(height: 20.h),
          // TODO: Reuse this button in other areas, as it might be a common action
          _buildShopAllButton(),
          SizedBox(height: 20.h),
        ],
      ),
    )
        : Container(
      padding: EdgeInsets.only(top: 5.h, left: 0.w, bottom: 10.0.h),
      width: double.infinity,
      decoration: BoxDecoration(color: AppColor.dynamicColor),
      child: Column(
        children: [
          data!.isEmpty ? SizedBox.shrink() : SizedBox(height: 15.h),
          data!.isEmpty
              ? SizedBox.shrink()
              : Icon(
            Icons.verified_outlined,
            color: AppColor().whiteColor,
            size: isTablet(context) ? 40.h : 30.h,
          ),
          data!.isEmpty ? SizedBox.shrink() : SizedBox(height: 6.h),
          // TODO: Make the title part reusable if used in other places
          data!.isEmpty ? SizedBox.shrink() : _buildTitle(),
          SizedBox(height: 20.h),
          // TODO: Refactor membership list into a separate widget for reusability
          data!.isEmpty
              ? SizedBox.shrink()
              : _buildMembershipList(context),
          SizedBox(height: 20.h),
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
          return Text(
            textAlign: TextAlign.center,
            controller.browseDetailModel.data == null
                ? membershipPerkHeader
                : controller.browseDetailModel.data!.membershipHeader,
            style: GoogleFonts.merriweather(
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: AppColor().whiteColor),
          );
        });
  }

  // TODO: Move this part into its own widget so it can be reused across the app
  Widget _buildMembershipList(context) {
    return GetBuilder<PackageController>(
        init: PackageController(),
        builder: (controller) {
          return controller.bload
              ? SizedBox(
              height: isTablet(context)
                  ? MediaQuery.of(context).size.height * .35
                  : MediaQuery.of(context).size.height < 812
                  ? MediaQuery.of(context).size.height * .31
                  : 230.h,
              child: BecomeAMemberLoading())
              : data!.isEmpty
              ? CommonHorizontalList(
              itemWidth: 200.w,
              height: isTablet(context)
                  ? MediaQuery.of(context).size.height * .35
                  : MediaQuery.of(context).size.height < 812
                  ? MediaQuery.of(context).size.height * .31
                  : 235.h,
              items: controller.memberships,
              itemBuilder: (context, member, index) {
                Widget imageWidget;
                if (member.membershipImage == null ||
                    member.membershipImage!.isEmpty) {
                  imageWidget = Container(
                    height: 150.h,
                    width: double.infinity,
                    color: AppColor.geryBackGroundColor,
                    child: Image.asset(
                      AppImages.noAvailableImage,
                      color: AppColor().blackColor,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  imageWidget = Stack(
                    children: [
                      CommonNetworkImageWidget(
                        imageUrl: member.membershipImage.toString(),
                        height: 150.0.h,
                        width: double.infinity,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(6.0.r)),
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
                }
                return InkWell(
                    onTap: () {
                      Get.toNamed(
                        RouteManager.membersShipDetailsPage,
                        arguments: member.membershipId,
                        parameters: {"onlyShow": "0"},
                      );
                    },
                    child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: 190.w,
                        margin: EdgeInsets.only(left: 5.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: AppColor().whiteColor,
                        ),
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            Center(
                                child: Stack(
                                  children: [
                                    imageWidget,
                                    member.offeroffText!.isEmpty
                                        ? SizedBox.shrink()
                                        : Positioned(
                                      top: 10.h,
                                      left: 5.w,
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6.w, vertical: 3.h),
                                        decoration: BoxDecoration(
                                          color: AppColor.dynamicColor,
                                          borderRadius:
                                          BorderRadius.circular(5.r),
                                        ),
                                        child: Text(member.offeroffText
                                            .toString()
                                            .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                            SizedBox(
                              height: 50.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 5.h),
                                child: Text(
                                  member.membershipTitle.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.merriweather(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "\$${member.membershipPricing}",
                                        style: GoogleFonts.roboto(
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "/month",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        RouteManager
                                            .membersShipDetailsPage,
                                        arguments: member.membershipId,
                                        parameters: {"onlyShow": "0"},
                                      );
                                    },
                                    child: Icon(
                                      Icons.navigate_next_rounded,
                                      color: AppColor.dynamicColor,
                                      size: 24.h,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )));
              })
              : CommonHorizontalList(
              height: isTablet(context)
                  ? MediaQuery.of(context).size.height * .35
                  : MediaQuery.of(context).size.height < 812
                  ? MediaQuery.of(context).size.height * .31
                  : 235.h,
              itemWidth: 200.w,
              items: data!,
              itemBuilder: (context, member, index) {
                // var member = data![index];
                Widget imageWidget;
                if (member.membershipImage == null ||
                    member.membershipImage!.isEmpty) {
                  imageWidget = Container(
                    height: 150.h,
                    width: double.infinity,
                    color: AppColor.geryBackGroundColor,
                    child: Image.asset(
                      AppImages.noAvailableImage,
                      color: AppColor().blackColor,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  imageWidget = Stack(
                    children: [
                      CommonNetworkImageWidget(
                        imageUrl: member.membershipImage.toString(),
                        height: 150.0.h,
                        width: double.infinity,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(6.0.r)),
                        fit: BoxFit.cover,
                      ),
                    ],
                  );
                }
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      RouteManager.membersShipDetailsPage,
                      arguments: member.membershipId,
                      parameters: {"onlyShow": "0"},
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    width: 190.w,
                    margin: EdgeInsets.only(
                      left: 5.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.r),
                      color: AppColor().whiteColor,
                    ),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        Center(
                            child: Stack(
                              children: [
                                imageWidget,
                                member.offeroffText!.isEmpty
                                    ? SizedBox.shrink()
                                    : Positioned(
                                  top: 10.h,
                                  left: 5.w,
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: AppColor.dynamicColor,
                                      borderRadius:
                                      BorderRadius.circular(5.r),
                                    ),
                                    child: Text(member.offeroffText
                                        .toString()
                                        .toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),)
                              ],
                            )),
                        SizedBox(
                          height: 50.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 5.h),
                            child: Text(
                              member.membershipTitle.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.merriweather(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Divider(),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "\$${member.membershipPricing}",
                                    style: GoogleFonts.roboto(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "/month",
                                    style: GoogleFonts.roboto(
                                      fontSize: 15.sp,
                                    ),
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    RouteManager.membersShipDetailsPage,
                                    arguments: member.membershipId,
                                    parameters: {"onlyShow": "0"},
                                  );
                                },
                                child: Icon(
                                  Icons.navigate_next_rounded,
                                  color: AppColor.dynamicColor,
                                  size: 24.h,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  // TODO: Membership Perks section
  Widget _buildMembershipPerks() {
    return GetBuilder<PackageController>(builder: (controller) {
      return (controller.membershipPerk.isEmpty && perks!.isEmpty)
          ? SizedBox.shrink()
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.membershipPerks,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w900,
              fontSize: 17.sp,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 10),
            child: perks!.isEmpty
            // We are showing this list for BROWSE PAGE ONLY
                ? ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.membershipPerk.length,
              itemBuilder: (context, index) => PerkRow(
                icon: controller.membershipPerk[index].membershipIcon ==
                    'reward'
                    ? Icons.card_giftcard
                    : controller.membershipPerk[index].membershipIcon ==
                    'calendar'
                    ? Icons.calendar_month
                    : Icons.local_offer_outlined,
                text: controller.membershipPerk[index].membershipPerk
                    .toString(),
              ),
            )
            // We are showing this list for HOME PAGE ONLY
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: perks!.length,
              itemBuilder: (context, index) => PerkRow(
                icon: perks![index].membershipIcon == 'reward'
                    ? Icons.card_giftcard
                    : perks![index].membershipIcon == 'calendar'
                    ? Icons.calendar_month
                    : Icons.local_offer_outlined,
                text: perks![index].membershipPerk.toString(),
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
          onTap: () => onPressed(),
          isOutlineButton: true,
          buttonName:
          'Shop all ${data!.isEmpty ? controller.memberShip.length : data!.length} memberships',
        ),
      );
    });
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
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 20.h),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 17.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
