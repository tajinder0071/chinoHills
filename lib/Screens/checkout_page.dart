import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:dio/dio.dart';
import 'package:chino_hills/common_Widgets/common_app_bar.dart';

import '../util/common_page.dart';

class CheckPage extends StatefulWidget {
  final String orderId;

  const CheckPage({super.key, required this.orderId});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  bool cardComplete = false;
  bool isLoading = false;

  // ✅ Create PaymentIntent (Server call)
  Future<String?> _createPaymentIntent(double amount) async {
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: {
          "amount": (amount * 100).round().toString(), // cents
          "currency": "usd",
          "payment_method_types[]": "card",
          "description": "Order ${widget.orderId}",
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer ${CommonPage().stripeSicretKey}",
          },
        ),
      );

      return response.data["client_secret"];
    } catch (e) {
      log(" PaymentIntent Error: $e");
      return null;
    }
  }

  // ✅ Confirm Payment without popup
  Future<void> _pay(double amount) async {
    try {
      setState(() => isLoading = true);

      // 1. Create PaymentIntent
      final clientSecret = await _createPaymentIntent(amount);
      if (clientSecret == null) return;

      // 2. Confirm payment with card form field
      final result = await Stripe.instance.confirmPayment(
        data: PaymentMethodParams.card(
          paymentMethodData: const PaymentMethodData(),
        ),
        paymentIntentClientSecret: clientSecret,
      );

      log("✅ Payment success: $result");
    } catch (e) {
      log("❌ Payment failed: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: "Checkout"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Embedded Card Form
            CardFormField(
              onCardChanged: (card) {
                setState(() {
                  cardComplete = card?.complete ?? false;
                });
              },
            ),

            const SizedBox(height: 20),

            // 🔹 Pay Button
            ElevatedButton(
              onPressed: cardComplete && !isLoading
                  ? () => _pay(866.12) // your order total
                  : null,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }
}
