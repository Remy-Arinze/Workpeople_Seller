import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/chart_service.dart';
import 'package:qixer_seller/services/permissions_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';
import 'package:qixer_seller/services/subscription_service.dart';

import '../view/utils/others_helper.dart';

formatDate(inputDate) {
  var outputFormat = DateFormat('MM/dd/yyyy');
  var outputDate = outputFormat.format(inputDate);

  return outputDate;
}

getDate(value) {
  final f = DateFormat('yyyy-MM-dd');
  var d = f.format(value);
  return d;
}

//=========>
removeUnderscore(value) {
  if (value == "null") return '-';
  return value.replaceAll(RegExp('_'), ' ');
}

// get screen height
screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

//============>
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

  Provider.of<SubscriptionService>(context, listen: false)
      .fetchCurrentSubscriptionData(context);

  Provider.of<PermissionsService>(context, listen: false)
      .fetchUserPermissions(context);
}

runAtSplashScreen(BuildContext context) async {
  //fetch translated strings
  Provider.of<AppStringService>(context, listen: false)
      .fetchTranslatedStrings();
}
