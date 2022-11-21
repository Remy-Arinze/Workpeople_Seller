import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_styles.dart';

class OrderExtras extends StatelessWidget {
  const OrderExtras({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(9)),
      child: Consumer<OrderDetailsService>(
        builder: (context, provider, child) => provider.isLoading == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonHelper().titleCommon('Extras'),
                  const SizedBox(
                    height: 20,
                  ),
                  for (int i = 0; i < provider.orderExtra.length; i++)
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CommonHelper().titleCommon(
                                    provider.orderExtra[i].title.toString(),
                                    fontsize: 14),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: const Icon(
                                  Icons.delete_forever,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          CommonHelper().paragraphCommon(
                              'Unit price: \$${provider.orderExtra[i].price.toStringAsFixed(2)}    Quantity: ${provider.orderExtra[i].quantity}',
                              TextAlign.left),
                          const SizedBox(
                            height: 4,
                          ),
                          CommonHelper().paragraphCommon(
                              'Total: \$${provider.orderExtra[i].total.toStringAsFixed(2)}',
                              TextAlign.left),
                          sizedBoxCustom(20),
                        ])
                ],
              )
            : Container(),
      ),
    );
  }
}
