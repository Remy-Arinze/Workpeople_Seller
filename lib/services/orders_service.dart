import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer_seller/model/orders_list_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersService with ChangeNotifier {
  var allOrdersList = [];

  late int totalPages;
  int currentPage = 1;

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  fetchAllOrders(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      allOrdersList = [];

      notifyListeners();

      Provider.of<OrdersService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {}

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
      var response = await http.post(
          Uri.parse("$baseApi/seller/my-orders?page=$currentPage"),
          headers: header);

      if (response.statusCode == 201 &&
          jsonDecode(response.body)['my_orders']['data'].isNotEmpty) {
        var data = AllOrdersModel.fromJson(jsonDecode(response.body));

        setTotalPage(data.myOrders.lastPage);

        if (isrefresh) {
          print('refresh true');
          //if refreshed, then remove all service from list and insert new data
          //make the list empty first so that existing data doesn't stay
          setServiceList(data.myOrders.data, false);
        } else {
          print('add new data');

          //else add new data
          setServiceList(data.myOrders.data, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        print(response.body);
        return false;
      }
    }
  }

  setServiceList(dataList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      allOrdersList = [];
      notifyListeners();
    }

    for (int i = 0; i < dataList.length; i++) {
      allOrdersList.add(dataList[i]);
    }

    notifyListeners();
  }

  // request buyer to mark order complete
  // =====================>

  bool markLoading = false;

  setMarkLoadingStatus(bool status) {
    markLoading = status;
    notifyListeners();
  }

  requestToComplete(BuildContext context, {required orderId}) async {
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
    if (!connection) return;

    setMarkLoadingStatus(true);

    var data = jsonEncode({'status': 2, 'order_id': orderId});

    var response = await http.post(
        Uri.parse('$baseApi/seller/my-orders/status/complete/request'),
        headers: header,
        body: data);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      // await Provider.of<OrderDetailsService>(context, listen: false)
      //     .fetchOrderDetails(orderId, context);

      setMarkLoadingStatus(false);

      OthersHelper().showToast(decodedData['msg'], Colors.black);
    } else {
      setMarkLoadingStatus(false);

      if (decodedData.containsKey('msg')) {
        OthersHelper().showToast(decodedData['msg'], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  //make payment status complete
  // ==============>

  bool payLoadingStatus = false;

  setPayLoadingStatus(bool status) {
    payLoadingStatus = status;
    notifyListeners();
  }

  makePaymentStatusComplete(BuildContext context, {required orderId}) async {
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
    if (!connection) return;

    setPayLoadingStatus(true);

    var data = jsonEncode({'id': orderId});

    var response = await http.post(
        Uri.parse('$baseApi/seller/my-orders/order/change-payment-status'),
        headers: header,
        body: data);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      await Provider.of<OrderDetailsService>(context, listen: false)
          .fetchOrderDetails(orderId, context);

      setPayLoadingStatus(false);

      Navigator.pop(context);

      OthersHelper().showToast(decodedData['msg'], Colors.black);
    } else {
      setPayLoadingStatus(false);

      if (decodedData.containsKey('msg')) {
        OthersHelper().showToast(decodedData['msg'], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  // decline history
  // =====================>

  var declineHistory;

  bool loadingDeclineHistory = false;

  setLoadingDeclineHistoryStatus(bool status) {
    loadingDeclineHistory = status;
    notifyListeners();
  }

  fetchDeclineHistory(BuildContext context, {required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      // "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setLoadingDeclineHistoryStatus(true);

    var response = await http.get(
      Uri.parse(
          '$baseApi/seller/my-orders/order/request/complete/decline/history?order_id=$orderId'),
      headers: header,
    );

    setLoadingDeclineHistoryStatus(false);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      declineHistory = decodedData;
      notifyListeners();
    } else {
      //error

      declineHistory = null;
      notifyListeners();
    }
  }
}
