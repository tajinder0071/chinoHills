import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CSS/app_strings.dart';
import '../../../CSS/color.dart';
import '../../Dashboard/Home/widget/become_a_member.dart';
import '../../shop/controller/shop_controller.dart';

class WalletPage extends StatelessWidget {
  final VoidCallback onShopServicesOnTap;
  final VoidCallback shopAllMemberOnTap;

  WalletPage({
    super.key,
    required this.onShopServicesOnTap,
    required this.shopAllMemberOnTap,
  });

  final ShopController controller = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            labelColor: AppColor.dynamicColor,
            unselectedLabelColor: AppColor().greyColor,
            indicatorColor: AppColor.dynamicColor,
            labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Treatments"),
              Tab(text: "Memberships"),
              Tab(text: "RepeatCash"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                // Make treatments scrollable
                // Replace the Treatments tab content
                SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "You haven’t purchased any treatments yet. Browse the shop to buy your first treatment and start your journey!",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                color: AppColor().blackColor,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(height: 20.h),
                          ElevatedButton(
                            onPressed: onShopServicesOnTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.dynamicColor,
                              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              "Browse Shop",
                              style: GoogleFonts.roboto(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                // Make BecomeAMember scrollable
                SingleChildScrollView(
                  child: BecomeAMember(
                    onPressed: shopAllMemberOnTap,
                    data: controller.homeData.isNotEmpty
                        ? controller.homeData[0].memberships
                        : [],
                    perks: controller.homeData.isNotEmpty
                        ? controller.homeData[0].membershipPerks
                        : [],
                    membershipPerkHeader: controller.homeData.isNotEmpty
                        ? controller.homeData[0].membershipsPerksHeader
                        : "",
                  ),
                ),

                // Make RepeatCash scrollable
                _buildRepeatCashTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRepeatCashTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200.h,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: const DecorationImage(
                image: AssetImage("assets/images/wallet_image.png"),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "RepeatCash",
                      style: GoogleFonts.merriweather(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0.h,
                  left: 10.w,
                  child: Text(
                    "\$24.06",
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.h,
                  right: 10.w,
                  child: InkWell(
                    onTap: onShopServicesOnTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Shop Services",
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.arrow_forward_ios,
                            size: 18.h, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            AppStrings.walletText,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                fontSize: 15.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 20.h),
          /*Text(
            "RECENT ACTIVITY",
            style: GoogleFonts.roboto(
                fontSize: 14.sp,
                color: Colors.black54,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          _buildTransactionRow("NIMA VIP Quartz", "-\$0.94", true),
          Divider(),
          _buildTransactionRow("\$25 Towards Any Service", "\$25.00", false),*/
        ],
      ),
    );
  }

  Widget _buildTransactionRow(String title, String amount, bool isNegative) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.roboto(
                  fontSize: 15.sp, fontWeight: FontWeight.w500)),
          Text(
            amount,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: isNegative ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
