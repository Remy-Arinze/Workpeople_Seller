import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/cat_subcat_dropdown_service_for_edit_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/others_helper.dart';

class ChildCategoryDropdownForEditService extends StatelessWidget {
  const ChildCategoryDropdownForEditService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Consumer<CatSubcatDropdownServiceForEditService>(
        builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonHelper().labelCommon(ConstString.childCategory),
                provider.childCategoryDropdownList.isNotEmpty
                    ? Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(color: cc.greyFive),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            // menuMaxHeight: 200,
                            isExpanded: true,
                            value: provider.selectedChildCategory,
                            icon: Icon(Icons.keyboard_arrow_down_rounded,
                                color: cc.greyFour),
                            iconSize: 26,
                            elevation: 17,
                            style: TextStyle(color: cc.greyFour),
                            onChanged: (newValue) {
                              provider.setChildCategoryValue(newValue);

                              //setting the id of selected value
                              provider.setSelectedChildCategoryId(
                                  provider.childCategoryDropdownIndexList[
                                      provider.childCategoryDropdownList
                                          .indexOf(newValue!)]);

                              // provider.fetchSubcategory(provider.selectedCategoryId);
                            },
                            items: provider.childCategoryDropdownList
                                .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: cc.greyPrimary.withOpacity(.8)),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [OthersHelper().showLoading(cc.primaryColor)],
                      ),
              ],
            ));
  }
}
