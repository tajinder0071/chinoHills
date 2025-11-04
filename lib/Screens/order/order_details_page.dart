import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/Screens/order/controller/order_controller.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import 'package:chino_hills/util/common_page.dart';
import 'package:shimmer/shimmer.dart';
import '../../CSS/color.dart';

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
          appBar: CommonAppBar(title: "Order Details"),
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
                    style: AppTypography.hostGroteskRegular.copyWith(
                      fontSize: 16.sp,
                      color: Colors.black54,
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
        final String name =
            item.itemName?.isNotEmpty == true ? item.itemName! : "Unnamed Item";
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
                color: Colors.grey.withValues(alpha: 0.05),
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
                      style: AppTypography.galanoGrostesqueMedium.copyWith(
                        fontSize: 16.sp,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (offerPrice > 0) ...[
                      Text(
                        formatCurrency(price - offerPrice),
                        style: AppTypography.hostGroteskRegular.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        formatCurrency(price), // original price
                        style: AppTypography.hostGroteskRegular.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ] else
                      Text(
                        formatCurrency(price),
                        style: AppTypography.hostGroteskRegular.copyWith(
                          fontSize: 14.sp,
                          color: Colors.black54,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      "$quantity ${capitalize(item.itemType)}",
                      style: AppTypography.hostGroteskRegular.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
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
        padding: EdgeInsets.all(12),
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
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 12.h,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 12.h,
                    width: 100.w,
                    color: Colors.grey.shade300,
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 12.h,
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

  Widget _shipmentCard(String trID, String type) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Shipment Details",
              style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                fontSize: 18.sp,
              )),
          SizedBox(height: 12),
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
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Detail",
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
              fontSize: 17.sp,
            ),
          ),
          SizedBox(height: 20.h),
          summaryRow(
            "Subtotal",
            "$totalCount products", // ✅ changed to products
            formatCurrency(cartTotal),
          ),
          formatCurrency(discount > 0 ? discount : 0) == "\$0.00" ||
                  formatCurrency(discount > 0 ? discount : 0) == "\$0"
              ? SizedBox.shrink()
              : summaryRow(
                  "Discount",
                  "",
                  '-${formatCurrency(discount > 0 ? discount : 0)}',
                  valueColor: Colors.green,
                ),
          summaryRow(
            "Convenience Fee",
            "",
            formatCurrency(convenienceFee),
          ),
          Divider(),
          summaryRow("Total amount", "", formatCurrency(totalAmount),
              isBold: true),
          SizedBox(height: 12),
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
      padding: EdgeInsets.symmetric(vertical: 4),
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
                style: isBold
                    ? AppTypography.hostGroteskSemiBold.copyWith(
                        fontSize: 14.sp,
                        color: valueColor ?? Colors.black,
                      )
                    : AppTypography.hostGroteskRegular.copyWith(
                        fontSize: 14.sp,
                        color: valueColor ?? Colors.black,
                      ),
                children: subtitle.isNotEmpty
                    ? [
                        TextSpan(text: "\n"),
                        TextSpan(
                          text: subtitle,
                          style: AppTypography.hostGroteskSemiBold
                              .copyWith(fontSize: 12.sp, color: Colors.grey),
                        ),
                      ]
                    : [],
              ),
            ),
          ),
          Text(
            value,
            style: isBold
                ? AppTypography.hostGroteskSemiBold.copyWith(
                    fontSize: 14.sp,
                    color: valueColor ?? Colors.black,
                  )
                : AppTypography.hostGroteskRegular.copyWith(
                    fontSize: 14.sp,
                    color: valueColor ?? Colors.black,
                  ),
          ),
        ],
      ),
    );
  }

  Widget _shipmentRow(String title, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style:
                  AppTypography.hostGroteskSemiBold.copyWith(fontSize: 14.sp),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppTypography.hostGroteskRegular
                  .copyWith(color: Colors.black54, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
