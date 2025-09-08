import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../CSS/color.dart';
import '../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';

class PaymentSuccessPopup extends StatelessWidget {
  final String transactionId;
  final String transactionType;

  const PaymentSuccessPopup({
    super.key,
    required this.transactionId,
    required this.transactionType,
  });

  String getCurrentFormattedDate() {
    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(now);
    final formattedDate = DateFormat('dd MMM yyyy').format(now);
    return '$formattedTime | $formattedDate';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColor().whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFEAF7EC),
              radius: 35.r,
              child: Lottie.asset(
                  'assets/lottie/success.json', // Ensure this exists in assets
                  height: 60.h,
                  width: 70.w,
                  repeat: true,
                  fit: BoxFit.cover),
            ),
            SizedBox(height: 16.h),
            Text(
              'Payment successful',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            /*Text.rich(TextSpan(children: [
              TextSpan(
                text: "Successfully paid",
                style: TextStyle(fontSize: 14.sp, color: Colors.black54),
              ),
              TextSpan(
                text: " \$$amount",
                style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              )
            ])),
            SizedBox(height: 20.h),*/
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailRow(label: 'Transaction ID', value: transactionId),
                  _DetailRow(label: 'Date', value: getCurrentFormattedDate()),
                  _DetailRow(
                      label: 'Type of Transaction', value: transactionType),
                  const _DetailRow(
                      label: 'Status', value: 'Success', status: true),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                  LocalStorage localStorage = LocalStorage();
                  localStorage.removeData("order_id");
                  Get.toNamed(RouteManager.orderPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.dynamicColor,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'View Orders',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool status;

  const _DetailRow({
    required this.label,
    required this.value,
    this.status = false,
  });

  @override
  Widget build(BuildContext context) {
    final valueWidget = status
        ? Row(
      children: [
        Icon(Icons.check_circle, size: 16.sp, color: Colors.green),
        SizedBox(width: 4.w),
        Text(
          'Success',
          style: TextStyle(color: Colors.green, fontSize: 14.sp),
        ),
      ],
    )
        : Text(
      value,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
      ),
      textAlign: TextAlign.right,
      maxLines: 2,
      overflow: TextOverflow.visible,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              label,
              style: TextStyle(color: Colors.black54, fontSize: 14.sp),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            flex: 6,
            child: valueWidget,
          ),
        ],
      ),
    );
  }
}
