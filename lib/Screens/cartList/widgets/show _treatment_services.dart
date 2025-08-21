import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../CSS/color.dart';
import '../../../Model/cart_model.dart';
import '../Controller/cart_controller.dart'; // <- contains TreatmentVariation

class ShowTreatmentServices extends StatefulWidget {
  final List<TreatmentVariation> selectTr;

  int? selectedServiceId;
  final int cartID;
  final int cartitemID;

  ShowTreatmentServices({
    Key? key,
    required this.selectTr,
    required this.cartitemID,
    required this.selectedServiceId,
    required this.cartID,
  }) : super(key: key);

  @override
  State<ShowTreatmentServices> createState() => _ShowTreatmentServicesState();
}

class _ShowTreatmentServicesState extends State<ShowTreatmentServices> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .93,
      decoration: BoxDecoration(
        color: AppColor().whiteColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10.h, left: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'SELECT YOUR SERVICE',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 40.w), // keeps title centred
              ],
            ),
          ),
          const Divider(),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectTr.length,
              itemBuilder: (_, index) {
                final variation = widget.selectTr[index];
                final bool isSelected =
                    variation.treatmentVariationId == widget.selectedServiceId;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedServiceId = variation.treatmentVariationId;
                    });
                  },
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(variation.treatmentVariationName ?? ''),
                        leading: Container(
                          width: 24.w,
                          height: 24.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColor.dynamicColor,
                              width: 2,
                            ),
                            color: isSelected
                                ? AppColor.dynamicColor
                                : Colors.white,
                          ),
                          child: isSelected
                              ? Icon(
                                  Icons.circle,
                                  size: 8.w,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                      Divider(
                        color: AppColor.dynamicColorWithOpacity,
                        thickness: 1,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: GetBuilder<CartController>(
              builder: (controller) => Container(
                margin: EdgeInsets.all(10.h),
                width: double.infinity,
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: LinearGradient(
                    colors: [
                      AppColor.dynamicColor,
                      AppColor.dynamicColor.withAlpha(500),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: controller.isUpdate
                      ? null
                      : () {
                          controller.updateProduct(
                            widget.selectedServiceId,
                            widget.cartID,
                            widget.cartitemID,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    disabledBackgroundColor: Colors.transparent,
                    overlayColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  child: controller.isUpdate
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColor().whiteColor,
                          ),
                        )
                      : Text(
                          'Apply',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor().whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
