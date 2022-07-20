import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/payout/components/payout_page_appbar.dart';

class PayoutPage extends StatelessWidget {
  const PayoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: PayoutPageAppbar(),
      ),
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Table(
              children: [
                TableRow(children: [
                  Container(
                      decoration: BoxDecoration(
                        color: cc.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 13),
                      child: const Text(
                        'ID',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Container(
                      color: cc.primaryColor,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 13),
                      child: const Text(
                        'Request Date',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Container(
                      decoration: BoxDecoration(
                        color: cc.primaryColor,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(7),
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 13),
                      child: const Text(
                        'Status',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                ]),
                for (int i = 0; i < 8; i++)
                  TableRow(
                      decoration: BoxDecoration(
                        color:
                            i % 2 == 0 ? Colors.white : const Color(0xffF6F6F6),
                      ),
                      children: [
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 15),
                            child: Text(
                              '#3343',
                              style: TextStyle(
                                  fontSize: 15.0, color: cc.greyPrimary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 15),
                            child: Text(
                              '12/05/22',
                              style: TextStyle(
                                  fontSize: 15.0, color: cc.greyPrimary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                        Container(
                            color: i % 2 == 0
                                ? Colors.white
                                : const Color(0xffF6F6F6),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 15),
                            child: Text(
                              'Pending',
                              style: TextStyle(
                                  fontSize: 15.0, color: cc.greyPrimary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )),
                      ]),
              ],
            )),
      ),
    );
  }
}
