import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/payments_service/payment_constants.dart';
import 'package:qixer_seller/services/payments_service/payment_details_service.dart';
import 'package:qixer_seller/services/payments_service/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/payments_service/payment_service.dart';
import 'package:qixer_seller/services/wallet_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';
import 'package:qixer_seller/view/orders/payment_helper.dart';
import 'package:qixer_seller/view/wallet/components/deposite_amount_section.dart';

import '../../services/payments_service/gateway_services/bank_transfer_service.dart';

class PaymentChoosePage extends StatefulWidget {
  const PaymentChoosePage(
      {Key? key,
      this.isFromDepositeToWallet = false,
      this.reniewSubscription = false,
      this.price})
      : super(key: key);

  final bool isFromDepositeToWallet;
  final bool reniewSubscription;
  final price;

  @override
  _PaymentChoosePageState createState() => _PaymentChoosePageState();
}

class _PaymentChoosePageState extends State<PaymentChoosePage> {
  @override
  void initState() {
    super.initState();
  }

  final amountController = TextEditingController();

  int selectedMethod = 0;
  bool termsAgree = false;
  bool depositeFromCurrent = false;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    //fetch payment gateway list
    Provider.of<PaymentGatewayListService>(context, listen: false)
        .fetchGatewayList();

    Future.delayed(const Duration(microseconds: 500), () {
      Provider.of<PaymentService>(context, listen: false)
          .setDepositeFromCurrent(false);
      Provider.of<WalletService>(context, listen: false).setAmount(null);
    });

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Payment', context, () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Consumer<AppStringService>(
            builder: (context, asProvider, child) => Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Consumer<PaymentGatewayListService>(
                builder: (context, pgProvider, child) => pgProvider
                        .paymentDropdownList.isNotEmpty
                    ? Consumer<PaymentService>(
                        builder: (context, provider, child) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              if (widget.price != null)
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 10, bottom: 5),
                                  child: PaymentHelper().detailsPanelRow(
                                      asProvider.getString('Total Payable'),
                                      0,
                                      widget.price.toString()),
                                ),

                              //Deposite amount section
                              if (widget.isFromDepositeToWallet)
                                const DepositeAmountSection(),

                              //
                              if (!provider.depositeFromCurrent)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 8, bottom: 16),
                                      child: CommonHelper().dividerCommon(),
                                    ),

                                    CommonHelper().titleCommon(asProvider
                                        .getString('Choose payment method')),

                                    //payment method card
                                    GridView.builder(
                                      gridDelegate:
                                          const FlutterzillaFixedGridView(
                                              crossAxisCount: 3,
                                              mainAxisSpacing: 15,
                                              crossAxisSpacing: 15,
                                              height: 60),
                                      padding: const EdgeInsets.only(top: 30),
                                      itemCount:
                                          pgProvider.paymentDropdownList.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      clipBehavior: Clip.none,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedMethod = index;
                                            });

                                            pgProvider.setSelectedMethodName(
                                                pgProvider.paymentDropdownList[
                                                    selectedMethod]['name']);

                                            //set key
                                            pgProvider.setKey(
                                                pgProvider.paymentDropdownList[
                                                    selectedMethod]['name'],
                                                index);

                                            //save selected payment method name
                                            Provider.of<PaymentDetailsService>(
                                                    context,
                                                    listen: false)
                                                .setSelectedPayment(pgProvider
                                                        .paymentDropdownList[
                                                    selectedMethod]['name']);
                                          },
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 60,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: selectedMethod ==
                                                              index
                                                          ? cc.primaryColor
                                                          : cc.borderColor),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl: pgProvider
                                                          .paymentDropdownList[
                                                      index]['logo_link'],
                                                  placeholder: (context, url) {
                                                    return Image.asset(
                                                        'assets/images/placeholder.png');
                                                  },
                                                  // fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              selectedMethod == index
                                                  ? Positioned(
                                                      right: -7,
                                                      top: -9,
                                                      child: CommonHelper()
                                                          .checkCircle())
                                                  : Container()
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    pgProvider.paymentDropdownList[
                                                selectedMethod]['name'] ==
                                            'manual_payment'
                                        ?
                                        //pick image ==========>
                                        Consumer<BankTransferService>(
                                            builder: (context, btProvider,
                                                    child) =>
                                                Column(
                                                  children: [
                                                    //pick image button =====>
                                                    Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        CommonHelper().buttonPrimary(
                                                            asProvider.getString(
                                                                'Choose images'),
                                                            () {
                                                          btProvider.pickImage(
                                                              context);
                                                        }),
                                                      ],
                                                    ),
                                                    btProvider.pickedImage !=
                                                            null
                                                        ? Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              SizedBox(
                                                                height: 80,
                                                                child: ListView(
                                                                  clipBehavior:
                                                                      Clip.none,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  shrinkWrap:
                                                                      true,
                                                                  children: [
                                                                    // for (int i = 0;
                                                                    //     i <
                                                                    //         btProvider
                                                                    //             .images!.length;
                                                                    //     i++)
                                                                    InkWell(
                                                                      onTap:
                                                                          () {},
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                const EdgeInsets.only(right: 10),
                                                                            child:
                                                                                Image.file(
                                                                              File(btProvider.pickedImage.path),
                                                                              height: 80,
                                                                              width: 80,
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        : Container(),
                                                  ],
                                                ))
                                        : Container(),

                                    sizedBoxCustom(20),

                                    //Agreement checkbox ===========>

                                    CheckboxListTile(
                                      checkColor: Colors.white,
                                      activeColor:
                                          ConstantColors().primaryColor,
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Text(
                                          asProvider.getString(
                                              'I agree with terms and conditions'),
                                          style: TextStyle(
                                              color: ConstantColors().greyFour,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                      value: termsAgree,
                                      onChanged: (newValue) {
                                        setState(() {
                                          termsAgree = !termsAgree;
                                        });
                                      },
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                    ),
                                  ],
                                ),

                              //pay button =============>
                              const SizedBox(
                                height: 20,
                              ),
                              CommonHelper().buttonPrimary(
                                  asProvider.getString('Pay & Confirm'),
                                  () async {
                                var w = await Provider.of<WalletService>(
                                        context,
                                        listen: false)
                                    .validate(
                                        context, widget.isFromDepositeToWallet);

                                if (w == false) return;

                                if (termsAgree == false &&
                                    provider.depositeFromCurrent == false) {
                                  OthersHelper().showToast(
                                      asProvider.getString(
                                          'You must agree with the terms and conditions to place the order'),
                                      Colors.black);
                                  return;
                                }
                                if (provider.isloading == true) {
                                  return;
                                } else {
                                  if (provider.depositeFromCurrent) {
                                    Provider.of<WalletService>(context,
                                            listen: false)
                                        .depositeFromCurrentBalance(context);
                                  } else {
                                    payAction(
                                        pgProvider.paymentDropdownList[
                                            selectedMethod]['name'],
                                        context,
                                        //if user selected bank transfer
                                        pgProvider.paymentDropdownList[
                                                    selectedMethod]['name'] ==
                                                'manual_payment'
                                            ? Provider.of<BankTransferService>(
                                                    context,
                                                    listen: false)
                                                .pickedImage
                                            : null,
                                        isFromWalletDeposite:
                                            widget.isFromDepositeToWallet,
                                        reniewSubscription:
                                            widget.reniewSubscription);
                                  }
                                }
                              },
                                  isloading: provider.isloading == false
                                      ? false
                                      : true),

                              const SizedBox(
                                height: 30,
                              )
                            ]),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: OthersHelper().showLoading(cc.primaryColor),
                      ),
              ),
            ),
          ),
        ));
  }
}
