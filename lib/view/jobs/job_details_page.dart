import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/common_service.dart';
import 'package:qixer_seller/services/jobs/job_details_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/jobs/components/overview_box.dart';

class JobDetailsPage extends StatefulWidget {
  const JobDetailsPage({
    Key? key,
    required this.imageLink,
    required this.jobId,
    required this.isFromNewJobPage,
  }) : super(key: key);

  final imageLink;
  final jobId;
  final isFromNewJobPage;

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  void initState() {
    super.initState();

    Provider.of<JobDetailsService>(context, listen: false)
        .fetchJobDetails(widget.jobId, context);
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
          child: Consumer<JobDetailsService>(
        builder: (context, provider, child) =>
            provider.loadingOrderDetails == false
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: screenPadding),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.jobDetails.title.toString(),
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
                              imageUrl: widget.imageLink,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                          sizedBoxCustom(22),
                          //Name, profile image etc
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     CommonHelper().profileImage(
                          //       userPlaceHolderUrl,
                          //       55,
                          //       55,
                          //     ),
                          //     const SizedBox(
                          //       width: 16,
                          //     ),
                          //     Expanded(
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           //name
                          //           CommonHelper()
                          //               .titleCommon('Saleheen', fontsize: 17),
                          //           sizedBoxCustom(7),
                          //           //time and category
                          //           Row(
                          //             children: [
                          //               Icon(
                          //                 Icons.cases_outlined,
                          //                 color: cc.greyParagraph,
                          //                 size: 19,
                          //               ),
                          //               const SizedBox(
                          //                 width: 6,
                          //               ),
                          //               Text(
                          //                 'Total posted: 12',
                          //                 style: TextStyle(
                          //                   color: cc.greyParagraph,
                          //                   fontSize: 13,
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Icon(
                          //                 Icons.calendar_month_outlined,
                          //                 color: cc.greyParagraph,
                          //                 size: 19,
                          //               ),
                          //               const SizedBox(
                          //                 width: 6,
                          //               ),
                          //               Text(
                          //                 '5 days ago',
                          //                 style: TextStyle(
                          //                   color: cc.greyParagraph,
                          //                   fontSize: 13,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ],
                          // ),

                          // sizedBoxCustom(14),

                          //Overview
                          Row(
                            children: [
                              OverviewBox(
                                title: 'Budget',
                                subtitle: '\$${provider.jobDetails.price}',
                              ),
                              const SizedBox(
                                width: 15,
                              ),

                              OverviewBox(
                                title: 'Deadline',
                                subtitle:
                                    '${getDate(provider.jobDetails.deadLine)}',
                              ),

                              // const OverviewBox(
                              //   title: 'Location',
                              //   subtitle: 'Dhaka, Bangladesh',
                              // ),
                            ],
                          ),

                          sizedBoxCustom(14),

                          //Overview
                          // Row(
                          //   children: [
                          //     OverviewBox(
                          //       title: 'Deadline',
                          //       subtitle:
                          //           '${getDate(provider.jobDetails.deadLine)}',
                          //     ),
                          //     const SizedBox(
                          //       width: 15,
                          //     ),
                          //     // const OverviewBox(
                          //     //   title: 'Category',
                          //     //   subtitle: 'Medical',
                          //     // ),
                          //   ],
                          // ),

                          //Description
                          // ===============>
                          // sizedBoxCustom(15),
                          CommonHelper().paragraphCommon(
                              provider.jobDetails.description.toString(),
                              TextAlign.left),

                          sizedBoxCustom(25),
                          if (widget.isFromNewJobPage == true)
                            CommonHelper().buttonPrimary('Apply', () {
                              provider.applyToJob(context,
                                  buyerId: provider.jobDetails.buyerId,
                                  jobPostId:
                                      provider.jobDetails.jobRequest.jobPostId,
                                  offerPrice: 100,
                                  coverLetter: 'cover letter',
                                  jobPrice: provider.jobDetails.price);
                            }, isloading: provider.applyLoading),

                          sizedBoxCustom(20),
                        ]),
                  )
                : OthersHelper().showLoading(cc.primaryColor),
      )),
    );
  }
}
