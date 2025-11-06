import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../CSS/appTypography.dart';
import '../CSS/color.dart';

class CommonPage {
  ///dev url
  /*var api = "https://devnima.scanacart.com/api/index.cfm?endpoint=";
  var api1 = "https://devnima.scanacart.com/apiV2/index.cfm?endpoint=";
  var image_url = "https://devnima.scanacart.com";*/
  ///live url
  var api = "https://nimawellness.com/api/index.cfm?endpoint=";
  var api1 = "https://nimawellness.com/apiv2/index.cfm?endpoint=";
  var image_url = "https://nimawellness.com";
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
        'Powered by: Birdhaus™ Technology',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'host-grotesk',
          color: AppColor().black80,
          fontSize: 10.sp,
        ),
      ),
    ),
  );
}

// commonAppBar(
//     BuildContext context,
//     {required bool isLeading,
//     required String title,
//     required List<Widget> action}) {
//   return isLeading
//       ? AppBar(
//     centerTitle: true,
//           scrolledUnderElevation: 0.0,
//           elevation: 0,
//           leading: Transform.scale(
//             scale: 0.6, // Makes the button 1.5x larger
//             child: InkWell(
//               onTap: () =>
//                   Navigator.pop(context),
//               child: Container(
//                 height: 30.w,
//                 width: 30.w,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color:
//                   AppColor.dynamicColor,
//                 ),
//                 child: Icon(
//                   Icons
//                       .arrow_back_ios_new_rounded,
//                   color:
//                   AppColor().whiteColor,
//                   size: 15.h,
//                 ),
//               ),
//             ),
//           ),
//           backgroundColor: AppColor().background,
//           title: Text(
//             title.toString(),
//             style: GoogleFonts.sarabun(
//                 fontWeight: FontWeight.w700,
//                 fontSize: 18.sp,
//               color: Colors.black.withOpacity(0.65)
//             ),
//           ),
//           actions: action,
//         )
//       : AppBar(
//           scrolledUnderElevation: 0.0,
//           elevation: 0,
//           backgroundColor: AppColor().background,
//           title: Text(
//             title.toString(),
//             style: GoogleFonts.sarabun(
//               fontWeight: FontWeight.w700,
//               fontSize: 18.sp,
//               color: Colors.black.withOpacity(0.65),)
//           ),
//           actions: action,
//         );
// }

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
  DateTime endDate =
      DateFormat("MMMM, dd yyyy HH:mm:ss").parseStrict(endDateStr);
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
  if (price == null) return '\$0'; // or any default currency

  final num parsed = num.tryParse(price.toString()) ?? 0;

  if (parsed % 1 == 0) {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 0).format(parsed);
  } else {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(parsed);
  }
}

// TODO >>
InlineSpan buildPriceTextSpan({
  required dynamic originalPrice,
  dynamic memberPrice,
  required bool isPackage,
  String? unit,
}) {
  // Helper to normalize values like "$235.00" → "235.00"
  String normalizePrice(dynamic value) {
    if (value == null) return "0";
    return value.toString().replaceAll("\$", "").replaceAll(",", "").trim();
  }

  // Format number with $ and dynamic decimals
  String formatCurrency(dynamic price) {
    final num parsed = num.tryParse(price.toString()) ?? 0;

    if (parsed % 1 == 0) {
      // Integer
      return NumberFormat.currency(symbol: '\$', decimalDigits: 0)
          .format(parsed);
    } else {
      // Decimal
      return NumberFormat.currency(symbol: '\$', decimalDigits: 2)
          .format(parsed);
    }
  }

  final currencyOriginalPrice = formatCurrency(normalizePrice(originalPrice));
  final currencyMemberPrice =
  memberPrice != null ? formatCurrency(normalizePrice(memberPrice)) : null;

  bool hasUnit = unit != null && unit.isNotEmpty;
  bool hasMember = (memberPrice != null &&
      (memberPrice is num
          ? memberPrice != 0
          : double.tryParse(normalizePrice(memberPrice)) != 0));

  // Base price line
  String baseText =
  hasUnit ? "$currencyOriginalPrice/$unit" : "From $currencyOriginalPrice";

  // If it's a package, show member price on new line — otherwise inline
  String separator = isPackage == true ? "\n" : " | ";

  // Member text formatting
  String memberText = hasMember ? "$separator$currencyMemberPrice Member" : "";

  return TextSpan(
    children: [
      TextSpan(
        text: baseText,
        style: GoogleFonts.sarabun(
          color: isPackage? Colors.black.withValues(alpha: 0.65) : Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
          height: 1.4,
        ),
      ),
      if (hasMember)
        TextSpan(
          text: memberText,
          style: GoogleFonts.sarabun(
            color: isPackage? Colors.black.withValues(alpha: 0.65) : Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            height: 1.4,
          ),
        ),
    ],
  );
}



Column buildPriceTextSpanColumn(
    {required dynamic originalPrice, dynamic memberPrice, String? unit}) {
  // Helper to normalize values like "$235.00" → "235.00"
  String normalizePrice(dynamic value) {
    if (value == null) return "0";
    return value.toString().replaceAll("\$", "").replaceAll(",", "").trim();
  }

  // Format number with $ and dynamic decimals
  String formatCurrency(dynamic price) {
    final num parsed = num.tryParse(price.toString()) ?? 0;

    if (parsed % 1 == 0) {
      // Integer
      return NumberFormat.currency(symbol: '\$', decimalDigits: 0)
          .format(parsed);
    } else {
      // Decimal
      return NumberFormat.currency(symbol: '\$', decimalDigits: 2)
          .format(parsed);
    }
  }

  final currencyOriginalPrice = formatCurrency(normalizePrice(originalPrice));
  final currencyMemberPrice =
  memberPrice != null ? formatCurrency(normalizePrice(memberPrice)) : null;

  bool hasUnit = unit != null && unit.isNotEmpty;
  bool hasMember = (memberPrice != null &&
      (memberPrice is num
          ? memberPrice != 0
          : double.tryParse(normalizePrice(memberPrice)) != 0));

  String baseText =
  hasUnit ? "$currencyOriginalPrice/$unit" : "From $currencyOriginalPrice";
  String memberText = hasMember ? "$currencyMemberPrice /Member" : "";

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        baseText.toString().replaceAll(" ", ""),
        style: AppTypography.hostGroteskRegular.copyWith(
          color: AppColor().whiteColor,
          fontSize: 18.sp,
        ),
      ),
      if (hasMember)
        Text(
          memberText,
          style: AppTypography.hostGroteskRegular.copyWith(
            color: AppColor().whiteColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
    ],
  );
}

bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final diagonal = sqrt(
      size.width * size.width + size.height * size.height); // Use sqrt here
  return diagonal > 1100.0; // Threshold for tablet detection
}

//common_Loader
Widget commonLoader({Color? color}) {
  return Center(
    child: SizedBox(
      height: 30.h,
      width: 30.w,
      child: CircularProgressIndicator(
        color: color,
        strokeWidth: 2.0,
      ),
    ),
  );
}
