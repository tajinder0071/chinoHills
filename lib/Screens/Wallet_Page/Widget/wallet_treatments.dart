import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/common_Widgets/common_button_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../../CSS/image_page.dart';
import '../../../common_Widgets/common_webViewUrl.dart';
import '../../../loading/browse_Concern_load.dart';
import '../controller/wallet_treatment_Controller.dart';

class WalletTreatments extends StatelessWidget {
  WalletTreatments({super.key});

  final WalletTreatmentController walletController =
      Get.put(WalletTreatmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().lightGrey?.withValues(alpha: 0.5),
      body: GetBuilder<WalletTreatmentController>(
          init: walletController..fetchWalletTreatmentList(),
          builder: (controller) {
            if (controller.isTLoading.value) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Column(
                    children: [
                      Container(
                        height: 200.h,
                        width: double.infinity,
                        color: AppColor().whiteColor,
                      ),
                      Expanded(child: BrowseConcernLoad())
                    ],
                  ));
            }

            final treatment = controller.treatmentList;

            if (treatment == null || treatment.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 150.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.noDataFoundBg),
                              colorFilter: ColorFilter.mode(
                                AppColor.dynamicColor,
                                BlendMode.srcIn,
                              ))),
                      child: Icon(
                        Iconsax.search_normal,
                        size: 60.h,
                        color: AppColor().whiteColor,
                      ),
                    ),
                  ),
                  Text(
                    'No Data Found',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor().blackColor,
                        fontWeight: FontWeight.w500),
                  )
                ],
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.h),
                      child: Text("Nima",
                          style: AppTypography.hostGroteskSemiBold.copyWith(
                              fontSize: 15.sp,
                              color: AppColor().lightBlackColor)),
                    ),
                    ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: treatment.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            child: /*InkWell(
                        onTap: () {
                          Get.to(() => WalletTreatmentDetails());
                        },
                        splashFactory: NoSplash.splashFactory,
                        child:*/
                                Card(
                                    elevation: 0.5,
                                    color: AppColor().whiteColor,
                                    shadowColor: AppColor().whiteColor,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 5.w, vertical: 7.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(15.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          /*Text(treatment[index].quantity.toString(),
                                          style: AppTypography.hostGroteskRegular
                                              .copyWith(
                                            fontSize: 12.sp,
                                            color: AppColor()
                                                .lightBlackColor
                                                .withOpacity(0.4),
                                          )),
                                      SizedBox(height: 5.h),*/
                                          Text(
                                              treatment[index]
                                                  .treatmentTitle
                                                  .toString(),
                                              maxLines: 2,
                                              style: AppTypography
                                                  .galanoGrostesqueSemiBold
                                                  .copyWith(
                                                fontSize: 14.sp,
                                                color: AppColor().blackColor,
                                              )),
                                          Text(
                                              "${treatment[index].quantity} ${treatment[index].treatmentVariantName.toString()}",
                                              style: AppTypography
                                                  .hostGroteskRegular
                                                  .copyWith(
                                                fontSize: 12.sp,
                                                color: AppColor()
                                                    .lightBlackColor
                                                    .withValues(alpha: 0.4),
                                              )),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 35.h,
                                                width: 100.w,
                                                child: CommonButtonWidget(
                                                  onTap: () {
                                                    var url =
                                                        "https://booking.nimawellness.com/online-booking/";
                                                    Get.to(WebViewPage(
                                                      url: url,
                                                      title: "Book Appointment",
                                                    ));
                                                  },
                                                  buttonName: "Book",
                                                  innerColor:
                                                      AppColor.dynamicColor,
                                                  outlineColor:
                                                      AppColor.dynamicColor,
                                                  isOutlineButton: false,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                          );
                        }),
                    SizedBox(
                      height: 90.h,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
