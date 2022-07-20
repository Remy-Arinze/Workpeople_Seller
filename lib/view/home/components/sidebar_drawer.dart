import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/others_helper.dart';

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
                  CommonHelper().profileImage(placeHolderUrl, 60, 60),
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
            onTap: () {},
          ),
          ListTile(
            title: const Text('Payout history'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
