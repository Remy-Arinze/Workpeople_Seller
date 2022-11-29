import 'dart:convert';
import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payments_service/payment_details_service.dart';
import 'package:qixer_seller/services/payments_service/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';

class CashfreeService {
  getTokenAndPay(BuildContext context) async {
    //========>

    String amount;

    String name;
    String phone;
    String email;
    String orderId;

    var profileProvider = Provider.of<ProfileService>(context, listen: false);
    var paymentProvider = Provider.of<PaymentService>(context, listen: false);
    var pdProvider = Provider.of<PaymentDetailsService>(context, listen: false);

    orderId = paymentProvider.orderId;

    name = profileProvider.profileDetails.name ?? '';
    phone = profileProvider.profileDetails.phone ?? '';
    email = profileProvider.profileDetails.email ?? '';

    amount = pdProvider.totalAmount.toStringAsFixed(2);

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      'x-client-id':
          Provider.of<PaymentGatewayListService>(context, listen: false)
              .publicKey
              .toString(),
      'x-client-secret':
          Provider.of<PaymentGatewayListService>(context, listen: false)
              .secretKey
              .toString(),
      "Content-Type": "application/json"
    };

    String orderCurrency = "INR";
    var data = jsonEncode({
      'orderId': orderId,
      'orderAmount': amount,
      'orderCurrency': orderCurrency
    });

    var response = await http.post(
      Uri.parse(
          'https://test.cashfree.com/api/v2/cftoken/order'), // change url to https://api.cashfree.com/api/v2/cftoken/order when in production
      body: data,
      headers: header,
    );
    print(response.body);

    Provider.of<PaymentService>(context, listen: false).setLoadingFalse();

    if (jsonDecode(response.body)['status'] == "OK") {
      cashFreePay(jsonDecode(response.body)['cftoken'], orderId, orderCurrency,
          context, amount, name, phone, email);
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
    // if()
  }

  cashFreePay(token, orderId, orderCurrency, BuildContext context, amount, name,
      phone, email) {
    //Replace with actual values
    //has to be unique every time
    String stage = "TEST"; // PROD when in production mode// TEST when in test

    String tokenData = token; //generate token data from server

    String appId = "94527832f47d6e74fa6ca5e3c72549";

    String notifyUrl = "";

    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": amount,
      "customerName": name,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": phone,
      "customerEmail": email,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl
    };

    CashfreePGSDK.doPayment(
      inputParams,
    ).then((value) {
      print('cashfree payment result $value');
      if (value != null) {
        if (value['txStatus'] == "SUCCESS") {
          print('Cashfree Payment successfull. Do something here');

          Provider.of<PaymentService>(context, listen: false)
              .makePaymentSuccess(context);
        }
      }
    });
  }
}
