import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/my_services/my_services_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/my_service/components/add_additional.dart';
import 'package:qixer_seller/view/my_service/components/add_package_included.dart';
import 'package:qixer_seller/view/my_service/components/benefits_of_package.dart';
import 'package:qixer_seller/view/my_service/components/faq_service_create.dart';

class CreateAttributePage extends StatefulWidget {
  const CreateAttributePage({Key? key}) : super(key: key);

  @override
  _CreateAttributePageState createState() => _CreateAttributePageState();
}

class _CreateAttributePageState extends State<CreateAttributePage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Add attributes', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: cc.bgColor,
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Consumer<MyServicesService>(
          builder: (context, provider, child) => Consumer<AppStringService>(
            builder: (context, asProvider, child) => Container(
              padding:
                  EdgeInsets.symmetric(horizontal: screenPadding, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
