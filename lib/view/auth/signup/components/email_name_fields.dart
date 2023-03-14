// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/custom_input.dart';

class EmailNameFields extends StatelessWidget {
  const EmailNameFields(
      {Key? key,
      this.fullNameController,
      this.userNameController,
      this.emailController,
      this.passController,
      this.confirmPassController})
      : super(key: key);

  final fullNameController;
  final userNameController;
  final emailController;
  final passController;
  final confirmPassController;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStringService>(
      builder: (context, ln, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Name ============>
          CommonHelper().labelCommon(ln.getString(ConstString.fullName)),

          CustomInput(
            controller: fullNameController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return ln.getString(ConstString.plzEnterFullName);
              }
              return null;
            },
            hintText: ln.getString(ConstString.enterFullName),
            icon: 'assets/icons/user.png',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 8,
          ),

          //User name ============>
          CommonHelper().labelCommon(ln.getString(ConstString.userName)),

          CustomInput(
            controller: userNameController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return ln.getString(ConstString.plzEnterUsername);
              }
              return null;
            },
            hintText: ln.getString(ConstString.enterUsername),
            icon: 'assets/icons/user.png',
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 8,
          ),

          //Email ============>
          CommonHelper().labelCommon(ln.getString(ConstString.email)),

          CustomInput(
            controller: emailController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return ln.getString(ConstString.plzEnterEmail);
              }
              return null;
            },
            hintText: ln.getString(ConstString.enterEmail),
            icon: 'assets/icons/email-grey.png',
            textInputAction: TextInputAction.next,
          ),
        ],
      ),
    );
  }
}
