import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/chart_service.dart';
import 'package:qixer_seller/services/live_chat/chat_message_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';

import '../utils/others_helper.dart';

late bool isIos;

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    OthersHelper()
        .showToast("Please turn on your internet connection", Colors.black);
    return false;
  } else {
    return true;
  }
}

runAtStart(BuildContext context) {
  Provider.of<RtlService>(context, listen: false).fetchCurrency();
  Provider.of<ProfileService>(context, listen: false).getProfileDetails();
  Provider.of<ChartService>(context, listen: false).fetchChartData(context);

  Provider.of<ChatMessagesService>(context, listen: false)
      .fetchPusherCredential(context);
}

runAtSplashScreen(BuildContext context) async {
  //fetch translated strings
  Provider.of<AppStringService>(context, listen: false)
      .fetchTranslatedStrings();
}
