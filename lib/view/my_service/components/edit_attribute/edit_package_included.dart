import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/my_services/edit_attribute_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';
import 'package:qixer_seller/view/utils/custom_input.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';

class EditPackageIncluded extends StatefulWidget {
  const EditPackageIncluded({Key? key}) : super(key: key);

  @override
  State<EditPackageIncluded> createState() => _EditPackageIncludedState();
}

class _EditPackageIncludedState extends State<EditPackageIncluded> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();

  bool isOnline = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<EditAttributeService>(
      builder: (context, provider, child) => Consumer<AppStringService>(
        builder: (context, ln, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //on off button
            Row(
              children: [
                CommonHelper().paragraphCommon(
                    ln.getString(ConstString.onlineService), TextAlign.left),
                Switch(
                  // This bool value toggles the switch.
                  value: isOnline,
                  activeColor: cc.successColor,
                  onChanged: (bool value) {
                    isOnline = !isOnline;
                    setState(() {});
                  },
                ),
              ],
            ),

            sizedBoxCustom(5),

            CommonHelper().titleCommon(
                ln.getString(ConstString.whatsIncludedInPackage),
                fontsize: 18),

            sizedBoxCustom(18),
            CommonHelper().labelCommon(ln.getString(ConstString.title)),
            CustomInput(
              controller: titleController,
              paddingHorizontal: 15,
              hintText: ln.getString(ConstString.enterTitle),
              textInputAction: TextInputAction.next,
            ),

            if (!isOnline)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonHelper().labelCommon(ln.getString(ConstString.price)),
                  CustomInput(
                    controller: priceController,
                    paddingHorizontal: 15,
                    hintText: ln.getString(ConstString.enterPrice),
                    isNumberField: true,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              ),

            //Add faq button
            //=========>
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (titleController.text.trim().isEmpty) {
                      OthersHelper().showSnackBar(context,
                          ln.getString(ConstString.plzEnterTitle), Colors.red);
                      return;
                    }
                    if (priceController.text.trim().isEmpty && !isOnline) {
                      OthersHelper().showSnackBar(context,
                          ln.getString(ConstString.plzEnterPrice), Colors.red);
                      return;
                    }

                    provider.addIncludedList(titleController.text,
                        !isOnline ? priceController.text : '0');

                    //clear
                    titleController.clear();
                    priceController.clear();
                  },
                  child: Container(
                    color: cc.primaryColor,
                    padding: const EdgeInsets.all(6),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            sizedBoxCustom(10),

            //
            //--------->
            if (provider.includedList.isNotEmpty)
              Column(
                children: [
                  ListView.builder(
                      itemCount: provider.includedList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withOpacity(.2),
                              width: 1.0,
                            ),
                          )),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonHelper().labelCommon(
                                      provider.includedList[index]['title'],
                                      marginBotton: 0),
                                  CommonHelper().paragraphCommon(
                                      "\$${provider.includedList[index]['price']}",
                                      TextAlign.left)
                                ],
                              )),

                              //icon
                              Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: InkWell(
                                  onTap: () {
                                    provider.removeIncludedList(index);
                                  },
                                  child: const Icon(
                                    Icons.delete_forever,
                                    size: 27,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                  sizedBoxCustom(20),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
