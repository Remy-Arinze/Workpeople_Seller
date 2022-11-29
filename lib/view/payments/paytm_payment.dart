// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaytmPayment extends StatefulWidget {
  const PaytmPayment({Key? key}) : super(key: key);

  @override
  State<PaytmPayment> createState() => _PaytmPaymentState();
}

class _PaytmPaymentState extends State<PaytmPayment> {
  WebViewController? _controller;
  var successUrl;
  var failedUrl;

  @override
  void initState() {
    super.initState();
    successUrl = Provider.of<PaymentService>(context, listen: false).successUrl;
    failedUrl = Provider.of<PaymentService>(context, listen: false).cancelUrl;
  }

  String? html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paytm')),
      body: WebView(
        onWebViewCreated: (controller) {
          _controller = controller;

          var paytmHtmlString =
              Provider.of<PaymentService>(context, listen: false).paytmHtmlForm
                  as String;

          controller.loadHtmlString(paytmHtmlString);
        },
        initialUrl: "url",
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (NavigationRequest request) async {
          print('current url is ${request.url}');
          print('success url is $successUrl');
          print('failed url is $failedUrl');
          if (request.url.contains(successUrl)) {
            //if payment is success, then the page is refreshing twice.
            //which is causing the screen pop twice.
            //So, this alreadySuccess = true trick will prevent that

            print('payment success');

            await Provider.of<PaymentService>(context, listen: false)
                .makePaymentSuccess(context);

            return NavigationDecision.prevent;
          }
          if (request.url.contains('order-cancel-static')) {
            print('payment failed');
            OthersHelper().showSnackBar(context, 'Payment failed', Colors.red);
            Navigator.pop(context);

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
