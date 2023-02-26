import 'dart:io';

import 'package:flutter/material.dart';

late bool isIos;

screenSizeAndPlatform(BuildContext context) {
  // getScreenSize(context);
  checkPlatform();
}
//responsive screen codes ========>

var fourinchScreenHeight = 610;
var fourinchScreenWidth = 385;

checkPlatform() {
  if (Platform.isAndroid) {
    isIos = false;
  } else if (Platform.isIOS) {
    isIos = true;
  }
}
