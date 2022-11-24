import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/orders_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_styles.dart';

class DeclineHistory extends StatelessWidget {
  const DeclineHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrdersService>(
      builder: (context, provider, child) => provider.declineHistory != null
          ? Container(
              margin: const EdgeInsets.only(bottom: 25),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(9)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonHelper().titleCommon('Decline history'),
                  for (int i = 0;
                      i < provider.declineHistory['decline_histories'].length;
                      i++)
                    Container(
                      margin: const EdgeInsets.only(top: 17),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().titleCommon(
                                "Decline reason:  ${provider.declineHistory['decline_histories'][i]['decline_reason']}",
                                fontsize: 14),
                            sizedBoxCustom(11),
                            CommonHelper()
                                .titleCommon('Buyer details:', fontsize: 14),
                            sizedBoxCustom(8),
                            CommonHelper().paragraphCommon(
                                'Name: ${provider.declineHistory['buyer_details'][0]['name']}',
                                TextAlign.left),
                            sizedBoxCustom(4),
                            CommonHelper().paragraphCommon(
                                'Email: ${provider.declineHistory['buyer_details'][0]['email']}',
                                TextAlign.left),
                            sizedBoxCustom(4),
                            CommonHelper().paragraphCommon(
                                'Phone: ${provider.declineHistory['buyer_details'][0]['phone']}',
                                TextAlign.left),
                            sizedBoxCustom(20),
                            CommonHelper().dividerCommon()
                          ]),
                    )
                ],
              ),
            )
          : Container(),
    );
  }
}
