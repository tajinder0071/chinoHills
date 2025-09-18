import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../../../CSS/color.dart';
import '../../../../../CSS/image_page.dart';
import '../../../../../Model/treatment_details_model.dart';
import '../../../../../util/common_page.dart';
import '../controller/treatment_details_controller.dart';

class TrearmentImagePageView extends StatelessWidget {
  TrearmentImagePageView({
    super.key,
    required this.data,
  });

  final controller = Get.find<TreatmentDetailsController>();
  final Treatment data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0.r),
            child: SizedBox(
              height: 250.0.h,
              child: data.images!.isEmpty
                  ? Container(
                height: 250.h,
                width: double.infinity,
                color: Colors.black12,
                child: Center(child: Icon(Icons.error)),
              )
                  : PageView.builder(
                controller: controller.pageController,
                itemCount: data.images?.length ?? 0,
                onPageChanged: (index) =>
                controller.currentPage.value = index,
                itemBuilder: (context, index) {
                  return Image.network(
                    (data.images != null &&
                        data.images!.isNotEmpty)
                        ? data.images![index]
                        : "",
                    fit: BoxFit.contain,
                    width: double.infinity,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 250.h,
                        width: double.infinity,
                        color: Colors.black12,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColor.dynamicColor,
                            value: loadingProgress.expectedTotalBytes !=
                                null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ??
                                    1)
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250.h,
                        width: double.infinity,
                        color: AppColor.geryBackGroundColor,
                        child: Center(
                            child: Image.asset(
                              AppImages.noAvailableImage,
                              color: AppColor().blackColor,
                              fit: BoxFit.cover,
                            )),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 10.h),
        // Page indicator dots
        if (data.images == null)
          SizedBox.shrink()
        else if (data.images!.length <= 1)
          SizedBox.shrink()
        else
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              data.images?.length ?? 0,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 2.0.w),
                height: 8.0,
                width:
                controller.currentPage.value == index ? 16.0.w : 8.0.w,
                decoration: BoxDecoration(
                  color: controller.currentPage.value == index
                      ? AppColor.dynamicColor
                      : AppColor().greyColor,
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
              ),
            ),
          )),
      ],
    );
  }
}
