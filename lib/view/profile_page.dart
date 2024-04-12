import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/utils/app_strings.dart';
import 'package:clarity_mirror/view/notification_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
                
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 56,
                child: Row(children:  [GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Image.asset(AppStrings.backNavIcon,height: 31,width: 39,fit: BoxFit.fill,)),
                const SizedBox(width: 8,),
                Text("Profile",style: AppFonts().sego29normal,),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                  },
                  child: const Icon(Icons.notifications,size: 40,color: Colors.white,))
                ],),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 1,width: MediaQuery.of(context).size.width,color: Colors.grey.shade700,),
              ),
              const SizedBox(height: 8,),
profilePic(),
          Text("Lisa Mathray",style: AppFonts().sego29normal.copyWith(color: AppConstColors.appThemeCayan,fontWeight: FontWeight.bold,height: 1.4),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Beauty Vlogger",style: AppFonts().sego14normal,),
          ),
          Row(children: [
            Column(children: [],),
            Column(children: [],),
            Column(children: [],)
          ],)
            ],
          ),
        ),),
    );
  }

Widget profilePic(){
  return Stack(
      children: [
        Container(
          width: 120, // Adjust according to your needs
          height: 120, // Adjust according to your needs
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white, // Border color white
              width: 5, // Border width 3
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 45, // Adjust according to your needs
            height: 45, // Adjust according to your needs
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey, // Example color for camera icon background
            ),
            child: const Icon(
              Icons.camera_alt,
              color: Colors.white, // Example color for camera icon
            ),
          ),
        ),
        
      ],
    );
}

}