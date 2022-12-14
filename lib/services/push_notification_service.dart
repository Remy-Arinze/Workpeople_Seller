import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushNotificationService with ChangeNotifier {
  bool pusherCredentialLoaded = false;

  //get pusher credential
  //======================>

  var apiKey;
  var secret;
  var pusherToken;
  var pusherApiUrl;

  fetchPusherCredential(BuildContext context) async {
    var connection = await checkConnection();
    if (!connection) return;
    if (pusherCredentialLoaded == true) return;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      // "Content-Type": "application/json"
      "Authorization": "Bearer $token",
    };

    var response = await http.get(
        Uri.parse("$baseApi/user/chat/pusher/credentials"),
        headers: header);

    print(response.body);

    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      pusherCredentialLoaded = true;
      apiKey = jsonData['pusher_app_key'];
      secret = jsonData['pusher_app_secret'];
      pusherToken = jsonData['pusher_app_push_notification_auth_token'];
      pusherApiUrl = jsonData['pusher_app_push_notification_auth_url'];

      notifyListeners();
    } else {
      print(response.body);
    }
  }

  sendNotification(BuildContext context, {required buyerId, required msg}) {
    //Send notification to seller
    var username = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .userDetails
            .name ??
        '';
    sendNotificationToBuyer(context,
        buyerId: buyerId, title: "New chat message: $username", body: '$msg');
  }

  sendNotificationToBuyer(BuildContext context,
      {required buyerId, required title, required body}) async {
    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      // "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
          "Bearer 0C764A214C6154535DB891CBD5640012FB5F4B997242314371798110916EAFCD",
    };

    var data = jsonEncode({
      "interests": ["debug-buyer$buyerId"],
      "fcm": {
        "notification": {"title": "$title", "body": "$body"}
      }
    });

    var response = await http.post(
        Uri.parse(
            'https://aa8d8bb4-1030-48a1-a4ac-ad1d5fbd99d3.pushnotifications.pusher.com/publish_api/v1/instances/aa8d8bb4-1030-48a1-a4ac-ad1d5fbd99d3/publishes'),
        headers: header,
        body: data);

    if (response.statusCode == 200) {
      print('send notification to seller success');
    } else {
      print('send notification to seller failed');
      print(response.body);
    }
  }
}
