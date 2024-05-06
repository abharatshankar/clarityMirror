import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_strings.dart';
import '../utils/custom_circular_percent.dart';

class DashboardSkinHair extends StatefulWidget {
  const DashboardSkinHair({super.key});

  @override
  State<DashboardSkinHair> createState() => _DashboardSkinHairState();
}

class _DashboardSkinHairState extends State<DashboardSkinHair> {

List<HairData> hairDataArr = [
  HairData(99, 4, "High", "Wrinkles"),
  HairData(60, 3, "Moderate", "Pigmentation"),
  HairData(70, 4, "Moderate-High", "Redness"),
  HairData(20, 1, "Moderate-High", "Acne"),
  HairData(30, 4, "Moderate", "Dark-Circles"),
];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstColors.themeBackgroundColor,
        body: SingleChildScrollView(child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
        Positioned(
          
          child: 
            SizedBox(
                width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,
                child: Image.asset("assets/images/Dermatolgist6.png",fit: BoxFit.cover,),),
                ),
        tabbarWidget(),
         gradientContainer(),
Positioned(
  bottom: 10,
  child: SizedBox(
    height: 100,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: hairDataArr.length,
      itemBuilder: ((context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text(hairDataArr[index].status ?? '',style: AppFonts().sego10bold,),
           CircularPercentIndicator(
                    radius: 20.0,
                    lineWidth: 5.0,
                    
                    percent: ((hairDataArr[index].percentage)/100),
                    center:  Text("${hairDataArr[index].rating}"),
                    progressColor: AppConstColors.appThemeCayan,
                  ),
          Text(hairDataArr[index].title ?? '',style: AppFonts().sego14normal.copyWith(color: Colors.white),),
        ],),
      );
    })),
  ),
),
      ],),),),
    );
  }

  Widget tabbarWidget(){
    return Positioned(
            top: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
              
                  children: [
                    Row(
                      children: [
                      const SizedBox(width: 5,),
                            GestureDetector(
                                onTap: () {
                                  // Navigator.pop(context);
                                },
                                child: Image.asset(
                                  AppStrings.backNavIcon,
                                  height: 31,
                                  width: 39,
                                  fit: BoxFit.fill,
                                )),
                                
                    ],),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),border: Border.all(color: Colors.white,width: 3)),child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 6),
                        child: Row(
                        children: [
                          Text("Go Live",style: AppFonts().sego14bold,),
                          const SizedBox(width: 12,),
                          const Icon(Icons.keyboard_arrow_down,color: Colors.white,)
                        ],
                                          ),
                      ),),
                    const SizedBox(width: 14,),
                   
                  ],
                ),
              ),
            ),
          );
  }


  Widget gradientContainer() {
    return Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, 0.6),
              colors: <Color>[Colors.transparent, Colors.black],
            ),
          ),
        ));
  }
}

class HairData{
  String? title;
  int percentage;
  int? rating;
  String? status;

  HairData(this.percentage,this.rating,this.status,this.title);
}