// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../common_service.dart';

class PaymentService with ChangeNotifier {
  bool isloading = false;

  var orderId;
  var successUrl;
  var cancelUrl;

  var paytmHtmlForm;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> depositeToWallet(BuildContext context, String? imagePath,
      {bool isManualOrCod = false, bool paytmPaymentSelected = false}) async {
    return true;
    // setLoadingTrue();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var token = prefs.getString('token');

    // var formData;
    // var dio = Dio();
    // dio.options.headers['Content-Type'] = 'multipart/form-data';
    // dio.options.headers['Accept'] = 'application/json';
    // dio.options.headers['Authorization'] = "Bearer $token";

    // print('not online service');
    // //if it's not online service
    // if (imagePath != null) {
    //   //if manual transfer selected then image upload is mandatory
    //   formData = FormData.fromMap({
    //     'service_id': serviceId.toString(),
    //     'seller_id': sellerId.toString(),
    //     'buyer_id': buyerId.toString(),
    //     'name': name,
    //     'email': email,
    //     'phone': phone, //amount he paid in bkash ucash etc
    //     'post_code': post,
    //     'address': address,
    //     'choose_service_city': city.toString(),
    //     'choose_service_area': area.toString(),
    //     'choose_service_country': country.toString(),
    //     'date': selectedDate.toString(),
    //     'schedule': schedule.toString(),
    //     'include_services': jsonEncode({"include_services": includesList}),
    //     'additional_services': jsonEncode({"additional_services": extrasList}),
    //     'coupon_code': coupon.toString(),
    //     'selected_payment_gateway': selectedPaymentGateway.toString(),
    //     'manual_payment_image': await MultipartFile.fromFile(imagePath,
    //         filename: 'bankTransfer$name$address$imagePath.jpg'),
    //     'is_service_online': 0,
    //   });
    // }

    // var response = await dio.post(
    //   '$baseApi/service/order',
    //   data: formData,
    // );

    // //if paytm payment selected
    // // =================>

    // if (paytmPaymentSelected == true) {
    //   var paytmRes = await http.post(Uri.parse('$baseApi/service/order-paytm'),
    //       headers: header, body: data);

    //   paytmHtmlForm = paytmRes.body;
    //   notifyListeners();
    // }

    // if (response.statusCode == 201) {
    //   print(response.data);

    //   orderId = response.data['order_id'];
    //   successUrl = response.data['success_url'];
    //   cancelUrl = response.data['cancel_url'];

    //   print('order id is $orderId');

    //   notifyListeners();

    //   if (isManualOrCod == true) {
    //     //if user placed order in manual transfer or cash on delivery then no need to hit the api- make payment success
    //     //because in this case payment needs to stay pending anyway.
    //     doNext(context, 'Pending');
    //     setLoadingFalse();
    //   }
    //   return true;
    // } else {
    //   setLoadingFalse();
    //   print(response.data);
    //   OthersHelper().showToast('Something went wrong', Colors.black);
    //   return false;
    // }

    //
  }

  //make payment successfull
  makePaymentSuccess(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var connection = await checkConnection();

    if (connection) {
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      print('order id is $orderId');

      var data = jsonEncode({
        'order_id': orderId,
      });

      var response = await http.post(
          Uri.parse('$baseApi/user/payment-status-update'),
          headers: header,
          body: data);
      setLoadingFalse();
      if (response.statusCode == 201) {
        OthersHelper().showToast('Order placed successfully', Colors.black);
        doNext(context, 'Complete');
      } else {
        print(response.body);
        OthersHelper().showToast(
            'Failed to make payment status successfull', Colors.black);
        doNext(context, 'Pending');
      }
    } else {
      OthersHelper().showToast(
          'Check your internet connection and try again', Colors.black);
    }
  }

  ///////////==========>
  doNext(BuildContext context, String paymentStatus) async {
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => const LandingPage()),
    //     (Route<dynamic> route) => false);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(
    //     builder: (BuildContext context) => PaymentSuccessPage(
    //       paymentStatus: paymentStatus,
    //     ),
    //   ),
    // );
  }
}
