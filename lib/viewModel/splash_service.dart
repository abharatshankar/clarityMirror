import 'package:clarity_mirror/view/home_page_main.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 3500)).then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePageMain()),
        ModalRoute.withName(
            RouteNames.tabbarScreen), // Remove all routes until the home route
      );
    });
  }
}
