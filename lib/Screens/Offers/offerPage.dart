import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../CSS/color.dart';
import '../../common_Widgets/cacheNetworkImage.dart';
import '../../common_Widgets/no_record.dart';
import '../../util/common_page.dart';
import '../../util/route_manager.dart';
import 'controler/offer_controller.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OfferController());
    return GetBuilder<OfferController>(
      init: OfferController(),
      builder: (controller) => Scaffold(
          backgroundColor: AppColor().background,
          appBar: commonAppBar(isLeading: true, title: 'Offers', action: []),
          body: controller.load
              ? Center(child: commonLoader(color: AppColor.dynamicColor))
              : controller.offerData.isEmpty
                  ? Center(
                      child: NoRecord(
                        "No Data Found",
                        Icon(Icons.no_accounts),
                        "We're sorry. no data available at this moment.\nPlease check back later",
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(15.h),
                      itemCount: controller.offerData.length,
                      itemBuilder: (context, index) => Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                                color: AppColor().whiteColor,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(2, 2),
                                    blurRadius: 5,
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      // border: Border.all(
                                      //   color: AppColor().blueColor.withOpacity(0.5),
                                      //   width: 1.w,
                                      // ),
                                      color: Colors.white),
                                  margin: EdgeInsets.all(8.w),
                                  child: ConstantNetworkImage(
                                    isLoad: true,
                                    imageUrl: CommonPage().image_url +
                                        controller.offerData[index].offerimage
                                            .toString(),
                                    height: 170.h,
                                    width: double.infinity,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '${controller.offerData[index].title}',
                                    style: GoogleFonts.sarabun(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '${controller.offerData[index].headline}',
                                    style: GoogleFonts.sarabun(fontSize: 14.sp),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed(RouteManager.offerDataLearnMore,
                                        arguments: controller.offerData[index]);
                                    // Get.to(
                                    //     OfferDetail(
                                    //         controller.offerData[index]),
                                    //     transition: Transition.downToUp,
                                    //     duration: Duration(milliseconds: 500));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: [
                                          AppColor().gradiant1,
                                          AppColor().gradiant2,
                                        ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight)),
                                    width: double.infinity,
                                    height: 50.h,
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Learn More",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17.h),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))),
    );
  }
}
