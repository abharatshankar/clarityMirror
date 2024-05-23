import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dashboard_beauty.dart';
import 'dashboard_mirror.dart';
import 'dashboard_more_menu.dart';
import 'dashboard_skin_hair.dart';

class TabsDemoScreen extends StatefulWidget {
  int? tabPosition;

  TabsDemoScreen({super.key, this.tabPosition});

  final String title = "Flutter Bottom Tab demo";

  @override
  _TabsDemoScreenState createState() => _TabsDemoScreenState();
}

class _TabsDemoScreenState extends State<TabsDemoScreen> {
  static const platform =
      MethodChannel('com.example.clarity_mirror/mirror_channel');
  late int currentTabIndex;

  List<Widget> tabs = [
    DashboardMirror(),
    DashboardBeauty(),
    DashboardSkinHair(),
    const DashboardMoreMenu(),
  ];

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
      if (index == 0) {
        _startLoadCamera();
      } else {
        _releaseCamera();
      }
    });
  }

  @override
  void initState() {
    setState(() {
      currentTabIndex = widget.tabPosition ?? 0;
    });
    super.initState();
  }

  Future<void> _startLoadCamera() async {
    try {
      await platform.invokeMethod('startLoadCamera');
    } on PlatformException catch (e) {
      print("Failed to load camera activity: '${e.message}'.");
    }
  }

  Future<void> _releaseCamera() async {
    try {
      await platform.invokeMethod('releaseCamera');
    } on PlatformException catch (e) {
      print("Failed to load camera activity: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: tabs[currentTabIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: Colors.black,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.red,
            textTheme: Theme.of(context).textTheme),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.black,
          selectedItemColor: AppConstColors.appThemeCayan,
          onTap: onTapped,
          currentIndex: currentTabIndex,
          items: [
            tabWidget(
                selectedIcon: AppStrings.mirrorSelected,
                normalIcon: AppStrings.mirrorNormal),
            tabWidget(
                selectedIcon: AppStrings.beautySelected,
                normalIcon: AppStrings.beautyNormal),
            tabWidget(
                selectedIcon: AppStrings.skinCareSelected,
                normalIcon: AppStrings.skinCareNormal),
            tabWidget(
                selectedIcon: AppStrings.dashboardSelected,
                normalIcon: AppStrings.dashboardNormal)
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem tabWidget(
      {required String selectedIcon, required String normalIcon}) {
    return BottomNavigationBarItem(
      activeIcon: ImageIcon(
        AssetImage(
          selectedIcon,
        ),
        size: 40,
      ),
      icon: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              normalIcon,
            ),
            fit: BoxFit.fill,
          ),
        ),
      ),
      label: "",
    );
  }
}

class TabScreen extends StatelessWidget {
  final Color color;

  TabScreen(this.color);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: color,
      ),
    );
  }
}
