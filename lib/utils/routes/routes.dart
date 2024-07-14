import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:clarity_mirror/features/splash/splash_screen.dart';

import '../../features/dashboard/home_page_main.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      
      case (RouteNames.splashScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) =>  SplashScreen());
      case (RouteNames.tabbarScreen):
        return MaterialPageRoute(
            builder: (BuildContext context) =>  HomePageMain());
      
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
