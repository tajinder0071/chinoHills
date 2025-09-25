import 'package:chino_hills/Screens/cartList/widgets/cart_item_widget.dart';
import 'package:chino_hills/Screens/cartList/widgets/order_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../CSS/color.dart';
import '../../binding/cart_billing.dart';
import '../../loading/cart_list_load.dart';
import '../../util/common_page.dart';
import '../../util/local_store_data.dart';
import '../../util/route_manager.dart';
import '../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import 'Controller/cart_controller.dart';
import 'widgets/promoCode_widget.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    controller.requestPermission();
    controller.cartList();

    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColor().background,
          appBar: commonAppBar(isLeading: true, title: "Cart", action: []),
          body: controller.isLoading
              ? CartListLoad()
              : controller.cartData.isEmpty
              ? _buildEmptyCart(context)
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
                    double price =
                        double.tryParse(item.price.toString()) ?? 0.0;
                    double discount = double.tryParse(
                        item.discountPrice.toString()) ??
                        0.0;
                    double originalAmount = price - discount;
                    // Map API fields -> controller fields
                    if (item.itemType == "Packages") {
                      controller.rewardType = RewardType.package;
                      controller.imageUrl = item.imageUrl ?? '';
                      controller.title = item.name ?? '';
                      controller.price =
                          formatCurrency(item.price ?? 0.00);
                      controller.subtitle =
                      '${item.quantity} Package';
                      controller.cartID = item.cartItemId;
                      controller.itemID = item.itemId;
                    } else if (item.itemType == "Treatments") {
                      controller.rewardType = RewardType.treatment;
                      controller.cartID = item.cartItemId;
                      controller.itemID = item.itemId;
                      controller.imageUrl = item.imageUrl ?? '';
                      controller.title =
                          item.variationName ?? item.name ?? '';
                      controller.price =
                          formatCurrency(item.price ?? 0.00);
                      controller.variationId = item.itemVariantId;
                      controller.subtitle =
                      '${item.quantity} Treatment';
                    } else if (item.itemType == "Memberships") {
                      controller.memId = item.itemId.toString();
                      print("memId${controller.memId}");
                      controller.rewardType = RewardType.membership;
                      controller.cartID = item.cartItemId;
                      controller.itemID = item.itemId;
                      controller.imageUrl = item.imageUrl ?? '';
                      controller.title = item.name ?? '';
                      controller.price =
                          formatCurrency(item.price ?? 0.00);
                      controller.subtitle =
                      'Renews at ${controller.price}/month';
                      controller.memberPrice =
                          formatCurrency(item.price ?? 0.00);
                      controller.memberTitle = item.name ?? '';
                      controller.memDiscount =
                      item.discountPrice.toString() == '0.0'
                          ? item.discountPrice.toString()
                          : originalAmount.toString();
                    }

                    return InkWell(
                      overlayColor:
                      WidgetStateProperty.all(Colors.transparent),
                      onTap: () {
                        // Navigate based on item_type
                        if (item.itemType == "Packages") {
                          Get.to(
                                () => PackageDetailPage(
                                sectionName: "Package"),
                            arguments: item.itemId,
                            binding: CommonBinding(),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 500),
                          );
                        } else if (item.itemType == "Treatments") {
                          Get.log("treatment: ${item.itemId}");
                          Get.to(
                                () => TreatmentDetailsPage(),
                            arguments: item.itemId,
                            binding: CommonBinding(),
                            transition: Transition.fadeIn,
                            duration: Duration(milliseconds: 500),
                          );
                        } else if (item.itemType == "Memberships") {
                          Get.log("membership: ${item.itemId}");

                          Get.toNamed(
                            RouteManager.membersShipDetailsPage,
                            arguments: item.itemId,
                            parameters: {"onlyShow": "0"},
                          );
                        }
                      },
                      child: RewardItemCard(
                        imageUrl: controller.imageUrl,
                        title: controller.title,
                        price: controller.price,
                        type: controller.rewardType ??
                            RewardType.package,
                        subtitle: controller.subtitle,
                        onRemove: () async {
                          controller.deleteCart(
                            item.cartItemId,
                            index,
                          );
                          Get.log('Remove ${item.cartItemId}');
                        },
                        discountPrice:
                        item.discountPrice.toString() == '0.0'
                            ? item.discountPrice
                            : formatCurrency(
                            originalAmount ?? 0.00) ??
                            0.00,
                      ),
                    );
                  },
                ),

                // Promo Code section
                promoSummaryCard(context, controller.memId),
                OrderSummaryCard(controller.cartData,
                    controller.cartModel1.value.data!.offerType),
              ],
            ),
          ),

          // ✅ persistentFooterButtons should be here, not inside Column
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
                  onPressed: () async {
                    if (controller.isUpdate) {
                      null;
                    }
                    else {
                      if (controller.currentLocation != null) {
                        //get order id in local storage
                        LocalStorage localStorage = LocalStorage();
                        var orderid = await localStorage.getOId();

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
                    /*   List discountList = controller.cartData.map((item) => item.discountPrice).toList();
                          double totalDiscount = discountList.fold(0, (sum, d) => sum + d);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutPage(
                                      controller.cartData,
                                      controller.cartModel1.value.data!
                                                  .offerType
                                                  .toString() ==
                                              "Promo Code"
                                          ? 'Discount (Promotion)'
                                          : controller.cartModel1.value.data!
                                                      .offerType
                                                      .toString() ==
                                                  'Membership'
                                              ? 'Membership Discount'
                                              : 'Discount (Reward)',
                                      CartController.cart.totalCost,formatCurrency('-${totalDiscount}'),formatCurrency(CartController.cart.totalConvenienceFee),formatCurrency(CartController.cart.finalTotalCost))));*/
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
          ]);
    });
  }

  Widget promoSummaryCard(BuildContext context, String memId) {
    final controller = Get.find<CartController>();

    return Obx(() {
      final promoCode = controller.cartModel1.value.promoCode;
      final availableReward = controller.cartModel1.value.reward;

      final id = promoCode?.id ?? "";
      final rewardId = availableReward?.id ?? "";

      // 1. Membership has the highest priority

      final discountName =
          controller.cartModel1.value.data!.offerName; // fallback
      print("discountName${discountName}");
      if (discountName != "") {
        return _buildAppliedCard(
          context,
          '$discountName',
          id,
          rewardId,
          memId,
        );
      } else if (controller.response.membership != null &&
          controller.response.offers != [] &&
          controller.response.rewards != []) {
        return _buildAvailableCard(context, memId);
      } else {
        return SizedBox.shrink();
      }
    });
  }

  /// ✅ Helper widget for applied state (Membership / Reward / Promo)
  Widget _buildAppliedCard(
      BuildContext context,
      String title,
      String id,
      String rewardId,
      String memId,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: AppColor().whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: AppColor().greyColor.withOpacity(0.4),
          width: 1.h,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(6.0.h),
        leading: Icon(Icons.check, color: Colors.green, size: 30),
        title: Text(
          '$title applied!',
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
        onTap: () => showPromoBottomSheet(id, rewardId, memId),
      ),
    );
  }

  Widget _buildAvailableCard(BuildContext context, String memId) {
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
          onTap: () => showPromoBottomSheet(null, null, memId),
        ),
      ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.shopping_bag, color: Colors.black, size: 55.h),
          SizedBox(height: 5.h),
          Text("Your cart is empty".toUpperCase(),
              style: TextStyle(
                  color: AppColor.dynamicColor,
                  fontSize: 20.h,
                  fontWeight: FontWeight.w500)),
          Text("You have no items in your cart\n at the moment",
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center),
          SizedBox(height: 10.h),
          Container(
            height: 35.h,
            width: 150.w,
            decoration: BoxDecoration(
                color: AppColor.dynamicColor,
                borderRadius: BorderRadius.circular(10.0.r)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
                overlayColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                Get.offAllNamed(RouteManager.dashBoardPage, arguments: 2);
              },
              child: Text(
                "Shop now".toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  showPromoBottomSheet(var selectedID, id, membershipId) async {
    Get.bottomSheet(
      PromocodeWidget(
        selectedId: selectedID,
        reward_id: id,
        memId: membershipId,
      ),
      isScrollControlled: true,
    ).then((value) {
      if (value == true) {
        Get.find<CartController>().cartList();
      }
    });
  }
}
