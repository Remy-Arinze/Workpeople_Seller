import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/view/payout/payout_page.dart';
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
              )),
          ListTile(
            title: const Text('Support ticket'),
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
            title: const Text('Profile settings'),
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
        ],
      ),
    );
  }
}
