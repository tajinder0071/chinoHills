import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common_Widgets/common_network_image_widget.dart';
import '../../common_Widgets/no_record.dart';
import '../../loading/cart_list_load.dart';
import '../../util/common_page.dart';
import 'package:get/get.dart';
import '../../CSS/color.dart';
import '../../../../../util/local_store_data.dart';
import '../../util/route_manager.dart';
import 'controller/search_location_controller.dart';

class SelectLocation extends StatelessWidget {
  SelectLocation({super.key});

  var searchLocation = Get.put(SearchLocationController());

  @override
  Widget build(BuildContext context) {
    searchLocation.viewClient();
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(
        isLeading: true,
        title: "Select Your Location",
        action: [],
      ),
      body: GetBuilder<SearchLocationController>(
        builder: (controller) => Center(
          child: Column(
            children: [
              controller.load
                  ? Expanded(child: CartListLoad())
                  : controller.clientList.isEmpty
                      ? NoRecord("No Record Found", Icon(Icons.clear), "")
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () async{
                              LocalStorage localStorage = LocalStorage();
                            var uId= await localStorage.getUId();
                              controller.selectClient(
                                  controller.clientList[index].id,
                                uId
                                  );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                height: 100.h,
                                width: 100.w,
                                child: Row(
                                  children: [
                                    CommonNetworkImageWidget(
                                      imageUrl: CommonPage().image_url +
                                          controller.clientList[index].image
                                              .toString(),
                                      borderRadius: BorderRadius.circular(10),
                                      height: 120.h,
                                      width: 120.w, fit: BoxFit.contain,
                                    ),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: Text(
                                        controller.clientList[index].clientName
                                            .toString(),
                                        style: GoogleFonts.merriweather(
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      size: 25.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          itemCount: controller.clientList.length,
                        ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, RouteManager.findYourLocationPage);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  elevation: 0,
                  shadowColor: AppColor.geryBackGroundColor,
                ),
                child: Text(
                  "+ Add a new location",
                  style: GoogleFonts.merriweather(fontSize: 17.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
