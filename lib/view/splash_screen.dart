import 'dart:ui' as ui;

import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:clarity_mirror/viewModel/splash_service.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late ValueNotifier<double> valueNotifier;

  int keyForRepaint = 0;

  @override
  void initState() {
    super.initState();

    valueNotifier = ValueNotifier(0.0);
    valueNotifier.value = 100.0;
    keyForRepaint++;
    SplashService.checkAuthentication(context);
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

  Widget animatedCircle(){
    return Center(
                        child: SizedBox(
                          height: 150,
                          child: SimpleCircularProgressBar(
                            progressColors: const [
                              AppConstColors.appThemeCayan
                            ],
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

  Widget clarityText(){
    return RichText(
                          text: TextSpan(
                        children: [
                           TextSpan(
                              text: 'CLARITY',
                              style: AppFonts().sego29normal.copyWith(fontWeight: FontWeight.w100),),
                          WidgetSpan(
                            child: Transform.translate(
                              offset: const Offset(0.0, -20.0),
                              child:  Text(
                                'TM',
                                style:
                                    AppFonts().sego14normal,
                              ),
                            ),
                          ),
                        ],
                      ),);
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
