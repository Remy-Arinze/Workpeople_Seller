// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer_seller/view/utils/others_helper.dart';

class RtlService with ChangeNotifier {
  /// RTL support
  String direction = 'ltr';

  String currency = '\$';
  String currencyDirection = 'left';
  bool showCommission = false;

  bool alreadyCurrencyLoaded = false;
  bool alreadyRtlLoaded = false;

  fetchCurrency() async {
    if (alreadyCurrencyLoaded == false) {
      var response = await http.get(Uri.parse('$baseApi/currency'));
      print(response.body);
      if (response.statusCode == 201) {
        currency = jsonDecode(response.body)['currency']['symbol'];
        currencyDirection = jsonDecode(response.body)['currency']['position'];
        alreadyCurrencyLoaded == true;
        notifyListeners();
      } else {
        print('failed loading currency');
        print(response.body);
      }
    } else {
      //already loaded from server. no need to load again
    }
  }

  fetchDirection() async {
    if (alreadyRtlLoaded == false) {
      var response = await http.get(Uri.parse('$baseApi/language'));
      if (response.statusCode == 201) {
        direction = jsonDecode(response.body)['language']['direction'];
        alreadyRtlLoaded == true;
        notifyListeners();
      } else {
        print('failed loading language direction');
        print(response.body);
      }
    } else {
      //already loaded from server. no need to load again
    }
  }
}
