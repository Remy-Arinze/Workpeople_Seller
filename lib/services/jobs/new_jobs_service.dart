import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:qixer_seller/model/new_jobs_list_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewJobsService with ChangeNotifier {
  var newJobsList = [];

  bool isLoading = true;

  late int totalPages;

  int currentPage = 1;

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
    notifyListeners();
  }

  fetchNewJobs(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      newJobsList = [];
      notifyListeners();

      Provider.of<NewJobsService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {}

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setLoadingStatus(true);

      var response = await http.get(
          Uri.parse("$baseApi/seller/job/job-lists?page=$currentPage"),
          headers: header);

      setLoadingStatus(false);

      final decodedData = jsonDecode(response.body);

      print(response.body);

      if (response.statusCode == 201 &&
          decodedData['jobs']['data'].isNotEmpty) {
        var data = NewJobsListModel.fromJson(decodedData);

        setTotalPage(data.jobs.lastPage);

        if (isrefresh) {
          print('refresh true');
          //if refreshed, then remove all service from list and insert new data
          setServiceList(data.jobs.data, false);
        } else {
          print('add new data');

          //else add new data
          setServiceList(data.jobs.data, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        print('error fetching new jobs ${response.body}');
        return false;
      }
    }
  }

  setServiceList(dataList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      newJobsList = [];
      notifyListeners();
    }

    for (int i = 0; i < dataList.length; i++) {
      newJobsList.add(dataList[i]);
    }

    notifyListeners();
  }
}
