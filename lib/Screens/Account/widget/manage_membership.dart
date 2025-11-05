import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';

import '../../../common_Widgets/common_button_widget.dart';

class ManageMembership extends StatelessWidget {
  const ManageMembership({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().whiteColor,
      appBar: CommonAppBar(title: "Manage Memberships"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Text(
              "2 active membership",
              textAlign: TextAlign.center,
              style: AppTypography.galanoGrostesqueMedium.copyWith(
                fontSize: 14.sp,
                color: AppColor().greyColor,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 2,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 15.h),
                    elevation: 0.5,
                    color: AppColor().whiteColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: Column(
                        children: [
                          Text(
                            "Tox",
                            style: AppTypography.galanoGrostesqueSemiBold
                                .copyWith(fontSize: 18.sp),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Minimun commitment: a year remaining\nNext payment on Nov 29,2025\nusing payment method ending in 3007",
                            textAlign: TextAlign.center,
                            style: AppTypography.galanoGrostesqueMedium
                                .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColor().greyColor,
                                ),
                          ),
                          SizedBox(height: 5.h),
                          Divider(
                            thickness: 1.2.h,
                            color: AppColor().lightGrey,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Iconsax.wallet_2),
                                    InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      onTap: () {
                                        _showBankYourRewardBottomSheet(context);
                                      },
                                      child: Text(
                                        "Update payment method",
                                        style: AppTypography
                                            .galanoGrostesqueRegular
                                            .copyWith(fontSize: 16.sp),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 20.h,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.close_rounded,
                                      color: AppColor().greyColor,
                                    ),
                                    Text(
                                      "Cancel membership",
                                      style: AppTypography
                                          .galanoGrostesqueRegular
                                          .copyWith(
                                            fontSize: 16.sp,
                                            color: AppColor().greyColor,
                                          ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor().greyColor,
                                      size: 20.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}

void _showBankYourRewardBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, color: Colors.black54),
            ),
          ),
          Icon(
            Iconsax.wallet_2,
            color: AppColor().lightBlackColor,
            size: 35.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            "Update payment method",
            textAlign: TextAlign.center,
            style: AppTypography.galanoGrostesqueSemiBold.copyWith(
              fontSize: 26.sp,
              color: AppColor().lightBlackColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            "Continuing will take you to a new page to update your membership payment method. Once updated, your new payment method will be used for this membership moving forward.",
            textAlign: TextAlign.center,
            style: AppTypography.galanoGrostesqueMedium.copyWith(
              fontSize: 15.sp,
              color: AppColor().greyColor,
            ),
          ),
          SizedBox(height: 18.h),

          CommonButtonWidget(
            innerColor: AppColor.dynamicColor,
            onTap: () {},
            buttonName: 'Update payment method',
          ),

          SizedBox(height: 16.h),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                color: AppColor.dynamicColor,
                fontSize: 15.sp,
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 16.h),
        ],
      ),
    ),
  );
}
