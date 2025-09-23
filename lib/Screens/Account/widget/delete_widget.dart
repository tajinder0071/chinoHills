import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import '../../../CSS/color.dart';
import '../../../util/common_page.dart';
import '../../../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';
import '../../../util/services.dart';

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
              Iconsax.profile_delete,
              size: 30.h,
              color: AppColor.dynamicColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Delete Account from Chino Hills",
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Text(
            "Are you sure you would like to delete of your Chino Hills account?",
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
                    onPressed: () {
                      deleteAccount();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor().lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: load
                        ? Center(
                            child: CircularProgressIndicator(
                              color: AppColor.dynamicColor,
                            ),
                          )
                        : Text("Delete", style: TextStyle(color: Colors.black)),
                  ),
                ),
              ),
            ],
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
    var userId =await local.getUId();
    print("${CommonPage().api}/deleteUser&user_id=${userId}");
    final response = await baseServiceDelete(
      "${CommonPage().api}/deleteUser&user_id=${userId}",
      {},
      "",
    );
    print(response.body);
    if (response.statusCode == 200) {
      // Account deleted successfully

     await local.clearAllData();
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
