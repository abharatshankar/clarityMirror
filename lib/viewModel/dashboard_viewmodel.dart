import 'dart:convert';
import 'dart:io';

import 'package:clarity_mirror/models/tag_results_model.dart';
import 'package:clarity_mirror/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class DashboardViewModel extends ChangeNotifier {
  MethodChannel channel = const MethodChannel('com.example.clarity_mirror/mirror_channel');
  String? capturedImagePath;
  var logger = Logger();
  final homeRepository = HomeRepository();
  TagResults? tagResults;

  void invokeMethodCallHandler() {
    channel.setMethodCallHandler(handleMethod);
  }

  Future<void> handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onCaptureSuccess':
        String imagePath = call.arguments as String;
        await convertImageAndMakeApiCall(imagePath);
        Fluttertoast.showToast(
          msg: imagePath,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        capturedImagePath = imagePath;
        print('Captured image in notifier: $capturedImagePath');
        notifyListeners();
        break;
      default:
        throw MissingPluginException('Plugin Exception: ${call.method}');
    }
  }

  Future<void> convertImageAndMakeApiCall(String imagePath) async {

    try {
      String base64Image = await encodeImageToBase64(imagePath);
      dynamic imageId = await homeRepository.getTagsAsync(base64Image);
      Future.delayed(const Duration(seconds: 16), () async{
        dynamic tagResultsData = await homeRepository.getTagResults(imageId);
        tagResults = TagResults.fromJson(tagResultsData);
        logger.d('Tags data: ${tagResults?.tags?.length} & Message: ${tagResults?.message}');
        logger.d('Tags info: Pending count is -> ${tagResults?.pendingTagCount} & Processed count is: ${tagResults?.processedTagCount}');
      });
      notifyListeners(); /// updating the data to controller
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<String> encodeImageToBase64(String filePath) async {
    // Read image file
    List<int> imageBytes = await File(filePath).readAsBytes();

    // Convert image bytes to base64
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }

}