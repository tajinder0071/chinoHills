import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/color.dart';
import '../../../CSS/appTypography.dart';
import '../Controller/cart_controller.dart';

class PromocodeWidget extends StatelessWidget {
  PromocodeWidget({
    super.key,
    required this.selectedId,
    required this.reward_id,
    required this.memId,
  });

  var selectedId, reward_id, memId;

  @override
  Widget build(BuildContext context) {
    print("Selected ID: $memId");
    return GetBuilder<CartController>(
      init: Get.find<CartController>()..couponAvailableRewards(),
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: 600.h,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
            child: ListView(
              children: [
                header(),
                SizedBox(height: 10.h),
                Divider(color: Colors.grey, thickness: 1),
                SizedBox(height: 10.h),

                if (controller.isRewardLoading)
                  SizedBox(
                    height: 400.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.w,
                        color: AppColor.dynamicColor,
                      ),
                    ),
                  )
                else ...[
                  Text(
                    'Select a promotion or enter a promo code',
                    style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // ✅ Membership box if available
                  controller.response.membership != null &&
                      controller.response.membership!.membershipId != null
                      ? membershipBox(controller)
                      : SizedBox.shrink(),

                  SizedBox(height: 10),

                  rewardMethod(controller, reward_id),

                  promoCodeList(controller, selectedId),

                  // ✅ Promo Code Textbox
                  TextFormField(
                    controller: controller.promoTextController,
                    onChanged: (value) {
                      if (controller.promoErrorText.isNotEmpty) {
                        controller.promoErrorText = '';
                        controller.update();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      hintText: "Enter Promo Code",
                      prefixIcon: Icon(Icons.local_offer_outlined),
                      suffixIcon: ValueListenableBuilder(
                        valueListenable: controller.promoTextController,
                        builder: (context, TextEditingValue value, child) {
                          final hasError = controller.promoErrorText.isNotEmpty;
                          final isTextFilled = value.text.isNotEmpty;

                          if (!isTextFilled) return SizedBox.shrink();

                          if (controller.isApplyLoading) {
                            return SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            );
                          }

                          return hasError
                              ? Icon(Icons.error, color: Colors.red)
                              : TextButton(
                            onPressed: () {
                              controller.applyPromoCode(value.text);
                            },
                            child: Text("Apply",
                                style: AppTypography.hostGroteskSemiBold),
                          );
                        },
                      ),
                      errorText: controller.promoErrorText.isNotEmpty
                          ? controller.promoErrorText
                          : null,
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ]
              ],
            )
        );
      },
    );
  }

  /// ✅ MEMBERSHIP CARD
  Widget membershipBox(CartController controller) {
    bool isApplied = controller.response.membership!.isApplied == true;

    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: isApplied ? AppColor.dynamicColor.withValues(alpha: .1) : Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isApplied
              ? AppColor.dynamicColor.withValues(alpha: .9)
              : Colors.grey.withValues(alpha: 0.5),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: isApplied ? AppColor.dynamicColor : AppColor().greyColor,
            size: 30,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.response.membership!.membershipTitle.toString(),
                  style: AppTypography.hostGroteskSemiBold.copyWith(
                    color: isApplied ? Colors.black : AppColor().greyColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '-${controller.response.membership!.membershipDiscount}',
                  style: AppTypography.hostGroteskRegular.copyWith(
                    color: isApplied ? Colors.black : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              if (!isApplied) {
                controller.memberTitle =
                    controller.response.membership!.membershipTitle;
                controller.applyMembership(
                    controller.response.membership!.membershipId,
                    controller.cartModel1.value.data!.cartId);
              }
            },
            child: Text(
              isApplied ? '' : 'Apply',
              style: AppTypography.hostGroteskSemiBold.copyWith(
                color: AppColor.dynamicColor,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ REWARDS LIST — SAFE
  Column rewardMethod(CartController controller, reward_id) {
    if (controller.availableData.isEmpty) {
      return Column(
        children: [
          Text(
            "No rewards available",
            style: AppTypography.hostGroteskRegular.copyWith(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
        ],
      );
    }

    return Column(
      children: List.generate(controller.availableData.length, (index) {
        if (index >= controller.availableData.length) return SizedBox.shrink(); // ✅ avoid crash

        bool isSelected = controller.availableData[index].isApplied ?? false;

        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.dynamicColor.withValues(alpha: .1)
                : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected
                  ? AppColor.dynamicColor
                  : Colors.grey.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.card_giftcard,
                color: isSelected ? AppColor.dynamicColor : Colors.grey,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.availableData[index].rewardTitle ?? '',
                      style: AppTypography.hostGroteskSemiBold.copyWith(
                        fontSize: 13.sp,
                        color: isSelected ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      controller.availableData[index].discountType ==
                              "btn-percent"
                          ? '${controller.availableData[index].discountAmount}%'
                          : '\$${controller.availableData[index].discountAmount}',
                      style: AppTypography.hostGroteskRegular.copyWith(
                        color: isSelected ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  if (index >= controller.availableData.length) return; // ✅ safe guard

                  bool isSelected = controller.availableData[index].isApplied ?? false;

                  if (isSelected) {
                    controller.removeSelection(controller.availableData[index].rewardId);
                  } else {
                    controller.rewardId = controller.availableData[index].rewardId.toString();
                    controller.rewardName = controller.availableData[index].rewardTitle.toString();

                    controller.applyAvailableCode(
                      controller.availableData[index].rewardId,
                      index,
                      controller.cartModel1.value.data!.cartId,
                    );
                  }
                },
                child: Text(
                  isSelected ? 'Remove' : 'Apply',
                  style: AppTypography.hostGroteskSemiBold.copyWith(
                    color: AppColor.dynamicColor,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// ✅ COUPON LIST — SAFE
  Column promoCodeList(CartController controller, selectedId) {
    if (controller.couponAvailableData.isEmpty) {
      return Column(
        children: [
          Text(
            "No promo codes available",
            style: AppTypography.hostGroteskRegular.copyWith(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
        ],
      );
    }

    return Column(
      children: List.generate(controller.couponAvailableData.length, (index) {
        bool isApplied =
            controller.couponAvailableData[index].isApplied ?? false;

        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isApplied
                ? AppColor.dynamicColor.withValues(alpha: .1)
                : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isApplied
                  ? AppColor.dynamicColor
                  : Colors.grey.withValues(alpha: 0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.card_giftcard,
                  color: isApplied ? AppColor.dynamicColor : Colors.grey),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.couponAvailableData[index].title ?? '',
                      style: AppTypography.hostGroteskSemiBold.copyWith(
                        color: isApplied ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                    Text(
                      controller.couponAvailableData[index].discountType ==
                              "Percentage"
                          ? '${controller.couponAvailableData[index].discountValue}%'
                          : '\$${controller.couponAvailableData[index].discountValue}',
                      style: AppTypography.hostGroteskRegular.copyWith(
                        color: isApplied ? Colors.black : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${controller.couponAvailableData[index].daysLeft} days left',
                      style: AppTypography.hostGroteskRegular.copyWith(
                        color: AppColor().redColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (isApplied) {
                    controller.removeSelectedPromo(
                        controller.couponAvailableData[index].id);
                  } else {
                    controller.promoname =
                        controller.couponAvailableData[index].title;
                    controller.promoId =
                        controller.couponAvailableData[index].id.toString();

                    controller.selectPromoCode(
                      controller.couponAvailableData[index].promoCode,
                      index,
                      controller.couponAvailableData[index].id,
                      selectedId,
                      controller.cartModel1.value.data!.cartId,
                    );
                    Get.back();
                  }
                },
                child: Text(
                  isApplied ? 'Remove' : 'Apply',
                  style: AppTypography.hostGroteskSemiBold.copyWith(
                    color: AppColor.dynamicColor,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Add Promotion Code',
          style: AppTypography.hostGroteskSemiBold.copyWith(fontSize: 14.sp),
        ),
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }
}
