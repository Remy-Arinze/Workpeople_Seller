import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/subscription_service.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';
import 'package:qixer_seller/view/subscription/subscription_details_page.dart';

class SubscriptionBadge extends StatelessWidget {
  const SubscriptionBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<SubscriptionService>(
        builder: (context, provider, child) => provider.subsData != null
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const SubscriptionDetailsPage(),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.subsData.type +
                                  ' ${ConstString.subscription}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            sizedBoxCustom(6),
                            Text(
                              '${ln.getString(ConstString.expireDate)}: ' +
                                  formatDate(provider.subsData.expireDate),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      )
                    ],
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
