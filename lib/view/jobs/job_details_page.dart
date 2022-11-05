import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/jobs/components/overview_box.dart';

import '../../utils/others_helper.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: screenPadding),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Barnaby The Bear’s my name never call me Jack or James',
            style: TextStyle(
                color: cc.greyFour,
                fontSize: 18,
                height: 1.4,
                fontWeight: FontWeight.bold),
          ),
          sizedBoxCustom(22),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              height: 180,
              width: double.infinity,
              imageUrl:
                  'https://cdn.pixabay.com/photo/2022/10/25/07/07/pumpkins-7545052_1280.jpg',
              errorWidget: (context, url, error) => const Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          sizedBoxCustom(22),
          //Name, profile image etc
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonHelper().profileImage(
                userPlaceHolderUrl,
                55,
                55,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //name
                    CommonHelper().titleCommon('Saleheen', fontsize: 17),
                    sizedBoxCustom(7),
                    //time and category
                    Row(
                      children: [
                        Icon(
                          Icons.cases_outlined,
                          color: cc.greyParagraph,
                          size: 19,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'Total posted: 12',
                          style: TextStyle(
                            color: cc.greyParagraph,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: cc.greyParagraph,
                          size: 19,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          '5 days ago',
                          style: TextStyle(
                            color: cc.greyParagraph,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          sizedBoxCustom(14),

          //Overview
          Row(
            children: const [
              OverviewBox(
                title: 'Budget',
                subtitle: '\$221.00',
              ),
              SizedBox(
                width: 15,
              ),
              OverviewBox(
                title: 'Location',
                subtitle: 'Dhaka, Bangladesh',
              ),
            ],
          ),

          sizedBoxCustom(14),

          //Overview
          Row(
            children: const [
              OverviewBox(
                title: 'Deadline',
                subtitle: '12/04/23',
              ),
              SizedBox(
                width: 15,
              ),
              OverviewBox(
                title: 'Category',
                subtitle: 'Medical',
              ),
            ],
          ),

          //Description
          // ===============>
          sizedBoxCustom(15),
          CommonHelper().paragraphCommon(
              'I never spend much time in school but I taught ladies plenty. It’s true I hire my body out for pay, hey hey. I’ve gotten burned over Cheryl Tiegs, blown up for Raquel Welch. But when I end up in the hay it’s only hay, hey hey. I might jump an open drawbridge, or Tarzan from a vine. ’Cause I’m the unknown stuntman that makes Eastwood look so fine.',
              TextAlign.left),

          sizedBoxCustom(20),
        ]),
      )),
    );
  }
}
