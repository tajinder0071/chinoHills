import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/util/local_stoage.dart';
import 'package:chino_hills/util/route_manager.dart';
import 'package:chino_hills/util/services.dart';

import '../../../CSS/appTypography.dart';
import '../../../util/common_page.dart';

class DeleteWidget extends StatefulWidget {
  const DeleteWidget({super.key});

  @override
  State<DeleteWidget> createState() => _DeleteWidgetState();
}

class _DeleteWidgetState extends State<DeleteWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor().whiteColor,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.r), bottom: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.all(20.h),
      margin: EdgeInsets.only(left: 10.h, right: 10.0.h, bottom: 5.0.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              backgroundColor: AppColor().redColor.withValues(alpha: 0.2),
              radius: 40.r,
              child: Icon(
                Iconsax.profile_delete,
                size: 30.h,
                color: AppColor().redColor,
              )),
          SizedBox(height: 10.h),
          Text(
            "Delete Account from Nima",
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Are you sure you would like to delete of your nima account?",
            textAlign: TextAlign.center,
            style: AppTypography.hostGroteskSemiBold
                .copyWith(fontSize: 14.sp, color: Colors.black54),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            height: 45.h,
            width: 260.w,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor().whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("Cancel",
                  style: AppTypography.hostGroteskSemiBold
                      .copyWith(color: AppColor().blackColor, fontSize: 14.sp)),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 45.h,
            width: 260.w,
            child: ElevatedButton(
              onPressed: () {
                deleteAccount();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor().redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: load
                  ? Center(
                      child:
                          CircularProgressIndicator(color: AppColor().redColor))
                  : Text("Delete",
                      style: AppTypography.hostGroteskSemiBold.copyWith(
                          color: AppColor().whiteColor, fontSize: 14.sp)),
            ),
          ),
        ],
      ),
    );
  }

  var load = false;

  //create a function to delete the account using the API /deleteUser?user_id=224
  Future<void> deleteAccount() async {
    load = true;
    setState(() {});
    LocalStorage local = LocalStorage();
    //user id
    var userId = await local.getUId();
    print("${CommonPage().api}/deleteUser&user_id=${userId}");
    final response = await baseServiceDelete(
        "${CommonPage().api}/deleteUser&user_id=${userId}", {}, "");
    print(response.body);
    if (response.statusCode == 200) {
      // Account deleted successfully

      local.clearAllData();
      Get.offAllNamed(RouteManager.loginPage);
      load = false;
      setState(() {});
    } else {
      // Handle error
      Get.snackbar('Error', 'Failed to delete account');
      load = false;
      setState(() {});
    }
  }
}
//364926490
