import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:flutter/material.dart';

import 'dashboard_more_menu.dart';
 
class TabsDemoScreen extends StatefulWidget {
  TabsDemoScreen() : super();
 
  final String title = "Flutter Bottom Tab demo";
 
  @override
  _TabsDemoScreenState createState() => _TabsDemoScreenState();
}
 
class _TabsDemoScreenState extends State<TabsDemoScreen> {
  int currentTabIndex = 0;
  List<Widget> tabs = [
    Screen1(),
    TabScreen(Colors.orange),
    TabScreen(Colors.blue),
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
             BottomNavigationBarItem(
              activeIcon: ImageIcon(AssetImage(AppStrings.mirrorSelected,),size: 40,),
              icon: ImageIcon(AssetImage(AppStrings.mirrorNormal,),size: 40,),
              label: "",
            ),
            BottomNavigationBarItem(
              activeIcon:  ImageIcon(AssetImage(AppStrings.beautySelected,),size: 40,),
              icon: Container(
                        height: 40,
                        width: 40,
                        decoration:  BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppStrings.beautyNormal,),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
              label: "",
            ),
            BottomNavigationBarItem(
              activeIcon:  ImageIcon(AssetImage(AppStrings.skinCareSelected,),size: 40,),
              icon: Container(
                        height: 40,
                        width: 40,
                        decoration:  BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(AppStrings.skinCareNormal,),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
              label: "",
            ),
            BottomNavigationBarItem(
              activeIcon: const ImageIcon(AssetImage('assets/images/Dashboard icon Selected.png',),size: 40,),
              icon: Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          // color: Colors.grey,
                          // borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage('assets/images/Dashboard icon Normal.png',),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
              label: "",
            )
          ],
        ),
      ),
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


class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      centerTitle: true,
      title: Text("screen 1"),
      backgroundColor: Colors.transparent,elevation: 0,),);
  }
}