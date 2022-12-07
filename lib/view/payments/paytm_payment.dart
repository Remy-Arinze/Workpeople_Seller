// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/wallet_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaytmPayment extends StatefulWidget {
  const PaytmPayment({Key? key, required this.isFromWalletDeposite})
      : super(key: key);

  final isFromWalletDeposite;

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
    successUrl = 'https://paytm.com/';
    failedUrl = 'https://paytm.com/';
  }

  String? html;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Paytm')),
      body: WebView(
        onWebViewCreated: (controller) {
          _controller = controller;

          var paytmHtmlString = 'https://paytm.com/';

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
            if (widget.isFromWalletDeposite) {
              Provider.of<WalletService>(context, listen: false)
                  .makeDepositeToWalletSuccess(context);
            }

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
