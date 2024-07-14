import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Utils {
// ! It contains all the utilities which help you in your project
  static const platform = MethodChannel('camera_ai_channel');

  static void changeNodeFocus(BuildContext context,
      {FocusNode? current, FocusNode? next}) {
    current!.unfocus();
    FocusScope.of(context).requestFocus(next);
  }


  /// Get tag title based on the tag name
  String getTagName(String? tagName) {
    // logger.d('Tag Title Name: $tagName');
    switch (tagName) {
      case "ACNE_SEVERITY_SCORE_FAST":
        return 'Acne';
      case "SPOTS_SEVERITY_SCORE_FAST":
        return 'Pigmentation';
      case "REDNESS_SEVERITY_SCORE_FAST":
        return 'Redness';
      case "WRINKLES_SEVERITY_SCORE_FAST":
        return 'Wrinkles';
      case "DEHYDRATION_SEVERITY_SCORE_FAST":
        return 'Dehydration';
      case "DARK_CIRCLES_SEVERITY_SCORE_FAST":
        return 'Dark Circles';
      case "UNEVEN_SKINTONE_SEVERITY_SCORE_FAST":
        return 'Uneven Skintone';
      case "PORES_SEVERITY_SCORE_FAST":
        return 'Pores';
      case "SHININESS_SEVERITY_SCORE_FAST":
        return 'Oiliness';
      case "LIP_ROUGHNESS_SEVERITY_SCORE_FAST":
        return 'Lip Health';
      case "ELASTICITY":
        return 'Elasticity';
      case "FIRMNESS":
        return 'Firmness';
      case "TEXTURE_SEVERITY_SCORE_FAST":
        return 'Texture';
      default:
        return 'N/A';
    }
  }
  

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  // average for ratings

  static double averageRatings(List<int> ratings) {
    double avg = 0;
    for (int i = 0; i < ratings.length; i++) {
      avg += ratings[i];
    }
    avg /= ratings.length;

    return avg;
  }

  static void getNewActivity() async {
    try {
      await platform.invokeMethod('startNewActivity');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

}
