import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/auth_services/change_pass_service.dart';
import 'package:qixer_seller/services/auth_services/email_verify_service.dart';
import 'package:qixer_seller/services/auth_services/login_service.dart';
import 'package:qixer_seller/services/auth_services/logout_service.dart';
import 'package:qixer_seller/services/auth_services/reset_password_service.dart';
import 'package:qixer_seller/services/auth_services/signup_service.dart';
import 'package:qixer_seller/services/chart_service.dart';
import 'package:qixer_seller/services/country_states_service.dart';
import 'package:qixer_seller/services/dashboard_service.dart';
import 'package:qixer_seller/services/deactivate_account_service.dart';
import 'package:qixer_seller/services/jobs/job_conversation_service.dart';
import 'package:qixer_seller/services/jobs/job_details_service.dart';
import 'package:qixer_seller/services/jobs/job_list_service.dart';
import 'package:qixer_seller/services/jobs/new_jobs_service.dart';
import 'package:qixer_seller/services/live_chat/chat_list_service.dart';
import 'package:qixer_seller/services/live_chat/chat_message_service.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/services/orders_service.dart';
import 'package:qixer_seller/services/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payout_details_service.dart';
import 'package:qixer_seller/services/payout_history_service.dart';
import 'package:qixer_seller/services/profile_edit_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/services/profile_verify_service.dart';
import 'package:qixer_seller/services/recent_orders_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';
import 'package:qixer_seller/services/subscription_service.dart';
import 'package:qixer_seller/services/ticket_services/support_messages_service.dart';
import 'package:qixer_seller/services/ticket_services/support_ticket_service.dart';
import 'package:qixer_seller/services/withdraw_service.dart';
import 'package:qixer_seller/view/intro/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PusherBeams.instance.start('fcaf9caf-509c-4611-a225-2e508593d6af');

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
        ChangeNotifierProvider(create: (_) => SupportMessagesService()),
        ChangeNotifierProvider(create: (_) => PayoutHistoryService()),
        ChangeNotifierProvider(create: (_) => PaymentGatewayListService()),
        ChangeNotifierProvider(create: (_) => PayoutDetailsService()),
        ChangeNotifierProvider(create: (_) => ChartService()),
        ChangeNotifierProvider(create: (_) => AppStringService()),
        ChangeNotifierProvider(create: (_) => ChatListService()),
        ChangeNotifierProvider(create: (_) => ChatMessagesService()),
        ChangeNotifierProvider(create: (_) => SubscriptionService()),
        ChangeNotifierProvider(create: (_) => JobListService()),
        ChangeNotifierProvider(create: (_) => NewJobsService()),
        ChangeNotifierProvider(create: (_) => JobConversationService()),
        ChangeNotifierProvider(create: (_) => JobDetailsService()),
        // ChangeNotifierProvider(create: (_) => WalletService()),
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
