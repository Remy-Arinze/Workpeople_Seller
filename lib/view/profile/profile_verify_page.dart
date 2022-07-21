import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/profile_verify_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';

class ProfileVerifyPage extends StatelessWidget {
  const ProfileVerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Verify', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Consumer<ProfileVerifyService>(
          builder: (context, provider, child) => Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenPadding,
            ),
            child: Column(
              children: [
                Text(
                  'Address document image',
                  style: TextStyle(color: cc.greyParagraph, fontSize: 15),
                ),
                provider.pickedAddressImage != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 80,
                            child: ListView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                // for (int i = 0;
                                //     i <
                                //         provider
                                //             .images!.length;
                                //     i++)
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.file(
                                          // File(provider.images[i].path),
                                          File(
                                              provider.pickedAddressImage.path),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),

                //pick image button =====>
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CommonHelper().buttonPrimary('Choose address images', () {
                      provider.pickAddressImage(context);
                    }),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),
                //NID document image ===========>
                //===============================
                Text(
                  'NID document image',
                  style: TextStyle(color: cc.greyParagraph, fontSize: 15),
                ),
                provider.pickedNidImage != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 80,
                            child: ListView(
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: [
                                // for (int i = 0;
                                //     i <
                                //         provider
                                //             .images!.length;
                                //     i++)
                                InkWell(
                                  onTap: () {},
                                  child: Column(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Image.file(
                                          // File(provider.images[i].path),
                                          File(provider.pickedNidImage.path),
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Container(),

                //pick image button =====>
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CommonHelper().buttonPrimary('Choose NID images', () {
                      provider.pickNidImage(context);
                    }),
                  ],
                ),

                //UPload button
                const SizedBox(
                  height: 20,
                ),
                CommonHelper().buttonPrimary('Upload', () {
                  provider.pickNidImage(context);
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}