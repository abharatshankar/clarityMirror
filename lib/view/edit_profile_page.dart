import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import 'custom_appbar.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColors.editProfileBtnColor,
      body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 56,
                  child: const CustomAppBar(titleTxt: "Edit Profile",showNotificationIcon: true,),
                ),
        profilePic(),
        editProfileBody(context),
        const SizedBox(height: 225,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 40),
            child: Text('Cancel',style: AppFonts().sego14bold.copyWith(color: AppConstColors.editProfileBtnColor),),
          ),
          ),
          Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 40),
            child: Text('Save',style: AppFonts().sego14bold.copyWith(color: AppConstColors.editProfileBtnColor),),
          ),
          )
          ],),
        ],),
      )),);
  }

Widget editProfileBody(BuildContext context){
  return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Name",style: AppFonts().sego18bold,),
                // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                SizedBox(
                  width :MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Consumer Name",hintStyle:AppFonts().sego18normal.copyWith(color: AppConstColors.editProfileTxtColor) ),
                  ))
              ],),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Status",style: AppFonts().sego18bold,),
                // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                SizedBox(
                  width :MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type Status Here",hintStyle:AppFonts().sego18normal.copyWith(color: AppConstColors.editProfileTxtColor) ),
                  ))
              ],),
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Age",style: AppFonts().sego18bold,),
                // SizedBox(width: MediaQuery.of(context).size.width * 0.1,),
                SizedBox(
                  width :MediaQuery.of(context).size.width * 0.5,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Years",hintStyle:AppFonts().sego18normal.copyWith(color: AppConstColors.editProfileTxtColor) ),
                  ))
              ],),
            )
          ],
        ),
      );
}

  Widget profilePic() {
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