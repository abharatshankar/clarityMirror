import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../appbar_with_more_button.dart';

class HelpAndSupport extends StatelessWidget {
   HelpAndSupport({super.key});
 final List<String> optionsArr = ["Frequently Asked Questions",'Report Issue','Contact Support'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColors.themeBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const AppBarWithMoreButton(
                titleTxt: 'Help and Support',
              ),
              dividerWidget(context),
            Expanded(
              child: ListView.builder(
              itemCount:optionsArr.length ,
              itemBuilder: (context,index){
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(optionsArr[index],style: AppFonts().sego14bold,),const Icon(Icons.arrow_forward_ios,color: Colors.white,)],),
                    ),
                  ),
                  dividerWidget(context)
                ],
              );
                  }),
            ),
          ],
        ),
      ),);
  }


  Widget dividerWidget(BuildContext context){
    return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(height: 1,width: MediaQuery.of(context).size.width,color: Colors.grey.shade800,),
              );
  }
}