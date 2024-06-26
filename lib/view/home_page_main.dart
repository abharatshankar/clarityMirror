import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:clarity_mirror/viewModel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewModel/tab_bar_provider.dart';
import 'dashboard_beauty.dart';
import 'dashboard_mirror.dart';
import 'dashboard_more_menu.dart';
import 'dashboard_skin_hair.dart';

class HomePageMain extends StatefulWidget {

  HomePageMain({super.key, this.tabPosition});

  final String title = "Home Page";
  int? tabPosition = 0;


  @override
  _HomePageMainState createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  // late int currentTabIndex;

  List<Widget> tabs = [
    DashboardMirror(),
    DashboardBeauty(),
    DashboardSkinHair(),
    const DashboardMoreMenu(),
  ];

  // onTapped(int index) {
  //   setState(() {
  //     currentTabIndex = index;
  //     if (index == 0) {
  //       // _startLoadCamera();
  //     } else {
  //       // _releaseCamera();
  //     }
  //   });
  // }

  @override
  void initState() {
    // setState(() {
    //   currentTabIndex = widget.tabPosition ?? 0;
    // });
    // Provider.of<TabControllerProvider>(context).setIndex(widget.tabPosition ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabControllerProvider>(
      builder: (context, bottomNavigationBarProvider, _) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: bottomNavigationBarProvider.currentIndex == 0 ? tabs[bottomNavigationBarProvider.currentIndex] :
          IndexedStack(index:bottomNavigationBarProvider.currentIndex ,children: tabs,),
                    // body: tabs[bottomNavigationBarProvider.currentIndex],

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
              // onTap: onTapped,
              // currentIndex: currentTabIndex,
            currentIndex: bottomNavigationBarProvider.currentIndex,
            onTap: (index) {
              if(Provider.of<DashboardViewModel>(context,listen: false).capturedImagePath != null && index == 2 && Provider.of<DashboardViewModel>(context,listen: false).skinConcernList.isNotEmpty){
                bottomNavigationBarProvider.setIndex(index);
              }else if(index == 0 || index == 1 || index == 3){
                bottomNavigationBarProvider.setIndex(index);
              }
              
            },
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

