import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/auth_services/change_pass_service.dart';
import 'package:qixer_seller/services/auth_services/email_verify_service.dart';
import 'package:qixer_seller/services/auth_services/facebook_login_service.dart';
import 'package:qixer_seller/services/auth_services/google_sign_service.dart';
import 'package:qixer_seller/services/auth_services/login_service.dart';
import 'package:qixer_seller/services/auth_services/logout_service.dart';
import 'package:qixer_seller/services/auth_services/reset_pass_otp_service.dart';
import 'package:qixer_seller/services/auth_services/reset_password_service.dart';
import 'package:qixer_seller/services/auth_services/signup_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/view/auth/login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => ChangePassService()),
        ChangeNotifierProvider(create: (_) => EmailVerifyService()),
        ChangeNotifierProvider(create: (_) => FacebookLoginService()),
        ChangeNotifierProvider(create: (_) => GoogleSignInService()),
        ChangeNotifierProvider(create: (_) => LogoutService()),
        ChangeNotifierProvider(create: (_) => ResetPasswordService()),
        ChangeNotifierProvider(create: (_) => SignupService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
      ],
      child: MaterialApp(
        title: 'Qixer seller',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
      ),
    );
  }
}
