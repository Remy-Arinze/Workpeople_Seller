import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/view/payout/payout_page.dart';
import 'package:qixer_seller/view/profile/account_settings_page.dart';
import 'package:qixer_seller/view/profile/profile_page.dart';
import 'package:qixer_seller/view/profile/profile_verify_page.dart';
import 'package:qixer_seller/view/supports/my_tickets_page.dart';

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
          ListTile(
            title: const Text('Support ticket'),
            leading: const Icon(Icons.headphones),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MyTicketsPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('Payout history'),
            leading: const Icon(Icons.attach_money_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const PayoutPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('All orders'),
            leading: const Icon(Icons.shopping_cart_outlined),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const PayoutPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.verified_outlined),
            title: const Text('Profile verify'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfileVerifyPage(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_suggest_outlined),
            title: const Text('Account settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      const AccountSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
