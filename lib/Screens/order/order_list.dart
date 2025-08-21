import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../../CSS/color.dart';
import '../../common_Widgets/no_record.dart';
import '../../loading/order_list_load.dart';
import '../../util/common_page.dart';
import 'controller/order_controller.dart';
import 'order_details_page.dart';
import 'widgets/order_summury_widget.dart';

class OrderList extends StatelessWidget {
  OrderList({super.key});

  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    orderController.orderListApi();
    return GetBuilder<OrderController>(
      builder: (controller) {
        print("orderController.orderList=>${orderController.orderList}");
        return Scaffold(
          backgroundColor: AppColor().background,
          appBar: commonAppBar(isLeading: true, title: "Orders", action: []),
          body: controller.isLoading.value
              ? OrderListLoad()
              : orderController.orderList.isEmpty
                  ? Center(
                      child: NoRecord(
                          "No orders Found",
                          Icon(Icons.no_accounts),
                          "We're sorry. no order available at this moment.\nPlease check back later"),
                    )
                  : LiquidPullToRefresh(
                      animSpeedFactor: 1.5,
                      springAnimationDurationInMilliseconds: 400,
                      key: controller.refreshIndicatorKey,
                      color: AppColor.dynamicColor,
                      showChildOpacityTransition: false,
                      backgroundColor: Colors.white,
                      onRefresh: controller.handleRefresh,
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 10),
                          itemCount: orderController.orderList.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < orderController.orderList.length) {
                              return BooksOrderSummaryCard(
                                orderId: orderController
                                    .orderList[index].orderId
                                    .toString(),
                                totalAmount: orderController
                                            .orderList[index].totalAmount ==
                                        ""
                                    ? 0.0
                                    : double.parse(orderController
                                        .orderList[index].totalAmount
                                        .toString()),
                                status: orderController
                                            .orderList[index].paymentStatus !=
                                        ""
                                    ? orderController
                                        .orderList[index].paymentStatus
                                        .toString()
                                    : "pending",
                                customerName: "",
                                orderDate: orderController
                                    .orderList[index].orderDate
                                    .toString(),
                                totalItems: orderController
                                    .orderList[index].items!.length,
                                onTap: () {
                                  Get.to(
                                          () => OrderDetailsPage(
                                                orderController
                                                    .orderList[index].orderId
                                                    .toString(),
                                              ),
                                          transition: Transition.fadeIn,
                                          duration:
                                              Duration(milliseconds: 500))!
                                      .then((_) {
                                    orderController.orderListApi();
                                  });
                                },
                              );
                            } else {
                              // TODO ?? Footer widget (at the end)
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Center(child: getBrand()),
                              );
                            }
                          }),
                    ),
        );
      },
    );
  }
}
