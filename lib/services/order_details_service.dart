// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    print('order id $orderId');

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

  //Add order extra
  addOrderExtra(BuildContext context,
      {required orderId,
      required title,
      required price,
      required quantity}) async {
    //check internet connection
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      //internet off
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
      return false;
    } else {
      //get user id
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      //internet connection is on
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };
      var data = jsonEncode({
        'order_id': orderId,
        'title': title,
        'price': price,
        'quantity': quantity
      });

      print(data);
      setLoadingTrue();

      var response = await http.post(
          Uri.parse('$baseApi/seller/order/extra-service/add'),
          headers: header,
          body: data);

      setLoadingFalse();

      final responseDecoded = jsonDecode(response.body);

      if (response.statusCode == 201 &&
          responseDecoded.containsKey("extra_service")) {
        Provider.of<OrderDetailsService>(context, listen: false)
            .fetchOrderDetails(orderId);

        Navigator.pop(context);
      } else {
        print(response.body);
        OthersHelper()
            .showToast(jsonDecode(response.body)['message'], Colors.black);
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
