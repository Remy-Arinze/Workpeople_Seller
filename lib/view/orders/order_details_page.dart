import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/orders/booking_helper.dart';
import '../../utils/others_helper.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  _OrdersDetailsPageState createState() => _OrdersDetailsPageState();
}

class _OrdersDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cc.bgColor,
        appBar: CommonHelper().appbarCommon('Order Details', context, () {
          Navigator.pop(context);
        }),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Consumer<AppStringService>(
              builder: (context, ln, child) => Consumer<OrderDetailsService>(
                builder: (context, provider, child) => provider.isLoading ==
                        false
                    ? provider.orderDetails != 'error'
                        ? Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //Service name
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.only(bottom: 25),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(9)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonHelper().titleCommon(
                                              ln.getString('Ordered service')),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          //Service row

                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // CommonHelper().profileImage(
                                              //     'https://cdn.pixabay.com/photo/2022/07/13/22/27/butterfly-7320158__340.jpg',
                                              //     50,
                                              //     50),
                                              Text(
                                                ln.getString("Service ID:") +
                                                    " ${provider.orderDetails.id}",
                                                style: TextStyle(
                                                  color: cc.primaryColor,
                                                  fontSize: 14,
                                                  height: 1.4,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                provider.orderedServiceTitle,
                                                style: TextStyle(
                                                  color: cc.greyThree,
                                                  fontSize: 14,
                                                  height: 1.4,
                                                ),
                                              )
                                            ],
                                          )
                                        ]),
                                  ),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(9)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonHelper().titleCommon(
                                              ln.getString('Buyer Details')),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          //Service row

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Name'),
                                                provider.orderDetails
                                                    .buyerDetails.name),
                                          ),

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Email'),
                                                provider.orderDetails
                                                        .buyerDetails.email ??
                                                    ''),
                                          ),

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Phone'),
                                                provider.orderDetails
                                                        .buyerDetails.phone ??
                                                    ''),
                                          ),
                                          provider.orderDetails.isOrderOnline ==
                                                  0
                                              ? Container(
                                                  child: BookingHelper().bRow(
                                                      'null',
                                                      ln.getString('Post code'),
                                                      provider
                                                              .orderDetails
                                                              .buyerDetails
                                                              .postCode ??
                                                          ''),
                                                )
                                              : Container(),
                                          provider.orderDetails.isOrderOnline ==
                                                  0
                                              ? Container(
                                                  child: BookingHelper().bRow(
                                                      'null',
                                                      ln.getString('Address'),
                                                      provider
                                                              .orderDetails
                                                              .buyerDetails
                                                              .address ??
                                                          '',
                                                      lastBorder: false),
                                                )
                                              : Container(),
                                        ]),
                                  ),

                                  // Date and schedule
                                  provider.orderDetails.isOrderOnline == 0
                                      ? Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 25),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(9)),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CommonHelper().titleCommon(
                                                    ln.getString(
                                                        'Date & Schedule')),
                                                const SizedBox(
                                                  height: 25,
                                                ),
                                                //Service row

                                                Container(
                                                  child: BookingHelper().bRow(
                                                      'null',
                                                      ln.getString('Date'),
                                                      provider.orderDetails
                                                              .date ??
                                                          ''),
                                                ),

                                                Container(
                                                  child: BookingHelper().bRow(
                                                      'null',
                                                      ln.getString('Schedule'),
                                                      provider.orderDetails
                                                              .schedule ??
                                                          '',
                                                      lastBorder: false),
                                                ),
                                              ]),
                                        )
                                      : Container(),

                                  Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(9)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonHelper().titleCommon(
                                              ln.getString('Amount Details')),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          //Service row

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Package fee'),
                                                provider.orderDetails.packageFee
                                                    .toString()),
                                          ),

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Extra service'),
                                                provider
                                                    .orderDetails.extraService
                                                    .toString()),
                                          ),

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Subtotal'),
                                                provider.orderDetails.subTotal
                                                    .toString()),
                                          ),

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Tax'),
                                                provider.orderDetails.tax
                                                    .toString()),
                                          ),

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Total'),
                                                provider.orderDetails.total
                                                    .toString()),
                                          ),

                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Payment status'),
                                                provider.orderDetails
                                                        .paymentStatus ??
                                                    '',
                                                lastBorder: false),
                                          ),
                                        ]),
                                  ),

                                  // Order status
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 25),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(9)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CommonHelper().titleCommon(
                                              ln.getString('Order Status')),
                                          const SizedBox(
                                            height: 25,
                                          ),
                                          Container(
                                            child: BookingHelper().bRow(
                                                'null',
                                                ln.getString('Order status'),
                                                provider.orderStatus ?? "",
                                                lastBorder: false),
                                          ),
                                        ]),
                                  ),

                                  //
                                ]),
                          )
                        : CommonHelper().nothingfound(
                            context, ln.getString("No details found"))
                    : Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height - 120,
                        child: OthersHelper().showLoading(cc.primaryColor)),
              ),
            ),
          ),
        ));
  }
}
