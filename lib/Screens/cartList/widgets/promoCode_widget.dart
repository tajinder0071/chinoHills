// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:nima/CSS/color.dart';
// import '../Controller/cart_controller.dart';
//
// class PromocodeWidget extends StatelessWidget {
//   PromocodeWidget({
//     super.key,
//     required this.selectedId,
//     required this.reward_id,
//     required this.memId,
//   });
//
//   var selectedId, reward_id, memId;
//
//   @override
//   Widget build(BuildContext context) {
//     print("Selected ID: $memId");
//     return GetBuilder<CartController>(
//       init: Get.find<CartController>()..couponAvailableRewards(),
//       builder: (controller) {
//         return Container(
//             width: double.infinity,
//             height: 600.h,
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(20.r),
//                   topLeft: Radius.circular(20.r)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 7,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ListView(
//               children: [
//                 //call header method
//                 header(),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 //divider
//                 Divider(color: Colors.grey, thickness: 1),
//                 SizedBox(height: 10.h),
//                 //add promotion code text Select a promotion or enter a promo code
//                 const Text('Select a promotion or enter a promo code',
//                     style: TextStyle(fontSize: 14, color: Colors.black)),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 controller.response.membership == null ||
//                         controller.response.membership!.membershipId
//                                 .toString() ==
//                             "null"
//                     ? SizedBox.shrink()
//                     : Container(
//                         padding: const EdgeInsets.all(10),
//                         margin: const EdgeInsets.only(bottom: 10),
//                         decoration: BoxDecoration(
//                           color: controller.response.membership!.membershipId
//                                           .toString() ==
//                                       memId.toString() &&
//                                   controller.response.membership!.isApplied ==
//                                       true
//                               ? AppColor.dynamicColor.withOpacity(.1)
//                               : Colors.white,
//                           borderRadius: BorderRadius.circular(10.r),
//                           border: Border.all(
//                             color: controller.response.membership!.membershipId
//                                             .toString() ==
//                                         memId.toString() &&
//                                     controller.response.membership!.isApplied ==
//                                         true
//                                 ? AppColor.dynamicColor.withOpacity(.9)
//                                 : Colors.grey.withOpacity(0.5),
//                             width: 2,
//                           ),
//                         ),
//                         child: Row(
//                           children: [
//                             Icon(
//                               Icons.check_circle_outline,
//                               color: controller
//                                               .response.membership!.membershipId
//                                               .toString() ==
//                                           memId.toString() &&
//                                       controller
//                                               .response.membership!.isApplied ==
//                                           true
//                                   ? AppColor.dynamicColor
//                                   : AppColor().greyColor,
//                               size: 30,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                                 child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   controller
//                                       .response.membership!.membershipTitle
//                                       .toString(),
//                                   style: TextStyle(
//                                     color: controller.response.membership!
//                                                     .membershipId
//                                                     .toString() ==
//                                                 memId.toString() &&
//                                             controller.response.membership!
//                                                     .isApplied ==
//                                                 true
//                                         ? AppColor().blackColor
//                                         : AppColor().greyColor,
//                                     fontWeight: controller.response.membership!
//                                                     .membershipId
//                                                     .toString() ==
//                                                 memId.toString() &&
//                                             controller.response.membership!
//                                                     .isApplied ==
//                                                 true
//                                         ? FontWeight.bold
//                                         : FontWeight.w600,
//                                     fontSize: 13.sp,
//                                   ),
//                                 ),
//                                 Text(
//                                   '-${(controller.response.membership!.membershipDiscount)}',
//                                   style: TextStyle(
//                                     color: controller.response.membership!
//                                                     .membershipId
//                                                     .toString() ==
//                                                 memId.toString() &&
//                                             controller.response.membership!
//                                                     .isApplied ==
//                                                 true
//                                         ? AppColor().blackColor
//                                         : AppColor().greyColor,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             )),
//                             TextButton(
//                               onPressed: () {
//                                 controller.promoErrorText = '';
//                                 if (controller.response.membership!.isApplied
//                                         .toString() ==
//                                     "false") {
//                                   controller.memberTitle = controller
//                                       .response.membership!.membershipTitle;
//                                   controller.applyMembership(
//                                       controller
//                                           .response.membership!.membershipId,
//                                       controller.cartModel1.value.data!.cartId);
//                                 }
//                                 controller.update();
//                               },
//                               child: Text(
//                                 controller.response.membership!.isApplied
//                                             .toString() ==
//                                         "true"
//                                     ? ''
//                                     : 'Apply',
//                                 style: TextStyle(
//                                   color: AppColor.dynamicColor,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 //create reward list
//                 rewardMethod(controller, reward_id),
//                 //create promocode list
//                 promoCodeList(controller, selectedId),
//
//                 TextFormField(
//                   controller: controller.promoTextController,
//                   onChanged: (value) {
//                     controller.promoErrorText = '';
//                     controller.update();
//                   },
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(20.0),
//                     hintText: "Enter Promo Code",
//                     prefixIcon: Icon(Icons.local_offer_outlined),
//                     suffixIcon:
//                         GetBuilder<CartController>(builder: (controller) {
//                       final hasError = controller.promoErrorText.isNotEmpty;
//                       final isTextFilled =
//                           controller.promoTextController.text.isNotEmpty;
//
//                       if (!isTextFilled) return SizedBox.shrink();
//
//                       if (controller.isApplyLoading) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: SizedBox(
//                             width: 20,
//                             height: 20,
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           ),
//                         );
//                       }
//
//                       return hasError
//                           ? Icon(Icons.error, color: Colors.red)
//                           : TextButton(
//                               onPressed: () {
//                                 controller.applyPromoCode(
//                                     controller.promoTextController.text);
//                               },
//                               child: Text("Apply"),
//                             );
//                     }),
//                     errorText: controller.promoErrorText.isNotEmpty
//                         ? controller.promoErrorText
//                         : null,
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                   ),
//                 ),
//               ],
//             ));
//       },
//     );
//   }
//
//   Column rewardMethod(CartController controller, reward_id) {
//     return Column(
//       children: List.generate(
//         controller.availableData.length,
//         (index) {
//           bool isSelected = controller.availableData[index].isApplied!;
//           return Container(
//             padding: const EdgeInsets.all(10),
//             margin: const EdgeInsets.only(bottom: 10),
//             decoration: BoxDecoration(
//               color: isSelected
//                   ? AppColor.dynamicColor.withOpacity(.1)
//                   : Colors.white,
//               borderRadius: BorderRadius.circular(10.r),
//               border: Border.all(
//                 color: isSelected
//                     ? AppColor.dynamicColor
//                     : Colors.grey.withOpacity(0.5),
//                 width: 1,
//               ),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.card_giftcard,
//                     color: isSelected
//                         ? AppColor.dynamicColor
//                         : AppColor().greyColor),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.availableData[index].rewardTitle!,
//                       style: TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13.sp,
//                         color: isSelected
//                             ? AppColor().blackColor
//                             : AppColor().greyColor,
//                       ),
//                     ),
//                     controller.availableData[index].discountType ==
//                             "btn-percent"
//                         ? Text(
//                             '${controller.availableData[index].discountAmount!}%',
//                             style: TextStyle(
//                               color: isSelected
//                                   ? AppColor().blackColor
//                                   : Colors.grey,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           )
//                         : Text(
//                             '\$${controller.availableData[index].discountAmount!}',
//                             style: TextStyle(
//                               color: isSelected
//                                   ? AppColor().blackColor
//                                   : Colors.grey,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                   ],
//                 )),
//                 //remove and Apply text button
//                 TextButton(
//                   onPressed: () {
//                     if (isSelected) {
//                       controller.removeSelection(
//                           controller.availableData[index].rewardId);
//                     } else {
//                       //get cartid index
//                       controller.rewardId =
//                           controller.availableData[index].rewardId.toString();
//                       controller.rewardName = controller
//                           .availableData[index].rewardTitle
//                           .toString();
//                       controller.applyAvailableCode(
//                           controller.availableData[index].rewardId,
//                           index,
//                           controller.cartModel1.value.data!.cartId);
//                     }
//                     controller.update();
//                   },
//                   child: Text(
//                     isSelected ? 'Remove' : 'Apply',
//                     style: TextStyle(
//                       color: AppColor.dynamicColor,
//                       fontSize: 14.sp,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   //header method
//   Widget header() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text(
//           'Add Promotion Code',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ],
//     );
//   }
//
//   Column promoCodeList(CartController controller, selectedId) {
//     return Column(
//       children: List.generate(controller.couponAvailableData.length, (index) {
//         // ✅ Use isApplied directly
//         bool isApplied =
//             controller.couponAvailableData[index].isApplied ?? false;
//
//         return Container(
//           padding: const EdgeInsets.all(10),
//           margin: const EdgeInsets.only(bottom: 10),
//           decoration: BoxDecoration(
//             color: isApplied
//                 ? AppColor.dynamicColor.withOpacity(.1)
//                 : Colors.white,
//             borderRadius: BorderRadius.circular(10.r),
//             border: Border.all(
//               color: isApplied
//                   ? AppColor.dynamicColor
//                   : Colors.grey.withOpacity(0.5),
//               width: 1,
//             ),
//           ),
//           child: Row(
//             children: [
//               Icon(Icons.card_giftcard,
//                   color: isApplied ? AppColor.dynamicColor : Colors.grey),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.couponAvailableData[index].title ?? '',
//                       style: TextStyle(
//                         color: isApplied ? AppColor().blackColor : Colors.grey,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 13.sp,
//                       ),
//                     ),
//                     controller.couponAvailableData[index].discountType ==
//                             "Percentage"
//                         ? Text(
//                             '${(controller.couponAvailableData[index].discountValue ?? 0)}%',
//                             style: TextStyle(
//                               color: isApplied
//                                   ? AppColor().blackColor
//                                   : Colors.grey,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           )
//                         : Text(
//                             '\$${(controller.couponAvailableData[index].discountValue ?? 0)}',
//                             style: TextStyle(
//                               color: isApplied
//                                   ? AppColor().blackColor
//                                   : Colors.grey,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                     Text(
//                       '${controller.couponAvailableData[index].daysLeft} days left',
//                       style: TextStyle(
//                         color: AppColor().redColor,
//                         fontSize: 12.sp,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//
//                   if (isApplied) {
//                     controller.removeSelectedPromo(
//                         controller.couponAvailableData[index].id);
//                   } else {
//                     reward_id = "";
//                     controller.promoname =
//                         controller.couponAvailableData[index].title;
//                     controller.promoId =
//                         controller.couponAvailableData[index].id.toString();
//                     controller.update();
//                     controller.selectPromoCode(
//                       controller.couponAvailableData[index].promoCode,
//                       index,
//                       controller.couponAvailableData[index].id,
//                       selectedId,
//                       controller.cartModel1.value.data!.cartId,
//                     );
//                   }
//                   controller.update();
//                 },
//                 child: Text(
//                   isApplied ? 'Remove' : 'Apply',
//                   style: TextStyle(
//                     color: AppColor.dynamicColor,
//                     fontSize: 14.sp,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         );
//       }),
//     );
//   }
// } //can we store the applied name in a variable
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../CSS/color.dart';
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
                controller.response.membership == null ||
                    controller.response.membership!.membershipId
                        .toString() ==
                        "null"
                    ? SizedBox.shrink()
                    : Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: controller.response.membership!.membershipId
                        .toString() ==
                        memId.toString() &&
                        controller.response.membership!.isApplied ==
                            true
                        ? AppColor.dynamicColor.withOpacity(.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: controller.response.membership!.membershipId
                          .toString() ==
                          memId.toString() &&
                          controller.response.membership!.isApplied ==
                              true
                          ? AppColor.dynamicColor.withOpacity(.9)
                          : Colors.grey.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: controller
                            .response.membership!.membershipId
                            .toString() ==
                            memId.toString() &&
                            controller
                                .response.membership!.isApplied ==
                                true
                            ? AppColor.dynamicColor
                            : AppColor().greyColor,
                        size: 30,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller
                                    .response.membership!.membershipTitle
                                    .toString(),
                                style: TextStyle(
                                  color: controller.response.membership!
                                      .membershipId
                                      .toString() ==
                                      memId.toString() &&
                                      controller.response.membership!
                                          .isApplied ==
                                          true
                                      ? AppColor().blackColor
                                      : AppColor().greyColor,
                                  fontWeight: controller.response.membership!
                                      .membershipId
                                      .toString() ==
                                      memId.toString() &&
                                      controller.response.membership!
                                          .isApplied ==
                                          true
                                      ? FontWeight.bold
                                      : FontWeight.w600,
                                  fontSize: 13.sp,
                                ),
                              ),
                              Text(
                                '-${(controller.response.membership!.membershipDiscount)}',
                                style: TextStyle(
                                  color: controller.response.membership!
                                      .membershipId
                                      .toString() ==
                                      memId.toString() &&
                                      controller.response.membership!
                                          .isApplied ==
                                          true
                                      ? AppColor().blackColor
                                      : AppColor().greyColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )),
                      TextButton(
                        onPressed: () {
                          controller.promoErrorText = '';
                          if (controller.response.membership!.isApplied
                              .toString() ==
                              "false") {
                            controller.memberTitle = controller
                                .response.membership!.membershipTitle;
                            controller.applyMembership(
                                controller
                                    .response.membership!.membershipId,
                                controller.cartModel1.value.data!.cartId);
                          }
                          // Remove this update() call
                          // controller.update();
                        },
                        child: Text(
                          controller.response.membership!.isApplied
                              .toString() ==
                              "true"
                              ? ''
                              : 'Apply',
                          style: TextStyle(
                            color: AppColor.dynamicColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                //create reward list
                rewardMethod(controller, reward_id),
                //create promocode list
                promoCodeList(controller, selectedId),

                // ✅ Fixed TextFormField with better state management
                TextFormField(
                  // onTap: () async {
                  //   await controller.unselectPromoOrReward();
                  //   await controller.cartList();
                  // },
                  controller: controller.promoTextController,
                  onChanged: (value) {
                    // Only clear error text, don't trigger full rebuild
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
                            controller.applyPromoCode(value.text);
                          },
                          child: Text("Apply"),
                        );
                      },
                    ),
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
          bool isSelected = controller.availableData[index].isApplied!;
          return Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.dynamicColor.withOpacity(.1)
                  : Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: isSelected
                    ? AppColor.dynamicColor
                    : Colors.grey.withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.card_giftcard,
                    color: isSelected
                        ? AppColor.dynamicColor
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
                      controller.rewardId =
                          controller.availableData[index].rewardId.toString();
                      controller.rewardName = controller
                          .availableData[index].rewardTitle
                          .toString();
                      controller.applyAvailableCode(
                          controller.availableData[index].rewardId,
                          index,
                          controller.cartModel1.value.data!.cartId);
                    }
                    // Remove this update() call as it's redundant
                    // controller.update();
                  },
                  child: Text(
                    isSelected ? 'Remove' : 'Apply',
                    style: TextStyle(
                      color: AppColor.dynamicColor,
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
        // ✅ Use isApplied directly
        bool isApplied =
            controller.couponAvailableData[index].isApplied ?? false;

        return Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: isApplied
                ? AppColor.dynamicColor.withOpacity(.1)
                : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isApplied
                  ? AppColor.dynamicColor
                  : Colors.grey.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.card_giftcard,
                  color: isApplied ? AppColor.dynamicColor : Colors.grey),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.couponAvailableData[index].title ?? '',
                      style: TextStyle(
                        color: isApplied ? AppColor().blackColor : Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                    controller.couponAvailableData[index].discountType ==
                        "Percentage"
                        ? Text(
                      '${(controller.couponAvailableData[index].discountValue ?? 0)}%',
                      style: TextStyle(
                        color: isApplied
                            ? AppColor().blackColor
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                        : Text(
                      '\$${(controller.couponAvailableData[index].discountValue ?? 0)}',
                      style: TextStyle(
                        color: isApplied
                            ? AppColor().blackColor
                            : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${controller.couponAvailableData[index].daysLeft} days left',
                      style: TextStyle(
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
                    reward_id = "";
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
                  }
                  // Remove this update() call as it's redundant
                  // controller.update();
                },
                child: Text(
                  isApplied ? 'Remove' : 'Apply',
                  style: TextStyle(
                    color: AppColor.dynamicColor,
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
