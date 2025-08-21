import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import '../../../util/common_page.dart';

class ShoppingCartController extends GetxController {
  //payment method
  Future<void> makePayment(int amount) async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(10, 'INR');
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'NIMA',


      ));
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Pay Success");
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> map = {
        "amount": _calculateAmount(amount),
        "currency": currency,
        'payment_method_types[]': 'card',
        'description': 'FLUTTER STRIPE DEMO',
        'statement_descriptor': 'FLUTTER STRIPE DEMO',
        'shipping': {
          'name': 'Tajinder Pal', // Replace with actual customer name
          'address': {
            'line1': '123 Street Name',
            'line2': 'Sector 70',
            'city': 'Mohali',
            'state': 'Punjab',
            'postal_code': '160055', // Correct Mohali PIN code
            'country': 'IN'
          }
        },
      };
      var responase = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: map,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${CommonPage().stripeSicretKey}",
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
      );
      if (responase.data != null) {
        print(responase.data);
        return responase.data['client_secret'];
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
