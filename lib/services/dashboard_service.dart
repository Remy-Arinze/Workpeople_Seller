import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qixer_seller/model/dashboard_model.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'common_service.dart';

class DashboardService with ChangeNotifier {
  bool isloading = false;
  var dashboardDataList = [];
  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  fetchData() async {
    if (dashboardDataList.isNotEmpty) {
      //if data is already loaded. no need to load again
      return;
    }
    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      setLoadingTrue();

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json"
        "Authorization": "Bearer $token",
      };

      var response = await http
          .post(Uri.parse('$baseApi/seller/dashboard-info'), headers: header);

      setLoadingFalse();

      if (response.statusCode == 201) {
        var data = DashboardModel.fromJson(jsonDecode(response.body));

        dashboardDataList.add(data.pendingOrder);
        dashboardDataList.add(data.completedOrder);
        dashboardDataList.add(data.totalWithdrawnMoney);
        dashboardDataList.add(data.remainingBalance);

        notifyListeners();
      } else {
        print('error fetching dashboard data ${response.body}');
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }
}
