// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer_seller/model/order_details_model.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'common_service.dart';

class OrderDetailsService with ChangeNotifier {
  var orderDetails;
  var orderStatus;

  var orderedServiceTitle;

  bool isLoading = true;

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  fetchOrderDetails(orderId) async {
    setLoadingTrue();
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.post(
          Uri.parse('$baseApi/seller/my-orders/$orderId'),
          headers: header);
      setLoadingFalse();
      if (response.statusCode == 201) {
        var data = OrderDetailsModel.fromJson(jsonDecode(response.body));

        orderDetails = data.orderInfo;
        orderedServiceTitle =
            jsonDecode(response.body)['orderInfo']['service']['title'];

        var status = data.orderInfo.status;
        orderStatus = getOrderStatus(status ?? -1);
      } else {
        //Something went wrong
        print('error fetching order details ' + response.body);
        orderDetails = 'error';
        notifyListeners();
      }
    }
  }

  getOrderStatus(int status) {
    if (status == 0) {
      return 'Pending';
    } else if (status == 1) {
      return 'Active';
    } else if (status == 2) {
      return "Completed";
    } else if (status == 3) {
      return "Delivered";
    } else if (status == 4) {
      return 'Cancelled';
    } else {
      return 'Unknown';
    }
  }
}
