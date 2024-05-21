import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../appbar_with_more_button.dart';

class AdvancedSettings extends StatefulWidget {
  const AdvancedSettings({super.key});

  @override
  State<AdvancedSettings> createState() => _AdvancedSettingsState();
}

class _AdvancedSettingsState extends State<AdvancedSettings> {
  
bool _isOn = false;

String dropdownValue = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const AppBarWithMoreButton(
                titleTxt: 'Advanced Settings',
              ),
              dividerWidget(),
          toogleWidget(Switch.adaptive(
              activeColor: AppConstColors.appThemeCayan,
                  value: _isOn,
                  onChanged: (newValue) => setState(() => _isOn = newValue),
                ),),
          dividerWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Text("Feature Configuration",style: AppFonts().sego14bold,),
          ),
          
        ],)),
    ),);
  }

Widget toogleWidget(Widget child){
  return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Text("Feature Recognisation Images",style: AppFonts().sego14bold),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text("For trained users only",style: AppFonts().sego10bold.copyWith(color: Colors.grey.shade500),),
                ),
          
                Text(_isOn ? "ON" :"OFF"  ,style: AppFonts().sego10bold.copyWith(color: Colors.grey.shade700
                ),)
              ],
            ),
            child
            ],),
          );
}

  Widget dividerWidget(){
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 1,width: MediaQuery.of(context).size.width,color: Colors.grey.shade800,),
              );
  }
}