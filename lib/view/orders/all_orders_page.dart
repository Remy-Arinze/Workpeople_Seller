import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/services/orders_service.dart';
import 'package:qixer_seller/services/rtl_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/orders/order_details_page.dart';

import 'orders_helper.dart';

class AllOrdersPage extends StatefulWidget {
  const AllOrdersPage({Key? key}) : super(key: key);

  @override
  _AllOrdersPageState createState() => _AllOrdersPageState();
}

class _AllOrdersPageState extends State<AllOrdersPage> {
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('All Orders', context, () {
          Navigator.pop(context);
        }),
        body: SmartRefresher(
          controller: refreshController,
          enablePullUp: true,
          enablePullDown:
              context.watch<OrdersService>().currentPage > 1 ? false : true,
          onRefresh: () async {
            final result =
                await Provider.of<OrdersService>(context, listen: false)
                    .fetchAllOrders(context);
            if (result) {
              refreshController.refreshCompleted();
            } else {
              refreshController.refreshFailed();
            }
          },
          onLoading: () async {
            final result =
                await Provider.of<OrdersService>(context, listen: false)
                    .fetchAllOrders(context);
            if (result) {
              debugPrint('loadcomplete ran');
              //loadcomplete function loads the data again
              refreshController.loadComplete();
            } else {
              debugPrint('no more data');
              refreshController.loadNoData();

              Future.delayed(const Duration(seconds: 1), () {
                //it will reset footer no data state to idle and will let us load again
                refreshController.resetNoData();
              });
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
                physics: physicsCommon,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenPadding),
                  child: Consumer<OrdersService>(
                    builder: (context, provider, child) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < provider.allOrdersList.length;
                              i++)
                            InkWell(
                              onTap: () {
                                Provider.of<OrderDetailsService>(context,
                                        listen: false)
                                    .fetchOrderDetails(
                                        provider.allOrdersList[i].id);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          const OrderDetailsPage(),
                                    ));
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
                                        'Order id: ' +
                                            provider.allOrdersList[i].id
                                                .toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: cc.primaryColor,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          //if online service,show online capsule
                                          provider.allOrdersList[i]
                                                      .isOrderOnline ==
                                                  1
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  child: OrdersHelper()
                                                      .statusCapsule('Online',
                                                          cc.primaryColor),
                                                )
                                              : Container(),

                                          OrdersHelper().statusCapsule(
                                              OrderDetailsService()
                                                  .getOrderStatus(provider
                                                      .allOrdersList[i].status),
                                              cc.greyFour),
                                        ],
                                      )
                                    ],
                                  ),

                                  //Divider
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 17, bottom: 20),
                                    child: CommonHelper().dividerCommon(),
                                  ),

                                  //Date and schedule
                                  provider.allOrdersList[i].isOrderOnline == 1
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                OrdersHelper().orderRow(
                                                  'assets/svg/calendar.svg',
                                                  'Date',
                                                  provider.allOrdersList[i].date
                                                      .toString(),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 14),
                                                  child: CommonHelper()
                                                      .dividerCommon(),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                OrdersHelper().orderRow(
                                                  'assets/svg/clock.svg',
                                                  'Schedule',
                                                  provider
                                                      .allOrdersList[i].schedule
                                                      .toString(),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 14),
                                                  child: CommonHelper()
                                                      .dividerCommon(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),

                                  Consumer<RtlService>(
                                    builder: (context, rtlP, child) =>
                                        OrdersHelper().orderRow(
                                      'assets/svg/bill.svg',
                                      'Billed',
                                      rtlP.currencyDirection == 'left'
                                          ? '${rtlP.currency}${provider.allOrdersList[i].total}'
                                          : '${provider.allOrdersList[i].total}${rtlP.currency}',
                                    ),
                                  )
                                ]),
                              ),
                            ),

                          //
                        ]),
                  ),
                )),
          ),
        ));
  }
}
