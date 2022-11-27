// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:qixer_seller/services/common_service.dart';
// import 'package:qixer_seller/services/wallet_service.dart';
// import 'package:qixer_seller/utils/common_helper.dart';
// import 'package:qixer_seller/utils/constant_colors.dart';
// import 'package:qixer_seller/utils/constant_styles.dart';
// import 'package:qixer_seller/utils/others_helper.dart';

// class WalletPage extends StatefulWidget {
//   const WalletPage({Key? key}) : super(key: key);

//   @override
//   _WalletPageState createState() => _WalletPageState();
// }

// class _WalletPageState extends State<WalletPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   ConstantColors cc = ConstantColors();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonHelper().appbarCommon('Wallet', context, () {
//         Navigator.pop(context);
//       }),
//       backgroundColor: cc.bgColor,
//       body: SingleChildScrollView(
//         physics: physicsCommon,
//         child: Consumer<WalletService>(
//           builder: (context, provider, child) =>
//               provider.hasWalletHistory == true
//                   ? provider.walletHistory != null
//                       ? Container(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: screenPadding, vertical: 10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               for (int i = 0; i < 4; i++)
//                                 Container(
//                                   margin: const EdgeInsets.only(bottom: 16),
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 16),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(9)),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               CommonHelper().titleCommon(
//                                                   'Silver subscription',
//                                                   fontsize: 15),
//                                               sizedBoxCustom(8),
//                                               Text(
//                                                 "Expire date: 02/11/23",
//                                                 style: TextStyle(
//                                                   color: cc.greyFour,
//                                                   fontSize: 14,
//                                                   height: 1.4,
//                                                 ),
//                                               ),
//                                             ]),
//                                       ),
//                                       // Icon(
//                                       //   Icons.arrow_forward_ios,
//                                       //   size: 16,
//                                       //   color: cc.greyFour,
//                                       // )
//                                     ],
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         )
//                       : Container(
//                           height: screenHeight(context) - 140,
//                           alignment: Alignment.center,
//                           child: OthersHelper().showLoading(cc.primaryColor),
//                         )
//                   : Container(
//                       height: screenHeight(context) - 120,
//                       alignment: Alignment.center,
//                       child: const Text('No history found'),
//                     ),
//         ),
//       ),
//     );
//   }
// }
