import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/my_services/edit_attribute_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/constant_styles.dart';
import 'package:qixer_seller/view/utils/custom_input.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';

class EditAdditional extends StatefulWidget {
  const EditAdditional({Key? key}) : super(key: key);

  @override
  State<EditAdditional> createState() => _EditAdditionalState();
}

class _EditAdditionalState extends State<EditAdditional> {
  final titleController = TextEditingController();
  final qtyController = TextEditingController();

  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<EditAttributeService>(
      builder: (context, provider, child) => Consumer<AppStringService>(
        builder: (context, ln, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonHelper().titleCommon(ln.getString('Add Additional Services'),
                fontsize: 18),

            sizedBoxCustom(18),

            //
            CommonHelper().labelCommon(ln.getString("Title")),
            CustomInput(
              controller: titleController,
              paddingHorizontal: 15,
              hintText: ln.getString("Enter title"),
              textInputAction: TextInputAction.next,
            ),

            //
            CommonHelper().labelCommon(ln.getString("Unit price")),
            CustomInput(
              controller: priceController,
              paddingHorizontal: 15,
              isNumberField: true,
              hintText: ln.getString("Enter price"),
              textInputAction: TextInputAction.next,
            ),

//
            CommonHelper().labelCommon(ln.getString("Quantity")),
            CustomInput(
              controller: qtyController,
              paddingHorizontal: 15,
              isNumberField: true,
              hintText: ln.getString("Enter quantity"),
              textInputAction: TextInputAction.next,
            ),

            //Add button
            //=========>
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    if (titleController.text.trim().isEmpty ||
                        priceController.text.trim().isEmpty ||
                        qtyController.text.trim().isEmpty) {
                      OthersHelper().showSnackBar(
                          context,
                          ln.getString('Please fill out all fields'),
                          Colors.red);
                      return;
                    }
                    provider.addAdditional(
                        title: titleController.text,
                        price: priceController.text,
                        qty: qtyController.text,
                        context: context);

                    //clear
                    titleController.clear();
                    priceController.clear();
                    qtyController.clear();
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
            if (provider.additionalList.isNotEmpty)
              ListView.builder(
                  itemCount: provider.additionalList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
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
                                  provider.additionalList[index]['title'],
                                  marginBotton: 0),
                              Row(
                                children: [
                                  CommonHelper().paragraphCommon(
                                    "x${provider.additionalList[index]['qty']}   \$${provider.additionalList[index]['price']}",
                                    TextAlign.left,
                                  ),

                                  //image
                                  if (provider.additionalList[index]['image'] !=
                                      null)
                                    InkWell(
                                      onTap: () {},
                                      child: Column(
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Image.file(
                                              // File(provider.images[i].path),
                                              File(provider
                                                  .additionalList[index]
                                                      ['image']
                                                  .path),
                                              height: 30,
                                              width: 30,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              ),
                            ],
                          )),

                          //icon
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: InkWell(
                              onTap: () {
                                provider.removeAdditional(index);
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
          ],
        ),
      ),
    );
  }
}
