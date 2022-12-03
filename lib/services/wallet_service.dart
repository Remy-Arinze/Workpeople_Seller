import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer_seller/model/wallet_history_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletService with ChangeNotifier {
  var walletHistory;
  var walletBalance = '\$0.0';

  bool isloading = false;
  bool hasWalletHistory = true;

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  var amountToAdd;

  setAmount(v) {
    amountToAdd = v;
    notifyListeners();
  }

  Future<bool> depositeToWallet(BuildContext context) async {
    return true;
  }

  // Fetch subscription history
  fetchWalletHistory(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    setLoadingStatus(true);

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response = await http.get(Uri.parse('$baseApi/user/wallet/history'),
        headers: header);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 200 && decodedData['history'].isNotEmpty) {
      final data = WalletHistoryModel.fromJson(jsonDecode(response.body));
      walletHistory = data.history;
      notifyListeners();
    } else {
      print('Error fetching wallet history' + response.body);

      hasWalletHistory = false;
      notifyListeners();
    }
  }

  // Fetch wallet balance
  // ==============>
  fetchWalletBalance(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    setLoadingStatus(true);

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response = await http.get(Uri.parse('$baseApi/user/wallet/balance'),
        headers: header);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      walletBalance = decodedData['balance'];
      notifyListeners();
    } else {
      print('Error fetching wallet balance' + response.body);

      notifyListeners();
    }
  }

  //=============>
  // ============>

  Future<bool> validate(BuildContext context, isFromDepositeToWallet) async {
    if (isFromDepositeToWallet && amountToAdd == null) {
      OthersHelper().showToast('You must enter an amount', Colors.black);
      return false;
    }
    if (isFromDepositeToWallet && double.tryParse(amountToAdd) == null) {
      // user entered non integer value
      OthersHelper().showToast('Please enter a valid amount', Colors.black);
      return false;
    }
    return true;
  }
}
