import 'package:clarity_mirror/utils/navigation_service.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:clarity_mirror/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes.dart';
import 'package:clarity_mirror/viewModel/auth_viewmodel.dart';
import 'package:clarity_mirror/viewModel/home_view_model.dart';
import 'package:clarity_mirror/viewModel/user_view_model.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.black, // Black color for the status bar
      statusBarIconBrightness:
          Brightness.light, // Light icons for the status bar
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigatorKey,
        title: 'Clarity Mirror',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // initialRoute: RouteNames.tabbarScreen,
        onGenerateRoute: Routes.generateRoutes,
        initialRoute: RouteNames.splashScreen,
      ),
    );
  }
}
