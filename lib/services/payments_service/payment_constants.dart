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
import 'package:qixer_seller/services/wallet_service.dart';
import 'package:qixer_seller/utils/others_helper.dart';

randomOrderId() {
  var rng = Random();
  return rng.nextInt(100).toString();
}

payAction(String method, BuildContext context, imagePath,
    {bool isFromWalletDeposite = false}) {
  //to know method names visit PaymentGatewayListService class where payment
  //methods list are fetching with method name

  switch (method) {
    case 'paypal':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaypalService().payByPaypal(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'cashfree':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          CashfreeService().getTokenAndPay(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'flutterwave':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          FlutterwaveService()
              .payByFlutterwave(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'instamojo':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          InstamojoService()
              .payByInstamojo(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'marcadopago':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          MercadoPagoService()
              .payByMercado(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'midtrans':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          MidtransService().payByMidtrans(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'mollie':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          MollieService().payByMollie(context, isFromWalletDeposite: true);
        });
      }
      break;

    case 'payfast':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PayfastService().payByPayfast(context, isFromWalletDeposite: true);
        });
      }

      break;

    case 'paystack':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaystackService().payByPaystack(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'paytm':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaytmService().payByPaytm(context, isFromWalletDeposite: true);
        }, paytmPaymentSelected: true);
      }

      break;

    case 'razorpay':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          RazorpayService().payByRazorpay(context, isFromWalletDeposite: true);
        });
      }

      break;
    case 'stripe':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          StripeService().makePayment(context, isFromWalletDeposite: true);
        });
      }

      break;

    case 'squareup':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          SquareService().payBySquare(context, isFromWalletDeposite: true);
        });
      }

      break;

    case 'cinetpay':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          CinetPayService().payByCinetpay(context, isFromWalletDeposite: true);
        });
      }

      break;

    case 'paytabs':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          PaytabsService().payByPaytabs(context, isFromWalletDeposite: true);
        });
      }

      break;

    case 'billplz':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          BillPlzService().payByBillPlz(context, isFromWalletDeposite: true);
        });
      }

      break;

    case 'zitopay':
      if (isFromWalletDeposite) {
        createDepositeRequestAndPay(context, () {
          ZitopayService().payByZitopay(context, isFromWalletDeposite: true);
        });
      }

      break;

    case 'manual_payment':
      if (imagePath == null) {
        OthersHelper()
            .showToast('You must upload the cheque image', Colors.black);
      } else {
        if (isFromWalletDeposite) {
          Provider.of<WalletService>(context, listen: false)
              .createDepositeRequest(context,
                  imagePath: imagePath.path, isManualOrCod: true);
        }
      }

      break;
    case 'cash_on_delivery':
      if (isFromWalletDeposite) {
        Provider.of<WalletService>(context, listen: false)
            .createDepositeRequest(context,
                imagePath: null, isManualOrCod: true);
      }

      break;
    default:
      {
        debugPrint('not method found');
      }
  }
}

createDepositeRequestAndPay(BuildContext context, VoidCallback function,
    {bool paytmPaymentSelected = false}) async {
  var res = await Provider.of<WalletService>(context, listen: false)
      .createDepositeRequest(context,
          imagePath: null, paytmPaymentSelected: paytmPaymentSelected);

  if (res == true) {
    function();
  } else {
    print('adding balance to wallet unsuccessfull');
  }
}
