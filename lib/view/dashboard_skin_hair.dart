import 'dart:convert';
import 'dart:io';
import 'package:before_after/before_after.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:clarity_mirror/models/skin_concern_model.dart';
import 'package:clarity_mirror/viewModel/dashboard_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class _DashboardSkinHairState extends State<DashboardSkinHair> with SingleTickerProviderStateMixin   {
late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
     WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = Provider.of<DashboardViewModel>(context, listen: false);
      notifier.addListener(_handleTabChange);
    });
  }

  @override
  void dispose() {
    // final notifier = Provider.of<DashboardViewModel>(context, listen: false);
    // notifier.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }
  
  void _handleTabChange() {
    
    final notifier = Provider.of<DashboardViewModel>(context, listen: false);
    print("tabbb barrrrrrr ${notifier.currentIndex}");
    _tabController.animateTo(notifier.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardViewModel, _) {
        print('Selected TagImage Name ${dashboardViewModel.selectedTagImageModel?.tagName}');
        print('Selected TagImage Value ${dashboardViewModel.selectedTagImageModel?.tagImage}');
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
            body: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                dashboardViewModel.featureRecogImage ? SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.7.h,
                  
                  child:dashboardViewModel.currentIndex == 0 ? ((dashboardViewModel.selectedTagImageModel != null && dashboardViewModel.selectedTagImageModel?.tagImage != null) ? SizedBox(
                    height: MediaQuery.of(context).size.height ,
                    child: getImageCompareWidget(dashboardViewModel),
                  ) : getOriginalImageWidget(dashboardViewModel)):getOriginalImageWidget(dashboardViewModel) 
                ) :Platform.isAndroid ? getAndroidCameraViewWidget() : getIosCameraViewWidget(),
                goliveButton(),
                gradientContainer(),
               dashboardViewModel.featureRecogImage ? skinHairTabs(dashboardViewModel): const SizedBox.shrink(),
                dashboardViewModel.featureRecogImage ?
                (dashboardViewModel.tabPosition == 0 ? skinList(dashboardViewModel) : hairResultWidget()): const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getOriginalImageWidget(dashboardViewModel) {
   return Align(
      child: Container(
        // color: Colors.red,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: dashboardViewModel.capturedImagePath != null ? Image.file(File(dashboardViewModel.capturedImagePath),fit: BoxFit.cover,) : Image.asset(
          "assets/images/Dermatolgist6.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getImageCompareWidget(DashboardViewModel dashboardViewModel) {
    return Container(
      // color: Colors.green,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BeforeAfter(
        value: dashboardViewModel.value,
        // divisions: 4,
        thumbWidth: 20.0,
        // thumbColor: Colors.red,
        trackColor: Colors.white.withOpacity(0.6),
        trackWidth: 1,
        // hideThumb: true,
        hideThumb: false,
        // overlayColor: WidgetStateProperty.all(Colors.white),
          thumbDecoration: const BoxDecoration( shape: BoxShape.circle,image: DecorationImage(image: ExactAssetImage('assets/images/Progress.png'),
          fit: BoxFit.fill,)),
          before: Image.memory(
          base64Decode(dashboardViewModel.selectedTagImageModel!.tagImage!),
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          gaplessPlayback: true,
            scale: 0.5,
          // cacheWidth: int.parse(MediaQuery.of(context).size.width.toString()),
          // cacheHeight: int.parse(MediaQuery.of(context).size.height.toString()),
        ),
        after: Image.memory(
          base64Decode(dashboardViewModel.base64ThumbValue!),
          fit: BoxFit.contain,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          gaplessPlayback: true,
          scale: 0.5,
        ),
        direction: SliderDirection.horizontal,
        onValueChanged: (value) {
          dashboardViewModel.onCompareValueChanged(value);
        },
      ),
    );
  }

  /// TODO: Handle android live cam error handling
  Widget getAndroidCameraViewWidget() {
    return Positioned(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height:
        MediaQuery.of(context).size.height * 0.86.h,
        child: PlatformViewLink(
          viewType:
          'com.example.clarity_mirror/my_native_view',
          surfaceFactory: (BuildContext context,
              PlatformViewController controller) {
            if (controller is AndroidViewController) {
              return AndroidViewSurface(
                controller: controller,
                gestureRecognizers: const <Factory<
                    OneSequenceGestureRecognizer>>{},
                hitTestBehavior:
                PlatformViewHitTestBehavior.opaque,
              );
            }
            return Container();
          },
          onCreatePlatformView:
              (PlatformViewCreationParams params) {
            return PlatformViewsService
                .initSurfaceAndroidView(
              id: params.id,
              viewType:
              'com.example.clarity_mirror/my_native_view',
              layoutDirection: TextDirection.ltr,
              creationParams: null,
              creationParamsCodec:
              const StandardMessageCodec(),
            )
              ..addOnPlatformViewCreatedListener(
                  params.onPlatformViewCreated)
              ..create();
          },
        ),
      ),
    );
  }

  Widget getIosCameraViewWidget() {
    return Positioned(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height:
        MediaQuery.of(context).size.height ,
        // child: Image.asset(
        //   "assets/images/Dermatolgist6.png",
        //   fit: BoxFit.cover,
        // ),
        child: const UiKitView(
          viewType: 'custom_view',
          layoutDirection: TextDirection.ltr,
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
          // color: Colors.red,
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
                      const SizedBox(
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
              const SizedBox(
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



  Widget skinHairTabs(DashboardViewModel dashboardViewModel) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * 0.14.h,
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
                  controller: _tabController,
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
                    // setState(() {
                    //   tabPosition = index;
                    // });
                    dashboardViewModel.setTabIndex(index);
                    dashboardViewModel.setCurrentIndex(index);
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
          // child: TabBar(
          //       controller: _tabController,
          //       // give the indicator a decoration (color and border radius)
          //       indicator: BoxDecoration(
          //         borderRadius: BorderRadius.circular(
          //           25.0,
          //         ),
          //         color: Colors.green,
          //       ),
          //       labelColor: Colors.white,
          //       unselectedLabelColor: Colors.black,
          //       tabs: [
          //         // first tab [you can add an icon using the icon property]
          //         Tab(
          //           text: 'Place Bid',
          //         ),

          //         // second tab [you can add an icon using the icon property]
          //         Tab(
          //           text: 'Buy Now',
          //         ),
          //       ],
          //     ),
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
              style: AppFonts().sego10bold.copyWith(height: 1.5.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget skinList(DashboardViewModel provider) {
    // var provider = Provider.of<DashboardViewModel>(context, listen: true);
    // provider.getSkinConcernResults();
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: SizedBox(
        height: 120.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: provider.skinConcernList.length,
          padding: const EdgeInsets.only(left: 24),
          itemBuilder: (context, index) {
            // Tag? tagData = tagResults?.elementAt(index);
            SkinConcernModel? skinConcern = provider.skinConcernList.elementAt(index);
            return InkWell(
              onTap: () {
                provider.onSkinConcernTap(skinConcern);
                provider.updateSkinIndex(index);
              },
              child: Container(
                width: 85.w,
                margin: const EdgeInsets.only(right: 24.0, top: 16),
                alignment: Alignment.center,
                // padding: const EdgeInsets.only(top: 16),
                decoration: provider.selectedSkinConcern == skinConcern ? BoxDecoration(color: Colors.white.withOpacity(0.1),borderRadius: BorderRadius.circular(16)) : null,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        '${skinConcern.getTagType}',
                        // tagData?.tagName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        AppFonts().sego14normal.copyWith(color: Colors.white,fontSize: 12),
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
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        // tagData?.tagName ?? 'N/A',
                        skinConcern.getTagName ?? 'N/A',
                        style: AppFonts().sego10bold,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
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
      bottom: 0,
      child: SizedBox(
        height: 120,
        child: ListView(
          physics: const ClampingScrollPhysics(),
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
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      width: 90,
      // color: Colors.amber,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Expanded(
              child: Text(
                '$title',
                // tagData?.tagName ?? '',
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style:
                AppFonts().sego14normal.copyWith(color: AppConstColors.appThemeCayan),
              ),
            ),
          ),
          // CircularPercentIndicator(
          //   radius: 20.0,
          //   lineWidth: 3.0,
          //   // percent: (skinConcern.getTagScore! * 20) / 100,
          //   percent: 1.0,
          //   center: const Text("",
          //       style: TextStyle(
          //           color: AppConstColors.appThemeCayan)),
          //   progressColor: AppConstColors.appThemeCayan,
          // ),

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
