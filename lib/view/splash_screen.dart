import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:clarity_mirror/repository/home_repository.dart';
import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:clarity_mirror/view/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/viewModel/splash_service.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

import '../utils/routes/routes_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const platform =
      MethodChannel('com.example.clarity_mirror/tab_bar_screen');
  late ValueNotifier<double> valueNotifier;
  int keyForRepaint = 0;

  @override
  void initState() {
    super.initState();

    receiveDataFromAndroidCamera();
    valueNotifier = ValueNotifier(0.0);
    valueNotifier.value = 100.0;
    keyForRepaint++;
    SplashService.checkAuthentication(context);
  }

  receiveDataFromAndroidCamera() async {
    if(Platform.isAndroid) {
      platform.setMethodCallHandler(_receiveFromAndroidProject);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
              key: ValueKey(keyForRepaint),
              child: CustomPaint(
                painter: Painter(),
                child: Padding(
                  padding: const EdgeInsets.all(56.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      //circular progress animated
                      animatedCircle(),

                      SizedBox(
                          height: 60,
                          child: Text(
                            "BTBP",
                            style: AppFonts().sego29normal,
                          )),
                      clarityText()
                    ],
                  ),
                ),
              ),
            ),
            Text(
              "MIRROR",
              style: AppFonts().sego70normal,
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              'Your Skincare & Beauty Consultant',
              style: AppFonts().sego18normal,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    valueNotifier.dispose();
    super.dispose();
  }

  Widget animatedCircle() {
    return Center(
      child: SizedBox(
        height: 150,
        child: SimpleCircularProgressBar(
          progressColors: const [AppConstColors.appThemeCayan],
          size: 80,
          progressStrokeWidth: 10,
          backStrokeWidth: 25,
          valueNotifier: valueNotifier,
          mergeMode: true,
          animationDuration: 3,
        ),
      ),
    );
  }

  Widget clarityText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'CLARITY',
            style:
                AppFonts().sego29normal.copyWith(fontWeight: FontWeight.w100),
          ),
          WidgetSpan(
            child: Transform.translate(
              offset: const Offset(0.0, -20.0),
              child: Text(
                'TM',
                style: AppFonts().sego14normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _receiveFromAndroidProject(MethodCall call) async {
    try {
      if (call.method == "receiveData") {
        var logger = Logger();
        final String data = call.arguments;
        String base64Image = await encodeImageToBase64(data);

        // Create a JSON array and put the base64 image into it
        var jsonArray = jsonEncode([base64Image]);

        logger.d("Image Path is: $data");
        logger.d("Image Array is: $jsonArray");
        final _homeRepository = HomeRepository();
        await _homeRepository.getTagsAsync(jsonArray);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TabsDemoScreen(tabPosition: 3,)),
          ModalRoute.withName(RouteNames
              .tabbarScreen), // Remove all routes until the home route
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> encodeImageToBase64(String filePath) async {
    // Read image file
    List<int> imageBytes = await File(filePath).readAsBytes();

    // Convert image bytes to base64
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }

  List<int> base64ToImageArray(String base64String) {
    Uint8List bytes = base64.decode(base64String); // Decode Base64 string to bytes
    return bytes;
  }
}

class Painter extends CustomPainter {
  @override
  void paint(ui.Canvas canvas, ui.Size size) {
    canvas.drawPaint(
      Paint()
        ..shader = ui.Gradient.radial(
          Offset(size.width / 2, size.height / 1.5),
          300, // radius
          [Colors.grey.shade800, Colors.black],
        ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
