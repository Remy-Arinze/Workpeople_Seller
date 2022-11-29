// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payments_service/payment_details_service.dart';
import 'package:qixer_seller/services/payments_service/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StripeService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Map<String, dynamic>? paymentIntentData;

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) async {
        print('stripe payment successfull');

        Provider.of<PaymentService>(context, listen: false)
            .makePaymentSuccess(context);

        //payment successs ================>

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        debugPrint('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on StripeException {
      // print('Exception/DISPLAYPAYMENTSHEET==> $e');
      OthersHelper().showToast("Payment cancelled", Colors.red);
    } catch (e) {
      debugPrint('$e');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
    // return amount;
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency, context) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      // var header ={
      //       'Authorization':
      //           'Bearer sk_test_51GwS1SEmGOuJLTMs2vhSliTwAGkOt4fKJMBrxzTXeCJoLrRu8HFf4I0C5QuyE3l3bQHBJm3c0qFmeVjd0V9nFb6Z00VrWDJ9Uw',
      //       'Content-Type': 'application/x-www-form-urlencoded'
      //     };
      var header = {
        'Authorization':
            'Bearer ${Provider.of<PaymentGatewayListService>(context, listen: false).secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded'
      };
      // print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: header);
      // print('Create Intent reponse ===> ${response.body.toString()}');
      // debugPrint("response body is ${response.body}");
      return jsonDecode(response.body);
    } catch (err) {
      debugPrint('err charging user: ${err.toString()}');
    }
  }

  Future<void> makePayment(
    BuildContext context,
  ) async {
    var amount;

    String name;
    // String phone;
    // String email;
    // String orderId;

    var profileProvider = Provider.of<ProfileService>(context, listen: false);
    // var paymentProvider = Provider.of<PaymentService>(context, listen: false);
    var pdProvider = Provider.of<PaymentDetailsService>(context, listen: false);

    name = profileProvider.profileDetails.name ?? '';

    amount = pdProvider.totalAmount.toStringAsFixed(0);

    //Stripe takes only integer value

    try {
      paymentIntentData = await createPaymentIntent(amount, 'USD', context);
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.light,
                  merchantCountryCode: 'US',
                  merchantDisplayName: name))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(context);
    } catch (e, s) {
      debugPrint('exception:$e$s');
    }
  }

  //get stripe key ==========>

  Future<String> getStripeKey() async {
    var defaultPublicKey =
        'pk_test_51GwS1SEmGOuJLTMsIeYKFtfAT3o3Fc6IOC7wyFmmxA2FIFQ3ZigJ2z1s4ZOweKQKlhaQr1blTH9y6HR2PMjtq1Rx00vqE8LO0x';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var response = await http
        .post(Uri.parse('$baseApi/user/payment-gateway-list'), headers: header);
    print(response.statusCode);
    if (response.statusCode == 201) {
      var paymentList = jsonDecode(response.body)['gateway_list'];
      var publicKey;

      for (int i = 0; i < paymentList.length; i++) {
        if (paymentList[i]['name'] == 'stripe') {
          publicKey = paymentList[i]['public_key'];
        }
      }
      print('stripe public key is $publicKey');
      if (publicKey == null) {
        return defaultPublicKey;
      } else {
        return publicKey;
      }
    } else {
      //failed loading
      return defaultPublicKey;
    }
  }
}
