import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../CSS/color.dart';

class CommonPage {
  ///dev url
  var api = "https://devnima.scanacart.com/api/index.cfm?endpoint=";
  var api1 = "https://devnima.scanacart.com/apiV2/index.cfm?endpoint=";
  var image_url = "https://devnima.scanacart.com";
  var admin_image_url =
      "https://www.simpleimageresizer.com/_uploads/photos/075b19b4/";
  var membership_image_url =
      "https://devnima.scanacart.com/admin/appbuilder/home/uploads/";

  ///live url
  /*  var api = "https://api.nimawellness.com/api/index.cfm?endpoint=";
  var image_url = "https://api.nimawellness.com";
  var admin_image_url =
      "https://www.simpleimageresizer.com/_uploads/photos/075b19b4/";
  var membership_image_url =
      "https://devnima.scanacart.com/admin/appbuilder/home/uploads/";*/

  String stripePublishKey =
      'pk_test_51HKe0qK3vChkrzJEAmSYsZyefdkUvi2i7odGzj6R7syvHXazrMXwZmNJ9rSl9ULU3mMZIV8TfoAf3TJ2rWAMLACj00GZY4MneH';
  String stripeSicretKey =
      'sk_test_51HKe0qK3vChkrzJEeIPSwOX4taivnN4CnhNTs7ERpAVXpxKatNr4yGwqHyjMbeuQFI4uVIrMllfsgsznDvU7mWe4001mKakTQg';
}

getBrand() {
  return SizedBox(
    height: 20.h,
    child: Center(
      child: Text(
        'Powered by: Scanacart™ Technology',
        textAlign: TextAlign.center,
        style: GoogleFonts.cabin(
          color: AppColor().black80,
          fontWeight: FontWeight.w600,
          fontSize: 10.sp,
        ),
      ),
    ),
  );
}

commonAppBar({
  required bool isLeading,
  required String title,
  required List<Widget> action,
}) {
  return isLeading
      ? AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          leading: BackButton(),
          backgroundColor: AppColor().background,
          title: Text(
            title.toString(),
            style: GoogleFonts.sarabun(
              fontWeight: FontWeight.w700,
              fontSize: 17.sp,
            ),
          ),
          actions: action,
        )
      : AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          backgroundColor: AppColor().background,
          title: Text(
            title.toString(),
            style: GoogleFonts.sarabun(
              fontWeight: FontWeight.w700,
              fontSize: 17.sp,
            ),
          ),
          actions: action,
        );
}

class Debouncer {
  VoidCallback? action;
  Timer? _timer;

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: 500), action);
  }
}

String getTimeDifference(String endDateStr) {
  print("End Date String: $endDateStr");
  DateTime endDate = DateFormat(
    "MMMM, dd yyyy HH:mm:ss",
  ).parseStrict(endDateStr);
  DateTime now = DateTime.now();

  if (now.isAfter(endDate)) return "Today";

  int years = endDate.year - now.year;
  int months = endDate.month - now.month;
  int days = endDate.day - now.day;

  if (days < 0) {
    final previousMonth = DateTime(now.year, now.month, 0);
    days += previousMonth.day;
    months--;
  }

  if (months < 0) {
    months += 12;
    years--;
  }

  if (years >= 1) {
    return years == 1 ? "1 year" : "$years years";
  } else if (months >= 1) {
    return months == 1 ? "1 month" : "$months months";
  } else {
    return days == 1 ? "1 day" : "$days days";
  }
}

// TODO >> Getting the price with number format
String formatCurrency(dynamic price) {
  final num parsed = price is String
      ? double.tryParse(price) ?? 0.0
      : (price ?? 0);
  return NumberFormat.simpleCurrency().format(parsed);
}

// TODO >>
InlineSpan buildPriceTextSpan({
  required dynamic originalPrice,
  dynamic memberPrice,
  String? unit,
}) {
  // Helper to normalize values like "$235.00" → "235.00"
  String normalizePrice(dynamic value) {
    if (value == null) return "0.00";
    return value.toString().replaceAll("\$", "").replaceAll(",", "").trim();
  }

  final currencyOriginalPrice = formatCurrency(normalizePrice(originalPrice));
  final currencyMemberPrice = memberPrice != null
      ? formatCurrency(normalizePrice(memberPrice))
      : null;

  print("currencyMemberPrice $currencyMemberPrice");

  bool hasUnit = unit != null && unit.isNotEmpty;
  bool hasMember =
      (memberPrice != null &&
      (memberPrice is num
          ? memberPrice != 0
          : double.tryParse(normalizePrice(memberPrice)) != 0));

  String baseText = hasUnit
      ? "$currencyOriginalPrice/$unit"
      : "From $currencyOriginalPrice";
  String memberText = hasMember ? " | $currencyMemberPrice Member" : "";

  return TextSpan(
    children: [
      TextSpan(
        text: baseText,
        style: TextStyle(
          color: AppColor().black80, // base price in gray
          fontWeight: FontWeight.w500,
        ),
      ),
      if (hasMember)
        TextSpan(
          text: memberText,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
    ],
  );
}

bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final diagonal = sqrt(
    size.width * size.width + size.height * size.height,
  ); // Use sqrt here
  return diagonal > 1100.0; // Threshold for tablet detection
}

//common_Loader
Widget commonLoader({Color? color}) {
  return Center(
    child: SizedBox(
      height: 30.h,
      width: 30.w,
      child: CircularProgressIndicator(color: color, strokeWidth: 2.0),
    ),
  );
}
