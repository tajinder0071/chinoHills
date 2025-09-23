import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chino_hills/CSS/app_strings.dart';
import 'package:chino_hills/util/route_manager.dart';
import '../../../../CSS/color.dart';
import '../../../../Model/discover_model.dart';
import '../../../../Model/offer_detail_model.dart';
import '../../../../binding/cart_billing.dart';
import '../../../../common_Widgets/cacheNetworkImage.dart';
import '../../../../common_Widgets/common_button_widget.dart';
import '../../../../loading/become_a_member_loading.dart';
import '../../../../util/common_page.dart';
import '../../../Discover/controller/discover_controller.dart';
import '../../../cartList/Controller/cart_controller.dart';
import '../../../shop/Pages/Package Page/Widgets/package_detail_page.dart';
import '../../../shop/Pages/Treatment Page/widgets/treatment_details_page.dart';
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
            imageUrl: cardData.cloudUrl.toString(),
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
            onTap: () => cardData.callToAction == "Call Now"
                ? controller.callNumber(cardData.customUrl.toString())
                : controller.launchURL(cardData.customUrl!),
            isLoading: false,
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
                offer.description.toString(),
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
                offer.discountType.toString(),
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
                      if (offer.treatments?.isNotEmpty ?? false) ...[
                        _SectionTitle("Treatments"),
                        _TreatmentList(offer.treatments ?? []),
                      ],
                      if (offer.packages?.isNotEmpty ?? false) ...[
                        _SectionTitle("Packages"),
                        _PackageList(offer.packages ?? []),
                      ],
                      if (offer.memberships?.isNotEmpty ?? false) ...[
                        _SectionTitle("Memberships"),
                        _MembershipList(offer.memberships ?? []),
                      ],
                    ],
                  ),
                ),
            ],
          ),
          // bottomNavigationBar: controller.cartModel1.value.data == null || controller.cartModel1.value.data!.items!.isEmpty || controller.cartModel1.value.data!.cartId.toString() == "0" // ? SizedBox.shrink() :
          bottomNavigationBar: SafeArea(
            minimum: EdgeInsets.only(bottom: 8.h),
            child: _BottomButton(
                label: "Apply offer to cart",
                onTap: () => controller.selectPromoCode(
                  offer.promoCode,
                  0,
                  offer.id,
                  controller,
                  controller.cartModel1.value.data?.cartId ?? "",
                  onSuccess: () => _showSuccessBottomSheet(context, offer),
                ),
                isLoading: controller.isLoadingPromo),
          ),
        );
      },
    );
  }
}

void _showSuccessBottomSheet(BuildContext context, offer) {
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
          // Drag Handle
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(bottom: 20.h),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Success Icon with Animation
          Icon(
            Icons.local_offer_outlined,
            color: Colors.black,
            size: 35.sp,
          ),
          SizedBox(height: 16.h),

          // Success Title
          Text(
            "Offer Applied to cart!",
            style: GoogleFonts.merriweather(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20.h),

          // Applied Offer Details
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.green.shade700,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer.title?.toString().capitalize ?? '',
                        style: GoogleFonts.merriweather(
                          fontSize: 12.sp,
                          color: AppColor().blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "has been applied to your cart.",
                        style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: AppColor().mediumGreyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.verified,
                  color: Colors.green.shade700,
                  size: 20.sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Action Buttons
          Column(
            children: [
              CommonButtonWidget(
                onTap: () {
                  Get.offAndToNamed(RouteManager.cartList);
                },
                buttonName: 'Continue to cart',
              ),
              SizedBox(height: 16.h),
              TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(8),
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Get.offAllNamed(RouteManager.dashBoardPage, arguments: 2);
                  },
                  child: Text('Explore shop',
                      style: GoogleFonts.poppins(
                        color: AppColor.dynamicColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      )))
            ],
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 16.h),
        ],
      ),
    ),
  );
}

// ----------------- REUSABLE COMPONENTS -----------------
class _BottomButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const _BottomButton(
      {required this.label, required this.onTap, required this.isLoading});

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
        child: isLoading
            ? Center(
            child: CircularProgressIndicator(
              color: AppColor().whiteColor,
            ))
            : Text(
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
            Text(AppStrings.noDetail, style: TextStyle(fontSize: 18.sp)),
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
      body: MemberLoadDetail(),
    );
  }
}
