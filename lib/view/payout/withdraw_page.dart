import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/payment_gateway_list_service.dart';
import 'package:qixer_seller/services/withdraw_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/custom_input.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/profile/components/textarea_field.dart';

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<PaymentGatewayListService>(context, listen: false)
        .fetchGatewayList();

    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Withdraw', context, () {
          Navigator.pop(context);
        }),
        body: WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: Listener(
            onPointerDown: (_) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: SingleChildScrollView(
              physics: physicsCommon,
              child: Consumer<PaymentGatewayListService>(
                builder: (context, provider, child) => Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenPadding, vertical: 10),
                    child: Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // dropdown ======>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHelper().labelCommon("Gateway"),
                              provider.paymentDropdownList.isNotEmpty
                                  ? Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: cc.greyFive),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          // menuMaxHeight: 200,
                                          // isExpanded: true,
                                          value: provider.selectedPayment,
                                          icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color: cc.greyFour),
                                          iconSize: 26,
                                          elevation: 17,
                                          style: TextStyle(color: cc.greyFour),
                                          onChanged: (newValue) {
                                            provider.setgatewayValue(newValue);

                                            //setting the id of selected value
                                            provider.setSelectedgatewayId(
                                                provider.paymentDropdownIndexList[
                                                    provider.paymentDropdownList
                                                        .indexOf(newValue!)]);
                                          },
                                          items: provider.paymentDropdownList
                                              .map<DropdownMenuItem<String>>(
                                                  (value) {
                                            return DropdownMenuItem(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                    color: cc.greyPrimary
                                                        .withOpacity(.8)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        OthersHelper()
                                            .showLoading(cc.primaryColor)
                                      ],
                                    ),
                            ],
                          ),

                          sizedBox20(),
                          CommonHelper().labelCommon("Amount"),
                          CustomInput(
                            controller: amountController,
                            validation: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an amount';
                              }
                              return null;
                            },
                            hintText: "Amount",
                            isNumberField: true,
                            // icon: 'assets/icons/user.png',
                            paddingHorizontal: 18,
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          CommonHelper().labelCommon("Note"),

                          TextareaField(
                            hintText: 'Note',
                            notesController: descController,
                          ),

                          sizedBox20(),
                          const Text(
                            'You can make a request only if your remaining balance in a range set by the site admin. Like admin set minimum request amount 50 and maximum request amount 500. then you can request a payment between 50 to 500.',
                            style: TextStyle(
                                color: Colors.red, fontSize: 13, height: 1.4),
                          ),

                          //Save button =========>

                          const SizedBox(
                            height: 30,
                          ),
                          Consumer<WithdrawService>(
                              builder: (context, wProvider, child) =>
                                  CommonHelper().buttonPrimary('Withdraw', () {
                                    if (_formKey.currentState!.validate()) {
                                      if (wProvider.isloading == false) {
                                        // provider.createTicket(
                                        //     context,
                                        //     amountController.text,
                                        //     provider.selectedPriority,
                                        //     descController.text,
                                        //     provider.selectedOrderId);
                                      }
                                    }
                                  },
                                      isloading: wProvider.isloading == false
                                          ? false
                                          : true))
                        ],
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
