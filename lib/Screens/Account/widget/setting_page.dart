import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import '../../../CSS/color.dart';
import '../../../util/common_page.dart';
import '../../../util/route_manager.dart';
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
            style: GoogleFonts.sarabun(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          // Subtitle
          Text(
            'Spread the word and share the love!\nInvite your friends to join and enjoy amazing services together.',
            textAlign: TextAlign.center,
            style: GoogleFonts.sarabun(fontSize: 15.sp, color: Colors.black54),
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
                  style: GoogleFonts.sarabun(
                      fontSize: 16.sp, color: AppColor.dynamicColor),
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
                  style: GoogleFonts.sarabun(
                      fontSize: 16.sp, color: AppColor().whiteColor),
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
        ? "https://play.google.com/store/apps/details?id=com.io.chino_hills"
        : "https://apps.apple.com/us/app/ch-eyecare/id6752308586";

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
      MenuItem(
          title: 'Refer a Friend',
          icon: Iconsax.share,
          onTap: () {
            showReferFriendDialog();
          }),
      /*MenuItem(
        title: 'Select Your Location',
        icon: Iconsax.location,
        onTap: () {
          // Get.to(SearchByLocation());
          Get.toNamed(RouteManager.selectLocationPage);
        },
      ),*/
      MenuItem(
          title: 'Delete Account',
          icon: Iconsax.profile_delete,
          onTap: () {
            showDeleteBottomSheet(context);
          }),
      MenuItem(
          title: 'Log out',
          icon: Iconsax.logout,
          onTap: () {
            showLogoutBottomSheet(context);
          }),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor().whiteColor,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        title: Text(
          "Your Account",
          style: GoogleFonts.sarabun(
              color: Colors.black,
              fontSize: 17.sp,
              fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return ListTile(
            leading: Icon(
              item.icon,
              color: Colors.black,
              size: isTablet(context) ? 30.h : 23.h,
            ),
            title: Text(item.title,
                style: GoogleFonts.sarabun(
                    fontSize: 16.sp, fontWeight: FontWeight.w500)),
            trailing: Icon(Icons.arrow_forward_ios,
                size: 16.h, color: AppColor.dynamicColor),
            onTap: item.onTap,
          );
        },
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
