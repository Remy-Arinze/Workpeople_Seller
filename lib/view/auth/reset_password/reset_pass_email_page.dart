import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/services/auth_services/reset_password_service.dart';
import 'package:qixer_seller/view/utils/common_helper.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/utils/custom_input.dart';

class ResetPassEmailPage extends StatefulWidget {
  const ResetPassEmailPage({Key? key}) : super(key: key);

  @override
  _ResetPassEmailPageState createState() => _ResetPassEmailPageState();
}

class _ResetPassEmailPageState extends State<ResetPassEmailPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      appBar: CommonHelper().appbarCommon(ConstString.resetPass, context, () {
        Navigator.pop(context);
      }),
      backgroundColor: Colors.white,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Consumer<AppStringService>(
            builder: (context, ln, child) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: MediaQuery.of(context).size.height - 120,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 33,
                        ),
                        Text(
                          ln.getString(ConstString.resetPass),
                          style: TextStyle(
                              color: cc.greyPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        CommonHelper().paragraphCommon(
                            ln.getString(
                                ConstString.enterEmailToGetInstruction),
                            TextAlign.start),

                        const SizedBox(
                          height: 33,
                        ),

                        //Name ============>
                        CommonHelper()
                            .labelCommon(ln.getString(ConstString.enterEmail)),

                        CustomInput(
                          controller: emailController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return ln.getString(ConstString.plzEnterEmail);
                            }
                            return null;
                          },
                          hintText: ln.getString(ConstString.email),
                          icon: 'assets/icons/email.png',
                          textInputAction: TextInputAction.next,
                        ),

                        //Login button ==================>
                        const SizedBox(
                          height: 13,
                        ),
                        Consumer<ResetPasswordService>(
                          builder: (context, provider, child) => CommonHelper()
                              .buttonPrimary(
                                  ln.getString(ConstString.sendInstruction),
                                  () {
                            if (provider.isloading == false) {
                              if (_formKey.currentState!.validate()) {
                                provider.sendOtp(
                                    emailController.text.trim(), context);
                              }
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute<void>(
                              //     builder: (BuildContext context) =>
                              //         const ResetPassOtpPage(),
                              //   ),
                              // );
                            }
                          },
                                  isloading: provider.isloading == false
                                      ? false
                                      : true),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
