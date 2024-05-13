import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_strings.dart';
import '../utils/custom_circle.dart';
import '../utils/custom_circular_percent.dart';

class DashboardBeauty extends StatefulWidget {
  const DashboardBeauty({super.key});

  @override
  State<DashboardBeauty> createState() => _DashboardBeautyState();
}

class _DashboardBeautyState extends State<DashboardBeauty> {
  List<BeautyData> beautyDataArr = [
    BeautyData(title: "Looks",picName:"assets/images/Dermatolgist6.png" ),
    BeautyData(picName: "assets/images/Dermatolgist6.png",title:  "Lipstick"),
    BeautyData(picName:  "assets/images/Dermatolgist6.png",title:"Foundation"),
    BeautyData(picName: "assets/images/Dermatolgist6.png",title:  "Maskara"),
    BeautyData(picName: "assets/images/Dermatolgist6.png",title: "Eye Lashes"),
    BeautyData(picName:  "assets/images/Dermatolgist6.png",title:"Foundation"),
    BeautyData(picName: "assets/images/Dermatolgist6.png",title:  "Maskara"),
    BeautyData(picName: "assets/images/Dermatolgist6.png",title: "Eye Lashes"),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppConstColors.themeBackgroundColor,
        body: SingleChildScrollView(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 130,
                  child: Image.asset(
                    "assets/images/Dermatolgist6.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              goliveButton(),
              gradientContainer(),
              beautyList(),
              
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
              colors: <Color>[
                Colors.transparent,
                Colors.black
              ],
            ),
          ),
        ));
  }

  Widget goliveButton() {
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
                  const SizedBox(
                    width: 5,
                  ),
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
                ],
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 3)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Row(
                    children: [
                      Text(
                        "Go Live",
                        style: AppFonts().sego14bold,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 18,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tempratureText(String temp) {
    return Positioned(
        right: 15,
        top: MediaQuery.of(context).size.height * 0.05,
        child: Text(
          "$temp\u00B0",
          style: AppFonts().sego29normal.copyWith(
                fontSize: 40,
                fontWeight: FontWeight.w600,
              ),
        ));
  }

  Widget tempIndexTxt({required String tempIndexStatus}) {
    return Positioned(
      right: 10,
      top: MediaQuery.of(context).size.height * 0.1,
      child: Text(
        tempIndexStatus,
        style: AppFonts().sego14normal,
      ),
    );
  }

  Widget humidityStatus({required String humidityStr}) {
    return Positioned(
      right: 10,
      top: MediaQuery.of(context).size.height * 0.122,
      child: Text(
        humidityStr,
        style: AppFonts().sego14normal,
      ),
    );
  }

  Widget skinHairTabs() {
    return Positioned(
      bottom: 110,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
              borderRadius: BorderRadius.circular(40)),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  backgroundColor: AppConstColors.appThemeCayan,
                  unselectedBackgroundColor: Colors.blueGrey.shade700,
                  labelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: (tabindex) {},
                  radius: 100,
                  tabs: [
                    Tab(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Center(
                              child: Text(
                            "SKIN CARE",
                            style: AppFonts().sego14normal.copyWith(height: 1),
                          ))),
                    ),
                    Tab(
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Center(
                              child: Text(
                            "HAIR CARE",
                            style: AppFonts().sego14normal.copyWith(height: 1),
                          ))),
                    ),
                  ],
                ),

                // const Expanded(
                //   child: TabBarView(
                //     children: <Widget>[
                //       Center(
                //         child: Icon(Icons.directions_car),
                //       ),
                //       Center(
                //         child: Icon(Icons.directions_transit),
                //       ),
                //       Center(
                //         child: Icon(Icons.directions_bike),
                //       ),
                //       Center(
                //         child: Icon(Icons.directions_car),
                //       ),
                //       Center(
                //         child: Icon(Icons.directions_transit),
                //       ),
                //       Center(
                //         child: Icon(Icons.directions_bike),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget ideaIconAndTxt() {
    return Positioned(
      left: 5,
      bottom: 0,
      child: Row(
        children: [
          const Icon(
            Icons.lightbulb_outlined,
            color: Color.fromARGB(255, 255, 147, 7),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "keep your skin hyderated",
            style: AppFonts()
                .sego18normal
                .copyWith(color: const Color.fromARGB(255, 255, 147, 7)),
          ),
        ],
      ),
    );
  }

  Widget excersiceWidget() {
    return const Positioned(
      right: 5,
      bottom: 7,
      child: Icon(
        Icons.sports_gymnastics_rounded,
        color: Colors.white,
        size: 37,
      ),
    );
  }

  Widget percentageCircle() {
    return Positioned(
      right: 5,
      bottom: MediaQuery.of(context).size.height * 0.07,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Skin health",
              style: AppFonts().sego14normal.copyWith(height: 1.5),
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: CustomPaint(
              size: const Size(5, 5), // no effect while adding child
              painter: CircularPaint(
                borderThickness: 3,
                progressValue: 0.9, //[0-1]
              ),
              child: Center(
                child: Text(
                  '95%',
                  style: AppFonts().sego14normal,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Excellent",
              style: AppFonts().sego10bold.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget beautyList() {
    return Positioned(
            left: 0,
            right: 0,
            bottom: -10, 
            child: Container(
              height: 100, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: beautyDataArr.length, 
                itemBuilder: (context, index) {
                  return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    
                    Container(decoration: const BoxDecoration(shape: BoxShape.circle),height: 40,width: 
                    40,child: Image.asset(beautyDataArr[index].picName ?? ''),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        beautyDataArr[index].title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: AppFonts()
                            .sego14normal
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
                },
              ),
            ),
          );
  }
}

class BeautyData {
  String? title;
  String? picName;

  BeautyData({this.picName, this.title});
}
