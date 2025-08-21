import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../common_Widgets/common_network_image_widget.dart';
import '../../../common_Widgets/no_record.dart';
import '../../../loading/cart_list_load.dart';
import '../../../util/common_page.dart';
import '../../../util/route_manager.dart';
import '../controller/search_by_location_controller.dart';

class SearchByLocation extends StatelessWidget {
  SearchByLocation({super.key});

  final SearchbyController controller = Get.put(SearchbyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: commonAppBar(
        isLeading: true,
        title: 'Search by location',
        action: [],
      ),
      body: GetBuilder<SearchbyController>(
        builder: (controller) => Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: TextField(
                onChanged: controller.onSearchChanged,
                controller: controller.searchFieldController,
                decoration: InputDecoration(
                  hintText: "Search zipcode",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: controller.load
                  ? CartListLoad()
                  : controller.searchFieldController.text.trim().isEmpty
                      ? NoRecord(
                          "Please enter a zipcode", Icon(Icons.clear), "")
                      : controller.clientList.isEmpty
                          ? NoRecord("No Record Found", Icon(Icons.clear), "")
                          : ListView.builder(
                              itemCount: controller.clientList.length,
                              itemBuilder: (context, index) {
                                final item = controller.clientList[index];
                                return InkWell(
                                  onTap: () {
                                    ///addClients?client_id=3&user_id=130
                                    Get.toNamed(
                                      RouteManager.completeProfile,
                                      arguments: {
                                        "userId": "",
                                        "otp": "",
                                        "id": item.id,
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 6.0),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(7.h),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CommonNetworkImageWidget(
                                                fit: BoxFit.contain,
                                                imageUrl:
                                                    CommonPage().image_url +
                                                        item.image.toString(),
                                                height: 80.h,
                                                width: 80.w,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            SizedBox(width: 12),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.clientName!,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.black87,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  RichText(
                                                    text: TextSpan(
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                      children: [
                                                        TextSpan(
                                                          text:
                                                              '${item.address} ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              ' - ${item.zipcode}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward_ios,
                                                size: 20, color: Colors.black),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
            ),
          ],
        ),
      ),
    );
  }
}
