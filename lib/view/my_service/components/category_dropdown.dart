import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/category_dropdown_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/others_helper.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<CategoryDropdownService>(context, listen: false)
        .fetchCategory();

    ConstantColors cc = ConstantColors();

    return Consumer<CategoryDropdownService>(
      builder: (context, provider, child) =>
          provider.categoryDropdownList.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHelper().labelCommon("Category"),
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
                          isExpanded: true,
                          value: provider.selectedCategory,
                          icon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: cc.greyFour),
                          iconSize: 26,
                          elevation: 17,
                          style: TextStyle(color: cc.greyFour),
                          onChanged: (newValue) {
                            provider.setCategoryValue(newValue);

                            //setting the id of selected value
                            provider.setSelectedCategoryId(
                                provider.categoryDropdownIndexList[provider
                                    .categoryDropdownList
                                    .indexOf(newValue!)]);

                            // provider.fetchSubcategory(provider.selectedCategoryId);
                          },
                          items: provider.categoryDropdownList
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
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [OthersHelper().showLoading(cc.primaryColor)],
                ),
    );
  }
}
