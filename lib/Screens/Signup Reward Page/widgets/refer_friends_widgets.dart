import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../../../CSS/color.dart';
import '../../../util/route_manager.dart';

class ReferFriendPage extends StatefulWidget {
  var rewardPoints;

  ReferFriendPage({super.key, required this.rewardPoints});

  @override
  State<ReferFriendPage> createState() => _ReferFriendPageState();

}

class _ReferFriendPageState extends State<ReferFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Bootstrap.gift, size: 50.h, color: AppColor.dynamicColor),
              SizedBox(height: 10.h),
              Text(
                "Sharing is caring!",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                "Send a friend \$${widget.rewardPoints ?? "Not available"} Towards Any Service !",
                style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: Image.asset(
                  "assets/images/gift_image.jpg",
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 60.h),
              Container(
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                   color: AppColor.dynamicColor),
                child: ElevatedButton(
                  onPressed: () {
                    Get.log("Refer Pressed");
                    onShare(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  child: Text(
                    "Refer a friend",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor().whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              TextButton(
                onPressed: () =>
                    Get.offAllNamed(RouteManager.dashBoardPage, arguments: 0),
                child: Text(
                  "Maybe later",
                  style: TextStyle(fontSize: 16, color: AppColor.dynamicColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //? Todo ?? Here We add xLetter Nima App And His Functionalities...
  void onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share(
      "https://play.google.com/store/apps/details?id=com.io.waxxbrandz",
      subject:
          "Send a friend \$${widget.rewardPoints ?? "Not available"}\nTowards Any Service!",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
