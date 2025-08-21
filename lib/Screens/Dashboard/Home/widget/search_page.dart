import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/color.dart';
import '../../../../binding/package_details_binding.dart';
import '../../../../binding/treartmentDetailsBinding.dart';
import '../../../../loading/cart_list_load.dart';
import '../../../../../util/local_store_data.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
import '../../../shop/widgets/package_card_widgets.dart';
import '../controller/search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchGlobalController());

    return FocusScope(
      node: FocusScopeNode(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColor().whiteColor,
          appBar: PreferredSize(
            preferredSize: Size(Get.width, 50.0.h),
            child: AppBar(
              backgroundColor: AppColor().whiteColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              titleSpacing: 0,
              title: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Obx(
                      () => Container(
                        height: 38.h,
                        decoration: BoxDecoration(
                          color: AppColor().whiteColor,
                          border: Border.all(
                            color: controller.isFocused.value
                                ? Colors.blue
                                : Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(9.r),
                        ),
                        child: TextFormField(
                          controller: controller.searchController,
                          focusNode: controller.focusNode,
                          autofocus: true,
                          onChanged: (value) {
                            if (!controller.isLoading.value) {
                              controller.debouncer.run(() {
                                controller.onChanged(value);
                                controller.searchManageTracking(value);
                              });
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h,
                            ),
                            hintText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: controller.searchText.value.isNotEmpty
                                ? IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: controller.clearText,
                                  )
                                : null,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColor.dynamicColorWithOpacity,
                                width: 0.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColor.dynamicColor,
                                width: 1,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColor.dynamicColor,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value == true) {
              return Shimmer.fromColors(
                child: TreatementLoad(),
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
              );
            }

            return controller.searchController.text.isEmpty
                ? SizedBox.shrink()
                : (controller.treatmentList.isEmpty &&
                      controller.packageList.isEmpty)
                ? Center(child: NoResultsFound())
                : ListView(
                    children: [
                      // TODO ?? Let's show here results found & SEARCH RESULTS
                      SizedBox(height: 10.0.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.h),
                        child: Text(
                          "${controller.packageList.length + controller.treatmentList.length} results found",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            color: AppColor().black80,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0.h),
                      Text(
                        "SEARCH RESULTS",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: AppColor().black80,
                        ),
                      ),

                      //Todo ?? Here is the TreatmentData
                      if (controller.treatmentList.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.treatmentList.length,
                              itemBuilder: (context, index) {
                                final product = controller.treatmentList[index];
                                // Extract concern names safely
                                List<dynamic> concerns =
                                    product['concern'] != null
                                    ? product['concern']!
                                          .map(
                                            (con) =>
                                                con['concern_name'].toString(),
                                          )
                                          .toList()
                                    : [];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  child: PackageCard(
                                    title: product['treatment_name'] ?? '',
                                    description:
                                        product['treatment_description'] ?? '',
                                    imageUrl:
                                        (product['treatmentImagePaths'] !=
                                                null &&
                                            product['treatmentImagePaths']!
                                                .isNotEmpty)
                                        ? product['treatmentImagePaths']![0]
                                        : "",
                                    originalPrice:
                                        double.tryParse(
                                          product['price'].toString(),
                                        ) ??
                                        0,
                                    memberPrice: product['membership_price'],
                                    // Replace with dynamic value if needed
                                    tags: concerns,
                                    discount: 0,
                                    sectionName: 'Treatment',
                                    onPressed: () {
                                      Get.to(
                                        () => TreatmentDetailsPage(),
                                        binding: TreatmentDetailsBinding(),
                                        arguments: product['id'],
                                        transition: Transition.fadeIn,
                                        duration: Duration(milliseconds: 500),
                                      );
                                    },
                                    unitType: "",
                                    DiscountType: product['DiscountType'] ?? '',
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      // TODO ??  Here is the PackageDetails Data..
                      if (controller.packageList.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.packageList.length,
                              itemBuilder: (context, index) {
                                final product = controller.packageList[index];

                                // Extract concern names safely
                                List<String> concerns = product.concern != null
                                    ? product.concern!
                                          .map(
                                            (con) => con.concernName.toString(),
                                          )
                                          .toList()
                                    : [];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  child: PackageCard(
                                    title: product.packageName ?? '',
                                    description: product.description ?? '',
                                    imageUrl:
                                        (product.packageImages != null &&
                                            product.packageImages!.isNotEmpty)
                                        ? product.packageImages![0]
                                        : "",
                                    originalPrice:
                                        double.tryParse(
                                          product.pricing.toString(),
                                        ) ??
                                        0,
                                    //membership amount need to be dynamic
                                    memberPrice: 0,
                                    // Replace with dynamic value if needed
                                    tags: concerns,
                                    discount: 0,
                                    sectionName: 'Package',
                                    onPressed: () {
                                      Get.to(
                                        () => PackageDetailPage(
                                          sectionName: 'Package',
                                        ),
                                        binding: PackageDetailsBinding(),
                                        arguments: product.packageId,
                                        transition: Transition.fadeIn,
                                        duration: Duration(milliseconds: 500),
                                      );
                                    },
                                    unitType: "",
                                    DiscountType:
                                        '', // Add unit type if applicable
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      // TODO ??  Here is the show the content..
                      SizedBox(height: 20.h),
                      SearchRedirectWidget(),
                      SizedBox(height: 20.h),
                    ],
                  );
          }),
        ),
      ),
    );
  }
}

class NoResultsFound extends StatelessWidget {
  const NoResultsFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_outlined,
              size: 60,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: 20.h),
            Text(
              'No results found',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18.sp),
            ),
            SizedBox(height: 10.h),
            SearchRedirectWidget(),
          ],
        ),
      ),
    );
  }
}

class SearchRedirectWidget extends StatelessWidget {
  const SearchRedirectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text:
            'Didn’t find what you were looking for?\nCheck your spelling or try ',
        style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
        children: [
          TextSpan(
            text: 'Browse by concern',
            style: TextStyle(
              color: AppColor.dynamicColor,
              fontWeight: FontWeight.w500,
            ),
            mouseCursor: SystemMouseCursors.click,
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                LocalStorage local = LocalStorage();
                local.saveData("shopIndex", 4);
                Get.offAllNamed(RouteManager.dashBoardPage, arguments: 2);
              },
          ),
        ],
      ),
    );
  }
}
