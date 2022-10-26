import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/common_helper.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHelper().titleCommon('Extras'),
          const SizedBox(
            height: 20,
          ),
          for (int i = 0; i < 2; i++)
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonHelper().titleCommon(
                        'Hair cut solution in your city',
                        fontsize: 14),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              CommonHelper().paragraphCommon(
                  'Price: \$100    Quantity: 3', TextAlign.left),
              const SizedBox(
                height: 14,
              ),
            ])
        ],
      ),
    );
  }
}
