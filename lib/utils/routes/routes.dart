import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:clarity_mirror/view/home_screen.dart';
import 'package:clarity_mirror/view/splash_screen.dart';

import '../../view/tabbar_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.home):
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) =>  SplashScreen());
      case (RouteNames.tabbarScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) =>  TabsDemoScreen());
      
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}
