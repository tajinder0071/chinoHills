import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chino_hills/CSS/appTypography.dart';

class CancelPaymentPopup extends StatelessWidget {
  //final String? transactionId;

  const CancelPaymentPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cancel_rounded,
              color: Colors.red,
              size: 40.sp,
            ),
            SizedBox(height: 10.h),
            Text(
              "Payment Cancelled",
              style: AppTypography.hostGroteskRegular.copyWith(
                fontSize: 15.sp,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 15.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 44.w, vertical: 10.h),
              ),
              onPressed: () {
                Navigator.of(context).pop(false); // return "false" if cancelled
              },
              child: const Text(
                "Close",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
