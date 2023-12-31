import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';

import '../../../../services/country_states_service.dart';
import '../../../utils/common_helper.dart';
import '../../../utils/others_helper.dart';

class CountryStatesDropdowns extends StatefulWidget {
  const CountryStatesDropdowns({Key? key}) : super(key: key);

  @override
  State<CountryStatesDropdowns> createState() => _CountryStatesDropdownsState();
}

class _CountryStatesDropdownsState extends State<CountryStatesDropdowns> {
  @override
  void initState() {
    super.initState();
    Provider.of<CountryStatesService>(context, listen: false)
        .fetchCountries(context);
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Consumer<CountryStatesService>(
          builder: (context, provider, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //dropdown and search box
                  const SizedBox(
                    width: 17,
                  ),

                  // Country dropdown ===============>
                  CommonHelper()
                      .labelCommon(ln.getString(ConstString.chooseCountry)),
                  provider.countryDropdownList.isNotEmpty
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
                              // isExpanded: true,
                              value: provider.selectedCountry,
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: cc.greyFour),
                              iconSize: 26,
                              elevation: 17,
                              style: TextStyle(color: cc.greyFour),
                              onChanged: (newValue) {
                                provider.setCountryValue(newValue);

                                // setting the id of selected value
                                provider.setSelectedCountryId(
                                    provider.countryDropdownIndexList[provider
                                        .countryDropdownList
                                        .indexOf(newValue)]);

                                //fetch states based on selected country
                                provider.fetchStates(
                                    provider.selectedCountryId, context);
                              },
                              items: provider.countryDropdownList
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
                          children: [
                            OthersHelper().showLoading(cc.primaryColor)
                          ],
                        ),

                  const SizedBox(
                    height: 25,
                  ),
                  // States dropdown ===============>
                  CommonHelper()
                      .labelCommon(ln.getString(ConstString.chooseStates)),
                  provider.statesDropdownList.isNotEmpty
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
                              // isExpanded: true,
                              value: provider.selectedState,
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: cc.greyFour),
                              iconSize: 26,
                              elevation: 17,
                              style: TextStyle(color: cc.greyFour),
                              onChanged: (newValue) {
                                provider.setStatesValue(newValue);

                                //setting the id of selected value
                                provider.setSelectedStatesId(
                                    provider.statesDropdownIndexList[provider
                                        .statesDropdownList
                                        .indexOf(newValue)]);
                                // //fetch area based on selected country and state

                                provider.fetchArea(provider.selectedCountryId,
                                    provider.selectedStateId, context);

                                // print(provider.statesDropdownIndexList[provider
                                //     .statesDropdownList
                                //     .indexOf(newValue)]);
                              },
                              items: provider.statesDropdownList
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
                          children: [
                            OthersHelper().showLoading(cc.primaryColor)
                          ],
                        ),

                  const SizedBox(
                    height: 25,
                  ),

                  // Area dropdown ===============>
                  CommonHelper()
                      .labelCommon(ln.getString(ConstString.chooseArea)),
                  provider.areaDropdownList.isNotEmpty
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
                              // isExpanded: true,
                              value: provider.selectedArea,
                              icon: Icon(Icons.keyboard_arrow_down_rounded,
                                  color: cc.greyFour),
                              iconSize: 26,
                              elevation: 17,
                              style: TextStyle(color: cc.greyFour),
                              onChanged: (newValue) {
                                provider.setAreaValue(newValue);

                                //setting the id of selected value
                                provider.setSelectedAreaId(
                                    provider.areaDropdownIndexList[provider
                                        .areaDropdownList
                                        .indexOf(newValue)]);
                              },
                              items: provider.areaDropdownList
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
                          children: [
                            OthersHelper().showLoading(cc.primaryColor)
                          ],
                        ),
                ],
              )),
    );
  }
}
