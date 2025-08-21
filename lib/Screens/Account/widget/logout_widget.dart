import 'package:chino_hills/util/local_store_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../CSS/color.dart';
import '../../../util/base_services.dart';
import '../../../util/route_manager.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
          bottom: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(left: 10.h, right: 10.0.h, bottom: 5.0.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: AppColor.dynamicColor.withOpacity(0.2),
            radius: 40.r,
            child: Icon(
              Iconsax.logout,
              size: 30.h,
              color: AppColor.dynamicColor,
            ),
          ),
          // Icon(Icons.warning_amber_rounded, size: 40, color: AppColor().blueColor),
          SizedBox(height: 10.h),
          Text(
            "Logout from CH BUCKS",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Text(
            "Are you sure you would like to logout of your CH BUCKS account?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.sp, color: Colors.black54),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.dynamicColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: SizedBox(
                  height: 45.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      LocalStorage localStoraage = LocalStorage();
                      await localStoraage.clearAllData().then((onValue) {
                        getUser();
                      });
                      Get.offAllNamed(RouteManager.loginPage);
                      setState(() {});
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor().lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool isLoadings = false;

  Future<void> getUser() async {
    isLoadings = true;
    setState(() {});
    try {
      LocalStorage localStorage = LocalStorage();
      var isUser = await localStorage.getUId();
      var response = await hitUserAPI();
      Get.log("Coming Response :${response['success']}");
      if (response['success'] == true) {
        print(response['data'][0]['client_id']);
        localStorage.saveData(
          "client_id",
          response['data'][0]['client_id'].toString(),
        );
        String hex = response['data'][0]['themeColor'].toString().replaceAll(
          '#',
          '',
        );
        if (hex.length == 6) hex = 'FF$hex';
        Color dynamicColor = Color(int.parse(hex, radix: 16));
        AppColor.dynamicColor = dynamicColor;
        isLoadings = false;
        setState(() {});
      } else {
        isLoadings = false;
        setState(() {});
      }
    } on Exception catch (exception) {
      isLoadings = false;
      Get.log("Exception : ${exception.toString()}");
      setState(() {});
    }
  }
}
