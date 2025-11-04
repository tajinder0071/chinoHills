import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/treatment_details_page.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../CSS/image_page.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../loading/cart_list_load.dart';
import '../../../../util/local_stoage.dart';
import '../../../../util/route_manager.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
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
              child: SafeArea(
                top: true,
                child: AppBar(
                  backgroundColor: AppColor().whiteColor,
                  automaticallyImplyLeading: false,
                  elevation: 0,
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            height: 40.w,
                            width: 40.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.dynamicColor,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: AppColor().whiteColor,
                              size: 15.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w,),
                        Expanded(
                          child: Obx(() => TextFormField(
                            controller: controller.searchController,
                            focusNode: controller.focusNode,
                            autofocus: true,
                            cursorHeight: 20.h,
                            cursorColor: AppColor.dynamicColor,
                            onChanged: (value) {
                              if (!controller.isLoading.value) {
                                controller.debouncer.run(() {
                                  controller.onChanged(value);
                                  controller.searchManageTracking(value);
                                });
                              }
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                              hintText: 'Search',
                              hintStyle: GoogleFonts.sarabun(
                                fontSize: 16.sp,
                                color: Colors.grey.shade600,
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 30.w,
                                  width: 30.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.dynamicColor,
                                  ),
                                  child: Icon(
                                    Iconsax.search_normal_outline,
                                    color: AppColor().whiteColor,
                                    size: 18.h,
                                  ),
                                ),
                              ),
                              suffixIcon:
                                  controller.searchText.value.isNotEmpty
                                      ? IconButton(
                                          icon: const Icon(Icons.clear_rounded),
                                          onPressed: controller.clearText,
                                    color: AppColor().lightBlackColor,
                                        )
                                      : null,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.r),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.r),
                                borderSide: BorderSide(
                                  color: AppColor.dynamicColor,
                                  width: 1.5,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.r), // rounded corners
                                borderSide: BorderSide.none, // no border
                              ),
                            ),
                          )),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Obx(() {
              if (controller.isLoading.value == true) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: TreatementLoad(),
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
                                    color: AppColor().black80),
                              ),
                            ),
                            SizedBox(height: 20.0.h),
                            Text(
                              "SEARCH RESULTS",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                  color: AppColor().black80),
                            ),

                            //Todo ?? Here is the TreatmentData
                            // Treatment List
                            if (controller.treatmentList.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.treatmentList.length,
                                itemBuilder: (context, index) {
                                  final product = controller.treatmentList[index];
                                  List<String> concerns = product.concerns != null
                                      ? List<String>.from(product.concerns)
                                      : [];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    child: PackageCard(
                                      title: product.name ?? '',
                                      description: product.description ?? '',
                                      imageUrl: product.imageurl ?? '',
                                      originalPrice: double.tryParse(product.minPrice?.toString() ?? '0') ?? 0,
                                      memberPrice: double.tryParse(product.minPrice?.toString() ?? '0') ?? 0,
                                      tags: concerns,
                                      discount: 0,
                                      sectionName: 'Treatment',
                                      onPressed: () {
                                        Get.to(() => TreatmentDetailsPage(),
                                            binding: CommonBinding(),
                                            arguments: product.serviceId,
                                            transition: Transition.fadeIn,
                                            duration: Duration(milliseconds: 500));
                                      },
                                      unitType: "",
                                      DiscountType: '',
                                    ),
                                  );
                                },
                              ),

                            if (controller.packageList.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.packageList.length,//add cond
                                itemBuilder: (context, index) {
                                  final product = controller.packageList[index];
                                  List<String> concerns = product.concerns != null
                                      ? List<String>.from(product.concerns)
                                      : [];

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                    child: PackageCard(
                                      title: product.name ?? '',
                                      description: product.description ?? '',
                                      imageUrl: product.imageurl ?? '',
                                      originalPrice: double.tryParse(product.minPrice?.toString() ?? '0') ?? 0,
                                      memberPrice: double.tryParse(product.minPrice?.toString() ?? '0') ?? 0,
                                      tags: concerns,
                                      discount: 0,
                                      sectionName: 'Package',
                                      onPressed: () {
                                        Get.to(() => PackageDetailPage(sectionName: 'Package'),
                                            binding: CommonBinding(),
                                            arguments: product.serviceId,
                                            transition: Transition.fadeIn,
                                            duration: Duration(milliseconds: 500));
                                      },
                                      unitType: "",
                                      DiscountType: '',
                                    ),
                                  );
                                },
                              ),

                            // TODO ??  Here is the PackageDetails Data..
                            if (controller.packageList.isNotEmpty)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller.packageList.length,
                                    itemBuilder: (context, index) {
                                      final product =
                                          controller.packageList[index];

                                      // Extract concern names safely
                                      List<String> concerns = product.concerns !=
                                              null
                                          ? product.concerns!
                                              .map((con) =>
                                                  con.concernName.toString())
                                              .toList()
                                          : [];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 6),
                                        child: PackageCard(
                                          title: product.serviceType ?? '',
                                          description:
                                              product.description ?? '',
                                          imageUrl:
                                              (product.imageurl != null &&
                                                      product.imageurl!
                                                          .isNotEmpty)
                                                  ? product.imageurl![0]
                                                  : "",
                                          originalPrice: double.tryParse(
                                                  product.minPrice.toString()) ??
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
                                                    sectionName: 'Package'),
                                                binding: CommonBinding(),
                                                arguments: product.serviceId,
                                                transition: Transition.fadeIn,
                                                duration: Duration(
                                                    milliseconds: 500));
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
            })),
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
            Container(
              height: 150.h,
              width: 150.w,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.noDataFoundBg),colorFilter: ColorFilter.mode(
                    AppColor.dynamicColor,
                    BlendMode.srcIn,))
              ),
              child: Icon(Icons.search_off_outlined, size: 60.h, color: AppColor().whiteColor,),
            ),
            SizedBox(height: 20.h),
            Text(
              'No results found',
              style: GoogleFonts.sarabun(fontWeight: FontWeight.w600, fontSize: 19.sp),
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
  const SearchRedirectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text:
            'Didn’t find what you were looking for?\nCheck your spelling or try ',
        style: GoogleFonts.sarabun(color: Colors.grey.shade600, fontSize: 14.sp),
        children: [
          TextSpan(
              text: 'Browse by concern',
              style: GoogleFonts.sarabun(
                  color: AppColor.dynamicColor, fontWeight: FontWeight.w500),
              mouseCursor: SystemMouseCursors.click,
              recognizer: TapGestureRecognizer()
                ..onTap = () async {
                  LocalStorage local = LocalStorage();
                  local.saveData("shopIndex", 4);
                  Get.offAllNamed(
                    RouteManager.dashBoardPage,
                    arguments: 2,
                  );
                })
        ],
      ),
    );
  }
}
