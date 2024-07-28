import 'package:clarity_mirror/features/registration/view_model/registration_view_model.dart';
import 'package:clarity_mirror/features/signin/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../utils/common_widgets/custom_appbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterpassController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    reEnterpassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegistrationViewModel>(
      create: (context) => RegistrationViewModel(),
      builder: (context, widget) {
        var registrationViewModel =
            Provider.of<RegistrationViewModel>(context, listen: true);
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(titleTxt: "Sign Up"),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(
                      height: 1,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  titleAndTextField(
                    "Full Name",
                    txtController: registrationViewModel.nameController,
                    errorText: registrationViewModel.userNameError,
                    onChange: (value) {
                      registrationViewModel.validateName(value);
                    },
                  ),
                  titleAndTextField(
                    "Email Id",
                    txtController: registrationViewModel.emailController,
                    onChange: (value) {
                      registrationViewModel.validateEmail(value);
                    },
                    errorText: registrationViewModel.userEmailError,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                    child: Text(
                      "Mobile Number",
                      style: AppFonts().sego14normal,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Colors.white)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black),
                                  hintText: "+ 91",
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: titleAndTextField(
                            "Mobile Number",
                            showTitle: false,
                            txtController:
                                registrationViewModel.mobileNumberController,
                            onChange: (value) {
                              registrationViewModel.validateMobileNumber(value);
                            },
                            errorText: registrationViewModel.userMobileError,
                          ),
                        ),
                      ],
                    ),
                  ),
                  titleAndTextField('Password',
                      txtController: registrationViewModel.passwordController,
                      errorText: registrationViewModel.userPasswordError,
                      onChange: (value) {
                    registrationViewModel.validatePassword(value);
                  }),
                  titleAndTextField(
                    'Re-Enter Password',
                    txtController: registrationViewModel.reEnterPasswordController,
                    errorText: registrationViewModel.userReEnterPasswordError,
                    onChange: (value) {
                      registrationViewModel.validateReEnteredPassword(value);
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                    child: Text(
                      "Choose Your Expertise",
                      style: AppFonts().sego14normal,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white)),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Cosmetologist",
                                  style: AppFonts()
                                      .sego16normal
                                      .copyWith(color: Colors.black),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.black,
                                ),
                              ],
                            ))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  GestureDetector(
                    onTap: () {
                      registrationViewModel.signUp(context);
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: AppConstColors.appThemeCayan,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          child: Text('Sign Up',
                              style: AppFonts()
                                  .sego14normal
                                  .copyWith(color: Colors.black)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account? ",
                              style: AppFonts().sego16normal),
                          GestureDetector(
                            onTap: () {
                              
                              // context.goNamed(RouteNames.login);
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen()));
                            },
                            child: Text(
                              'Sign In',
                              style: AppFonts().sego16bold.copyWith(
                                    decoration: TextDecoration.underline,
                                    color: AppConstColors.appThemeCayan,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    /* return Consumer<RegistrationViewModel>(
      builder: (context, registrationViewModel, widget) {

      },
    );*/
  }

  Widget titleAndTextField(
    String title, {
    required TextEditingController txtController,
    required Function(dynamic) onChange,
    errorText,
    bool? showTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (showTitle != null)
            ? Container()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                child: Text(
                  title,
                  style: AppFonts().sego14normal,
                ),
              ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: txtController,
                  onChanged: (value) {
                    onChange(value);
                  },
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Colors.black),
                    hintText: title,
                    border: InputBorder.none,
                    errorText: errorText,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              )),
        ),
      ],
    );
  }
}
