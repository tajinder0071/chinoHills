import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/app_strings.dart';
import '../../../../CSS/color.dart';
import '../../../../Model/dynamic_tab_model.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../loading/cart_list_load.dart';
import '../../../../util/route_manager.dart';
import '../../controller/dynamic_tab_controller.dart';
import '../../widgets/package_card_widgets.dart';
import '../BrowseByConcern/controller/browse_controller.dart';
import '../Package Page/Widgets/package_detail_page.dart';
import '../Treatment Page/widgets/treatment_details_page.dart';
import 'package:upgrader/upgrader.dart';

class DynamicData extends StatefulWidget {
  final String dynamicId;


  const DynamicData({required this.dynamicId, Key? key}) : super(key: key);

  @override
  State<DynamicData> createState() => _DynamicDataState();
}

class _DynamicDataState extends State<DynamicData> {
  late DynamicTabController controller;


  @override
  void initState() {
    super.initState();
    // Initialize controller in initState to ensure proper lifecycle
    controller = Get.put(DynamicTabController(widget.dynamicId), tag: widget.dynamicId);
  }

  @override
  void dispose() {
    // Clean up controller when widget is disposed
    Get.delete<DynamicTabController>(tag: widget.dynamicId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: GetBuilder<DynamicTabController>(
        tag: widget.dynamicId,
        builder: (controller) => LiquidPullToRefresh(
          animSpeedFactor: 1.5,
          springAnimationDurationInMilliseconds: 400,
          color: AppColor.dynamicColor,
          showChildOpacityTransition: false,
          key: controller.refreshIndicatorKey,
          onRefresh: controller.handleRefresh,
          child: Scaffold(
            backgroundColor: Colors.grey.withOpacity(0.2),
            body: Obx(() {
              if (controller.isLoading.value) {
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
                      Expanded(
                        child: TreatementLoad(),
                      ),
                    ],
                  ),
                );
              }

              final dataList = controller.dynamicTabModel.value?.data ?? [];
              final header = controller.dynamicTabModel.value?.headerDetails;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    _buildHeaderSection(header),
                    dataList.isEmpty
                        ? Center(
                      child: NoRecord(
                        AppStrings.noDataFound,
                        const Icon(Icons.no_accounts),
                        AppStrings.weAreSorryNoDataAvailable,
                      ),
                    )
                        : ListView.builder(
                      padding: EdgeInsets.fromLTRB(13.w, 7.h, 13.w,0),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final item = dataList[index];

                        List<String> tags = [];
                        if (item.concerns is List) {
                          tags = List<String>.from(item.concerns!);
                        }
                        else if (item.concerns is String) {
                          tags = (item.concerns! as String)
                              .replaceAll(' ', '')
                              .split(',')
                              .where((e) => e.isNotEmpty)
                              .toList();
                        }

                        return PackageCard(
                          title: item.name ?? AppStrings.unnamed,
                          description: item.description ?? "",
                          imageUrl: item.image ?? "",
                          originalPrice: item.price?.toString() ?? "0.0",
                          memberPrice: item.type == 'Package'
                              ? item.membershipInfo == null
                              ? item.membershipOfferPrice
                              : item.membershipInfo!.membershipOfferPrice
                              : item.membershipOfferPrice ?? "0.0",
                          tags: tags,
                          sectionName: item.type ?? 'Treatments',
                          onPressed: () {
                            if (item.type == "Treatment") {
                              Get.to(
                                    () => TreatmentDetailsPage(),
                                arguments: item.id,
                                binding: CommonBinding(),
                                transition: Transition.fadeIn,
                                duration: Duration(milliseconds: 500),
                              );
                            } else if (item.type == "Package") {
                              Get.to(
                                    () => PackageDetailPage(
                                  sectionName: 'Package',
                                ),
                                arguments: item.id,
                                binding: CommonBinding(),
                                transition: Transition.fadeIn,
                                duration: Duration(milliseconds: 500),
                              );
                            } else {
                              Get.toNamed(
                                RouteManager.membersShipDetailsPage,
                                arguments: item.id,
                                parameters: {"onlyShow": "0"},
                              );
                            }
                          },
                          unitType: item.type.toString(),
                          DiscountType: "0",
                          discount: item.offeroffText.toString(),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  // You need to implement this method based on your header structure
  Widget _buildHeaderSection(HeaderDetails? headerDetails) {
    if (headerDetails == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        image: headerDetails.categoryHeaderCloudUrl != null &&
                headerDetails.categoryHeaderCloudUrl!.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(headerDetails.categoryHeaderCloudUrl!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              )
            : null,
        color: Colors.black26,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerDetails.categoryHeader ?? '',
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            headerDetails.categoryDescription ?? '',
            style: GoogleFonts.actor(
              color: Colors.white,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

//*****************Previous Code Without Liquid pull referesh********************

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import 'package:nima/CSS/app_strings.dart';
// import 'package:nima/CSS/color.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../Model/dynamic_tab_model.dart';
// import '../../../../binding/cart_billing.dart';
// import '../../../../common_Widgets/no_record.dart';
// import '../../../../loading/cart_list_load.dart';
// import '../../../../util/route_manager.dart';
// import '../../controller/dynamic_tab_controller.dart';
// import '../../widgets/package_card_widgets.dart';
// import '../Package Page/Widgets/package_detail_page.dart';
// import '../Treatment Page/widgets/treatment_details_page.dart';
// import 'package:upgrader/upgrader.dart';
// class DynamicData extends StatelessWidget {
//   final String dynamicId;
//
//   DynamicData({required this.dynamicId, Key? key}) : super(key: key);
//
//   // Inject controller with tag = dynamicId
//   late final DynamicTabController controller =
//       Get.put(DynamicTabController(dynamicId), tag: dynamicId);
//
//   @override
//   Widget build(BuildContext context) {
//     return UpgradeAlert(
//       child: GetBuilder<DynamicTabController>(
//         tag: dynamicId,
//         builder: (controller) => LiquidPullToRefresh(
//           animSpeedFactor: 1.5,
//           springAnimationDurationInMilliseconds: 400,
//           color: AppColor.dynamicColor,
//           showChildOpacityTransition: false,
//           key: controller.refreshIndicatorKey,
//           onRefresh: controller.handleRefresh,
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             body: Obx(() {
//               if (controller.isLoading.value) {
//                 return Shimmer.fromColors(
//                   baseColor: Colors.grey[300]!,
//                   highlightColor: Colors.grey[100]!,
//                   child: Column(
//                     children: [
//                       Container(
//                         height: 200.h,
//                         width: double.infinity,
//                         color: AppColor().whiteColor,
//                       ),
//                       Expanded(
//                         child: TreatementLoad(),
//                       ),
//                     ],
//                   ),
//                 );
//               }
//
//               final dataList = controller.dynamicTabModel.value?.data ?? [];
//               final header = controller.dynamicTabModel.value?.headerDetails;
//
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildHeaderSection(header),
//                     dataList.isEmpty
//                         ? Center(
//                       child: NoRecord(
//                         AppStrings.noDataFound,
//                         const Icon(Icons.no_accounts),
//                         AppStrings.weAreSorryNoDataAvailable,
//                       ),
//                     )
//                         : ListView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.all(16.r),
//                       itemCount: dataList.length,
//                       itemBuilder: (context, index) {
//                         final item = dataList[index];
//
//                         List<String> tags = [];
//                         if (item.concerns is List) {
//                           tags = List<String>.from(item.concerns!);
//                         } else if (item.concerns is String) {
//                           tags = (item.concerns! as String)
//                               .replaceAll(' ', '')
//                               .split(',')
//                               .where((e) => e.isNotEmpty)
//                               .toList();
//                         }
//
//                         return Padding(
//                           padding: EdgeInsets.symmetric(vertical: 10.h),
//                           child: PackageCard(
//                             title: item.name ?? AppStrings.unnamed,
//                             description: item.description ?? "",
//                             imageUrl: item.image ?? "",
//                             originalPrice: item.price?.toString() ?? "0.0",
//                             memberPrice: item.type == 'Package'
//                                 ? item.membershipInfo == null
//                                 ? item.membershipOfferPrice
//                                 : item.membershipInfo!
//                                 .membershipOfferPrice
//                                 : item.membershipOfferPrice ?? "0.0",
//                             tags: tags,
//                             sectionName: item.type ?? 'Treatments',
//                             onPressed: () {
//                               if (item.type == "Treatment") {
//                                 Get.to(
//                                       () => TreatmentDetailsPage(),
//                                   arguments: item.id,
//                                   binding: CommonBinding(),
//                                   transition: Transition.fadeIn,
//                                   duration: Duration(milliseconds: 500),
//                                 );
//                               } else if (item.type == "Package") {
//                                 Get.to(
//                                       () => PackageDetailPage(
//                                     sectionName: 'Package',
//                                   ),
//                                   arguments: item.id,
//                                   binding: CommonBinding(),
//                                   transition: Transition.fadeIn,
//                                   duration: Duration(milliseconds: 500),
//                                 );
//                               } else {
//                                 Get.toNamed(
//                                   RouteManager.membersShipDetailsPage,
//                                   arguments: item.id,
//                                   parameters: {"onlyShow": "0"},
//                                 );
//                               }
//                             },
//                             unitType: item.type.toString(),
//                             DiscountType: "0",
//                             discount: item.offeroffText.toString(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   // @override
//   // Widget build(BuildContext context) {
//   //   //print("dynamicId :$dynamicId");
//   //   // 🔑 ensures fresh API call if ID changes
//   //   controller.updateDynamicId(dynamicId);
//   //
//   //   return Scaffold(
//   //     backgroundColor: Colors.white,
//   //     body: Obx(() {
//   //       if (controller.isLoading.value) {
//   //         return Shimmer.fromColors(
//   //             baseColor: Colors.grey[300]!,
//   //             highlightColor: Colors.grey[100]!,
//   //             child: Column(
//   //               children: [
//   //                 Container(
//   //                   height: 200.h,
//   //                   width: double.infinity,
//   //                   color: AppColor().whiteColor,
//   //                 ),
//   //                 Expanded(
//   //                   child: TreatementLoad(),
//   //                 )
//   //               ],
//   //             ));
//   //       }
//   //
//   //       final dataList = controller.dynamicTabModel.value?.data ?? [];
//   //       final header = controller.dynamicTabModel.value?.headerDetails;
//   //
//   //       // Debug print
//   //       print("HeaderDetails from controller: ${header?.toJson()}");
//   //
//   //       return SingleChildScrollView(
//   //         child: Column(
//   //           children: [
//   //             _buildHeaderSection(header),
//   //             dataList.isEmpty
//   //                 ? Center(
//   //                     child: NoRecord(
//   //                       AppStrings.noDataFound,
//   //                       const Icon(Icons.no_accounts),
//   //                       AppStrings.weAreSorryNoDataAvailable,
//   //                     ),
//   //                   )
//   //                 : ListView.builder(
//   //                     shrinkWrap: true,
//   //                     physics: NeverScrollableScrollPhysics(),
//   //                     padding: EdgeInsets.all(16.r),
//   //                     itemCount: dataList.length,
//   //                     itemBuilder: (context, index) {
//   //                       final item = dataList[index];
//   //                       print(
//   //                           'item.membershipOfferPrice${item.membershipOfferPrice}');
//   //                       // Handle concerns as tags
//   //                       List<String> tags = [];
//   //                       if (item.concerns is List) {
//   //                         tags = List<String>.from(item.concerns!);
//   //                       }
//   //                       else if (item.concerns is String) {
//   //                         tags = (item.concerns! as String)
//   //                             .replaceAll(' ', '')
//   //                             .split(',')
//   //                             .where((e) => e.isNotEmpty)
//   //                             .toList();
//   //                       }
//   //
//   //                       return Padding(
//   //                         padding: EdgeInsets.symmetric(vertical: 10.h),
//   //                         child: PackageCard(
//   //                           title: item.name ?? AppStrings.unnamed,
//   //                           description: item.description ?? "",
//   //                           imageUrl:
//   //                               (item.image != null && item.image!.isNotEmpty)
//   //                                   ? item.image!
//   //                                   : "",
//   //                           originalPrice: item.price?.toString() ?? "0.0",
//   //                           memberPrice: item.type == 'Package'
//   //                               ? item.membershipInfo == null
//   //                                   ? item.membershipOfferPrice
//   //                                   : item.membershipInfo!.membershipOfferPrice
//   //                               : item.membershipOfferPrice ?? "0.0",
//   //                           tags: tags,
//   //                           sectionName: item.type ?? 'Treatments',
//   //                           onPressed: () {
//   //                             print("item.type: ${item.type}");
//   //                             // Navigate based on type
//   //                             item.type == "Treatment"
//   //                                 ? Get.to(
//   //                                     () => TreatmentDetailsPage(),
//   //                                     arguments: item.id,
//   //                                     binding: CommonBinding(),
//   //                                     transition: Transition.fadeIn,
//   //                                     duration:
//   //                                         const Duration(milliseconds: 500),
//   //                                   )
//   //                                 : item.type == "Package"
//   //                                     ? Get.to(
//   //                                         () => PackageDetailPage(
//   //                                           sectionName: 'Package',
//   //                                         ),
//   //                                         arguments: item.id,
//   //                                         transition: Transition.fadeIn,
//   //                                         binding: CommonBinding(),
//   //                                         duration:
//   //                                             const Duration(milliseconds: 500),
//   //                                       )
//   //                                     : Get.toNamed(
//   //                                         RouteManager.membersShipDetailsPage,
//   //                                         arguments: item.id,
//   //                                         parameters: {"onlyShow": "0"},
//   //                                       );
//   //                           },
//   //                           unitType: item.type.toString(),
//   //                           DiscountType: "0",
//   //                           discount: item.offeroffText.toString(),
//   //                         ),
//   //                       );
//   //                     },
//   //                   ),
//   //           ],
//   //         ),
//   //       );
//   //     }),
//   //   );
//   // }
//
//
//   Widget _buildHeaderSection(HeaderDetails? headerDetails) {
//     if (headerDetails == null) return const SizedBox.shrink();
//
//     return Container(
//       width: double.infinity,
//       height: 180.h,
//       decoration: BoxDecoration(
//         image: headerDetails.headerimage != null &&
//                 headerDetails.headerimage!.isNotEmpty
//             ? DecorationImage(
//                 image: NetworkImage(headerDetails.headerimage!),
//                 fit: BoxFit.cover,
//                 colorFilter: ColorFilter.mode(
//                   Colors.black.withOpacity(0.5),
//                   BlendMode.darken,
//                 ),
//               )
//             : null,
//         color: Colors.black26,
//       ),
//       padding: EdgeInsets.symmetric(horizontal: 10.h),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             headerDetails.headerTitle ?? '',
//             style: GoogleFonts.merriweather(
//               color: Colors.white,
//               fontSize: 25.sp,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: 5.h),
//           Text(
//             headerDetails.headerDescription ?? '',
//             style: GoogleFonts.actor(
//               color: Colors.white,
//               fontSize: 13.sp,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
