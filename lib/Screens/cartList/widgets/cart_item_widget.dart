// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nima/CSS/color.dart';
// import 'package:nima/Screens/cartList/widgets/circular_network_image.dart';
// import 'package:nima/common_Widgets/cacheNetworkImage.dart';
//
// class CartItemWidget extends StatelessWidget {
//   final int productCount;
//   final String productTitle, productDescription;
//   final String productImage;
//   final bool isDelete;
//   final VoidCallback onDelete, onRemoveItem, onAddItem;
//   final Widget addItemWidget, removeItemWidget, deleteItemWidget;
//   var itemPrice;
//
//   CartItemWidget(
//       {super.key,
//       required this.productCount,
//       required this.isDelete,
//       required this.productTitle,
//       required this.productDescription,
//       required this.productImage,
//       required this.onDelete,
//       required this.onRemoveItem,
//       required this.onAddItem,
//       required this.addItemWidget,
//       required this.itemPrice,
//       required this.removeItemWidget,
//       required this.deleteItemWidget});
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none, // Allow the image to overflow
//       children: [
//         // Card Container
//         Container(
//           margin: EdgeInsets.only(left: 50.h, bottom: 40.h, right: 5.h),
//           width: MediaQuery.of(context).size.width * 0.8,
//           padding:
//               EdgeInsets.only(left: 60.h, top: 5.h, bottom: 5.h, right: 5.h),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16.0),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blue.withOpacity(0.2),
//                 blurRadius: 2.0.h,
//                 offset: const Offset(-0, -1),
//               ),
//               BoxShadow(
//                 color: Colors.blue.withOpacity(0.2),
//                 blurRadius: 2.0,
//                 offset: Offset(-0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       productTitle.toString(),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 16.0.h,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     // const SizedBox(height: 4.0),
//                     Text(
//                       productDescription,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 14.0.h,
//                         color: Colors.grey,
//                       ),
//                     ),
//
//                     SizedBox(height: 8.0.h),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Row(
//                             children: [
//                               IconButton(
//                                 icon: removeItemWidget,
//                                 onPressed: onRemoveItem,
//                               ),
//                               Text(
//                                 "$productCount",
//                                 style: TextStyle(
//                                   fontSize: 16.0.h,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               IconButton(
//                                   icon: addItemWidget, onPressed: onAddItem),
//                             ],
//                           ),
//                         ),
//                         isDelete
//                             ? CircleAvatar(
//                                 backgroundColor: Colors.blue,
//                                 radius: 20.r,
//                                 child: SizedBox(
//                                     height: 15,
//                                     width: 15,
//                                     child: CircularProgressIndicator(
//                                       color: AppColor().whiteColor,
//                                     )),
//                               )
//                             : productCount == 1
//                                 ? const SizedBox.shrink()
//                                 : IconButton(
//                                     onPressed: onDelete,
//                                     style: IconButton.styleFrom(
//                                         shape: const CircleBorder(),
//                                         backgroundColor: Colors.blue),
//                                     icon: deleteItemWidget,
//                                   )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // Profile Image (Positioned outside the card)
//
//         Positioned(
//           bottom: 10.h,
//           left: 20.h,
//           child: Container(
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.blue.withOpacity(0.2),
//                     blurRadius: 3,
//                     offset: const Offset(-0, 4)),
//               ],
//             ),
//             child: CircleAvatar(
//               radius: 50.h,
//               backgroundColor: AppColor().whiteColor,
//               child: CircleAvatar(
//                 radius: 45.h,
//                 backgroundColor: Colors.blue.withOpacity(0.2),
//                 child: CircularNetworkImage(
//                     imageUrl: productImage.toString(), fit: BoxFit.cover),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//           top: 0.h,
//           right: 14.w,
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topRight: Radius.circular(10.r),
//                 bottomLeft: Radius.circular(3.r),
//               ),
//               color: AppColor().blueColor,
//             ),
//             child: Text(
//               "\$$itemPrice",
//               style:
//                   TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CSS/color.dart';
import '../../../util/common_page.dart';

enum RewardType { treatment, membership, package }

class RewardItemCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String subtitle;
  final dynamic price;
  final dynamic discountPrice;
  final RewardType type;
  final VoidCallback? onEdit;
  final VoidCallback onRemove;

  RewardItemCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.discountPrice,
    required this.type,
    required this.onRemove,
    this.subtitle = '',
    this.onEdit,
  });

  Color get bgColor => type == RewardType.membership
      ? AppColor.dynamicColorWithOpacity
      : Colors.white;

  String get typeLabel {
    switch (type) {
      case RewardType.treatment:
        return 'TREATMENT';
      case RewardType.membership:
        return 'MEMBERSHIP';
      case RewardType.package:
        return 'PACKAGE';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      padding: EdgeInsets.all(12.h),
      margin: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.network(
              imageUrl.toString(),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              errorBuilder: (context, url, error) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  height: 90.h,
                  width: 110.w,
                  decoration: BoxDecoration(
                      color: typeLabel == "MEMBERSHIP"
                          ? AppColor.geryBackGroundColor
                          : AppColor.geryBackGroundColor,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: Center(
                      child: Image.asset(
                    "assets/images/Image_not_available.png",
                    color: AppColor().blackColor,
                    fit: BoxFit.cover,
                  )),
                );
              },
              loadingBuilder: (BuildContext ctx, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child; // ✅ Return the fully loaded image
                }
                return SizedBox(
                  height: 90.h,
                  width: 110.w,
                  child: Center(
                    child: Platform.isAndroid
                        ? Center(child: commonLoader(color: AppColor.dynamicColor))
                        : CupertinoActivityIndicator(
                            color: AppColor.dynamicColor),
                  ),
                );
              },
              height: 90.h,
              width: 110.w,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.merriweather(
                              fontWeight: FontWeight.bold, fontSize: 13.sp)),
                    ),
                    SizedBox(width: 5.0.w),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: typeLabel == "MEMBERSHIP"
                            ? [
                                Text(
                                  price.toString(),
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  ),
                                )
                              ]
                            : [
                                if (price == discountPrice)
                                  Text(
                                    price.toString(),
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  )
                                else ...[
                                  Text(
                                    price.toString(),
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.sp,
                                    ),
                                  ),
                                  Text(
                                    discountPrice.toString(),
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10.sp,
                                      color: AppColor().greyColor,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ],
                              ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColor.dynamicColor.withAlpha(20),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    typeLabel,
                    style: GoogleFonts.roboto(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.dynamicColor,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        subtitle,
                        style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: isTablet(context) ? 17.h : 14.h),
                      ),
                    ),
                    if (onEdit != null)
                      typeLabel != "TREATMENT"
                          ? SizedBox.shrink()
                          : TextButton(
                              onPressed: onEdit,
                              child: Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Text(
                                  "EDIT",
                                  style: TextStyle(
                                    fontSize: isTablet(context) ? 17.h : 14.h,
                                    color: AppColor.dynamicColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    TextButton(
                      onPressed: onRemove,
                      child: Text(
                        "REMOVE",
                        style: GoogleFonts.roboto(
                            fontSize: isTablet(context) ? 17.h : 14.h,
                            color: AppColor.dynamicColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
