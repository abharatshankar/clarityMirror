import 'package:clarity_mirror/features/products/view_model/products_view_model.dart';
import 'package:clarity_mirror/utils/navigation_service.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:clarity_mirror/features/dashboard/view_model/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'utils/app_colors.dart';
import 'features/cart/view_model/cart_view_model.dart';
import 'features/dashboard/view_model/tab_bar_provider.dart';
import 'core/theme_provider.dart';

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
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => TabControllerProvider()),
        ChangeNotifierProvider(create: (context) => ProductsViewModel()),
        ChangeNotifierProvider(create: (context) => CartViewModel()),
        

      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {
           final themeProvider = Provider.of<ThemeProvider>(context);
          return ScreenUtilInit(
            designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
            child: MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            title: 'Clarity Mirror',
            // theme: ThemeData(
              // primarySwatch: Colors.cyan,
            // ),
            themeMode: themeProvider.themeMode,
            theme: lightTheme,
                    darkTheme: darkTheme,
            // initialRoute: RouteNames.tabbarScreen,
            onGenerateRoute: Routes.generateRoutes,
            initialRoute: RouteNames.splashScreen,
                    ),
          );
        },
        
      ),
    );
  }
}


