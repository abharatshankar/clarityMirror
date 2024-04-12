import 'package:clarity_mirror/res/widgets/coloors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:clarity_mirror/view/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'notification_screen.dart';
import 'profile_page.dart';

class DashboardMoreMenu extends StatelessWidget {
   const DashboardMoreMenu({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.black, // Set status bar color to black
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
            children: [
              SizedBox(height: 56,width:MediaQuery.of(context).size.width,child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                    },
                    child: const Icon(Icons.notifications,color: Colors.white,size: 40,)),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const ProfilePage()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text('Customer Name',
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,style:AppFonts().sego18medium ,),),
                          const SizedBox(height: 8,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text('name@email.com',style: AppFonts().sego14normal,textAlign: TextAlign.end,))
                        ],),
                        const SizedBox(width: 8,),
                        Container(height: 53,width: 53,decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.white)),)],),
                  ),
                ],
              ),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: GridView.builder(
                itemCount: AppStrings.dashbordMoreMenuItems.length,
                
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 6.0, 
                  mainAxisSpacing: 3.0, 
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      if(index == 11){
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => SearchableList(items: [MyDataClass(name: AppStrings.accountSettings,description: 'description about setting option'),MyDataClass(name: 'NOTIFICATION SETTINGS',description: 'description about setting dg dfg fg'),MyDataClass(name: 'APPEARANCE',description: 'description about sfsdfs df sdf sf  option'),MyDataClass(name: 'ADVANCED SETTINGS',description: 'sdfsdfdfs s dfs df about setting option'),MyDataClass(name: 'HELP AND SUPPORT',description: 'sdf sd f sf sd fg fg fh fg  about setting option'),MyDataClass(name: 'ABOUT',description: 'sdf sd f sf sd fg fg fh fg  about setting option'),],))));
                      }
                    },
                    child: GridItem(itemImage: 'assets/images/${AppStrings.dashbordMoreMenuItems[index]}.png',itemName: AppStrings.dashbordMoreMenuItems[index],),
                  );
                },
              ),
            
              ),
                
            ],
                ),
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String itemName;
  final String itemImage;

  GridItem({required this.itemName, required this.itemImage});

  @override
  Widget build(BuildContext context) {
    return GridTile(
                child: SizedBox(
                  height: 100,
                  width: 80,
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: AssetImage(itemImage,),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        itemName,
                        textAlign: TextAlign.center,
                        style:const TextStyle(fontSize: 12,height:1,color: Colors.white,letterSpacing: 0,wordSpacing: 0,fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
  }
}