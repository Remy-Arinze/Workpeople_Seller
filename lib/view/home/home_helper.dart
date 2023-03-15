import 'package:flutter/material.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';

class HomeHelper {
  List cardColors = [
    const Color(0xffff6b2c),
    const Color(0xff1DBF73),
    const Color(0xffc71f66),
    const Color(0xff6560ff),
    const Color(0xffff6b2c),
    const Color(0xffff6b2c),
  ];

  List cardTitles = [
    ConstString.orderPending,
    ConstString.orderCompleted,
    ConstString.totalWithdraw,
    ConstString.remainingBalance
  ];
}
