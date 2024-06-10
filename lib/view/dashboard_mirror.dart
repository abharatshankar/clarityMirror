import 'dart:io';
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/viewModel/dashboard_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../utils/app_strings.dart';
import '../utils/custom_circle.dart';

class DashboardMirror extends StatefulWidget {
  const DashboardMirror({super.key});

  @override
  State<DashboardMirror> createState() => _DashboardMirrorState();
}

class _DashboardMirrorState extends State<DashboardMirror> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardViewModel>(
      builder: (context, dashboardViewModel, _) {
        /// Handle the method call and return the image path and calling api after getting image
        dashboardViewModel.invokeMethodCallHandler();
        return SafeArea(
          child: Scaffold(
            backgroundColor: AppConstColors.themeBackgroundColor,
            body: Platform.isAndroid
                ? getAndroidViewWidget(dashboardViewModel)
                : getIosViewWidget(dashboardViewModel),
          ),
        );
      },
    );
  }

  Widget getAndroidViewWidget(dashboardViewModel) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Positioned(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height:
                  MediaQuery.of(context).size.height * 0.85,
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
              ),
              goliveButton(),
              dashboardViewModel.temperatureStr != null
                  ? tempratureText(
                  dashboardViewModel.temperatureStr)
                  : const SizedBox(),
              dashboardViewModel.uvIndexTxt != null
                  ? tempIndexTxt(
                  tempIndexStatus:
                  "uv index ${dashboardViewModel.uvIndexTxt}")
                  : const SizedBox(),
              humidityStatus(humidityStr: "Humidity low"),
              gradientContainer(),
              dashboardViewModel.pollutionLevelStr != null
                  ? pollutionStatus(
                  pollutionStr:
                  dashboardViewModel.pollutionLevelStr ??
                      '')
                  : Positioned(
                left: 10,
                bottom: MediaQuery.of(context).size.height *
                    0.05,
                child: const SizedBox(),
              ),
              dashboardViewModel.tipsStr != null
                  ? ideaIconAndTxt(dashboardViewModel.tipsStr)
                  : const Positioned(
                left: 5,
                bottom: 0,
                child: SizedBox(),
              ),
              excersiceWidget(),
              dashboardViewModel.avgOfTags != null
                  ? percentageCircle(
                  dashboardViewModel.avgOfTags.toString())
                  : Positioned(
                right: 5,
                bottom: MediaQuery.of(context).size.height *
                    0.07,
                child: const SizedBox(),
              ),
              dashboardViewModel.isLoading
                  ? Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 2,
                child: CircularProgressIndicator(
                  color: Colors.red,
                  backgroundColor: Colors.grey,
                ),
              )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }

  Widget getIosViewWidget(dashboardViewModel) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height:
                  MediaQuery.of(context).size.height - 200,
                  // child: Image.asset(
                  //   "assets/images/Dermatolgist6.png",
                  //   fit: BoxFit.cover,
                  // ),
                  child: UiKitView(
                    viewType: 'custom_view',
                    layoutDirection: TextDirection.ltr,
                  ),
                ),
              ),
              goliveButton(),
              dashboardViewModel.temperatureStr != null
                  ? tempratureText(
                  dashboardViewModel.temperatureStr)
                  : const SizedBox(),
              dashboardViewModel.uvIndexTxt != null
                  ? tempIndexTxt(
                  tempIndexStatus:
                  "uv index ${dashboardViewModel.uvIndexTxt}")
                  : const SizedBox(),
              humidityStatus(humidityStr: "Humidity low"),
              // gradientContainer(),
              dashboardViewModel.pollutionLevelStr != null
                  ? pollutionStatus(
                  pollutionStr:
                  dashboardViewModel.pollutionLevelStr ??
                      '')
                  : Positioned(
                left: 10,
                bottom: MediaQuery.of(context).size.height *
                    0.05,
                child: const SizedBox(),
              ),
              dashboardViewModel.tipsStr != null
                  ? ideaIconAndTxt(dashboardViewModel.tipsStr)
                  : const Positioned(
                left: 5,
                bottom: 0,
                child: SizedBox(),
              ),
              excersiceWidget(),
              dashboardViewModel.avgOfTags != null
                  ? percentageCircle(
                  dashboardViewModel.avgOfTags.toString())
                  : Positioned(
                right: 5,
                bottom: MediaQuery.of(context).size.height *
                    0.07,
                child: const SizedBox(),
              ),
              dashboardViewModel.isLoading
                  ? Positioned(
                top: MediaQuery.of(context).size.height / 2,
                left: MediaQuery.of(context).size.width / 2,
                child: CircularProgressIndicator(
                  color: Colors.red,
                  backgroundColor: Colors.grey,
                ),
              )
                  : Container(),
            ],
          ),
        ],
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

  Widget tempratureText(String? temp) {
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

  Widget pollutionStatus({required String pollutionStr}) {
    return Positioned(
      left: 10,
      bottom: MediaQuery.of(context).size.height * 0.05,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pollition moderate",
            style: AppFonts().sego14normal.copyWith(color: Colors.white),
          ),
          Text(
            pollutionStr,
            style: AppFonts().sego32normal.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget ideaIconAndTxt(String? tipsString) {
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
            tipsString ?? '',
            overflow: TextOverflow.fade,
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

  Widget percentageCircle(String? percentage) {
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
                progressValue: int.parse(percentage ?? "0") / 100, //[0-1]
              ),
              child: Center(
                child: Text(
                  '$percentage%',
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
}
