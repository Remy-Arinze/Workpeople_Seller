import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/services/orders_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';

import 'orders_helper.dart';

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrdersService>(context, listen: false).fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('All Orders', context, () {
          Navigator.pop(context);
        }),
        body: SafeArea(
          child: SingleChildScrollView(
              physics: physicsCommon,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int i = 0; i < 2; i++)
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute<void>(
                            //       builder: (BuildContext context) =>
                            //           const OrderDetailsPage(orderId: 1),
                            //     ));
                            //             );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              top: 20,
                              bottom: 10,
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 18),
                            decoration: BoxDecoration(
                                border: Border.all(color: cc.borderColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    '#23232',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: cc.primaryColor,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      OrdersHelper().statusCapsule(
                                          OrderDetailsService()
                                              .getOrderStatus(1),
                                          cc.greyFour),
                                    ],
                                  )
                                ],
                              ),

                              //Divider
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 17, bottom: 20),
                                child: CommonHelper().dividerCommon(),
                              ),

                              Column(
                                children: [
                                  OrdersHelper().orderRow(
                                    'assets/svg/calendar.svg',
                                    'Date',
                                    '12/04/22',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: CommonHelper().dividerCommon(),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  OrdersHelper().orderRow(
                                    'assets/svg/clock.svg',
                                    'Schedule',
                                    '5/4/15',
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: CommonHelper().dividerCommon(),
                                  ),
                                ],
                              ),

                              Consumer<RtlService>(
                                builder: (context, rtlP, child) =>
                                    OrdersHelper().orderRow(
                                  'assets/svg/bill.svg',
                                  'Billed',
                                  rtlP.currencyDirection == 'left'
                                      ? '${rtlP.currency}${200}'
                                      : '${200}${rtlP.currency}',
                                ),
                              )
                            ]),
                          ),
                        ),

                      //
                    ]),
              )),
        ));
  }
}
