import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/orders/booking_helper.dart';

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
      appBar: CommonHelper().appbarCommon('Subscription', context, () {
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
              CommonHelper().paragraphCommon(
                  'Note: Pending connect will be added to available connect only if the payment status is completed',
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonHelper().titleCommon('Silver subscription'),
                      const SizedBox(
                        height: 10,
                      ),
                      //Service row

                      Text(
                        "Type: yearly",
                        style: TextStyle(
                          color: cc.primaryColor,
                          fontSize: 14,
                          height: 1.4,
                        ),
                      ),

                      sizedBoxCustom(10),
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

              //Connect details
              //================>
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonHelper().titleCommon('Connect details'),
                      const SizedBox(
                        height: 25,
                      ),
                      //Service row

                      Container(
                        child: BookingHelper()
                            .bRow('null', 'Available connect', '410'),
                      ),

                      Container(
                        child: BookingHelper().bRow(
                            'null', 'Pending connect', '200',
                            lastBorder: false),
                      ),
                    ]),
              ),

              //Payment details
              //================>
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonHelper().titleCommon('Payment details'),
                      const SizedBox(
                        height: 25,
                      ),
                      //Service row

                      Container(
                        child: BookingHelper()
                            .bRow('null', 'Payment gateway', 'Manual payment'),
                      ),

                      Container(
                        child: BookingHelper().bRow(
                            'null', 'Payment status', 'Pending',
                            lastBorder: false),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
