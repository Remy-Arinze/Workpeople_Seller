import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/my_services/my_services_service.dart';
import 'package:qixer_seller/utils/common_helper.dart';
import 'package:qixer_seller/utils/constant_colors.dart';
import 'package:qixer_seller/utils/constant_styles.dart';
import 'package:qixer_seller/utils/custom_input.dart';
import 'package:qixer_seller/view/my_service/components/category_dropdown.dart';
import 'package:qixer_seller/view/my_service/components/create_service_image_upload.dart';
import 'package:qixer_seller/view/my_service/components/sub_category_dropdown.dart';
import 'package:qixer_seller/view/my_service/create_attribute_page.dart';
import 'package:qixer_seller/view/profile/components/textarea_field.dart';

class CreateServicePage extends StatefulWidget {
  const CreateServicePage({Key? key}) : super(key: key);

  @override
  _CreateServicePageState createState() => _CreateServicePageState();
}

class _CreateServicePageState extends State<CreateServicePage> {
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
      appBar: CommonHelper().appbarCommon('Create Service', context, () {
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
                    //on off button
                    Row(
                      children: [
                        CommonHelper().paragraphCommon(
                            'Is Available All Cities and Area', TextAlign.left),
                        Switch(
                          // This bool value toggles the switch.
                          value: false,
                          activeColor: cc.successColor,
                          onChanged: (bool value) {},
                        ),
                      ],
                    ),

                    sizedBoxCustom(10),
                    const CategoryDropdown(),

                    sizedBoxCustom(20),

                    const SubCategoryDropdown(),

                    sizedBoxCustom(20),

                    // Title
                    //============>
                    CommonHelper().labelCommon(asProvider.getString("Title")),

                    CustomInput(
                      controller: titleController,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      hintText: asProvider.getString("Title"),
                      paddingHorizontal: 15,
                      textInputAction: TextInputAction.next,
                    ),

                    // Video URL
                    //============>
                    CommonHelper()
                        .labelCommon(asProvider.getString("Video URL")),

                    CustomInput(
                      controller: videoUrlController,
                      hintText: asProvider.getString("Youtube embed code"),
                      paddingHorizontal: 15,
                      textInputAction: TextInputAction.next,
                    ),

                    // Description
                    //============>

                    CommonHelper()
                        .labelCommon(asProvider.getString('Description')),
                    TextareaField(
                      hintText: asProvider.getString('Description'),
                      notesController: descController,
                    ),

                    sizedBoxCustom(10),

                    const CreateServiceImageUpload(),

                    sizedBoxCustom(20),

                    CommonHelper().buttonPrimary('Next', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const CreateAttributePage(),
                        ),
                      );
                    }),

                    sizedBoxCustom(20),

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
