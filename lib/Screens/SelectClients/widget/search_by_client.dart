import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common_Widgets/common_network_image_widget.dart';
import '../../../common_Widgets/no_record.dart';
import '../../../loading/order_list_load.dart';
import '../../../util/common_page.dart';
import '../../../../../util/local_store_data.dart';
import '../../../util/route_manager.dart';
import '../controller/search_location_controller.dart';

class SearchByClient extends StatelessWidget {
  SearchByClient(this.fromSomeFlow, {super.key});

  var fromSomeFlow;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchLocationController());
    controller.searchLocation();
    print("fromSomeFlow==>$fromSomeFlow");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(
        isLeading: false,
        title: "Select Client",
        action: [],
      ),
      // 13412091143
      body: GetBuilder<SearchLocationController>(
        builder: (controller) => controller.load
            ? OrderListLoad()
            : controller.searchList.isEmpty
                ? NoRecord("No Record Found", Icon(Icons.search), "")
                : ListView.builder(
                    itemCount: controller.searchList.length,
                    itemBuilder: (context, index) {
                      print(CommonPage().image_url +
                          controller.searchList[index].image.toString());
                      return InkWell(
                        onTap: () {
                          LocalStorage localStorage = LocalStorage();
                          var clientId = localStorage.getCId();
                          print(clientId);
                          fromSomeFlow.toString() == "false"
                              ?
                              //call dashboard page
                              Get.offAllNamed(RouteManager.dashBoardPage)
                              : Get.offAllNamed(
                                  RouteManager.rewardUnlockedScreen,
                                  parameters: {
                                      "client_id": controller
                                          .searchList[index].id
                                          .toString()
                                    });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CommonNetworkImageWidget(
                                imageUrl: CommonPage().image_url +
                                    controller.searchList[index].image
                                        .toString(),
                                height: 70.h,
                                width: 70.h,
                                borderRadius: BorderRadius.circular(10),
                                fit: null,
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.searchList[index].clientName
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text.rich(
                                      TextSpan(
                                        text: controller
                                            .searchList[index].clientEmail
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      ),
                                      softWrap: true,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
