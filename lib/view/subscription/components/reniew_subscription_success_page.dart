import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';

class ReniewSubscriptionSuccessPage extends StatefulWidget {
  const ReniewSubscriptionSuccessPage({
    Key? key,
  }) : super(key: key);

  @override
  _ReniewSubscriptionSuccessPageState createState() =>
      _ReniewSubscriptionSuccessPageState();
}

class _ReniewSubscriptionSuccessPageState
    extends State<ReniewSubscriptionSuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  final cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Success', context, () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
            child: Consumer<AppStringService>(
          builder: (context, ln, child) => Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: Container(
              height: screenHeight(context) - 180,
              alignment: Alignment.center,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: cc.successColor,
                      size: 85,
                    ),
                    sizedBoxCustom(7),
                    Text(
                      ln.getString('Subscription renewed'),
                      style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 21,
                          fontWeight: FontWeight.w600),
                    ),
                  ]),
            ),
          ),
        )));
  }
}
