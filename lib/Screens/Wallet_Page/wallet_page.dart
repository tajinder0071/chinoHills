import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/Screens/Wallet_Page/Widget/wallet_treatments.dart';
import '../../CSS/appTypography.dart';
import '../../CSS/color.dart';
import '../../util/common_page.dart';
import '../order/controller/order_controller.dart';
import '../order/order_details_page.dart';
import '../shop/controller/shop_controller.dart';
import 'Widget/wallet_active_membership.dart';

class WalletPage extends StatefulWidget {
  final VoidCallback onShopServicesOnTap;
  final VoidCallback shopAllMemberOnTap;

  const WalletPage({
    super.key,
    required this.onShopServicesOnTap,
    required this.shopAllMemberOnTap,
  });

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> with TickerProviderStateMixin {
  final ShopController controller = Get.find<ShopController>();
  late TabController _tabController;
  final OrderController orderController = Get.put(OrderController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchWalletNimaCash();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.h),
          child: TabBar(
            controller: _tabController,
            labelColor: AppColor.dynamicColor,
            unselectedLabelColor: Colors.grey.shade600,
            labelStyle: GoogleFonts.roboto(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.roboto(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(width: 2.5, color: AppColor.dynamicColor),
              insets: const EdgeInsets.symmetric(horizontal: 24.0),
            ),
            indicatorColor: AppColor.dynamicColor,
            indicatorWeight: 2,
            tabs: const [
              Tab(text: "Treatments"),
              Tab(text: "Memberships"),
              Tab(text: "ChinoCash"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            //_buildTreatmentsTab(),
            WalletTreatments(),
            WalletActiveMembership(),
            _buildRepeatCashTab(),
          ],
        ),
      ),
    );
  }

  /// --- NimaCash Tab ---
  Widget _buildRepeatCashTab() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.dynamicColor,
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage("assets/new_images/nima_cash_card_bg.png"),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(AppColor().whiteColor.withValues(alpha: 0.05), BlendMode.srcIn)
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ChinoCash",
                    style: GoogleFonts.sarabun(
                      fontSize: 20.sp,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Shop Services",
                        style: GoogleFonts.sarabun(
                          fontSize: 13.sp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "\$${controller.nimaCashBalance.value.toString().replaceAll(".0", "")}",
                        style: GoogleFonts.sarabun(
                          fontSize: 30.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 20.h),
            controller.nimaCashBalance.value.toString() == "0.0"
                ? SizedBox.shrink()
                : Center(
                    child: Text(
                      "HISTORY",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.sarabun(
                        fontSize: 20.sp,
                        color: Colors.black.withValues(alpha: 0.65),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            SizedBox(height: 20.h),
            controller.nimaCashHistory.isEmpty
                ? SizedBox.shrink()
                : ListView.builder(
                    itemCount: controller.nimaCashHistory.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = controller.nimaCashHistory[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: RewardTile(
                          title: item.notes!,
                          amount: "\$${item.amount?.toString()}",
                          onTap: item.orderId!.isNotEmpty
                              ? () {
                                  Get.to(() => OrderDetailsPage(item.orderId!),
                                          transition: Transition.fadeIn,
                                          duration:
                                              Duration(milliseconds: 500))!
                                      .then((_) {
                                    orderController.orderListApi();
                                  });
                                }
                              : () {},
                          iconVisibility:
                              item.orderId!.isNotEmpty ? true : false,
                          balanceType: item.balanceType!,
                        ),
                      );
                    },
                  ),
            getBrand()
          ],
        ),
      );
    });
  }
}

/// --- Reward Tile Widget ---
class RewardTile extends StatelessWidget {
  final String title;
  final String amount;
  final VoidCallback? onTap;
  final bool iconVisibility;
  final String balanceType;

  const RewardTile({
    super.key,
    required this.title,
    required this.amount,
    this.onTap,
    required this.iconVisibility,
    required this.balanceType,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColor().lightGrey?.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "$amount $title",
                style: AppTypography.galanoGrostesqueSemiBold.copyWith(
                  fontSize: 14.5.sp,
                  color: AppColor().blackColor,
                ),
              ),
            ),
            Row(
              children: [
                (balanceType == "debit")
                    ? Text(
                        "-$amount",
                        style: GoogleFonts.nunito(
                          fontSize: 15.sp,
                          color: AppColor().redColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    : Text(
                        "+$amount",
                        style: GoogleFonts.nunito(
                          fontSize: 15.sp,
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                iconVisibility
                    ? Icon(Icons.chevron_right,
                        color: AppColor().blackColor, size: 22.sp)
                    : const SizedBox.shrink()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
