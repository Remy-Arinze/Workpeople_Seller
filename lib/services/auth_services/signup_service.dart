import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/utils/others_helper.dart';

import '../../utils/constant_colors.dart';
import '../../view/auth/signup/components/email_verify_page.dart';
import '../common_service.dart';
import '../country_states_service.dart';
import 'email_verify_service.dart';

class SignupService with ChangeNotifier {
  bool isloading = false;

  String phoneNumber = '0';
  String countryCode = 'IN';

  setPhone(value) {
    phoneNumber = value;
    notifyListeners();
  }

  setCountryCode(code) {
    countryCode = code;
    notifyListeners();
  }

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future signup(
    String fullName,
    String userName,
    String email,
    String phoneNumber,
    String password,
    BuildContext context,
  ) async {
    var connection = await checkConnection();

    var selectedCountryId =
        Provider.of<CountryStatesService>(context, listen: false)
            .selectedCountryId;
    var selectedStateId =
        Provider.of<CountryStatesService>(context, listen: false)
            .selectedStateId;
    if (connection) {
      setLoadingTrue();
      var data = jsonEncode({
        'full_name': fullName,
        'username': userName,
        'email': email,
        'country_id': selectedCountryId,
        'country_code': countryCode,
        'state_id': selectedStateId,
        'phone': phoneNumber,
        'password': password,
        'terms_conditions': 1,
      });
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(Uri.parse('$baseApi/register'),
          body: data, headers: header);

      if (response.statusCode == 201) {
        OthersHelper().showToast(
            "Registration successful", ConstantColors().successColor);

        // Navigator.pushReplacement<void, void>(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) => const LandingPage(),
        //   ),
        // );

        String token = jsonDecode(response.body)['token'];
        int userId = jsonDecode(response.body)['users']['id'];

        //Send otp
        var isOtepSent =
            await Provider.of<EmailVerifyService>(context, listen: false)
                .sendOtpForEmailValidation(email, context, token);
        setLoadingFalse();
        if (isOtepSent) {
          Navigator.pushReplacement<void, void>(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => EmailVerifyPage(
                email: email,
                pass: password,
                token: token,
                userId: userId,
                state: selectedStateId,
                countryId: selectedCountryId,
              ),
            ),
          );
        } else {
          OthersHelper().showToast('Otp send failed', Colors.black);
        }

        return true;
      } else {
        //Sign up unsuccessful ==========>
        print(response.body);
        showError(jsonDecode(response.body)['validation_errors']);
        setLoadingFalse();
        return false;
      }
    } else {
      //internet connection off
      return false;
    }
  }

  showError(error) {
    if (error.containsKey('email')) {
      OthersHelper().showToast(error['email'][0], Colors.black);
    } else if (error.containsKey('username')) {
      OthersHelper().showToast(error['username'][0], Colors.black);
    } else if (error.containsKey('phone')) {
      OthersHelper().showToast(error['phone'][0], Colors.black);
    } else if (error.containsKey('password')) {
      OthersHelper().showToast(error['password'][0], Colors.black);
    } else {
      OthersHelper().showToast('Something went wrong', Colors.black);
    }
  }
}
