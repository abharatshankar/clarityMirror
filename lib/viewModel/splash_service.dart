import 'dart:io';

import 'package:clarity_mirror/view/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:flutter/services.dart';

class SplashService {
  static const platform = const MethodChannel('camera_ai_channel');

  static void checkAuthentication(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 3500)).then((value) {
      Platform.isAndroid
          ? _getNewActivity()
          : Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => TabsDemoScreen()),
              ModalRoute.withName(RouteNames
                  .tabbarScreen), // Remove all routes until the home route
            );
    });
  }

  static void _getNewActivity() async {
    try {
      await platform.invokeMethod('startNewActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }
}
