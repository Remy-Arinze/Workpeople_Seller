import 'package:flutter/material.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/jobs/job_conversation_page.dart';
import 'package:qixer_seller/view/jobs/job_details_page.dart';

class AppliedJobsPage extends StatefulWidget {
  const AppliedJobsPage({Key? key}) : super(key: key);

  @override
  _AppliedJobsPageState createState() => _AppliedJobsPageState();
}

class _AppliedJobsPageState extends State<AppliedJobsPage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();

  List menuNames = ['View details', 'Conversation'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Applied jobs', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: cc.bgColor,
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: screenPadding, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonHelper().titleCommon(
                                  'Barnaby The Bear’s my name never call',
                                  fontsize: 15),
                              sizedBoxCustom(8),
                              CommonHelper().paragraphCommon(
                                  'Buyer budget: \$100', TextAlign.left),
                              sizedBoxCustom(8),
                              CommonHelper().paragraphCommon(
                                  'Your offer: \$80', TextAlign.left,
                                  color: cc.primaryColor),
                            ]),
                      ),
                      PopupMenuButton(
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const JobDetailsPage(),
                                  ),
                                );
                              });
                            },
                            child: Text(menuNames[0]),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const JobConversationPage(
                                      jobId: 1,
                                      title:
                                          'Barnaby The Bear’s my name never call me Jack or James',
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Text(menuNames[1]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
