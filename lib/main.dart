import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/auth_services/change_pass_service.dart';
import 'package:qixer_seller/services/auth_services/email_verify_service.dart';
import 'package:qixer_seller/services/auth_services/login_service.dart';
import 'package:qixer_seller/services/auth_services/logout_service.dart';
import 'package:qixer_seller/services/auth_services/reset_password_service.dart';
import 'package:qixer_seller/services/auth_services/signup_service.dart';
import 'package:qixer_seller/services/country_states_service.dart';
import 'package:qixer_seller/services/dashboard_service.dart';
import 'package:qixer_seller/services/deactivate_account_service.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/services/orders_service.dart';
import 'package:qixer_seller/services/profile_edit_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/services/profile_verify_service.dart';
import 'package:qixer_seller/services/recent_orders_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';
import 'package:qixer_seller/services/ticket_services/support_ticket_service.dart';
import 'package:qixer_seller/services/withdraw_service.dart';
import 'package:qixer_seller/view/intro/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => ProfileService()),
        ChangeNotifierProvider(create: (_) => ChangePassService()),
        ChangeNotifierProvider(create: (_) => EmailVerifyService()),
        ChangeNotifierProvider(create: (_) => LogoutService()),
        ChangeNotifierProvider(create: (_) => ResetPasswordService()),
        ChangeNotifierProvider(create: (_) => SignupService()),
        ChangeNotifierProvider(create: (_) => LoginService()),
        ChangeNotifierProvider(create: (_) => CountryStatesService()),
        ChangeNotifierProvider(create: (_) => RtlService()),
        ChangeNotifierProvider(create: (_) => SupportTicketService()),
        ChangeNotifierProvider(create: (_) => WithdrawService()),
        ChangeNotifierProvider(create: (_) => OrdersService()),
        ChangeNotifierProvider(create: (_) => OrderDetailsService()),
        ChangeNotifierProvider(create: (_) => ProfileVerifyService()),
        ChangeNotifierProvider(create: (_) => ProfileEditService()),
        ChangeNotifierProvider(create: (_) => DeactivateAccountService()),
        ChangeNotifierProvider(create: (_) => DashboardService()),
        ChangeNotifierProvider(create: (_) => RecentOrdersService()),
      ],
      child: MaterialApp(
        title: 'Qixer seller',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
