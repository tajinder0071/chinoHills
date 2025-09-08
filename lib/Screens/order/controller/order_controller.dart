import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Model/order_detail_model.dart';
import '../../../Model/orer_list_model.dart';
import '../../../util/base_services.dart';
import '../../../util/local_store_data.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  List<Orders> orderList = [];
  RxBool isLoading = false.obs;
  bool loading = false;
  LocalStorage localStorage = LocalStorage();
  OrderListModel response = OrderListModel();
  OrderDetailModel detailModel = OrderDetailModel();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();

  var totalCount;

  Future<void> handleRefresh() async {
    await orderListApi();
  }

  ///Todo: order list api implement
  orderListApi() async {
    orderList.clear();
    isLoading.value = true;
    update();
    try {
      //response = await hitOrderListApi();
      orderList.addAll(response.orders!);
      print(orderList);
      isLoading.value = false;
      update();
    } on Exception catch (e) {
      isLoading.value = false;
      update();
    }
  }

  // Todo >>  order list api implement
  orderDetailApi(String orderId) async {
    loading = true;
    try {
      detailModel = await hitOrderDetailApi(orderId);
      print(response);
      loading = false;
      update();
    } on Exception catch (e) {
      loading = false;
      update();
    }
  }
}
