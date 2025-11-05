import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

class CheckoutForm extends StatelessWidget {
  const CheckoutForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional text
            Text(
              "Optional",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              "Save my information for faster checkout",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            // Email
            TextFormField(
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            // Phone with country code
            IntlPhoneField(
              decoration: InputDecoration(
                labelText: "Phone number",
                border: OutlineInputBorder(),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                print(phone.completeNumber);
              },
            ),
            const SizedBox(height: 16),
            // First and last name
            TextFormField(
              decoration: InputDecoration(
                labelText: "First and last name",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16),
            // Terms text
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black87, fontSize: 12),
                children: [
                  const TextSpan(
                      text:
                          "👉 By providing phone number and email, you agree to create an account subject to "),
                  TextSpan(
                    text: "Terms",
                    style: TextStyle(color: Colors.blue),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(color: Colors.blue),
                  ),
                  const TextSpan(text: "."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
