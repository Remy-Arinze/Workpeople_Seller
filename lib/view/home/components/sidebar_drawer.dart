import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/auth_services/logout_service.dart';
import 'package:qixer_seller/services/live_chat/chat_list_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/jobs/jobs_request_page.dart';
import 'package:qixer_seller/view/jobs/new_jobs_page.dart';
import 'package:qixer_seller/view/live_chat/chat_list_page.dart';
import 'package:qixer_seller/view/my_service/my_services_list_page.dart';
import 'package:qixer_seller/view/orders/all_orders_page.dart';
import 'package:qixer_seller/view/payout/payout_page.dart';
import 'package:qixer_seller/view/profile/change_password_page.dart';
import 'package:qixer_seller/view/profile/components/deactivate_account_page.dart';
import 'package:qixer_seller/view/profile/profile_page.dart';
import 'package:qixer_seller/view/profile/profile_verify_page.dart';
import 'package:qixer_seller/view/report/my_reports_list_page.dart';
import 'package:qixer_seller/view/subscription/subscription_history_page.dart';
import 'package:qixer_seller/view/supports/my_tickets_page.dart';
import 'package:qixer_seller/view/wallet/wallet_page.dart';

import '../../../utils/common_helper.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer<ProfileService>(
            builder: (context, profileProvider, child) =>
                profileProvider.profileDetails != null
                    ? SizedBox(
                        height: 185,
                        child: DrawerHeader(
                            decoration: BoxDecoration(color: cc.primaryColor),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const ProfilePage(),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonHelper().profileImage(
                                      profileProvider.profileImage != null
                                          ? profileProvider.profileImage.imgUrl
                                          : userPlaceHolderUrl,
                                      60,
                                      60),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    profileProvider.profileDetails.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                ],
                              ),
                            )),
                      )
                    : Container(),
          ),

          SidebarMenuItem(
              title: 'All orders',
              leading:
                  Icon(Icons.shopping_cart_outlined, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const AllOrdersPage(),
                  ),
                );
              }),
          SidebarMenuItem(
              title: 'Payout history',
              leading: Icon(Icons.attach_money_sharp, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const PayoutPage(),
                  ),
                );
              }),
          SidebarMenuItem(
              title: 'Support ticket',
              leading: Icon(Icons.headphones, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const MyTicketsPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'Subscriptions',
              leading:
                  Icon(Icons.subscriptions_outlined, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const SubscriptionHistoryPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'New jobs',
              leading: Icon(Icons.cases_outlined, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const NewJobsPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'Applied jobs',
              leading: Icon(Icons.cases_rounded, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const JobRequestPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'Profile',
              leading: Icon(Icons.person_outline, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ProfilePage(),
                  ),
                );
              }),
          SidebarMenuItem(
              title: 'Profile verify',
              leading: Icon(Icons.verified_outlined, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ProfileVerifyPage(),
                  ),
                );
              }),
          SidebarMenuItem(
              title: 'Change password',
              leading:
                  Icon(Icons.settings_suggest_outlined, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const ChangePasswordPage(),
                  ),
                );
              }),
          SidebarMenuItem(
              title: 'Chat',
              leading: Icon(Icons.message_outlined, color: cc.primaryColor),
              ontap: () {
                //=====>
                Provider.of<ChatListService>(context, listen: false)
                    .fetchChatList(context);

                //======>
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const ChatListPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'Wallet',
              leading: Icon(Icons.wallet, color: cc.primaryColor),
              ontap: () {
                //======>
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const WalletPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'Services',
              leading: Icon(Icons.room_service, color: cc.primaryColor),
              ontap: () {
                //======>
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const MyServiceListPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'My Report list',
              leading: Icon(Icons.report_gmailerrorred, color: cc.primaryColor),
              ontap: () {
                //======>
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const MyReportsListPage(),
                  ),
                );
              }),

          SidebarMenuItem(
              title: 'Deactivate account',
              leading: Icon(Icons.close, color: cc.primaryColor),
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const DeactivateAccountPage(),
                  ),
                );
              }),

          //Logout button
          Consumer<LogoutService>(
            builder: (context, logoutProvider, child) => Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: CommonHelper().buttonPrimary("Logout", () async {
                logoutProvider.logout(context);
              },
                  isloading: logoutProvider.isloading == false ? false : true,
                  bgColor: cc.warningColor),
            ),
          )
        ],
      ),
    );
  }
}

class SidebarMenuItem extends StatelessWidget {
  const SidebarMenuItem(
      {Key? key,
      required this.title,
      required this.leading,
      required this.ontap})
      : super(key: key);

  final String title;
  final leading;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: ConstantColors().borderColor,
          width: 1.0,
        ),
      )),
      child: ListTile(
        title: Text(title),
        leading: leading,
        onTap: ontap,
      ),
    );
  }
}
