
import 'dart:ui';

import 'package:flutter/material.dart';

class AppConstColors{
  static const Color appThemeCayan = Color(0xff00EFFE);
  static const Color appBoldTextColor = Color(0xffCFCFCF);
  static const Color appBarTitleColor = Color(0xffC5C5C5);
  static const Color editProfileTxtColor = Color(0xffCCCCCC);
  static const Color editProfileBtnColor = Color(0xff707070);
  static const Color themeBackgroundColor = Color(0xff343434);
}

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  // Add other theme properties as needed
);

final darkTheme = ThemeData(
  primarySwatch: createMaterialColor(AppConstColors.appThemeCayan),
  brightness: Brightness.dark,
  
  // Add other theme properties as needed
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}