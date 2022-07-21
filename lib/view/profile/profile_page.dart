import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/profile_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/orders/booking_helper.dart';
import 'package:qixer_seller/view/profile/profile_edit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Profile', context, () {
          Navigator.pop(context);
        }),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Consumer<ProfileService>(
                  builder: (context, profileProvider, child) =>
                      // profileProvider
                      //             .profileDetails !=
                      //         null
                      //     ?
                      //  profileProvider.profileDetails != 'error'
                      // ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: screenPadding),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //profile image, name ,desc
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        //Profile image section =======>
                                        InkWell(
                                          highlightColor: Colors.transparent,
                                          splashColor: Colors.transparent,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        ProfileEditPage(),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              profileProvider.profileImage !=
                                                      null
                                                  ? CommonHelper().profileImage(
                                                      placeHolderUrl, 62, 62)
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.asset(
                                                        'assets/images/avatar.png',
                                                        height: 62,
                                                        width: 62,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),

                                              const SizedBox(
                                                height: 12,
                                              ),

                                              //user name
                                              CommonHelper()
                                                  .titleCommon('saleheen'),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              //phone
                                              CommonHelper().paragraphCommon(
                                                  '53384135135',
                                                  TextAlign.center),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              CommonHelper().paragraphCommon(
                                                  'Mobile app developer',
                                                  TextAlign.center)
                                            ],
                                          ),
                                        ),

                                        //Grid cards
                                      ],
                                    ),
                                  ),

                                  //
                                ]),
                          ),

                          const SizedBox(
                            height: 10,
                          ),

                          // Personal information ==========>
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: screenPadding),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  BookingHelper().bRow(
                                      'null', 'Email', 'smsaleheen@gmail.com'),
                                  BookingHelper().bRow('null', 'City', 'Dhaka'),
                                  BookingHelper()
                                      .bRow('null', 'Area', 'Banasree'),
                                  BookingHelper()
                                      .bRow('null', 'Country', 'Bangladesh'),
                                  BookingHelper()
                                      .bRow('null', 'Post Code', '1212'),
                                  BookingHelper().bRow(
                                      'null', 'Address', 'Dhaka, Bangladesh',
                                      lastBorder: false),
                                ]),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          CommonHelper().buttonPrimary('Edit Profile', () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    ProfileEditPage(),
                              ),
                            );
                          })
                        ],
                      )
                  //     : OthersHelper().showError(context)
                  // : Container(
                  //     alignment: Alignment.center,
                  //     height: MediaQuery.of(context).size.height - 150,
                  //     child: OthersHelper().showLoading(cc.primaryColor),
                  //   ),
                  ),
            ),
          ),
        ));
  }
}
