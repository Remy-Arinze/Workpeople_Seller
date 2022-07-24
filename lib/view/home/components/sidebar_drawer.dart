import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/view/orders/all_orders_page.dart';
import 'package:qixer_seller/view/payout/payout_page.dart';
import 'package:qixer_seller/view/profile/change_password_page.dart';
import 'package:qixer_seller/view/profile/components/deactivate_account_page.dart';
import 'package:qixer_seller/view/profile/profile_page.dart';
import 'package:qixer_seller/view/profile/profile_verify_page.dart';
import 'package:qixer_seller/view/supports/my_tickets_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
          DrawerHeader(
              decoration: BoxDecoration(color: cc.primaryColor),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const ProfilePage(),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHelper().profileImage(
                        'https://bytesed.com/laravel/qixer/assets/uploads/media-uploader/seller-s21644057790.jpg',
                        60,
                        60),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'SM Saleheen',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ],
                ),
              )),
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
          CommonHelper().buttonPrimary("Logout", () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
          }, bgColor: cc.warningColor),
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
