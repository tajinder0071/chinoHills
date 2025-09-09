import 'package:chino_hills/Screens/shop/Pages/Package%20Page/Widgets/package_detail_page.dart';
import 'package:chino_hills/Screens/shop/Pages/Treatment%20Page/widgets/treatment_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../CSS/color.dart';
import '../../../../Model/discover_model.dart';
import '../../../../Model/offer_detail_model.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/cacheNetworkImage.dart';
import '../../../../util/common_page.dart';
import '../../../Discover/controller/discover_controller.dart';
import '../../../cartList/Controller/cart_controller.dart';
import 'members_ship_details_page.dart';

class LearnMorePage extends StatelessWidget {
  final bool isExpire;
  final ContentCard? cardData;
  final int? id;

  const LearnMorePage({
    super.key,
    this.isExpire = false,
    this.cardData,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return cardData == null
        ? _OfferDetailSection(id: id!)
        : _DiscoverSection(cardData: cardData!);
  }
}

// ----------------- DISCOVER SECTION -----------------
class _DiscoverSection extends StatelessWidget {
  final ContentCard cardData;

  const _DiscoverSection({required this.cardData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(isLeading: true, title: "Learn More", action: []),
      body: ListView(
        children: [
          ConstantNetworkImage(
            isLoad: true,
            imageUrl:  cardData.cloudUrl.toString(),
            width: double.infinity,
            height: 200.h,
            boxFit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardData.title?.capitalizeFirst ?? '',
                  style: GoogleFonts.merriweather(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  cardData.description ?? '',
                  style: GoogleFonts.roboto(
                    fontSize: 15.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(bottom: 8.h),
        child: GetBuilder<DiscoverController>(builder: (controller) {
          return _BottomButton(
            label: cardData.callToAction ?? "Learn More",
            onTap: () => controller.launchURL(cardData.customUrl!),
          );
        }),
      ),
    );
  }
}

// ----------------- OFFER DETAIL SECTION -----------------
class _OfferDetailSection extends StatelessWidget {
  final int id;

  const _OfferDetailSection({required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.find<CartController>()
        ..cartList()
        ..learnMore(id.toString()),
      builder: (controller) {
        if (controller.isLoading) {
          return _LoadingState();
        }
        if (controller.offerDetailModel.data == null) {
          return _EmptyState();
        }

        final offer = controller.offerDetailModel.data!;
        return Scaffold(
          backgroundColor: AppColor().background,
          appBar:
          commonAppBar(isLeading: true, title: "Learn More", action: []),
          body: ListView(
            padding: EdgeInsets.all(12.w),
            children: [
              ConstantNetworkImage(
                isLoad: true,
                imageUrl: offer.image ?? "",
                width: double.infinity,
                height: 200.h,
                boxFit: BoxFit.cover,
              ),
              SizedBox(height: 12.h),
              Text(
                offer.title?.capitalizeFirst ?? '',
                style: GoogleFonts.merriweather(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              offer.description == ""
                  ? SizedBox.shrink()
                  : SizedBox(height: 10.h),
              offer.description == ""
                  ? SizedBox.shrink()
                  : Text(
                offer.description.toString() ?? '',
                style: GoogleFonts.merriweather(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              offer.description == ""
                  ? SizedBox.shrink()
                  : SizedBox(height: 10.h),
              offer.discountType == ""
                  ? SizedBox.shrink()
                  : Text(
                offer.discountType.toString() ?? '',
                style: GoogleFonts.merriweather(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              if ((offer.treatments?.isNotEmpty ?? false) ||
                  (offer.packages?.isNotEmpty ?? false) ||
                  (offer.memberships?.isNotEmpty ?? false))
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle("Treatments"),
                      _TreatmentList(offer.treatments ?? []),
                      _SectionTitle("Packages"),
                      _PackageList(offer.packages ?? []),
                      _SectionTitle("Memberships"),
                      _MembershipList(offer.memberships ?? []),
                    ],
                  ),
                ),
            ],
          ), // bottomNavigationBar: controller.cartModel1.value.data == null || controller.cartModel1.value.data!.items!.isEmpty || controller.cartModel1.value.data!.cartId.toString() == "0" // ? SizedBox.shrink() :
          bottomNavigationBar: controller.isApplyLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : SafeArea(
            minimum: EdgeInsets.only(bottom: 8.h),
            child: _BottomButton(
              label: "Apply offer to cart",
              onTap: () => controller.selectPromoCode(
                offer.promoCode,
                0,
                offer.id,
                controller,
                controller.cartModel1.value.data?.cartId ?? "",
              ),
            ),
          ),
        );
      },
    );
  }
}

// ----------------- REUSABLE COMPONENTS -----------------
class _BottomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _BottomButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: WidgetStatePropertyAll(AppColor().transparent),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColor.dynamicColor,
        ),
        height: 55.h,
        alignment: Alignment.center,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.h,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Text(
        title,
        style: GoogleFonts.merriweather(
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _TreatmentList extends StatelessWidget {
  final List<Treatment> treatments;

  const _TreatmentList(this.treatments);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: treatments.map((treatment) {
        return _ListItem(
          title: treatment.treatmentName ?? '',
          onTap: () => Get.to(
                () => TreatmentDetailsPage(),
            arguments: treatment.treatmentId,
            binding: CommonBinding(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
          ),
          children: treatment.variations?.map((v) {
            return Padding(
              padding: EdgeInsets.only(left: 16.w, top: 4.h),
              child: Text("• ${v.variationName}",
                  style: GoogleFonts.roboto(fontSize: 14.sp)),
            );
          }).toList() ??
              [],
        );
      }).toList(),
    );
  }
}

class _PackageList extends StatelessWidget {
  final List<Package> packages;

  const _PackageList(this.packages);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: packages.map((package) {
        return _ListItem(
          title: package.packageName ?? '',
          onTap: () => Get.to(
                () => PackageDetailPage(),
            arguments: package.packageId,
            binding: CommonBinding(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
          ),
        );
      }).toList(),
    );
  }
}

class _MembershipList extends StatelessWidget {
  final List<Membership> memberships;

  const _MembershipList(this.memberships);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: memberships.map((membership) {
        return _ListItem(
          title: membership.membershipName ?? '',
          onTap: () => Get.to(
                () => MembersShipDetailsPage(onlyShow: false),
            arguments: membership.membershipId,
            binding: CommonBinding(),
            transition: Transition.fadeIn,
            duration: const Duration(milliseconds: 500),
          ),
        );
      }).toList(),
    );
  }
}

class _ListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final List<Widget> children;

  const _ListItem({
    required this.title,
    required this.onTap,
    this.children = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                  child:
                  Text(title, style: GoogleFonts.roboto(fontSize: 15.sp))),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios,
                    size: 16.sp, color: AppColor().blueColor),
                onPressed: onTap,
              ),
            ],
          ),
          ...children,
        ],
      ),
    );
  }
}

// ----------------- EMPTY & LOADING STATES -----------------
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(isLeading: true, title: "Learn More", action: []),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 40.sp, color: Colors.grey),
            SizedBox(height: 12.h),
            Text("No details available", style: TextStyle(fontSize: 18.sp)),
          ],
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor().background,
      appBar: commonAppBar(isLeading: true, title: "Learn More", action: []),
      body: Center(
          child: CircularProgressIndicator(color: AppColor.dynamicColor)),
    );
  }
}
