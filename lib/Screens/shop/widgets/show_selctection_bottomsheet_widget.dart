import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../CSS/color.dart';
import '../Pages/Package Page/controller/package_cotroller.dart';
import '../Pages/Treatment Page/controller/treatment_controller.dart';
import 'bottom_button.dart';

class CommonBottomSheet extends StatelessWidget {
  final con = Get.put(TreatmentController());
  List concernValue = [];
  final pcon = Get.put(PackageController());
  final String title;
  final String name;
  final List options;
  final bool isSortBy;
  final VoidCallback onReset, onApply;
  List<String> selectedOptions;
  List<int> selectedValue;
  int? selectFilter = -1;
  bool isFirstTimeFilterOpen = true;

  CommonBottomSheet({
    super.key,
    required this.title,
    required this.name,
    required this.options,
    required this.isSortBy,
    required this.selectedValue,
    required this.selectedOptions,
    required this.onApply,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedValue.isNotEmpty) {
      selectFilter = selectedValue[0];
    }
    bool isApplyButtonEnabled =
        selectedOptions.isNotEmpty || selectFilter != -1;

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          height: Get.height * 0.85,
          decoration: BoxDecoration(
            color: AppColor().whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //! Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor().greyColor.withOpacity(0.1),
                        ),
                        child: Icon(Icons.close, size: 20.r),
                      ),
                    ),
                    Text(
                      title.toUpperCase(),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 40.w),
                  ],
                ),
              ),

              //! Divider
              Divider(
                height: 1.h,
                thickness: 1.h,
                color: AppColor().greyColor.withOpacity(0.1),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final concernItem = options[index];
                    final optionId = concernItem['id'].toString();
                    final title = concernItem['title'].toString();

                    final isSelected = isSortBy
                        ? selectFilter == index
                        : selectedOptions.contains(optionId);

                    return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: isSelected
                              ? AppColor.dynamicColor.withOpacity(0.3)
                              : AppColor().greyColor.withOpacity(0.1),
                          width: 1.5.w,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12.r),
                          onTap: isSortBy
                              ? () {}
                              : () async {
                                  setState(() {
                                    if (selectedOptions.contains(optionId)) {
                                      selectedOptions.remove(optionId);
                                    } else {
                                      selectedOptions.add(optionId);
                                    }
                                    pcon.selectedOptions = [...selectedOptions];
                                    isApplyButtonEnabled =
                                        selectedOptions.isNotEmpty;
                                  });

                                  await pcon.enabledBrowseAPI(name);
                                },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.h),
                            child: ListTile(
                                contentPadding:
                                    EdgeInsets.only(left: 8.w, right: 16.w),
                                minLeadingWidth: 0,
                                horizontalTitleGap: 12.w,
                                title: Text(
                                  title,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: isSelected
                                        ? AppColor.dynamicColor
                                        : Colors.black,
                                  ),
                                ),
                                leading: isSortBy
                                    ? Radio<int>(
                                        value: index,
                                        groupValue: selectFilter,
                                        toggleable: true,
                                        activeColor: AppColor.dynamicColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        onChanged: (value) {
                                          selectedValue.clear();
                                          setState(() {
                                            selectFilter = value;
                                            isApplyButtonEnabled =
                                                selectFilter != null &&
                                                    selectFilter != -1;
                                          });
                                          selectedValue
                                              .add(selectFilter!.toInt());
                                        },
                                      )
                                    : Checkbox(
                                        value:
                                            selectedOptions.contains(optionId),
                                        activeColor: AppColor.dynamicColor,
                                        checkColor: Colors.white,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        visualDensity: VisualDensity.compact,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                        side: BorderSide(
                                          width: 1.5.w,
                                          color: AppColor()
                                              .greyColor
                                              .withOpacity(0.4),
                                        ),
                                        onChanged: (bool? isChecked) async {
                                          setState(() {
                                            if (isChecked == true) {
                                              selectedOptions.add(optionId);
                                            } else {
                                              selectedOptions.remove(optionId);
                                            }
                                            pcon.selectedOptions = [
                                              ...selectedOptions
                                            ];
                                            isApplyButtonEnabled =
                                                selectedOptions.isNotEmpty;
                                          });

                                          await pcon.enabledBrowseAPI(name);
                                        },
                                      )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: Offset(0, -4),
                    )
                  ],
                ),
                padding: EdgeInsets.all(16.r),
                child: BottomButton(
                  isApplyButtonEnabled: isApplyButtonEnabled,
                  onReset: onReset,
                  onApply: () {
                    onApply();
                    if (isSortBy) {
                      Get.back(result: selectFilter);
                    } else {
                      Get.back(result: selectedOptions);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
