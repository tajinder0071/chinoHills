import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/color.dart';

class BooksOrderSummaryCard extends StatelessWidget {
  final String orderId;
  final double totalAmount;
  final String status;
  final String? customerName;
  final String orderDate;
  final int totalItems;
  final VoidCallback? onTap;

  const BooksOrderSummaryCard({
    super.key,
    required this.orderId,
    required this.totalAmount,
    required this.status,
    this.customerName,
    required this.orderDate,
    required this.totalItems,
    this.onTap,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat.simpleCurrency().format(totalAmount);
    DateTime parsedDate = DateFormat('MMMM, dd yyyy HH:mm:ss').parse(orderDate);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              spreadRadius: 1,
              offset: Offset(0, 0), // No offset = shadow on all sides
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.receipt_long, size: 22.sp),
                SizedBox(width: 8.w),
                Text("Order Summary",
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 15.sp,
                      color: Colors.black87,
                    )),
                Spacer(),
                CircleAvatar(
                  radius: 16.r,
                  backgroundColor: AppColor().background,
                  child: Icon(Icons.arrow_forward_ios_rounded,
                      size: 14.h, color: AppColor.dynamicColor),
                ),
              ],
            ),
            Divider(height: 20.h, thickness: 1, color: Colors.grey.shade300),
            SizedBox(height: 4.h),
            _buildInfoRow("Order ID", orderId),
            _buildInfoRow("Amount", currency),
            _buildInfoRow("Date", DateFormat('dd-MMM yyyy').format(parsedDate)),
            // _buildInfoRow("Items", totalItems.toString()),
            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Status",
                    style: AppTypography.hostGroteskSemiBold.copyWith(
                      fontSize: 13.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    )),
                Text(
                  status.toUpperCase(),
                  style: AppTypography.hostGroteskRegular.copyWith(
                    color: AppColor.dynamicColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: AppTypography.hostGroteskSemiBold.copyWith(
                fontSize: 13.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              )),
          Text(
            value,
            style: AppTypography.hostGroteskSemiBold.copyWith(
              color: Colors.black87,
              fontSize: 14.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
//add shadow on all sides
