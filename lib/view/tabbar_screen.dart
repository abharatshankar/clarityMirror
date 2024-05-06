import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:flutter/material.dart';

import 'dashboard_mirror.dart';
import 'dashboard_more_menu.dart';
import 'dashboard_skin_hair.dart';
 
class TabsDemoScreen extends StatefulWidget {
  TabsDemoScreen() : super();
 
  final String title = "Flutter Bottom Tab demo";
 
  @override
  _TabsDemoScreenState createState() => _TabsDemoScreenState();
}
 
class _TabsDemoScreenState extends State<TabsDemoScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    DashboardMirror(),
    TabScreen(Colors.orange),
    DashboardSkinHair(),
    const DashboardMoreMenu(),
    
  ];
  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
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
        textTheme: Theme
            .of(context)
            .textTheme
            ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.black,
          selectedItemColor: 
          AppConstColors.appThemeCayan,
          onTap: onTapped,
          currentIndex: currentTabIndex,
          items: [
            tabWidget(selectedIcon: AppStrings.mirrorSelected, normalIcon: AppStrings.mirrorNormal),
            tabWidget(selectedIcon: AppStrings.beautySelected,normalIcon: AppStrings.beautyNormal),
            tabWidget(selectedIcon: AppStrings.skinCareSelected,normalIcon: AppStrings.skinCareNormal),
            tabWidget(selectedIcon: AppStrings.dashboardSelected,normalIcon: AppStrings.dashboardNormal)
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem tabWidget({required String selectedIcon,required String normalIcon}){
    return BottomNavigationBarItem(
              activeIcon:  ImageIcon(AssetImage(selectedIcon,),size: 40,),
              icon: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(normalIcon,),
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

