import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer_seller/services/app_string_service.dart';
import 'package:qixer_seller/view/utils/const_strings.dart';
import 'package:qixer_seller/view/utils/constant_colors.dart';
import 'package:qixer_seller/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:qixer_seller/view/auth/signup/pages/signup_phone_pass.dart';

import '../../../services/auth_services/signup_service.dart';
import '../../utils/common_helper.dart';
import '../../utils/others_helper.dart';
import '../login/login.dart';
import 'components/email_name_fields.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key, this.hasBackButton = true}) : super(key: key);

  final hasBackButton;

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool termsAgree = false;

  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Listener(
            onPointerDown: (_) {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: Consumer<AppStringService>(
              builder: (context, ln, child) => Consumer<SignupService>(
                builder: (context, provider, child) => Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 230.0,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/login-slider.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        widget.hasBackButton == true
                            ? Positioned(
                                top: 30,
                                left: 10,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: cc.greyPrimary,
                                      size: 20,
                                    ),
                                  ),
                                ))
                            : Container(),
                      ],
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 33,
                            ),
                            CommonHelper().titleCommon(
                                ln.getString(ConstString.register)),
                            const SizedBox(
                              height: 33,
                            ),
                            EmailNameFields(
                              fullNameController: fullNameController,
                              userNameController: userNameController,
                              emailController: emailController,
                            ),

                            const SizedBox(
                              height: 8,
                            ),

                            SignupPhonePass(
                              passController: passwordController,
                              confirmPassController: confirmPasswordController,
                              phoneController: phoneController,
                            ),
                            const SizedBox(
                              height: 8,
                            ),

                            //Country dropdown =====>
                            const CountryStatesDropdowns(),

                            const SizedBox(
                              height: 8,
                            ),
                            //Agreement checkbox ===========>

                            CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: ConstantColors().primaryColor,
                              contentPadding: const EdgeInsets.all(0),
                              title: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  ln.getString(ConstString.iAgreeTerms),
                                  style: TextStyle(
                                      color: ConstantColors().greyFour,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ),
                              value: termsAgree,
                              onChanged: (newValue) {
                                setState(() {
                                  termsAgree = !termsAgree;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            // sign up button
                            const SizedBox(
                              height: 10,
                            ),
                            CommonHelper().buttonPrimary(ConstString.signUp,
                                () {
                              if (_formKey.currentState!.validate()) {
                                if (termsAgree == false) {
                                  OthersHelper().showToast(
                                      ln.getString(
                                          ConstString.mustAgreeTermsToRegister),
                                      Colors.black);
                                } else if (passwordController.text !=
                                    confirmPasswordController.text) {
                                  OthersHelper().showToast(
                                      ln.getString(ConstString.passDidntMatch),
                                      Colors.black);
                                } else if (passwordController.text.length < 6) {
                                  OthersHelper().showToast(
                                      ln.getString(ConstString.passMustBeSix),
                                      Colors.black);
                                } else {
                                  if (provider.isloading == false) {
                                    provider.signup(
                                        fullNameController.text.trim(),
                                        userNameController.text.trim(),
                                        emailController.text.trim(),
                                        phoneController.text.trim(),
                                        passwordController.text,
                                        context);
                                  }
                                }
                              }
                            },
                                isloading:
                                    provider.isloading == false ? false : true),

                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: ln.getString(
                                            ConstString.alreadyHaveAccount) +
                                        '  ',
                                    style: const TextStyle(
                                        color: Color(0xff646464), fontSize: 14),
                                    children: <TextSpan>[
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage()));
                                            },
                                          text: ln.getString(ConstString.login),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: cc.primaryColor,
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    )
                    // }
                    // }),
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
