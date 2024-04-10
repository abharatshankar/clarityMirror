import 'package:clarity_mirror/view/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:clarity_mirror/viewModel/user_view_model.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();

    final user = await userViewModel.getUser();

    if (user!.token.toString() == "null" || user.token.toString() == "") {
      await Future.delayed(const Duration(seconds: 4));
      // Navigator.pushReplacement(context, RouteNames.tabbarScreen);
      Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TabsDemoScreen()),
              ModalRoute.withName(RouteNames.tabbarScreen), // Remove all routes until the home route
            );
    } else {
      await Future.delayed(const Duration(seconds: 4));
      Navigator.pushNamed(context, RouteNames.home);
    }
  }
}
