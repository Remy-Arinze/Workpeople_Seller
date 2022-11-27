import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/payments/instamojo_payment_page.dart';

class InstamojoService {
  payByInstamojo(BuildContext context, {bool isFromOrderExtraAccept = false}) {
    String amount;

    String name;
    String phone;
    String email;
    String orderId;

    if (isFromOrderExtraAccept == true) {
      name = Provider.of<ProfileService>(context, listen: false)
              .profileDetails
              .userDetails
              .name ??
          'test';
      phone = Provider.of<ProfileService>(context, listen: false)
              .profileDetails
              .userDetails
              .phone ??
          '111111111';
      email = Provider.of<ProfileService>(context, listen: false)
              .profileDetails
              .userDetails
              .email ??
          'test@test.com';
      amount = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraPrice;

      orderId = Provider.of<OrderDetailsService>(context, listen: false)
          .selectedExtraId
          .toString();
    } else {
      var bcProvider =
          Provider.of<BookConfirmationService>(context, listen: false);
      var pProvider =
          Provider.of<PersonalizationService>(context, listen: false);
      var bookProvider = Provider.of<BookService>(context, listen: false);

      name = bookProvider.name ?? '';
      phone = bookProvider.phone ?? '';
      email = bookProvider.email ?? '';

      if (pProvider.isOnline == 0) {
        amount = bcProvider.totalPriceAfterAllcalculation.toStringAsFixed(2);
      } else {
        amount = bcProvider.totalPriceOnlineServiceAfterAllCalculation
            .toStringAsFixed(2);
      }
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => InstamojoPaymentPage(
          amount: amount,
          name: name,
          email: email,
          isFromOrderExtraAccept: isFromOrderExtraAccept,
        ),
      ),
    );
  }
}
