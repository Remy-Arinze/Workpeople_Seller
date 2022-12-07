import 'package:flutter/material.dart';
import 'package:qixer_seller/view/payments/paystack_payment_page.dart';

class PaystackService {
  payByPaystack(BuildContext context,
      {bool isFromOrderExtraAccept = false,
      bool isFromWalletDeposite = false}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaystackPaymentPage(
          isFromWalletDeposite: isFromWalletDeposite,
        ),
      ),
    );
  }
}
