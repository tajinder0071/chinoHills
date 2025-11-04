import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import 'package:chino_hills/util/common_page.dart';
import 'package:chino_hills/util/route_manager.dart';
import 'package:share_plus/share_plus.dart';
import '../../../CSS/appTypography.dart';
import 'delete_widget.dart';
import 'logout_widget.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  void showReferFriendDialog() {
    Get.defaultDialog(
      barrierDismissible: false,
      title: '',
      contentPadding: EdgeInsets.all(5.h),
      backgroundColor: AppColor().background,
      radius: 15,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColor.dynamicColor,
                  AppColor.dynamicColor.withAlpha(400)
                ],
              ),
            ),
            child:
                Icon(Icons.card_giftcard, color: Colors.white, size: 30.spMax),
          ),
          SizedBox(height: 15.h),
          // Title
          Text(
            'Invite & Earn',
            style: AppTypography.hostGroteskSemiBold.copyWith(
              fontSize: 20.sp,
            ),
          ),
          SizedBox(height: 8.h),
          // Subtitle
          Text(
            'Spread the word and share the love!\nInvite your friends to join and enjoy amazing services together.',
            textAlign: TextAlign.center,
            style: AppTypography.galanoGrostesqueSemiBold
                .copyWith(fontSize: 15.sp, color: Colors.black54),
          ),
          SizedBox(height: 20.h),
          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel Button
              OutlinedButton(
                onPressed: () => Get.back(),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColor.dynamicColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.h),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                ),
                child: Text(
                  'Maybe Later',
                  style: AppTypography.hostGroteskSemiBold
                      .copyWith(fontSize: 16.sp, color: AppColor.dynamicColor),
                ),
              ),
              // Invite Button
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  _onShare(Get.context!);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dynamicColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  padding:
                      EdgeInsets.symmetric(horizontal: 25.w, vertical: 12.h),
                ),
                child: Text(
                  'Send Invite',
                  style: AppTypography.hostGroteskSemiBold
                      .copyWith(fontSize: 16.sp, color: AppColor().whiteColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    final String shareText = Platform.isAndroid
        ? "https://play.google.com/store/apps/details?id=com.app.nima"
        : "https://apps.apple.com/us/app/nima-newport/id6745820609";

    await Share.share(
      "$shareText\n\nSend a friend \$25\nTowards Any Service!",
      subject: "Invite & Earn Rewards!",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<MenuItem> menuItems = [
      MenuItem(
          title: 'Account details',
          icon: Iconsax.user,
          onTap: () => Get.toNamed(RouteManager.accountDetail)),
      MenuItem(
          title: 'Order history',
          icon: Iconsax.folder_open,
          onTap: () => Get.toNamed(RouteManager.orderHistory)),
      /*MenuItem(
          title: 'Reward history',
          icon: Iconsax.gift,
          onTap: () => Get.toNamed('/reward-history')),
      MenuItem(
          title: 'Visit history',
          icon: Iconsax.scanning,
          onTap: () => Get.toNamed('/visit-history')),
      MenuItem(
          title: 'Contact us',
          icon: Iconsax.message_question,
          onTap: () => Get.toNamed('/contact')),*/
      MenuItem(
          title: 'Refer a Friend',
          icon: Iconsax.share,
          onTap: () {
            showReferFriendDialog();
          }),
      /* MenuItem(
        title: 'Select Your Location',
        icon: Iconsax.location,
        onTap: () {
          // Get.to(SearchByLocation());
          Get.toNamed(RouteManager.selectLocationPage);
        },
      ),*/
      MenuItem(
          title: 'Log out',
          icon: Iconsax.logout,
          onTap: () {
            showLogoutBottomSheet(context);
          }),
    ];

    return Scaffold(
      appBar: CommonAppBar(title: "Your Account"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      color: AppColor.dynamicColor.withValues(alpha: .09),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: item.onTap,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Leading Icon
                            CircleAvatar(
                              backgroundColor: AppColor.dynamicColor,
                              radius: 23.h,
                              child: Icon(
                                item.icon,
                                color: AppColor().whiteColor,
                                size: isTablet(context) ? 30.h : 23.h,
                              ),
                            ),

                            SizedBox(width: 15.w),

                            // Title
                            Expanded(
                              child: Text(
                                item.title,
                                style: AppTypography.galanoGrostesqueSemiBold
                                    .copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),

                            // Trailing Icon
                            CircleAvatar(
                              backgroundColor: AppColor.dynamicColor,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: 16.h,
                                color: AppColor().whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () => showDeleteBottomSheet(context),
              child: Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: AppColor().redColor.withValues(alpha: .2)),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Leading
                      CircleAvatar(
                        backgroundColor: AppColor().redColor,
                        radius: 20.h,
                        child: Icon(
                          Icons.delete,
                          color: AppColor().whiteColor,
                          size: isTablet(context) ? 30.h : 23.h,
                        ),
                      ),

                      SizedBox(width: 15.w),

                      // Title
                      Expanded(
                        child: Text(
                          "Delete Account",
                          style: AppTypography.hostGroteskSemiBold.copyWith(
                            fontSize: 16.sp,
                          ),
                        ),
                      ),

                      // Trailing
                      Container(
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColor().redColor,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 16.h,
                          color: AppColor().whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  MenuItem({required this.title, required this.icon, required this.onTap});
}

void showLogoutBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SafeArea(child: LogoutWidget());
    },
  );
}

class DeleteMenuItem {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DeleteMenuItem(
      {required this.title, required this.icon, required this.onTap});
}

void showDeleteBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return SafeArea(child: DeleteWidget());
    },
  );
}
