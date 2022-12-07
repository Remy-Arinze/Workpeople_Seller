import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/services/wallet_service.dart';
import 'package:qixer_seller/view/payments/instamojo_payment_page.dart';

class InstamojoService {
  payByInstamojo(BuildContext context, {bool isFromWalletDeposite = false}) {
    String amount = '';

    String name;
    String phone;
    String email;
    String orderId;

    name = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .name ??
        'test';
    phone = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .phone ??
        '111111111';
    email = Provider.of<ProfileService>(context, listen: false)
            .profileDetails
            .email ??
        'test@test.com';
    if (isFromWalletDeposite) {
      amount = Provider.of<WalletService>(context, listen: false).amountToAdd;

      orderId = DateTime.now().toString();
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => InstamojoPaymentPage(
            amount: amount,
            name: name,
            email: email,
            isFromWalletDeposite: isFromWalletDeposite),
      ),
    );
  }
}
