// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_styles.dart';

class ShowAttributeSection extends StatelessWidget {
  const ShowAttributeSection({
    Key? key,
    required this.sectionTitle,
    required this.dataList,
  }) : super(key: key);

  final sectionTitle;
  final dataList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 25),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(9)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHelper().titleCommon(sectionTitle),
              const SizedBox(
                height: 20,
              ),
              for (int i = 0; i < dataList.length; i++)
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CommonHelper().titleCommon(
                            dataList[i].includeServiceTitle.toString(),
                            fontsize: 14),
                      ),

                      // delete button

                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                  CommonHelper().paragraphCommon(
                      'Unit price: \$${dataList[i].includeServicePrice}    Quantity: ${dataList[i].includeServiceQuantity}',
                      TextAlign.left),
                  sizedBoxCustom(20),
                ])
            ],
          ),
        )
      ],
    );
  }
}
