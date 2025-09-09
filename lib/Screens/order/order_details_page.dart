import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../CSS/color.dart';
import '../../util/common_page.dart';
import 'controller/order_controller.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage(this.orderId, {super.key});

  final String orderId;

  // ✅ Custom capitalize function (safe)
  String capitalize(String? text) {
    if (text == null || text.isEmpty) return "Item";
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: Get.find<OrderController>()..orderDetailApi(orderId),
      builder: (controller) {
        final order = controller.detailModel.orders?.isNotEmpty == true
            ? controller.detailModel.orders!.first
            : null;

        return Scaffold(
          backgroundColor: AppColor().whiteColor,
          appBar: commonAppBar(
            isLeading: true,
            title: "Order Details",
            action: [],
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              // 🔹 Show shimmer while loading
              if (controller.loading || order == null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: List.generate(3, (_) => _shimmerItem()),
                  ),
                )
              // 🔹 No items in this order
              else if (order.orderitems == null || order.orderitems!.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "No items found in this order.",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              // 🔹 Actual order items
              else
                _orderItemList(controller, order),

              // 🔹 Shipment Details
              if (!controller.loading && order != null)
                _shipmentCard(
                  order.transactionId ?? "",
                  order.paymentMethod ?? "Card",
                ),

              // 🔹 Summary Card
              if (!controller.loading && order != null)
                _summaryCard(controller.totalCount, order),
            ],
          ),
        );
      },
    );
  }

  /// 🔹 Order Items List
  Widget _orderItemList(OrderController controller, dynamic order) {
    // ✅ set totalCount to number of products instead of summing quantities
    controller.totalCount = order.orderitems!.length;

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: order.orderitems!.length,
      itemBuilder: (_, index) {
        var item = order.orderitems![index];

        final String imagePath = item.image ?? "";
        final String name = item.itemName?.isNotEmpty == true
            ? item.itemName!
            : "Unnamed Item";
        final double price = (item.price ?? 0).toDouble();
        final double offerPrice = (item.offerPrice ?? 0).toDouble();
        final int quantity = item.quantity ?? 0;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 5.h),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imagePath,
                  width: 80.w,
                  height: 80.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) {
                    return Container(
                      height: 80.h,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: AppColor.geryBackGroundColor,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/images/Image_not_available.png",
                          color: AppColor().blackColor,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  loadingBuilder: (ctx, child, progress) {
                    if (progress == null) return child;
                    return SizedBox(
                      height: 80.h,
                      width: 80.w,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: AppColor.dynamicColor,
                          radius: 14,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (offerPrice > 0) ...[
                      Text(
                        formatCurrency(price - offerPrice),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        formatCurrency(price), // original price
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ] else
                      Text(
                        formatCurrency(price),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      "$quantity ${capitalize(item.itemType)}",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Shimmer Placeholder Item
  Widget _shimmerItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12.h,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12.h,
                    width: 100.w,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12.h,
                    width: 80.w,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shipmentCard(String trID, String type) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Shipment Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _shipmentRow("Order Type", "Online Purchase"),
        ],
      ),
    );
  }

  Widget _summaryCard(int totalCount, dynamic order) {
    final double cartTotal = (order.cartTotalPrice ?? 0).toDouble();
    final double totalAmount = (order.totalAmount ?? 0).toDouble();
    final double convenienceFee = (order.convenienceFree ?? 0).toDouble();

    // Calculate discount if not provided
    final double discount = (cartTotal + convenienceFee) - totalAmount;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: const Border(top: BorderSide(color: Colors.grey, width: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Detail",
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          summaryRow(
            "Subtotal",
            "$totalCount products", // ✅ changed to products
            formatCurrency(cartTotal),
          ),
          formatCurrency(discount > 0 ? discount : 0) == "\$0.00"
              ? SizedBox.shrink()
              : summaryRow(
                  "Discount",
                  "",
                  '-${formatCurrency(discount > 0 ? discount : 0)}',
                  valueColor: Colors.green,
                ),
          summaryRow("Convenience Fee", "", formatCurrency(convenienceFee)),
          const Divider(),
          summaryRow(
            "Total amount",
            "",
            formatCurrency(totalAmount),
            isBold: true,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget summaryRow(
    String title,
    String subtitle,
    String value, {
    bool isBold = false,
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: subtitle.isNotEmpty
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                text: title,
                style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black,
                ),
                children: subtitle.isNotEmpty
                    ? [
                        const TextSpan(text: "\n"),
                        TextSpan(
                          text: subtitle,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ]
                    : [],
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _shipmentRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(color: Colors.black54)),
          ),
        ],
      ),
    );
  }
}
