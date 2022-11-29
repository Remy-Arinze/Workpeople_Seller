// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payments_service/payment_details_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/view/payments/midtrans_payment.dart';

class MidtransService {
  payByMidtrans(BuildContext context, {bool isFromOrderExtraAccept = false}) {
    Provider.of<PaymentService>(context, listen: false).setLoadingFalse();

    var amount;
    String name;
    String phone;
    String email;

    var profileProvider = Provider.of<ProfileService>(context, listen: false);
    // var paymentProvider = Provider.of<PaymentService>(context, listen: false);
    var pdProvider = Provider.of<PaymentDetailsService>(context, listen: false);

    name = profileProvider.profileDetails.name ?? '';
    phone = profileProvider.profileDetails.phone ?? '';
    email = profileProvider.profileDetails.email ?? '';

    amount = pdProvider.totalAmount.toStringAsFixed(2);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MidtransPayment(
          amount: amount,
          name: name,
          phone: phone,
          email: email,
        ),
      ),
    );
  }
}
