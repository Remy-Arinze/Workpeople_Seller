// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';

class MyServicesCard extends StatelessWidget {
  const MyServicesCard({
    Key? key,
    required this.imageLink,
    required this.title,
    required this.viewCount,
    required this.price,
  }) : super(key: key);

  final imageLink;
  final title;
  final viewCount;
  final price;

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    return Consumer<AppStringService>(
      builder: (context, asProvider, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonHelper().profileImage(imageLink, 75, 78),
          const SizedBox(
            width: 13,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //service name ======>
                Text(
                  title.toString(),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: cc.greyFour,
                    fontSize: 15,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                //Author name
                const SizedBox(
                  height: 10,
                ),

                Row(
                  children: [
                    // Text(
                    //   'Orders: 17',
                    //   textAlign: TextAlign.start,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(
                    //     color: cc.greyFour,
                    //     fontSize: 13,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // const SizedBox(
                    //   width: 16,
                    // ),
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 18,
                      color: cc.successColor,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      viewCount.toString(),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
