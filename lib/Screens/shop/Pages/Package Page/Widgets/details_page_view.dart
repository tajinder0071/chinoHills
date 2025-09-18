import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../CSS/color.dart';
import '../../../../../CSS/image_page.dart';
import '../../../../../Model/package_details_model.dart';
import '../controller/package_cotroller.dart';

class DetailsPageView extends StatelessWidget {
  DetailsPageView({
    super.key,
    required this.data,
  });

  final controller = Get.find<PackageController>();
  final Package data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColor().greyColor.withOpacity(.1)),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0.r),
              child: SizedBox(
                height: 250.0.h,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: (data.images?.isNotEmpty ?? false)
                      ? data.images!.length
                      : 1,
                  onPageChanged: (index) =>
                  controller.currentPage.value = index,
                  itemBuilder: (context, index) {
                    return Image.network(
                      (data.images != null && data.images!.isNotEmpty)
                          ? data.images![index]
                          : "",
                      fit: BoxFit.contain,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
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
                  width: controller.currentPage.value == index
                      ? 16.0.w
                      : 8.0.w,
                  decoration: BoxDecoration(
                    color: controller.currentPage.value == index
                        ? AppColor.dynamicColor
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(8.0.r),
                  ),
                ),
              ),
            )),

          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 10.0.h),
            child: Text(
              data.description.toString(),
              style: GoogleFonts.roboto(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87),
            ),
          ),

        ],
      ),
    );
  }
}
