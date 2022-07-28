import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payout_history_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  withdrawMoney(String amount, String? note, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var selectedPayment =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .selectedPaymentId;

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var data = jsonEncode({
      'amount': amount,
      'payment_gateway': selectedPayment,
      'seller_note': note ?? ''
    });

    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();
      //if connection is ok
      var response = await http.post(
          Uri.parse('$baseApi/seller/payment-history/create'),
          headers: header,
          body: data);
      setLoadingFalse();
      notifyListeners();
      if (response.statusCode == 201) {
        OthersHelper().showToast('Ticket created successfully', Colors.black);

        Provider.of<PayoutHistoryService>(context, listen: false)
            .makePayoutHistoryListEmpty();

        Provider.of<PayoutHistoryService>(context, listen: false)
            .fetchPayoutHistory(context);

        Navigator.pop(context);
      } else if (response.statusCode == 404) {
        print(response.body);
        if (jsonDecode(response.body).containsKey('message')) {
          OthersHelper()
              .showToast(jsonDecode(response.body)['message'], Colors.black);
        }
      } else {
        print(response.body);
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }
}
