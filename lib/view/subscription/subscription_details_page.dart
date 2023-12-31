import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/subscription_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';
import 'package:qixer_seller/view/orders/payment_helper.dart';
import 'package:qixer_seller/view/payments/payment_choose_page.dart';

class SubscriptionDetailsPage extends StatefulWidget {
  const SubscriptionDetailsPage({Key? key}) : super(key: key);

  @override
  _SubscriptionDetailsPageState createState() =>
      _SubscriptionDetailsPageState();
}

class _SubscriptionDetailsPageState extends State<SubscriptionDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Subscription details', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: cc.bgColor,
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Consumer<AppStringService>(
          builder: (context, ln, child) => Consumer<SubscriptionService>(
            builder: (context, provider, child) => Container(
              padding:
                  EdgeInsets.symmetric(horizontal: screenPadding, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonHelper().paragraphCommon(
                      ln.getString(
                          'Note: Pending connect will be added to available connect only if the payment status is completed'),
                      TextAlign.left),
                  Container(
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                  ),

                  sizedBoxCustom(25),
                  //Title,  type
                  //===================>
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper().titleCommon(provider.subsData.type +
                              ' ${ln.getString('subscription')}'),
                          const SizedBox(
                            height: 10,
                          ),
                          //Service row

                          Text(
                            "${ln.getString('Type')}: ${provider.subsData.type}",
                            style: TextStyle(
                              color: cc.greyFour,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),

                          sizedBoxCustom(10),
                          Text(
                            '${ln.getString('Expire date')}: ' +
                                formatDate(provider.subsData.expireDate),
                            style: TextStyle(
                              color: cc.primaryColor,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ]),
                  ),

                  //Connect details
                  //================>
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper()
                              .titleCommon(ln.getString('Connect details')),
                          const SizedBox(
                            height: 25,
                          ),
                          //Service row

                          Container(
                            child: PaymentHelper().bRow(
                                'null',
                                ln.getString('Available connect'),
                                '${provider.subsData.connect}'),
                          ),

                          Container(
                            child: PaymentHelper().bRow(
                                'null',
                                ln.getString('Pending connect'),
                                '${provider.subsData.initialConnect}',
                                lastBorder: false),
                          ),
                        ]),
                  ),

                  //Payment details
                  //================>
                  Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonHelper()
                              .titleCommon(ln.getString('Payment details')),
                          const SizedBox(
                            height: 25,
                          ),
                          //Service row

                          Container(
                            child: PaymentHelper().bRow(
                                'null',
                                ln.getString('Payment gateway'),
                                '${removeUnderscore(provider.subsData.paymentGateway)}'),
                          ),

                          Container(
                            child: PaymentHelper().bRow(
                                'null',
                                ln.getString('Payment status'),
                                '${provider.subsData.paymentStatus}',
                                lastBorder: false),
                          ),
                        ]),
                  ),

                  sizedBoxCustom(5),

                  CommonHelper().buttonPrimary('Reniew Subscription', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => PaymentChoosePage(
                          reniewSubscription: true,
                          price: provider.subsData.price,
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
