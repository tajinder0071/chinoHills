import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../CSS/image_page.dart';
import '../../../../util/common_page.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/controller/shop_controller.dart';

class HomePageSection extends StatelessWidget {
  HomePageSection({super.key});

  final ShopController shopController = Get.put(ShopController());
  var mediaQuery = MediaQuery.of(Get.context!).size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/new_images/home_background.png"),
        Positioned(
            top: 50.h,
            left: 0.w,
            right: 0.w,
            child: buildNimaRewardImageSection(shopController, context)),
        Positioned(
            bottom: 90.h,
            left: 16.w,
            right: 16.w,
            child: buildWelcomeSection(shopController)),
        Positioned(
          bottom: 0.h,
          left: 0.w,
          right: 0.w,
          child: Container(
            height: 100.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColor.dynamicColor.withValues(alpha: 0.01),
                  AppColor.dynamicColor.withValues(alpha: 1)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildWelcomeSection(ShopController controller) {
    String getGreeting() {
      final hour = DateTime.now().hour;
      if (hour < 12) {
        return "Good Morning";
      } else if (hour < 17) {
        return "Good Afternoon";
      } else {
        return "Good Evening";
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${getGreeting()}, ${controller.userName == "" || controller.userName == null ? "" : controller.userName.toString()}",
          textAlign: TextAlign.center,
          style: AppTypography.hostGroteskRegular.copyWith(
            fontSize: 14.sp,
            color: AppColor().blackColor.withValues(alpha: 0.65),
          ),
        ),
        SizedBox(height: mediaQuery.height * 0.01),
        controller.homeData.isEmpty
            ? SizedBox.shrink()
            : RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 26.sp,
                      // fontWeight: FontWeight.bold,
                      color: AppColor().blackColor.withValues(alpha: 0.65),
                      height: 1.h // default color
                      ),
                  children: [
                    TextSpan(
                      text: 'Just ',
                    ),
                    TextSpan(
                      text:
                          '${double.parse(controller.homeData[0].unlockAtCount.toString()).toInt()}',
                    ),
                    TextSpan(
                      text: ' More visit or\n',
                    ),
                    TextSpan(
                      text: 'Spend ',
                    ),
                    TextSpan(
                      text: formatCurrency(
                          controller.homeData[0].unlockSpend.toString()),
                    ),
                    TextSpan(
                      text: '  For Your\n',
                    ),
                    TextSpan(
                      text: 'Next Reward!',
                    ),
                  ],
                ),
              ),
        SizedBox(height: mediaQuery.height * 0.01),
        Text(
          AppStrings.scanText,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.hostGroteskRegular.copyWith(
              fontSize: 12.sp,
              color: AppColor().mediumGreyColor,
              fontWeight: FontWeight.w300),
        ),
        SizedBox(height: mediaQuery.height * 0.03),
        SizedBox(
          width: double.infinity,
          height: mediaQuery.height * 0.06,
          child: ElevatedButton.icon(
            onPressed: () =>
                Get.toNamed(RouteManager.qRCodeScannerPage)!.then((onValue) {
              shopController.homeApi();
            }),
            icon: Icon(
              Iconsax.scan,
              size: 20.h,
              // height: mediaQuery.height * 0.04,
              color: AppColor().whiteColor,
            ),
            label: Text(
              AppStrings.checkInForRewards,
              style: AppTypography.hostGroteskSemiBold.copyWith(
                color: AppColor().whiteColor,
                fontSize: 15.sp,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.dynamicColor,
              elevation: 0,
              padding: EdgeInsets.symmetric(
                      horizontal: mediaQuery.width * 0.05,
                      vertical: mediaQuery.height * 0.015)
                  .h,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildNimaRewardImageSection(ShopController controller, context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.50,
      width: double.infinity,
      child: controller.homeData.isEmpty
          ? Center(child: commonLoader(color: AppColor.dynamicColor))
          : controller.homeData[0].announcementOffers!.isEmpty
              ? Container(
                  decoration: BoxDecoration(
                      color: AppColor().transparent // fallback background
                      ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        (controller.homeData[0].headerImage != null &&
                                controller.homeData[0].headerImage!.isNotEmpty)
                            ? controller.homeData[0].headerImage.toString()
                            : "",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: AppColor().blackColor.withValues(alpha: .2),
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
                            height: size.height * 0.45,
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
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColor().transparent,
                                AppColor().transparent,
                                AppColor().whiteColor.withValues(alpha: .18),
                                AppColor().whiteColor.withValues(alpha: .6),
                              ],
                              stops: [0.0, 0.5, 0.7, 1.0],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : PageView.builder(
                  controller: controller.pageController,
                  itemCount:
                      (controller.homeData[0].announcementOffers?.length ?? 0) +
                          1,
                  onPageChanged: (index) =>
                      controller.currentPageForHeaderImage = index,
                  itemBuilder: (context, index) {
                    // First page -> Header Image
                    if (index == 0) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColor().greyColor.withValues(alpha: .2),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              (controller.homeData[0].headerImage != null &&
                                      controller
                                          .homeData[0].headerImage!.isNotEmpty)
                                  ? controller.homeData[0].headerImage
                                      .toString()
                                  : "",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  color: AppColor().blackColor.withValues(alpha: .2),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: AppColor.dynamicColor,
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: size.height * 0.3,
                                  width: double.infinity,
                                  color: AppColor.geryBackGroundColor,
                                  child: Center(
                                    child: Image.asset(
                                      AppImages.noAvailableImage,
                                      color: AppColor().blackColor,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                                child: Container(
                              height: size.height * 0.52,
                              width: double.infinity,
                              color: AppColor().blackColor.withValues(alpha: .1),
                            )),
                            Positioned(
                              bottom: size.height * 0.03,
                              left: size.width * 0.03,
                              right: size.width * 0.03,
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      controller.homeData[0].mainheader
                                          .toString()
                                          .toUpperCase(),
                                      style: AppTypography.hostGroteskRegular
                                          .copyWith(
                                        fontSize: 35.sp,
                                        color: AppColor().whiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Text(
                                      controller.homeData[0].subheader
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: AppTypography.hostGroteskRegular
                                          .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColor().whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    // Other pages -> Announcement Offers
                    var data =
                        controller.homeData[0].announcementOffers![index - 1];
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColor().greyColor.withValues(alpha: .2),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            (data.image != null && data.image!.isNotEmpty)
                                ? data.image.toString()
                                : "",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: AppColor().blackColor.withValues(alpha: .2),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.dynamicColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: size.height * 0.3,
                                width: double.infinity,
                                color: AppColor.geryBackGroundColor,
                                child: Center(
                                  child: Image.asset(
                                    AppImages.noAvailableImage,
                                    color: AppColor().blackColor,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: size.height * 0.03,
                                left: size.width * 0.03,
                                right: size.width * 0.03,
                              ),
                              child: Text(
                                data.title!.toUpperCase(),
                                style:
                                    AppTypography.hostGroteskRegular.copyWith(
                                  fontSize: 17.sp,
                                  color: AppColor().whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
