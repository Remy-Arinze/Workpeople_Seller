import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/orders/payment_helper.dart';

class DateSchedule extends StatelessWidget {
  const DateSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<OrderDetailsService>(
        builder: (context, provider, child) => Column(
          children: [
            provider.orderDetails.isOrderOnline == 0
                ? Container(
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
                              .titleCommon(ln.getString('Date & Schedule')),
                          const SizedBox(
                            height: 25,
                          ),
                          //Service row

                          Container(
                            child: PaymentHelper().bRow(
                                'null',
                                ln.getString('Date'),
                                provider.orderDetails.date ?? ''),
                          ),

                          Container(
                            child: PaymentHelper().bRow(
                                'null',
                                ln.getString('Schedule'),
                                provider.orderDetails.schedule ?? '',
                                lastBorder: false),
                          ),
                        ]),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
