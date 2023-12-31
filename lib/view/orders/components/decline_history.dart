import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/orders_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';

class DeclineHistory extends StatelessWidget {
  const DeclineHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<OrdersService>(
        builder: (context, provider, child) => provider.declineHistory != null
            ? Container(
                margin: const EdgeInsets.only(bottom: 25),
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHelper().titleCommon('Decline history'),
                    for (int i = 0;
                        i < provider.declineHistory['decline_histories'].length;
                        i++)
                      Container(
                        margin: const EdgeInsets.only(top: 13),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHelper().titleCommon(
                                  "${ln.getString("Decline reason")}:  ${provider.declineHistory['decline_histories'][i]['decline_reason']}",
                                  fontsize: 14,
                                  lineheight: 1.5),
                              sizedBoxCustom(8),
                              CommonHelper().titleCommon(
                                  '${ln.getString("Buyer details")}:',
                                  fontsize: 14,
                                  color: cc.successColor),
                              sizedBoxCustom(8),
                              CommonHelper().paragraphCommon(
                                  '${ln.getString("Name")}: ${provider.declineHistory['buyer_details'][0]['name']}',
                                  TextAlign.left),
                              sizedBoxCustom(4),
                              CommonHelper().paragraphCommon(
                                  '${ln.getString("Email")}: ${provider.declineHistory['buyer_details'][0]['email']}',
                                  TextAlign.left),
                              sizedBoxCustom(4),
                              CommonHelper().paragraphCommon(
                                  '${ln.getString("Phone")}: ${provider.declineHistory['buyer_details'][0]['phone']}',
                                  TextAlign.left),
                              sizedBoxCustom(20),
                              CommonHelper().dividerCommon()
                            ]),
                      )
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}
