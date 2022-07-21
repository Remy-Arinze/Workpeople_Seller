import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/deactivate_account_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/profile/components/textarea_field.dart';

class DeactivateAccount extends StatelessWidget {
  const DeactivateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    TextEditingController descController = TextEditingController();
    return Consumer<DeactivateAccountService>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // dropdown ======>
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHelper().titleCommon('Deactivate account'),
              sizedBox20(),
              CommonHelper().labelCommon("Choose Reason"),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: cc.greyFive),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    // menuMaxHeight: 200,
                    // isExpanded: true,
                    value: provider.selecteddeactivateReason,
                    icon: Icon(Icons.keyboard_arrow_down_rounded,
                        color: cc.greyFour),
                    iconSize: 26,
                    elevation: 17,
                    style: TextStyle(color: cc.greyFour),
                    onChanged: (newValue) {
                      provider.setdeactivateReasonValue(newValue);

                      //setting the id of selected value
                      provider.setSelecteddeactivateReasonId(
                          provider.deactivateReasonDropdownList[provider
                              .deactivateReasonDropdownList
                              .indexOf(newValue!)]);
                    },
                    items: provider.deactivateReasonDropdownList
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style:
                              TextStyle(color: cc.greyPrimary.withOpacity(.8)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(
            height: 20,
          ),
          CommonHelper().labelCommon("Short description"),

          TextareaField(
            hintText: 'description',
            notesController: descController,
          ),

          const SizedBox(
            height: 30,
          ),

          InkWell(
            onTap: () {},
            child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                    color: cc.orangeColor,
                    borderRadius: BorderRadius.circular(8)),
                child: provider.isLoading == false
                    ? const Text(
                        'Deactivate account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    : OthersHelper().showLoading(Colors.white)),
          ),

          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
