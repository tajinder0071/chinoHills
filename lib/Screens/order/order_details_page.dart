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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      init: Get.find<OrderController>()..orderDetailApi(orderId),
      builder: (controller) => Scaffold(
        backgroundColor: AppColor().whiteColor,
        appBar:
            commonAppBar(isLeading: true, title: "Order details", action: []),
        body: Stack(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                controller.detailModel.orders == null
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: List.generate(3, (_) => _shimmerItem()),
                        ),
                      )
                    : controller.detailModel.orders![0].orderitems == null
                        ? Text(
                            "No items found in this order.",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: controller
                                .detailModel.orders![0].orderitems!.length,
                            itemBuilder: (_, index) {
                              var item = controller
                                  .detailModel.orders![0].orderitems![index];

                              final String imagePath = item.image!;

                              final String name = item.itemName!.isNotEmpty
                                  ? item.itemName!
                                  : "";

                              final dynamic price =
                                  item.price.toString().isNotEmpty
                                      ? item.price
                                      : '0';
                              final dynamic OfferPrice =
                                  item.offerPrice.toString().isNotEmpty
                                      ? item.offerPrice
                                      : '0';
                              print(OfferPrice);
                              final dynamic quantity = item.quantity ?? 1;

                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border:
                                      Border.all(color: Colors.grey.shade200),
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
                                            clipBehavior: Clip.antiAlias,
                                            height: 80.h,
                                            width: 80.w,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppColor.geryBackGroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
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
                                              child: Platform.isAndroid
                                                  ? Center(
                                                      child:
                                                          CupertinoActivityIndicator(
                                                              color: AppColor()
                                                                  .background))
                                                  : CupertinoActivityIndicator(
                                                      color: AppColor
                                                          .dynamicColor),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          OfferPrice.toString() == '0.0'
                                              ? SizedBox.shrink()
                                              : Text(
                                                  formatCurrency(
                                                      price - OfferPrice),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                          Text(
                                            formatCurrency(price),
                                            style: OfferPrice.toString() ==
                                                    '0.0'
                                                ? TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                  )
                                                : TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black54,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "$quantity ${item.itemType?.capitalize ?? 'Item'}",
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
                          ),

                // Shipment Details
                controller.loading
                    ? const SizedBox.shrink()
                    : _shipmentCard(
                        controller.detailModel.orders?[0].transactionId ?? 0.0,
                        controller.detailModel.orders?[0].paymentMethod ??
                            "Card",
                      ),

                // Summary Details
                controller.loading ? const SizedBox.shrink() : _summaryCard(),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
                    height: 10.h,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 70.h,
                    width: 100.w,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 90.h,
                    width: 80.w,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _shipmentCard(trID, type) {
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
          const Text("Shipment Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          // _shipmentRow("Transaction ID", "$trID"),
          _shipmentRow("Payment Method", "$type"),
          _shipmentRow("Order Type", "Online Purchase"),
        ],
      ),
    );
  }

  Widget _summaryCard() {
    final order =
        OrderController.instance.detailModel.orders?.isNotEmpty == true
            ? OrderController.instance.detailModel.orders![0]
            : null;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: Colors.grey, width: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Detail",
            style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          const Text(
            "Use this personalized guide to get your store up and running.",
            style: TextStyle(fontSize: 13, color: Colors.black87),
          ),
          SizedBox(height: 20.h),
          summaryRow(
            "Subtotal",
            "${order!.items!.length ?? 0} items",
            formatCurrency(order.cartTotalPrice),
          ),
          /* summaryRow(
            "offer price",
            "",
            formatCurrency(-order.cartOfferPrice),
          ),*/
          summaryRow(
            "convenience fee",
            "",
            formatCurrency(order.convenienceFree),
          ),
          const Divider(),
          summaryRow("Total amount", "", formatCurrency(order.totalAmount),
              isBold: true),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget summaryRow(String title, String subtitle, String value,
      {bool isBold = false}) {
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
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
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
            child: Text(
              value,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
