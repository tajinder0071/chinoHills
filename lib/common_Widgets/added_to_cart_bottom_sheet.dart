import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../CSS/color.dart';
import '../util/route_manager.dart';

class AddedToCartBottomSheet extends StatelessWidget {
  final String titleName;
  var price;
  var quantity;
  final String quantityName;
  bool isChecked;
  String membeTitleName;
  var memberPrice;

  AddedToCartBottomSheet(
      {super.key,
      required this.titleName,
      required this.quantity,
      required this.quantityName,
      required this.membeTitleName,
      required this.memberPrice,
      this.isChecked = false,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.close),
            ),
          ),
          SizedBox(height: 8.h),
          Icon(Icons.check_circle_outline, color: Colors.black, size: 40.h),
          SizedBox(height: 15.h),
          Text(
            "Added to cart!",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Divider(),
          SizedBox(height: 5.h),
          // TODO >> This is for Package..
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleName.toString(),
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4.h),
                    quantity != null && quantity != 0
                        ? Text(
                      "$quantity $quantityName",
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    )
                        : SizedBox.shrink(),

                  ],
                ),
              ),
              SizedBox(width: 12),
              Text(
                "\$$price",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          isChecked
              ? Divider(
                  thickness: 1,
                )
              : SizedBox.shrink(),
          // Todo >>  this is the members id checked...
          isChecked
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            membeTitleName.toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Membership",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "\$$memberPrice",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              : SizedBox.shrink(),
          SizedBox(height: 25.h),
          SafeArea(
            child: InkWell(
              onTap: () => Get.offAndToNamed(RouteManager.cartList),
              overlayColor: WidgetStatePropertyAll(AppColor().transparent),
              child: Container(
                width: double.infinity,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.dynamicColor,
                ),
                child: ElevatedButton(
                  onPressed: () => Get.offAndToNamed(RouteManager.cartList),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: Text(
                    "View Cart",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor().whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
