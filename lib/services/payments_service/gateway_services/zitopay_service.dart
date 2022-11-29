// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payments_service/payment_details_service.dart';
import 'package:qixer_seller/services/payments_service/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/view/payments/zitopay_payment_page.dart';

class ZitopayService {
  payByZitopay(
    BuildContext context,
  ) {
    //========>
    Provider.of<PaymentService>(context, listen: false).setLoadingFalse();

    var amount;

    var pdProvider = Provider.of<PaymentDetailsService>(context, listen: false);

    amount = pdProvider.totalAmount.toStringAsFixed(2);

    var userName =
        Provider.of<PaymentGatewayListService>(context, listen: false)
            .zitopayUserName;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ZitopayPaymentPage(
          amount: amount,
          userName: userName,
        ),
      ),
    );
  }
}
