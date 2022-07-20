import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/responsive.dart';
import 'package:qixer_seller/view/payout/withdraw_page.dart';

class PayoutPageAppbar extends StatelessWidget {
  const PayoutPageAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return AppBar(
      iconTheme: IconThemeData(color: cc.greyPrimary),
      title: Text(
        'Payout history',
        style: TextStyle(
            color: cc.greyPrimary, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.arrow_back_ios,
          size: 18,
        ),
      ),
      actions: [
        Container(
          width: screenWidth / 4,
          padding: const EdgeInsets.symmetric(
            vertical: 9,
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const WithdrawPage(),
                ),
              );
            },
            child: Container(
                // width: double.infinity,

                alignment: Alignment.center,
                // padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: cc.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                child: const AutoSizeText(
                  'Withdraw',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                )),
          ),
        ),
        const SizedBox(
          width: 25,
        ),
      ],
    );
  }
}
