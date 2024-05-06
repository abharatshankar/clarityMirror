import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_fonts.dart';
import '../appbar_with_more_button.dart';

class AppearanceSettings extends StatefulWidget {
  const AppearanceSettings({super.key});

  @override
  State<AppearanceSettings> createState() => _AppearanceSettingsState();
}

class _AppearanceSettingsState extends State<AppearanceSettings> {
  
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
                titleTxt: 'Appearance',
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
            child: Text("Select Language",style: AppFonts().sego14bold,),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,),
            child: DropdownButtonFormField<String>(
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              // iconSize: 40,
              iconDisabledColor: Colors.blue,
              iconEnabledColor: Colors.black,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: Colors.white,
                    width: 3,
                  ),
                ),
              ),
              hint: const Text('Select your language'),
              dropdownColor: Colors.white,
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['English', 'Spanish', 'Italian', ]
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                );
              }).toList(),
            ),
          ),
        ],)),
    ),);
  }

Widget toogleWidget(Widget child){
  return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Light/Dark Theme",style: AppFonts().sego14bold),
                Text(_isOn ? "Dark Theme" :"Light Theme"  ,style: AppFonts().sego10bold.copyWith(color: Colors.grey.shade600
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