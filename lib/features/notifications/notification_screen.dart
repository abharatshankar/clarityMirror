import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        backgroundColor: Colors.black,
        
        body: Column(
          children: [
            SizedBox(height: 56,width: MediaQuery.of(context).size.width,child: Row(children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(AppStrings.backNavIcon,height: 31,width: 39,fit: BoxFit.fill,)),
              Text(AppStrings.notifications,style: AppFonts().sego32bold,),
              
            ],),),
            Expanded(
              child: ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
              return notificationWidget(context);
                  })),
            ),
          ],
        ),),
    );
  }

  Widget notificationWidget(BuildContext context){
    return Container(
                decoration: const BoxDecoration(border: Border(top: BorderSide(
                    color: AppConstColors.appBoldTextColor, // Border color for top side
                    width: 0.5, // Border width for top side
                  ),
                  bottom: BorderSide(
                    color:  AppConstColors.appBoldTextColor, // Border color for bottom side
                    width: 0.5, // Border width for bottom side
                  ),)),
                
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                  child: Row(children: [
                    Container(
                      height: 45,width: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppConstColors.appBoldTextColor,),),
                      const SizedBox(width: 8,),
                      SizedBox(
                        
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Text("Notification",style: AppFonts().sego14bold,textAlign: TextAlign.start,),
                          const SizedBox(height: 5,),
                          Text('8 seconds ago',style: AppFonts().sego10bold,)
                          ],),
                      ),
                  Spacer(),
                      Container(
                      height: 45,width: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: AppConstColors.appBoldTextColor,),),
                  ],),
                ),
              );
  }
}