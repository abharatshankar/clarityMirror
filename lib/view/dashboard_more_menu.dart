import 'package:clarity_mirror/features/products/products_main_page.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:clarity_mirror/utils/utils.dart';
import 'package:clarity_mirror/view/progress_page.dart';
import 'package:clarity_mirror/view/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../viewModel/dashboard_viewmodel.dart';
import '../viewModel/tab_bar_provider.dart';
import 'notification_screen.dart';
import 'profile_page.dart';

// class DashboardMoreMenu extends StatelessWidget {
//   const DashboardMoreMenu({super.key});

// }

class DashboardMoreMenu extends StatefulWidget {
  const DashboardMoreMenu({super.key});

  @override
  State<DashboardMoreMenu> createState() => _DashboardMoreMenuState();
}

class _DashboardMoreMenuState extends State<DashboardMoreMenu> with  AutomaticKeepAliveClientMixin {
  
@override
  bool get wantKeepAlive => true;
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.black, // Set status bar color to black
      ),
      child: SafeArea(
        child: 
         Consumer<DashboardViewModel>(
      builder: (context, dashboardViewModel, _) {
            return Scaffold(
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: dashboardAppBar(context),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.62,
                      child: GridView.builder(
                        itemCount: AppStrings.dashbordMoreMenuItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 3.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            // color: Colors.amber,
                            child: GestureDetector(
                              onTap: () {
                                print( dashboardViewModel.skinConcernList);
                                if (index == 11) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) => SearchableList(
                                                items: [
                                                  AppStrings.accountSettings,
                                                  'NOTIFICATION SETTINGS',
                                                  'APPEARANCE',
                                                  'ADVANCED SETTINGS',
                                                  'HELP AND SUPPORT',
                                                  'ABOUT',
                                                ],
                                              ))));
                                }
                                if (index == 4) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ProfilePage()));
                                }
                                if(index == 0) {
                                  Utils.getNewActivity();
                                  Provider.of<TabControllerProvider>(context,listen: false).setIndex(1);
                                }
                                else if(index == 1 && dashboardViewModel.skinConcernList.isNotEmpty ){
                                  Provider.of<TabControllerProvider>(context,listen: false).setIndex(2);// bottom tab bar index
                                  dashboardViewModel.setTabIndex(0);
                                  dashboardViewModel.setCurrentIndex(0);
                                        
                                }
                                else if(index == 2 && dashboardViewModel.skinConcernList.isNotEmpty ){
                                  Provider.of<TabControllerProvider>(context,listen: false).setIndex(2);// bottom tab bar index
                                  dashboardViewModel.setTabIndex(1);
                                  dashboardViewModel.setCurrentIndex(1);
                                        
                                }else if (index == 3){
                                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const ProgressPage()));
                                } else if(index == 7) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductsMainPage()));
                                }
                              },
                              child: GridItem(
                                itemImage:
                                    'assets/images/${AppStrings.dashbordMoreMenuItems[index]}.png',
                                itemName: AppStrings.dashbordMoreMenuItems[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  Widget dashboardAppBar(BuildContext context){
    return SizedBox(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen()));
                          },
                          child: const Icon(
                            Icons.notifications,
                            color: Colors.white,
                            size: 40,
                          )),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProfilePage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  child: Text(
                                    'Customer Name',
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts().sego18medium,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      'name@email.com',
                                      style: AppFonts().sego14normal,
                                      textAlign: TextAlign.end,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 53,
                              width: 53,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
  }

}

class GridItem extends StatelessWidget {
  final String itemName;
  final String itemImage;

  const GridItem({super.key, required this.itemName, required this.itemImage});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Column(
        children: [
          Container(
            height: 75,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: AssetImage(
                  itemImage,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            itemName,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 12,
                height: 1,
                color: Colors.white,
                letterSpacing: 0,
                wordSpacing: 0,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
