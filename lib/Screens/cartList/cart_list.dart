import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/Screens/cartList/Controller/Wallet_controller.dart';
import 'package:chino_hills/Screens/cartList/Controller/cart_controller.dart';
import 'package:chino_hills/Screens/cartList/widgets/cart_item_widget.dart';
import 'package:chino_hills/Screens/cartList/widgets/empty_cart.dart';
import 'package:chino_hills/Screens/cartList/widgets/order_summary_widget.dart';
import 'package:chino_hills/Screens/shop/Pages/Package Page/Widgets/package_detail_page.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';
import 'package:chino_hills/util/common_page.dart';
import 'package:chino_hills/util/local_stoage.dart';
import '../../CSS/color.dart';
import '../../binding/cart_billing.dart';
import '../../common_Widgets/wallet_cash_widget.dart';
import '../../loading/cart_list_load.dart';
import '../../util/route_manager.dart';
import 'widgets/promoCode_widget.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final walletController = Get.put(WalletController());
    controller.isAccepted = false;
    controller.requestPermission();
    controller.cartList();

    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
          backgroundColor: AppColor().background,
          appBar: CommonAppBar(title: "Cart"),
          body: controller.isLoading
              ? CartListLoad()
              : controller.cartData.isEmpty
                  ? EmptyCart()
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
                                  offerType:controller.offerType,
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
                          SizedBox(height: 10.h),
                          controller.cartModel1.value.data!.nimaCashBalance
                                      .toString() ==
                                  "0"
                              ? SizedBox.shrink()
                              : WalletCashWidget(
                                  isAvailable: controller.cartModel1.value.data!
                                                  .nimaCashApplied
                                                  .toString() ==
                                              "0.0" ||
                                          controller.cartModel1.value.data!
                                                  .nimaCashApplied
                                                  .toString() ==
                                              "0"
                                      ? true
                                      : false,
                                  availableAmount: controller.cartModel1.value
                                                  .data!.nimaCashApplied
                                                  .toString() ==
                                              "0.0" ||
                                          controller.cartModel1.value.data!
                                                  .nimaCashApplied
                                                  .toString() ==
                                              "0"
                                      ? double.parse(controller.cartModel1.value
                                          .data!.nimaCashBalance
                                          .toString())
                                      : double.parse(controller.cartModel1.value
                                          .data!.nimaCashApplied
                                          .toString()),
                                  onApply: () {
                                    controller
                                        .applyWalletCash(
                                            controller.cartModel1.value.data!
                                                .nimaCashBalance,
                                            controller.cartModel1.value.data!
                                                .subTotal)
                                        .then((value) {
                                      controller.cartList();
                                    });
                                  },
                                  isEdit: () {
                                    walletController.isEditing.value = true;
                                  },
                                  onRemove: () async {
                                    await controller
                                        .removeNimaCash(controller.sendCartID);
                                    walletController.isEditing.value = false;
                                  },
                                  isViewMode: controller.cartModel1.value.data!
                                                  .nimaCashApplied
                                                  .toString() ==
                                              "0.0" ||
                                          controller.cartModel1.value.data!
                                                  .nimaCashApplied
                                                  .toString() ==
                                              "0"
                                      ? true
                                      : false,
                                  subtotalAmount: controller
                                      .cartModel1.value.data!.subTotal,
                                  nimaCashBalance: double.parse(controller
                                      .cartModel1.value.data!.nimaCashBalance
                                      .toString()),
                                ),
                          OrderSummaryCard(
                            isNimaCashApplied: controller.cartModel1.value.data!
                                            .nimaCashApplied
                                            .toString() ==
                                        "0.0" ||
                                    controller.cartModel1.value.data!
                                            .nimaCashApplied
                                            .toString() ==
                                        "0"
                                ? false
                                : true,
                            nimaCashAppliedAmount: double.parse(controller
                                .cartModel1.value.data!.nimaCashApplied
                                .toString()),
                            controller.cartData,
                            controller.cartModel1.value.data!.offerType,
                            controller.cartModel1.value.data!.discountPrice,
                          ),
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
                    child: ElevatedButton(
                      onPressed: controller.isAccepted
                          ? () async {
                              double totalDiscount =
                                  controller.cartModel1.value.data == null
                                      ? 0.0
                                      : controller
                                          .cartModel1.value.data!.discountPrice;
                              LocalStorage localStorage = LocalStorage();
                              var orderid = await localStorage.getOId();
                              controller.createOrder(
                                  controller.cartModel1.value.reward == null
                                      ? 0
                                      : controller.cartModel1.value.reward!.id,
                                  controller.cartModel1.value.promoCode == null
                                      ? ""
                                      : controller
                                          .cartModel1.value.promoCode!.id,
                                  orderid,
                                  totalDiscount,
                                  controller
                                      .cartModel1.value.data!.nimaCashApplied
                                      .toString());
                              // Get.to(CheckPage(orderId: '',));
                            }
                          : () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: controller.isAccepted
                              ? AppColor.dynamicColor
                              : AppColor().mediumGreyColor,
                          disabledBackgroundColor: AppColor.disableButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          elevation: 0,
                          shadowColor: AppColor.dynamicColor,
                          padding: EdgeInsets.all(13.h)),
                      child: controller.isUpdate
                          ? Center(
                              child: SizedBox(
                                height: 30.h,
                                child: CircularProgressIndicator(
                                  color: AppColor().whiteColor,
                                ),
                              ),
                            )
                          : Text(
                              style: AppTypography.hostGroteskSemiBold.copyWith(
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                              "Checkout now".toUpperCase(),
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

      final discountName = controller.cartModel1.value.data!.offerName;
      print("discountName${discountName}");
      if (discountName != "") {
        return _buildAppliedCard(
          context,
          '$discountName',
          id,
          rewardId,
          memId,
        );
      } else if (controller.response.membership!.membershipTitle.toString() ==
              "null" &&
          controller.response.offers!.isEmpty &&
          controller.response.rewards!.isEmpty) {
        return SizedBox.shrink();
      } else {
        return _buildAvailableCard(context, memId);
      }
    });
  }

  Widget _buildAvailableCard(BuildContext context, String memId) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ListTile(
        contentPadding: EdgeInsets.all(6.0.h),
        leading: Stack(
          alignment: Alignment.topRight,
          children: [
            Icon(Icons.local_offer_outlined, size: 30.h),
            Positioned(
              right: 0,
              child:
                  CircleAvatar(radius: 5, backgroundColor: AppColor().redColor),
            ),
          ],
        ),
        title: Text(
          AppStrings.availablePromotions,
          style: AppTypography.galanoGrostesqueSemiBold.copyWith(
            fontSize: 14.sp,
          ),
        ),
        subtitle: Text(
          AppStrings.viewAllPromo,
          style: AppTypography.hostGroteskRegular.copyWith(fontSize: 13.sp),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: AppColor().blackColor),
        onTap: () => showPromoBottomSheet(null, null, memId),
      ),
    );
  }

  Widget _buildAppliedCard(
    BuildContext context,
    String title,
    String id,
    String rewardId,
    String memId,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColor().whiteColor,
          borderRadius: BorderRadius.circular(7.r),
          /*  border: Border.all(
            color: AppColor().greyColor.withOpacity(0.4),
            width: 1.h,
          ),*/
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(6.0.h),
          leading: Icon(Icons.check, color: Colors.green, size: 30),
          title: Text(
            "$title Applied!",
            style: AppTypography.hostGroteskSemiBold.copyWith(
              fontSize: 14.sp,
            ),
          ),
          subtitle: Text(
            AppStrings.viewAllPromo,
            style: AppTypography.hostGroteskRegular.copyWith(fontSize: 13.sp),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.green),
          onTap: () => showPromoBottomSheet(id, rewardId, memId),
        ),
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
