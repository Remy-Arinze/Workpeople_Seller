import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/my_services/attribute_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/others_helper.dart';
import 'package:qixer_seller/view/my_service/components/show_attribute_section.dart';

class ShowAttributePage extends StatefulWidget {
  const ShowAttributePage({Key? key, required this.serviceId})
      : super(key: key);

  final serviceId;

  @override
  _ShowAttributePageState createState() => _ShowAttributePageState();
}

class _ShowAttributePageState extends State<ShowAttributePage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Service attributes', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: cc.bgColor,
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Consumer<AppStringService>(
          builder: (context, asProvider, child) => Container(
            padding:
                EdgeInsets.symmetric(horizontal: screenPadding, vertical: 10),
            child: Consumer<AttributeService>(
              builder: (context, provider, child) =>
                  provider.attrLoading == false
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShowAttributeSection(
                                sectionTitle: 'Include Service Attributes',
                                dataList: provider.attributes.includeServices)
                            //
                          ],
                        )
                      : OthersHelper().showLoading(cc.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
