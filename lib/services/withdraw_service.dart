import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/dashboard_service.dart';
import 'package:qixer_seller/services/payments_service/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payout_history_service.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawService with ChangeNotifier {
  bool isloading = false;

  int minAmount = 50;
  int maxAmount = 250;

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

        //fetch dashboard data again
        Provider.of<DashboardService>(context, listen: false)
            .fetchData(fetchAgain: true);

        Navigator.pop(context);
      } else if (response.statusCode == 404) {
        if (jsonDecode(response.body).containsKey('message')) {
          OthersHelper()
              .showToast(jsonDecode(response.body)['message'], Colors.black);
        }
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

//====================>
  getMinMaxAmount(BuildContext context) async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.get(
        Uri.parse('$baseApi/amount-settings'),
        headers: header,
      );

      if (response.statusCode == 201) {
        minAmount = jsonDecode(response.body)['amount_settings']['min_amount'];
        maxAmount = jsonDecode(response.body)['amount_settings']['max_amount'];
        notifyListeners();
      } else {
        //error fetching min max amount
        print('error fetching min and max amount' + response.body);
      }
    }
  }

  // =================>
  //gateway list for withdraw
  // =============>

  var paymentDropdownList = [];
  var paymentDropdownIndexList = [];
  var selectedPayment;
  var selectedPaymentId;

  setgatewayValue(value) {
    selectedPayment = value;
    notifyListeners();
  }

  setSelectedgatewayId(value) {
    selectedPaymentId = value;
    notifyListeners();
  }

  Future fetchGatewayList() async {
    //if payment list already loaded, then don't load again
    if (paymentDropdownList.isNotEmpty) {
      return;
    }

    var connection = await checkConnection();
    if (connection) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(
          Uri.parse('$baseApi/user/payment-gateway-list'),
          headers: header);

      if (response.statusCode == 201) {
        var gatewayList = jsonDecode(response.body)['gateway_list'];
        for (int i = 0; i < gatewayList.length; i++) {
          paymentDropdownList.add(removeUnderscore(gatewayList[i]['name']));
          paymentDropdownIndexList.add(gatewayList[i]['name']);
        }
        selectedPayment = removeUnderscore(gatewayList[0]['name']);
        selectedPaymentId = gatewayList[0]['name'];
        notifyListeners();
      } else {
        //something went wrong
        print('payment gateway list fetching error' + response.body);
      }
    } else {
      //internet off
      return false;
    }
  }
}
