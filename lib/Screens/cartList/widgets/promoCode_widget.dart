import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../CSS/color.dart';
import '../Controller/cart_controller.dart';

class PromocodeWidget extends StatelessWidget {
  PromocodeWidget(
      {super.key, required this.selectedId, required this.reward_id});

  var selectedId, reward_id;

  @override
  Widget build(BuildContext context) {
    print("Selected ID: $reward_id");
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
                  topLeft: Radius.circular(20.r)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListView(
              children: [
                //call header method
                header(),
                SizedBox(
                  height: 10.h,
                ),
                //divider
                Divider(color: Colors.grey, thickness: 1),
                SizedBox(height: 10.h),
                //add promotion code text Select a promotion or enter a promo code
                const Text('Select a promotion or enter a promo code',
                    style: TextStyle(fontSize: 14, color: Colors.black)),
                SizedBox(
                  height: 10.h,
                ),
                //create reward list
                rewardMethod(controller, reward_id),
                //create promocode list
                promoCodeList(controller, selectedId),
                TextFormField(
                  controller: controller.promoTextController,
                  onChanged: (value) {
                    controller.promoErrorText = '';
                    controller.update();
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    hintText: "Enter Promo Code",
                    prefixIcon: Icon(Icons.local_offer_outlined),
                    suffixIcon:
                        GetBuilder<CartController>(builder: (controller) {
                      final hasError = controller.promoErrorText.isNotEmpty;
                      final isTextFilled =
                          controller.promoTextController.text.isNotEmpty;

                      if (!isTextFilled) return SizedBox.shrink();

                      if (controller.isApplyLoading) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }

                      return hasError
                          ? Icon(Icons.error, color: Colors.red)
                          : TextButton(
                              onPressed: () {
                                controller.applyPromoCode(
                                    controller.promoTextController.text);
                              },
                              child: Text("Apply"),
                            );
                    }),
                    errorText: controller.promoErrorText.isNotEmpty
                        ? controller.promoErrorText
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ));
      },
    );
  }

  Column rewardMethod(CartController controller, reward_id) {
    return Column(
      children: List.generate(
        controller.availableData.length,
        (index) {
          bool isSelected =
              controller.availableData[index].rewardId?.toString() ==
                  reward_id.toString();
          print(isSelected);
          print(controller.availableData[index].rewardId?.toString());
          print(reward_id.toString());
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected
                    ? AppColor().blackColor
                    : Colors.grey.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.card_giftcard,
                    color: isSelected
                        ? AppColor().blackColor
                        : AppColor().greyColor),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.availableData[index].rewardTitle!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: isSelected
                            ? AppColor().blackColor
                            : AppColor().greyColor,
                      ),
                    ),
                    controller.availableData[index].discountType ==
                            "btn-percent"
                        ? Text(
                            '${controller.availableData[index].discountAmount!}%',
                            style: TextStyle(
                              color: isSelected
                                  ? AppColor().blackColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(
                            '\$${controller.availableData[index].discountAmount!}',
                            style: TextStyle(
                              color: isSelected
                                  ? AppColor().blackColor
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ],
                )),
                //remove and Apply text button
                TextButton(
                  onPressed: () {
                    if (isSelected) {
                      controller.removeSelection(
                          controller.availableData[index].rewardId);
                    } else {
                      //get cartid index
                      controller.selectPromo(
                        controller.availableData[index].rewardId,
                        index,
                        false,
                        "",
                      );
                    }
                    controller.update();
                  },
                  child: Text(
                    isSelected ? 'Remove' : 'Apply',
                    style: TextStyle(
                      color: isSelected ? Colors.red : Colors.green,
                      fontSize: 14.sp,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  //header method
  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Add Promotion Code',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Column promoCodeList(CartController controller, selectedId) {
    return Column(
      children: List.generate(controller.couponAvailableData.length, (index) {
        //check if selectedId is equal to offerId or promo_code_id

        bool isSelected =
            controller.couponAvailableData[index].promo_code_id?.toString() ==
                selectedId.toString();
        print("isSelected $isSelected");
        print(controller.couponAvailableData[index].promo_code_id?.toString());
        print(selectedId.toString());
        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected
                  ? AppColor().blackColor
                  : Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.card_giftcard,
                  color: isSelected ? AppColor().blackColor : Colors.grey),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.couponAvailableData[index].title!,
                    style: TextStyle(
                      color: isSelected ? AppColor().blackColor : Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.sp,
                    ),
                  ),
                  controller.couponAvailableData[index].discountType ==
                          "Percentage"
                      ? Text(
                          '${(controller.couponAvailableData[index].discountValue ?? 0)}%',
                          style: TextStyle(
                            color: isSelected
                                ? AppColor().blackColor
                                : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      : Text(
                          '\$${(controller.couponAvailableData[index].discountValue ?? 0)}',
                          style: TextStyle(
                            color: isSelected
                                ? AppColor().blackColor
                                : Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                  Text(
                    '${controller.couponAvailableData[index].dayLeft} days left',
                    style: TextStyle(
                      color: AppColor().redColor,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              )),
              //todo remove and Apply text button
              TextButton(
                onPressed: () {
                  controller.promoErrorText = '';
                  if (isSelected) {
                    controller.removeSelectedPromo(
                        controller.couponAvailableData[index].offerId);
                  } else {
                    reward_id = "";
                    controller.selectPromoCode(
                        controller.couponAvailableData[index].offerCode,
                        index,
                        controller.couponAvailableData[index].offerId,
                        selectedId);
                  }
                  controller.update();
                },
                child: Text(
                  isSelected ? 'Remove' : 'Apply',
                  style: TextStyle(
                    color: isSelected ? Colors.red : Colors.green,
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
