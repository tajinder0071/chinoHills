import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/util/local_stoage.dart';
import '../../../CSS/appTypography.dart';
import '../../../CSS/color.dart';
import '../../../util/route_manager.dart';
import '../../Splash/controller/splash_controller.dart';

class LogoutWidget extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  LogoutWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r), bottom: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(left: 10.h, right: 10.0.h, bottom: 5.0.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              backgroundColor: AppColor.dynamicColor.withValues(alpha: 0.2),
              radius: 40.r,
              child: Icon(
                Iconsax.logout,
                size: 30.h,
                color: AppColor.dynamicColor,
              )),
          // Icon(Icons.warning_amber_rounded, size: 40, color: AppColor().blueColor),
          SizedBox(height: 10.h),
          Text(
            "Logout from Nima",
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(fontSize: 18.sp,),
          ),
          SizedBox(height: 10.h),
          Text(
            "Are you sure you would like to logout of your nima account?",
            textAlign: TextAlign.center,
            style: AppTypography.hostGroteskRegular.copyWith(fontSize: 14.sp, color: Colors.black54),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 45.h,
            width: 260.w,
            child: ElevatedButton(
              onPressed: () async {
                final storage = LocalStorage();
                await storage.clearAllData();
                splashController.getUser();
                AppColor.dynamicColor = Colors.blue;
                Get.offAllNamed(RouteManager.loginPage);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.dynamicColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text("Logout",
                  style:
                  AppTypography.hostGroteskSemiBold.copyWith(color: AppColor().whiteColor, fontSize: 14.sp)),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 45.h,
            width: 260.w,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor().lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Cancel",
                  style: AppTypography.hostGroteskSemiBold.copyWith(color: AppColor().blackColor, fontSize: 14.sp)),
            ),
          ),
        ],
      ),
    );
  }
}
