import 'package:chino_hills/Screens/shop/widgets/package_card_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../Model/dynamic_tab_model.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/no_record.dart';
import '../../../../util/route_manager.dart';
import '../../../CSS/color.dart';
import '../../../binding/account_Binding.dart';
import '../../Discover/controller/dynamic_tab_controller.dart';
import '../Pages/Package Page/Widgets/package_detail_page.dart';
import '../Pages/Treatment Page/widgets/treatment_details_page.dart';

class DynamicData extends StatelessWidget {
  final String dynamicId;

  DynamicData({required this.dynamicId, Key? key}) : super(key: key);

  // Inject controller with dynamicId
  late final DynamicTabController controller =
  Get.put(DynamicTabController(dynamicId), tag: dynamicId);

  @override
  Widget build(BuildContext context) {
    print("dynamicId :$dynamicId");

    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
              child: CircularProgressIndicator(
                color: AppColor.dynamicColor,
              ));
        }

        final dataList = controller.dynamicTabModel.value?.data ?? [];

        return Column(
          children: [
            _buildHeaderSection(
                controller.dynamicTabModel.value?.headerDetails),
            dataList.isEmpty
                ? Center(
              child: NoRecord(
                "No Data Found",
                Icon(Icons.no_accounts),
                "We're sorry. No data available at this moment.",
              ),
            )
                : Expanded(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(16.r),
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final item = dataList[index];

                  // Handle concerns as tags
                  List<String> tags = [];
                  if (item.concerns is List) {
                    tags = List<String>.from(item.concerns!);
                  } else if (item.concerns is String) {
                    tags = (item.concerns! as String)
                        .replaceAll(' ', '')
                        .split(',')
                        .where((e) => e.isNotEmpty)
                        .toList();
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: PackageCard(
                      title: item.name ?? "Unnamed",
                      description: item.description ?? "",
                      imageUrl:
                      (item.image != null && item.image!.isNotEmpty)
                          ? item.image!
                          : "",
                      originalPrice: item.price?.toString() ?? "0.0",
                      memberPrice: item.offeroffText ?? "0.0",
                      tags: tags,
                      sectionName:
                      typeValues.reverse[item.type] ?? 'Treatments',
                      onPressed: () {
                        print("item.type: ${item.type}");
                        // Optional: Add navigation here
                        typeValues.reverse[item.type] == "Treatment"
                            ? Get.to(
                              () => TreatmentDetailsPage(),
                          arguments: item.id,
                          binding: CommonBinding(),
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 500),
                        )
                            : typeValues.reverse[item.type] == "Package"
                            ? Get.to(
                          PackageDetailPage(
                            sectionName: 'Package',
                          ),
                          arguments: item.id,
                          transition: Transition.fadeIn,
                          duration: Duration(milliseconds: 500),
                        )
                            : Get.toNamed(
                          RouteManager.membersShipDetailsPage,
                          arguments: item.id,
                          parameters: {"onlyShow": "0"},
                        );
                      },
                      unitType: "",
                      DiscountType: "",
                      discount: 0,
                    ),
                  );
                },
              ),
            )
          ],
        );
      }),
    );
  }

  Widget _buildHeaderSection(HeaderDetails? headerDetails) {
    print(headerDetails);
    return headerDetails == null
        ? SizedBox.shrink()
        : Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(headerDetails.headerimage ?? ''),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headerDetails.headerTitle ?? '',
            style: GoogleFonts.merriweather(
              color: Colors.white,
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.h),
          Text(
            headerDetails.headerDescription ?? '',
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
