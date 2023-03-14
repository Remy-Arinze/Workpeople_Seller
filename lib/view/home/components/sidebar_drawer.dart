import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/auth_services/logout_service.dart';
import 'package:qixer_seller/services/live_chat/chat_list_service.dart';
import 'package:qixer_seller/services/permissions_service.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';
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

import '../../utils/common_helper.dart';

class SidebarDrawer extends StatelessWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Drawer(
      child: Consumer<AppStringService>(
        builder: (context, ln, child) => Consumer<PermissionsService>(
          builder: (context, pProvider, child) => ListView(
            padding: EdgeInsets.zero,
            children: [
              Consumer<ProfileService>(
                builder: (context, profileProvider, child) => profileProvider
                            .profileDetails !=
                        null
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
                  title: ConstString.allOrders,
                  leading: Icon(Icons.shopping_cart_outlined,
                      color: cc.primaryColor),
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const AllOrdersPage(),
                      ),
                    );
                  }),
              SidebarMenuItem(
                  title: ConstString.payoutHistory,
                  leading:
                      Icon(Icons.attach_money_sharp, color: cc.primaryColor),
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const PayoutPage(),
                      ),
                    );
                  }),
              SidebarMenuItem(
                  title: ConstString.supportTicket,
                  leading: Icon(Icons.headphones, color: cc.primaryColor),
                  ontap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const MyTicketsPage(),
                      ),
                    );
                  }),

              SidebarMenuItem(
                  title: ConstString.subscriptions,
                  leading: Icon(Icons.subscriptions_outlined,
                      color: cc.primaryColor),
                  ontap: () {
                    if (!pProvider.subsPermission) {
                      OthersHelper().showToast(
                          ln.getString(ConstString.noPermissionToAccess),
                          Colors.black);
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const SubscriptionHistoryPage(),
                      ),
                    );
                  }),

              SidebarMenuItem(
                  title: ConstString.newJobs,
                  leading: Icon(Icons.cases_outlined, color: cc.primaryColor),
                  ontap: () {
                    if (!pProvider.jobPermission) {
                      OthersHelper().showToast(
                          ln.getString(ConstString.noPermissionToAccess),
                          Colors.black);
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const NewJobsPage(),
                      ),
                    );
                  }),

              SidebarMenuItem(
                  title: ConstString.appliedJobs,
                  leading: Icon(Icons.cases_rounded, color: cc.primaryColor),
                  ontap: () {
                    if (!pProvider.jobPermission) {
                      OthersHelper().showToast(
                          ln.getString(ConstString.noPermissionToAccess),
                          Colors.black);
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            const JobRequestPage(),
                      ),
                    );
                  }),

              SidebarMenuItem(
                  title: ConstString.profile,
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
                  title: ConstString.profileVerify,
                  leading:
                      Icon(Icons.verified_outlined, color: cc.primaryColor),
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
                  title: ConstString.changePass,
                  leading: Icon(Icons.settings_suggest_outlined,
                      color: cc.primaryColor),
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
                  title: ConstString.chat,
                  leading: Icon(Icons.message_outlined, color: cc.primaryColor),
                  ontap: () {
                    if (!pProvider.chatPermission) {
                      OthersHelper().showToast(
                          ln.getString(ConstString.noPermissionToAccess),
                          Colors.black);
                      return;
                    }
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
                  title: ConstString.wallet,
                  leading: Icon(Icons.wallet, color: cc.primaryColor),
                  ontap: () {
                    if (!pProvider.walletPermission) {
                      OthersHelper().showToast(
                          ln.getString(ConstString.noPermissionToAccess),
                          Colors.black);
                      return;
                    }
                    //======>
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const WalletPage(),
                      ),
                    );
                  }),

              SidebarMenuItem(
                  title: ConstString.services,
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
                  title: ConstString.myReportList,
                  leading:
                      Icon(Icons.report_gmailerrorred, color: cc.primaryColor),
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
                  title: ConstString.deactivateAccount,
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
                  child: CommonHelper().buttonPrimary(ConstString.logout,
                      () async {
                    logoutProvider.logout(context);
                  },
                      isloading:
                          logoutProvider.isloading == false ? false : true,
                      bgColor: cc.warningColor),
                ),
              )
            ],
          ),
        ),
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
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: ConstantColors().borderColor,
            width: 1.0,
          ),
        )),
        child: ListTile(
          title: Text(ln.getString(title)),
          leading: leading,
          onTap: ontap,
        ),
      ),
    );
  }
}
