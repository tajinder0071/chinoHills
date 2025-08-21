import 'package:chino_hills/Screens/cartList/widgets/cart_item_widget.dart';
import 'package:chino_hills/Screens/cartList/widgets/order_summary_widget.dart';
import 'package:chino_hills/Screens/cartList/widgets/show%20_treatment_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../CSS/color.dart';
import '../../binding/package_details_binding.dart';
import '../../binding/treartmentDetailsBinding.dart';
import '../../loading/cart_list_load.dart';
import '../../util/common_page.dart';
import '../../../../../util/local_store_data.dart';
import '../../util/route_manager.dart';
import '../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import 'Controller/cart_controller.dart';
import 'widgets/promoCode_widget.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    controller.requestPermission();
    controller.cartList();


    return GetBuilder<CartController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColor().background,
          appBar: commonAppBar(isLeading: true, title: "Cart", action: []),
          body: controller.isLoading.value
              ? CartListLoad()
              : controller.cartData.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.shopping_bag,
                        color: Colors.black,
                        size: 55.h,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Your cart is empty".toUpperCase(),
                        style: TextStyle(
                          color: AppColor.dynamicColor,
                          fontSize: 20.h,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "You have no item's in your cart\n at the moment",
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10.h),
                      Container(
                        height: 35.h,
                        width: 150.w,
                        decoration: BoxDecoration(
                          color: AppColor.dynamicColor,
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            overlayColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            Get.offAllNamed(
                              RouteManager.dashBoardPage,
                              arguments: 2,
                            );
                          },
                          child: Text(
                            "Shop now".toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                        itemCount: controller.cartData.length,
                        itemBuilder: (context, index) {
                          var item = controller.cartData[index];
                          if (item.packageName != null) {
                            controller.rewardType = RewardType.package;
                            controller.imageUrl =
                                "${item.packageImagePath}" ?? '';
                            controller.title = item.packageName ?? '';
                            controller.price = formatCurrency(
                              item.price ?? 0.00,
                            );
                            controller.subtitle = '1 Package';
                            controller.cartID = item.cartId;
                            controller.itemID = item.packageId;
                          } else if (item.treatmentName != null) {
                            controller.rewardType = RewardType.treatment;
                            controller.cartID = item.cartId;
                            controller.itemID = item.treatmentId;
                            controller.imageUrl =
                                "${item.treatmentImagePath!.isEmpty ? "" : item.treatmentImagePath?[0] ?? ""}";
                            controller.title =
                                "${item.treatmentName} - ${item.treatmentVariationName}" ??
                                '';
                            controller.price = formatCurrency(
                              item.price ?? 0.00,
                            );
                            // '\$${(item.price ?? 0.00).toStringAsFixed(2)}';
                            controller.variationList =
                                item.treatmentVariations ?? [];
                            controller.variationId = item.treatmentId;

                            controller.subtitle = '1 treatment';
                          } else if (item.membershipName != null) {
                            controller.rewardType = RewardType.membership;
                            controller.cartID = item.cartId;
                            controller.itemID = item.memberId;
                            controller.imageUrl =
                                "${CommonPage().image_url}${item.membershipImage ?? ""}";
                            controller.title = item.membershipName ?? '';

                            controller.price = formatCurrency(
                              item.price ?? 0.00,
                            );
                            // '\$${item.price ?? '0.00'}';
                            controller.subtitle =
                                'Renews at ${controller.price}/month';
                            controller.memberPrice =
                                '\$${item.price ?? '0.00'}';
                            controller.memberTitle = item.membershipName ?? '';
                          }

                          return InkWell(
                            overlayColor: WidgetStateProperty.all(
                              Colors.transparent,
                            ),
                            onTap: () {
                              if (item.packageName != null) {
                                Get.to(
                                  () =>
                                      PackageDetailPage(sectionName: "Package"),
                                  arguments: item.packageId,
                                  binding: PackageDetailsBinding(),
                                  transition: Transition.fadeIn,
                                  duration: Duration(milliseconds: 500),
                                );
                              } else if (item.treatmentName != null) {
                                Get.log("treatment: ${item.treatmentId}");
                                Get.to(
                                  () => TreatmentDetailsPage(),
                                  arguments: item.treatmentId,
                                  binding: TreatmentDetailsBinding(),
                                  transition: Transition.fadeIn,
                                  duration: Duration(milliseconds: 500),
                                );
                              } else if (item.membershipName != null) {
                                Get.log("membership: ${item.memberId}");
                                Get.toNamed(
                                  RouteManager.membersShipDetailsPage,
                                  arguments: item.memberId,
                                  parameters: {"onlyShow": "0"},
                                );
                                // Add your MembershipDetailsPage navigation here
                              }
                            },
                            child: RewardItemCard(
                              imageUrl: controller.imageUrl,
                              title: controller.title,
                              price: controller.price,
                              type: controller.rewardType ?? RewardType.package,
                              subtitle: controller.subtitle,
                              onEdit: () {
                                Get.bottomSheet(
                                  ShowTreatmentServices(
                                    selectTr: item.treatmentVariations ?? [],
                                    selectedServiceId:
                                        item.treatmentVariationId,
                                    cartID: item.cartId,
                                    cartitemID: item.cartItemId,
                                  ),
                                  isDismissible: false,
                                  isScrollControlled: true,
                                );
                                Get.log('Edit ${controller.cartID}');
                              },
                              onRemove: () {
                                controller.deleteCart(item.cartItemId, index);
                                Get.log('Remove ${item.cartItemId}');
                              },
                              discountPrice: formatCurrency(
                                item.actualPrice ?? 0.00,
                              ),
                              // "\$${(item.actualPrice ?? 0.00).toStringAsFixed(2)}" ??
                              //     "",
                            ),
                          );
                        },
                      ),
                      //? Promotion Code
                      Obx(() {
                        final controller = Get.find<CartController>();
                        final hasApplied =
                            controller.cartModel1.value.promoCode != null ||
                            controller.cartModel1.value.reward != null;
                        final hasAvailable =
                            controller.couponAvailableData.isNotEmpty ||
                            controller.availableData.isNotEmpty;
                        if (!hasApplied && !hasAvailable) {
                          return SizedBox.shrink();
                        }
                        return promoSummaryCard(context);
                      }),
                      //? Order Summary
                      OrderSummaryCard(),
                    ],
                  ),
                ),
          persistentFooterButtons: controller.cartData.isEmpty
              ? null
              : [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: double.infinity,
                    color: Colors.transparent,
                    child: SizedBox(
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () async{
                          if (controller.isUpdate) {
                            null;
                          } else {
                            if (controller.currentLocation != null) {
                              //get order id in local storage
                              LocalStorage localStorage = LocalStorage();
                              var orderid =await localStorage.getOId();

                              controller.createOrder(
                                controller.cartModel1.value.reward == null
                                    ? 0
                                    : controller.cartModel1.value.reward!.id,
                                controller.cartModel1.value.promoCode == null
                                    ? ""
                                    : controller.cartModel1.value.promoCode!.id,
                                orderid,
                              );
                            } else {
                              controller.requestPermission();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.dynamicColor,
                          disabledBackgroundColor: AppColor.disableButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                          shadowColor: AppColor.dynamicColor,
                        ),
                        child: controller.isUpdate
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: AppColor().whiteColor,
                                ),
                              )
                            : Text(
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                "Checkout now".toUpperCase(),
                              ),
                      ),
                    ),
                  ),
                ],
        );
      },
    ); //add liquid refresh
  }

  Widget promoSummaryCard(context) {
    final controller = Get.find<CartController>();

    return Obx(() {
      final promoCode = controller.cartModel1.value.promoCode;
      final availableReward = controller.cartModel1.value.reward;

      if (promoCode != null || availableReward != null) {
        // If either promoCode or reward is available
        final discountName = promoCode?.name ?? availableReward?.name;
        final id = promoCode?.id ?? "", rewardId = availableReward?.id ?? "";

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.w),
          decoration: BoxDecoration(
            color: AppColor().whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(7.r),
              topRight: Radius.circular(7.r),
            ),
            border: Border.all(
              color: AppColor().greyColor.withOpacity(0.4),
              width: 1.h,
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(6.0.h),
            leading: Icon(Icons.check, color: Colors.green, size: 30),
            title: Text(
              '$discountName applied!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isTablet(context) ? 17.sp : 14.sp,
              ),
            ),
            subtitle: Text(
              "Tap to view all available promotions",
              style: TextStyle(fontSize: isTablet(context) ? 17.sp : 14.sp),
            ),
            trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
            onTap: () {
              print("promo id: $id");
              showPromoBottomSheet(id, rewardId);
            },
          ),
        );
      } else {
        // No promo or reward available
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
            decoration: BoxDecoration(
              color: AppColor().whiteColor,
              borderRadius: BorderRadius.circular(7.r),
              border: Border.all(
                color: AppColor().greyColor.withOpacity(0.4),
                width: 1.h,
              ),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(6.0.h),
              leading: Stack(
                alignment: Alignment.topRight,
                children: [
                  Icon(Icons.local_offer_outlined, size: 30.h),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
                  ),
                ],
              ),
              title: Text(
                "You have available promotions!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet(context) ? 15.sp : 14.sp,
                ),
              ),
              subtitle: Text(
                "Tap to view all available promotions",
                style: TextStyle(fontSize: isTablet(context) ? 15.sp : 14.sp),
              ),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
              onTap: () => showPromoBottomSheet(null, null),
            ),
          ),
        );
      }
    });
  }

  //? Bottom Sheet..
  showPromoBottomSheet(var selectedID, id) async {
    Get.bottomSheet(
      PromocodeWidget(selectedId: selectedID, reward_id: id),
      isScrollControlled: true,
    ).then((value) {
      print("should update $value");

      if (value == true) {
        Get.find<CartController>().cartList();
      }
    });
  }
}
