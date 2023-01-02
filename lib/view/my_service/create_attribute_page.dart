import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/my_services/my_services_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/view/my_service/components/add_additional.dart';
import 'package:qixer_seller/view/my_service/components/add_package_included.dart';

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

  final titleController = TextEditingController();
  final videoUrlController = TextEditingController();
  final descController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AddPackageIncluded(),

                    const AddAdditional(),

                    sizedBoxCustom(40),

                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
