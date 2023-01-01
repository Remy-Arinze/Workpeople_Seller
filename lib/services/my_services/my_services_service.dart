import 'package:flutter/material.dart';

class MyServicesService with ChangeNotifier {
  //
  late int totalPages;
  int currentPage = 1;

  List myServiceListMap = [];

  setActiveStatus(bool status, int index) {
    myServiceListMap[index]['isActive'] = status;
    notifyListeners();
  }

  fetchMyServiceList(BuildContext context) {
    return true;
  }
}
