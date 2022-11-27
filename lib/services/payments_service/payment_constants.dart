// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/billplz_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/cashfree_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/cinetpay_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/flutterwave_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/instamojo_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/mercado_pago_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/midtrans_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/mollie_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/payfast_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/paypal_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/paystack_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/paytabs_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/paytm_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/razorpay_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/square_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/stripe_service.dart';
import 'package:qixer_seller/services/payments_service/gateway_services/zitopay_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';

randomOrderId() {
  var rng = Random();
  return rng.nextInt(100).toString();
}

payAction(String method, BuildContext context, imagePath,
    {bool isFromOrderExtraAccept = false}) {
  //to know method names visit PaymentGatewayListService class where payment
  //methods list are fetching with method name

  switch (method) {
    case 'paypal':
      makePaymentToGetOrderId(context, () {
        PaypalService().payByPaypal(context);
      });

      break;
    case 'cashfree':
      makePaymentToGetOrderId(context, () {
        CashfreeService().getTokenAndPay(context);
      });

      break;
    case 'flutterwave':
      makePaymentToGetOrderId(context, () {
        FlutterwaveService().payByFlutterwave(context);
      });

      break;
    case 'instamojo':
      makePaymentToGetOrderId(context, () {
        InstamojoService().payByInstamojo(context);
      });

      break;
    case 'marcadopago':
      makePaymentToGetOrderId(context, () {
        MercadoPagoService().payByMercado(context);
      });

      break;
    case 'midtrans':
      makePaymentToGetOrderId(context, () {
        MidtransService().payByMidtrans(context);
      });

      break;
    case 'mollie':
      makePaymentToGetOrderId(context, () {
        MollieService().payByMollie(context);
      });

      break;

    case 'payfast':
      makePaymentToGetOrderId(context, () {
        PayfastService().payByPayfast(context);
      });

      break;

    case 'paystack':
      makePaymentToGetOrderId(context, () {
        PaystackService().payByPaystack(context);
      });

      break;
    case 'paytm':
      makePaymentToGetOrderId(context, () {
        PaytmService().payByPaytm(context);
      }, paytmPaymentSelected: true);

      break;

    case 'razorpay':
      makePaymentToGetOrderId(context, () {
        RazorpayService().payByRazorpay(context);
      });

      break;
    case 'stripe':
      makePaymentToGetOrderId(context, () {
        StripeService().makePayment(context);
      });

      break;

    case 'squareup':
      makePaymentToGetOrderId(context, () {
        SquareService().payBySquare(context);
      });

      break;

    case 'cinetpay':
      makePaymentToGetOrderId(context, () {
        CinetPayService().payByCinetpay(context);
      });

      break;

    case 'paytabs':
      makePaymentToGetOrderId(context, () {
        PaytabsService().payByPaytabs(context);
      });

      break;

    case 'billplz':
      makePaymentToGetOrderId(context, () {
        BillPlzService().payByBillPlz(context);
      });

      break;

    case 'zitopay':
      makePaymentToGetOrderId(context, () {
        ZitopayService().payByZitopay(context);
      });

      break;

    case 'manual_payment':
      if (imagePath == null) {
        OthersHelper()
            .showToast('You must upload the cheque image', Colors.black);
      } else {
        Provider.of<PaymentService>(context, listen: false)
            .depositeToWallet(context, imagePath.path, isManualOrCod: true);
      }

      break;
    case 'cash_on_delivery':
      Provider.of<PaymentService>(context, listen: false)
          .depositeToWallet(context, null, isManualOrCod: true);

      break;
    default:
      {
        debugPrint('not method found');
      }
  }
}

makePaymentToGetOrderId(BuildContext context, VoidCallback function,
    {bool paytmPaymentSelected = false}) async {
  var res = await Provider.of<PaymentService>(context, listen: false)
      .depositeToWallet(context, null,
          paytmPaymentSelected: paytmPaymentSelected);

  if (res == true) {
    function();
  } else {
    print('order place unsuccessfull, visit payment_constants.dart file');
  }
}
