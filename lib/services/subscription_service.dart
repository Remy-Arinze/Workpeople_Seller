import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer_seller/model/subscription_history_model.dart';
import 'package:qixer_seller/model/subscription_info_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SubscriptionService with ChangeNotifier {
  var subsData;

  List subsHistoryList = [];

  bool hasSubsHistory = true;
  bool isloading = false;

  setLoadingStatus(bool status) {
    isloading = status;
    notifyListeners();
  }

  fetchSubscriptionData(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return;

    if (subsData != null) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    setLoadingStatus(true);

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response = await http
        .get(Uri.parse('$baseApi/seller/subscription/info'), headers: header);

    if (response.statusCode == 201) {
      final data = SubscriptionInfoModel.fromJson(jsonDecode(response.body));
      subsData = data.subscriptionInfo;
      notifyListeners();
    } else {
      print('Error fetching subscription data' + response.body);

      notifyListeners();
    }
  }

  // Fetch subscription history
  fetchSubscriptionHistory(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return;

    if (subsHistoryList.isNotEmpty) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    setLoadingStatus(true);

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
        Uri.parse('$baseApi/seller/subscription/history'),
        headers: header);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201 &&
        decodedData['subscription_history'].isNotEmpty) {
      final data = SubscriptionHistoryModel.fromJson(jsonDecode(response.body));
      subsHistoryList = data.subscriptionHistory;
      notifyListeners();
    } else {
      print('Error fetching subscription history' + response.body);

      hasSubsHistory = false;
      notifyListeners();
    }
  }
}
