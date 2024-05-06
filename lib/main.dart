import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/utils/routes/routes.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:clarity_mirror/viewModel/auth_viewmodel.dart';
import 'package:clarity_mirror/viewModel/home_view_model.dart';
import 'package:clarity_mirror/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clarity Mirror',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NativeViewWidget(),
        // initialRoute: RouteNames.tabbarScreen,
        // onGenerateRoute: Routes.generateRoutes,
      ),
    );
  }
}

class NativeViewWidget extends StatelessWidget {
  const NativeViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        fixedColor: Colors.blue,
        showUnselectedLabels: true,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Mirror',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.microwave_rounded),
              label: 'Beauty',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.reorder_sharp),
            label: 'Results',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 600,
                margin: const EdgeInsets.only(top: 100),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.red, width: 2),
                ),
                /*child: AndroidView(
                  viewType: "view1",
                ),*/
              child: const AndroidView(
                  viewType: "camera_module",
                ),
            ),
          ],
        ),
      ),
    );
  }
}

