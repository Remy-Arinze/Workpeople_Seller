import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/custom_input.dart';

class AddExtrasPopup extends StatelessWidget {
  const AddExtrasPopup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    final titleController = TextEditingController();
    final quantityController = TextEditingController();
    final priceController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Name ============>
        CommonHelper().labelCommon('Title'),

        CustomInput(
          controller: titleController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            return null;
          },
          hintText: 'Title',
          textInputAction: TextInputAction.next,
        ),

        //Name ============>
        CommonHelper().labelCommon('Quantity'),

        CustomInput(
          controller: titleController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a quantity';
            }
            return null;
          },
          hintText: 'Quantity',
          textInputAction: TextInputAction.next,
        ),

        //Name ============>
        CommonHelper().labelCommon('Price'),

        CustomInput(
          controller: titleController,
          validation: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a price';
            }
            return null;
          },
          hintText: 'Price',
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(
          height: 5,
        ),

        CommonHelper().buttonPrimary('Add', () {}, isloading: false),
      ],
    );
  }
}
