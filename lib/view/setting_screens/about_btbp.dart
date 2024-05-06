import 'package:clarity_mirror/res/widgets/coloors.dart';
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../appbar_with_more_button.dart';

class AboutBtbp extends StatelessWidget {
  const AboutBtbp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColors.themeBackgroundColor,
      body: SafeArea(child: Column(children: [
      const AppBarWithMoreButton(
                titleTxt: 'About BTBP',
              ),
Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 1,width: MediaQuery.of(context).size.width,color: Colors.grey.shade800,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                            0.1,
                            1.0
                          ], colors: [
                            
                             Colors.cyanAccent.withOpacity(.8),
                           Colors.white.withAlpha(
                            240
                           ),
                            
                          ])),
                        // child: Center(
                        //   child: Text(
                        //    'Hello',
                        //     style: TextStyle(fontSize: 29),
                        //   ),
                        // ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text("Clarity Mirror",style: AppFonts().sego29normal,),
              ),
              Container(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const RadialGradient(
                    colors: [Colors.red, Colors.yellow],
                    radius: 0.75,
                   ),
            ),
        )
    ],)),);
  }
}