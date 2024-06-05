import 'dart:io';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:clarity_mirror/models/tag_results_model.dart';
import 'package:clarity_mirror/viewModel/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';
import '../utils/app_strings.dart';
import '../utils/custom_circle.dart';
import '../utils/custom_circular_percent.dart';

class DashboardSkinHair extends StatefulWidget {
  const DashboardSkinHair({super.key});

  @override
  State<DashboardSkinHair> createState() => _DashboardSkinHairState();
}

class _DashboardSkinHairState extends State<DashboardSkinHair> {

  int tabPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardViewModel, _) {

      /*  print(
            'skin & hair tab - tags length: ${dashboardViewModel.tagResults?.tags?.length}');
        print(
            'skin & hair tab - Message: ${dashboardViewModel.tagResults?.message} ImageID: ${dashboardViewModel.tagResults?.imageId}');
        print(
            'Processed Tag count & Pending count: ${dashboardViewModel.tagResults?.processedTagCount} & ${dashboardViewModel.tagResults?.pendingTagCount}');
        dashboardViewModel.tagResults?.tags?.forEach((tag) {
          print(
              'Tag data: Message -> ${tag.message} TagName -> ${tag.tagName} Status -> ${tag.status} StatusCode -> ${tag.statusCode} TagValues -> ${tag.tagValues} ');
          print('Tag Values => ${tag.tagValues?.length}');
          tag.tagValues?.forEach((tagValue) {
            Logger().i(
                'Value: ${tagValue.value} Units: ${tagValue.units} ValueName: ${tagValue.valueName}');
          });
        });*/

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
                      height: MediaQuery.of(context).size.height - 110,
                      child: dashboardViewModel.capturedImagePath != null ? Image.file(File(dashboardViewModel.capturedImagePath!),fit: BoxFit.cover,) : Image.asset(
                        "assets/images/Dermatolgist6.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  goliveButton(),
                  gradientContainer(),
                  skinHairTabs(),
                  tabPosition == 0 ? skinList(dashboardViewModel.tagResults?.tags) : hairResultWidget(),
                ],
              ),
            ),
          ),
        );
      },
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
                // const Color(0x00ef5350),
                // const Color(0xffef5350),
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
                  onTap: (index) {
                    print('tab position: $index');
                    setState(() {
                      tabPosition = index;
                    });
                  },
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

               /* const Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Center(
                        child: Icon(Icons.directions_car),
                      ),
                      Center(
                        child: Icon(Icons.directions_transit),
                      ),
                    ],
                  ),
                ),*/
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

  Widget skinList(List<Tag>? tagResults) {
    Provider.of<DashboardViewModel>(context).getSkinConcernResults();

    return Positioned(
      left: 0,
      right: 0,
      bottom: -10,
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: Provider.of<DashboardViewModel>(context).skinConcernList.length,
          itemBuilder: (context, index) {
            // Tag? tagData = tagResults?.elementAt(index);
            SkinConcernModel? skinConcern = Provider.of<DashboardViewModel>(context).skinConcernList.elementAt(index);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0),
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      '${skinConcern.getTagType}',
                      // tagData?.tagName ?? '',
                      overflow: TextOverflow.ellipsis,
                      style:
                      AppFonts().sego14normal.copyWith(color: Colors.white),
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 20.0,
                    lineWidth: 5.0,
                    // percent: (skinConcern.getTagScore! * 20) / 100,
                    percent: skinConcern.getTagPercentage ?? 0,
                    center: Text("${skinConcern.getTagScore}",
                        style: const TextStyle(
                            color: AppConstColors.appThemeCayan)),
                    progressColor: AppConstColors.appThemeCayan,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      // tagData?.tagName ?? 'N/A',
                      skinConcern.getTagName ?? 'N/A',
                      style: AppFonts().sego10bold,
                    ),
                  ),
                  // Text(tagData?.tagValues?.length?.toString() ?? '0', style: TextStyle(color: Colors.white),),

                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget hairResultWidget() {
    Provider.of<DashboardViewModel>(context).getHairData();
    DashboardViewModel viewModel = Provider.of<DashboardViewModel>(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: -10,
      child: SizedBox(
        height: 120,
        child: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            getHairTagDataWidget(title: viewModel.hairType, type: 'Hair Type'),
            getHairTagDataWidget(title: viewModel.hairColor, type: 'Hair Color'),
            getHairTagDataWidget(title: viewModel.facialHairType, type: 'Facial Hair Type'),
            getHairTagDataWidget(title: viewModel.hairLossLevel, type: 'Hair Loss Level'),
          ],
        ),
      ),
    );
  }

  Widget getHairTagDataWidget({String? title, int? value, String? type}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '$title',
              // tagData?.tagName ?? '',
              overflow: TextOverflow.ellipsis,
              style:
              AppFonts().sego14normal.copyWith(color: Colors.white),
            ),
          ),
          CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 3.0,
            // percent: (skinConcern.getTagScore! * 20) / 100,
            percent: 1.0,
            center: Text("",
                style: const TextStyle(
                    color: AppConstColors.appThemeCayan)),
            progressColor: AppConstColors.appThemeCayan,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              '$type',
              style: AppFonts().sego10bold,
            ),
          ),
          // Text(tagData?.tagValues?.length?.toString() ?? '0', style: TextStyle(color: Colors.white),),

        ],
      ),
    );
  }
}

class HairData {
  String? title;
  int percentage;
  int? rating;
  String? status;

  HairData(this.percentage, this.rating, this.status, this.title);
}
