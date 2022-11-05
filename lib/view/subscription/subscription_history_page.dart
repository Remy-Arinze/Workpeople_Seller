import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';

class SubscriptionHistoryPage extends StatefulWidget {
  const SubscriptionHistoryPage({Key? key}) : super(key: key);

  @override
  _SubscriptionHistoryPageState createState() =>
      _SubscriptionHistoryPageState();
}

class _SubscriptionHistoryPageState extends State<SubscriptionHistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Subscriptions', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: cc.bgColor,
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: screenPadding, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHelper().titleCommon('Silver subscription',
                                  fontsize: 15),
                              sizedBoxCustom(8),
                              Text(
                                "Expire date: 02/11/23",
                                style: TextStyle(
                                  color: cc.greyFour,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ]),
                      ),
                      // Icon(
                      //   Icons.arrow_forward_ios,
                      //   size: 16,
                      //   color: cc.greyFour,
                      // )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
