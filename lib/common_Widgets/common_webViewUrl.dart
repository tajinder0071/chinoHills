import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:chino_hills/CSS/appTypography.dart';
import 'package:chino_hills/CSS/color.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Screens/cartList/widgets/success_paymnet_widget.dart';
import '../Screens/checkout_page/Widgets/cancel_payment_popup.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, required this.title});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          // ✅ Step 1: URL check
          onNavigationRequest: (NavigationRequest request) {
            debugPrint("Navigating to: ${request.url}");

            if (request.url.contains("payment/success")) {
              Navigator.pop(context, true);
              showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (context) => PaymentSuccessPopup(
                  transactionId: "123",
                  transactionType: "Test",
                ),
              );

              return NavigationDecision.prevent;
            }
            if (request.url.contains("payment/failed")) {
              Navigator.pop(context, false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },

          // ✅ Step 2 + 3: Title & Content check
          onPageFinished: (String url) async {
            debugPrint("Page loaded: $url");

            // Page title check
            String? title = await _controller.getTitle();
            debugPrint("Page: $title");

            if (title != null &&
                title.toLowerCase().contains("payment successful")) {
              Navigator.pop(context, true);
              showDialog(
                context: Get.context!,
                barrierDismissible: false,
                builder: (context) => PaymentSuccessPopup(
                  transactionId: "123",
                  transactionType: "Test",
                ),
              );
              return;
            }
            if (title != null &&
                title.toLowerCase().contains("payment failed")) {
              Navigator.pop(context, false);
              return;
            }

            // Page content check (HTML body text)
            try {
              var html = await _controller.runJavaScriptReturningResult(
                "document.body.innerText",
              );

              String bodyText = html.toString().toLowerCase();
              debugPrint("Page Content: $bodyText");

              if (bodyText.contains("payment done") ||
                  bodyText.contains("transaction successful") ||
                  bodyText.contains("success")) {
                final parsedJson = jsonDecode(bodyText);
                if (parsedJson is Map && parsedJson['success'] == false) {
                  // Show cancel payment popup
                  Navigator.pop(context, false);
                  showDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (context) => CancelPaymentPopup(),
                  );
                } else {
                  Navigator.pop(context, true);
                  final regex = RegExp(r'"transaction_id"\s*:\s*"([^"]+)"');
                  final match = regex.firstMatch(bodyText);
                  print(match);
                  String? transactionId;
                  if (match != null) {
                    transactionId = match.group(1); // TXN123456
                  }

                  showDialog(
                    context: Get.context!,
                    barrierDismissible: false,
                    builder: (context) => PaymentSuccessPopup(
                      transactionId: transactionId ?? "Unknown",
                      transactionType: "success",
                    ),
                  );
                }
              } else if (bodyText.contains("payment failed") ||
                  bodyText.contains("declined") ||
                  bodyText.contains("error") ||
                  bodyText.contains("no cart found")) {
                Navigator.pop(context, false);
              }
            } catch (e) {
              debugPrint("Error reading page content: $e");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor().whiteColor,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
            ),
          ),
          title: Text(
            widget.title,
            style: AppTypography.hostGroteskSemiBold.copyWith(fontSize: 15.sp),
          )),
      body: WebViewWidget(controller: _controller),
    );
  }
}
