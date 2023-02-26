import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer_seller/model/job_details_model.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/services/push_notification_service.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';
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

  // ===========>
  //================>
  bool applyLoading = false;

  setApplyLoadingStatus(bool status) {
    applyLoading = status;
    notifyListeners();
  }

  applyToJob(BuildContext context,
      {required buyerId,
      required jobPostId,
      required offerPrice,
      required coverLetter,
      required jobPrice}) async {
    var connection = await checkConnection();
    if (!connection) return;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var userId = prefs.getInt('userId');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    setApplyLoadingStatus(true);
    var data = jsonEncode({
      'buyer_id': buyerId,
      'seller_id': userId,
      'job_post_id': jobPostId,
      'expected_salary': offerPrice,
      'cover_letter': coverLetter,
      'job_price': jobPrice
    });

    var response = await http.post(Uri.parse('$baseApi/job/apply/new-job'),
        headers: header, body: data);

    setApplyLoadingStatus(false);
    print(response.body);

    final decodedData = jsonDecode(response.body);

    Navigator.pop(context);

    if (response.statusCode == 201) {
      OthersHelper().showToast('Successfully applied', Colors.black);
      sendNotificationInJobRequest(context, buyerId: buyerId);
    } else {
      print(response.body);

      if (decodedData.containsKey('msg')) {
        OthersHelper().showToast(decodedData['msg'], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }

  //send notification
  //============>

  sendNotificationInJobRequest(BuildContext context, {required buyerId}) {
    //Send notification to seller
    var username = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .name ??
        '';
    PushNotificationService().sendNotificationToBuyer(context,
        buyerId: buyerId, title: "New job request from $username", body: '');
  }
}
