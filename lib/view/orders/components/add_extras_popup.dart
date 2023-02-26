import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/order_details_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/custom_input.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';

class AddExtrasPopup extends StatelessWidget {
  const AddExtrasPopup({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  final orderId;

  @override
  Widget build(BuildContext context) {
    final cc = ConstantColors();

    final titleController = TextEditingController();
    final quantityController = TextEditingController();
    final priceController = TextEditingController();

    return Consumer<OrderDetailsService>(
      builder: (context, provider, child) => Consumer<AppStringService>(
        builder: (context, ln, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Name ============>
            CommonHelper().labelCommon(ln.getString('Title')),

            CustomInput(
              controller: titleController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return ln.getString('Please enter a title');
                }
                return null;
              },
              hintText: ln.getString('Title'),
              textInputAction: TextInputAction.next,
            ),

            //Name ============>
            CommonHelper().labelCommon(ln.getString('Quantity')),

            CustomInput(
              controller: quantityController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return ln.getString('Please enter a quantity');
                }
                return null;
              },
              hintText: ln.getString('Quantity'),
              textInputAction: TextInputAction.next,
            ),

            //Name ============>
            CommonHelper().labelCommon(ln.getString('Price')),

            CustomInput(
              controller: priceController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return ln.getString('Please enter a price');
                }
                return null;
              },
              hintText: ln.getString('Price'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 5,
            ),

            CommonHelper().buttonPrimary('Add', () {
              if (provider.isLoading == true) return;

              if (double.tryParse(priceController.text.trim()) == null) {
                //if not integer value
                OthersHelper().showSnackBar(context,
                    ln.getString('You must enter a valid amount'), Colors.red);
                return;
              }
              if (double.tryParse(quantityController.text.trim()) == null) {
                //if not integer value
                OthersHelper().showSnackBar(
                    context,
                    ln.getString('Quantity must be an integer value'),
                    Colors.red);
                return;
              }

              provider.addOrderExtra(context,
                  orderId: orderId,
                  title: titleController.text,
                  price: priceController.text,
                  quantity: quantityController.text);
            }, isloading: provider.isLoading == true ? true : false),
          ],
        ),
      ),
    );
  }
}
