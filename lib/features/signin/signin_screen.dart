import 'package:clarity_mirror/features/registration/signup_screen.dart';
import 'package:clarity_mirror/features/signin/view_model/signin_view_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../../utils/app_strings.dart';
import '../../utils/common_widgets/custom_appbar.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  @override
  void dispose() {
    super.dispose();
    // clearData();
  }

  void clearData() {
    Provider.of<SignInViewModel>(context, listen: false).clearData();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInViewModel>(
      create: (context) => SignInViewModel(),
      builder: (context, widget) {
        var signInViewModel = Provider.of<SignInViewModel>(context, listen: true);
        return Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomAppBar(titleTxt: "Sign In"),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          height: 1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                        child: Text(
                          "Email Id/ Mobile Number",
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
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: signInViewModel.userNameController,
                                onChanged: (value) {
                                  signInViewModel.validateUserName(value);
                                },
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(color: Colors.black),
                                  hintText: "E-mail",
                                  border: InputBorder.none,
                                  errorText: signInViewModel.isValidUserName ? null : signInViewModel.userNameError,
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                        child: Text(
                          "Password",
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
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                obscureText: true,
                                controller: signInViewModel.passwordController,
                                onChanged: (value) {
                                  signInViewModel.validatePassword(value);
                                },
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(color: Colors.black),
                                  hintText: "Password",
                                  border: InputBorder.none,
                                  // errorText: signInViewModel.validatePassword(signInViewModel.passwordController.text),
                                  errorText: signInViewModel.isValidPassword ? null : signInViewModel.userPasswordError,
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              AppStrings.forgotPassowrd,
                              style: const TextStyle(
                                color: Colors.white,
                                height: 2,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      // const Spacer(),
                      GestureDetector(
                        onTap: () {
                          /// call the sign in api from the view model
                          /// TODO: Handle the validation
                          signInViewModel.signIn(context);
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: AppConstColors.appThemeCayan,
                            ),
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                              child: Text('Sign In',
                                  style: AppFonts()
                                      .sego14normal
                                      .copyWith(color: Colors.black)),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ",
                                  style: AppFonts().sego16normal),
                              GestureDetector(
                                onTap: () {
                                  // context.goNamed(RouteNames.signupScreen);
Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignUpScreen()));
                                },
                                child: Text(
                                  'Create',
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
              )),
        );
      },
    );
   /* return Consumer<SignInViewModel>(
        builder: (context, signInViewModel, widget) {

    });*/
  }
}
