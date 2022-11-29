// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:qixer_seller/services/payments_service/payment_details_service.dart';
import 'package:qixer_seller/services/payments_service/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MercadopagoPaymentPage extends StatefulWidget {
  const MercadopagoPaymentPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MercadopagoPaymentPage> createState() => _MercadopagoPaymentPageState();
}

class _MercadopagoPaymentPageState extends State<MercadopagoPaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  late String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mercado pago')),
      body: FutureBuilder(
          future: getPaymentUrl(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              return const Center(
                child: Text('Loding failed.'),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
              return const Center(
                child: Text('Loding failed.'),
              );
            }
            return WebView(
              onWebResourceError: (error) => showDialog(
                  context: context,
                  builder: (ctx) {
                    return const AlertDialog(
                      title: Text('Loading failed!'),
                      content: Text('Failed to load payment page.'),
                      actions: [
                        Spacer(),
                      ],
                    );
                  }),
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.contains('https://www.google.com/')) {
                  print('payment success');
                  await Provider.of<PaymentService>(context, listen: false)
                      .makePaymentSuccess(context);

                  return NavigationDecision.prevent;
                }
                if (request.url.contains('https://www.facebook.com/')) {
                  print('payment failed');
                  OthersHelper()
                      .showSnackBar(context, 'Payment failed', Colors.red);
                  Navigator.pop(context);

                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
            );
          }),
    );
  }

  Future<dynamic> getPaymentUrl(BuildContext context) async {
    var amount;

    String orderId;
    String email;

    var profileProvider = Provider.of<ProfileService>(context, listen: false);
    var paymentProvider = Provider.of<PaymentService>(context, listen: false);
    var pdProvider = Provider.of<PaymentDetailsService>(context, listen: false);

    amount = pdProvider.totalAmount;

    orderId = paymentProvider.orderId;

    email = profileProvider.profileDetails.email ?? '';

    String mercadoKey =
        Provider.of<PaymentGatewayListService>(context, listen: false)
                .secretKey ??
            '';

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    var data = jsonEncode({
      "items": [
        {
          "title": "Qixer",
          "description": "Qixer payment",
          "quantity": 1,
          "currency_id": "ARS",
          "unit_price": amount
        }
      ],
      'back_urls': {
        "success": 'https://www.google.com/',
        "failure": 'https://www.facebook.com',
        "pending": 'https://www.facebook.com'
      },
      'auto_return': 'approved',
      "payer": {"email": email}
    });

    var response = await http.post(
        Uri.parse(
            'https://api.mercadopago.com/checkout/preferences?access_token=$mercadoKey'),
        headers: header,
        body: data);

    print(response.body);

    // print(response.body);
    if (response.statusCode == 201) {
      url = jsonDecode(response.body)['init_point'];

      return;
    }
    return '';
  }
}
