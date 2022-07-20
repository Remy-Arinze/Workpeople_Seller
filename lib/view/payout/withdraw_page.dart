import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/withdraw_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/custom_input.dart';
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
              child: Consumer<WithdrawService>(
                builder: (context, provider, child) => Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenPadding, vertical: 10),
                    child: Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Priority dropdown ======>
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHelper().labelCommon("Gateway"),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: cc.greyFive),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    // menuMaxHeight: 200,
                                    // isExpanded: true,
                                    value: provider.selectedgateway,
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
                                          provider.gatewayDropdownIndexList[
                                              provider.gatewayDropdownList
                                                  .indexOf(newValue!)]);
                                    },
                                    items: provider.gatewayDropdownList
                                        .map<DropdownMenuItem<String>>((value) {
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
                            hintText: 'your payment account details',
                            notesController: descController,
                          ),

                          //Save button =========>

                          const SizedBox(
                            height: 30,
                          ),
                          CommonHelper().buttonPrimary('Withdraw', () {
                            if (_formKey.currentState!.validate()) {
                              if (provider.isLoading == false) {
                                // provider.createTicket(
                                //     context,
                                //     amountController.text,
                                //     provider.selectedPriority,
                                //     descController.text,
                                //     provider.selectedOrderId);
                              }
                            }
                          },
                              isloading:
                                  provider.isLoading == false ? false : true)
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