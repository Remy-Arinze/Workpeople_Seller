// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payments_service/payment_details_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/view/payments/billplz_payment.dart';

class BillPlzService {
  payByBillPlz(BuildContext context) {
    //========>
    Provider.of<PaymentService>(context, listen: false).setLoadingFalse();

    var amount;

    String name;
    String phone;
    String email;

    var pProvider = Provider.of<ProfileService>(context, listen: false);
    var pdProvider = Provider.of<PaymentDetailsService>(context, listen: false);

    name = pProvider.profileDetails.name ?? '';
    phone = pProvider.profileDetails.phone ?? '';
    email = pProvider.profileDetails.email ?? '';

    amount = pdProvider.totalAmount.toStringAsFixed(2);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BillplzPayment(
          amount: amount,
          name: name,
          phone: phone,
          email: email,
        ),
      ),
    );
  }
}
