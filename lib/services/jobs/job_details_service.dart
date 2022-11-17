import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer_seller/model/job_details_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobDetailsService with ChangeNotifier {
  //Fetch order details
  //=====================>

  bool loadingOrderDetails = false;

  setOrderDetailsLoadingStatus(bool status) {
    loadingOrderDetails = status;
    notifyListeners();
  }

  var jobDetails;

  fetchJobDetails(jobId, BuildContext context) async {
    //check internet connection
    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setOrderDetailsLoadingStatus(true);
      print('fun ran');

      var response = await http.get(
        Uri.parse('$baseApi/job/details/$jobId'),
        headers: header,
      );

      setOrderDetailsLoadingStatus(false);

      if (response.statusCode == 201) {
        final data = JobDetailsModel.fromJson(jsonDecode(response.body));

        jobDetails = data.jobDetails;

        notifyListeners();
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }
}
