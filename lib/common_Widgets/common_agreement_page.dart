import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../CSS/color.dart';
import '../Screens/Dashboard/Home/controller/membership_detail_controller.dart';
import '../util/common_page.dart';

class CommonAgreementPage extends StatelessWidget {
  CommonAgreementPage({super.key});

  final controller = Get.put(MembershipDetailController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MembershipDetailController>(
      init: Get.find<MembershipDetailController>()..getTermAndCondition(),
      builder: (memController) {
        return Container(
          height: Get.height * 0.89,
          decoration: BoxDecoration(
            color: AppColor().whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h, left: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Get.back(),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "PATIENT MEMBERSHIP AGREEMENT",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: memController.isLoading
                    ? Center(child: commonLoader())
                    : memController.response != null
                    ? SingleChildScrollView(
                        child: SafeArea(
                          child: Html(data: memController.response.content),
                        ),
                      )
                    : SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}
