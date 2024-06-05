import 'dart:convert';
import 'dart:io';

import 'package:clarity_mirror/models/tag_results_model.dart';
import 'package:clarity_mirror/repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class DashboardViewModel extends ChangeNotifier {
  MethodChannel channel = const MethodChannel('com.example.clarity_mirror/mirror_channel');
  String? capturedImagePath;
  var logger = Logger();
  final homeRepository = HomeRepository();
  TagResults? tagResults;
  List<SkinConcernModel> skinConcernList = [];
Tag? _tempTag;
String? temperatureStr;
Tag? _uvTag;
String? uvIndexTxt;

Tag? _pollutionTag;
String? pollutionLevelStr;
String? tipsStr;


  void invokeMethodCallHandler() {
    channel.setMethodCallHandler(handleMethod);
  }

  Future<void> handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'onCaptureSuccess':
        String imagePath = call.arguments as String;
        await convertImageAndMakeApiCall(imagePath);
        
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
      Future.delayed(const Duration(seconds: 16), () async {
        dynamic tagResultsData = await homeRepository.getTagResults(imageId);
        tagResults = TagResults.fromJson(tagResultsData);
        _tempTag = tagResults?.tags?.firstWhere(
          (tag) {
            return tag.tagName == "WEATHER";
          },
        );
        TagValue? tempTagValue = _tempTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'TEMPARATURE_C';
        });
        temperatureStr = tempTagValue?.value;


        _uvTag =  tagResults?.tags?.firstWhere(
          (tag) {
            return tag.tagName == "UVINDEX";
          },
        );
        TagValue? uvTagValue = _uvTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'Category';
        });
        uvIndexTxt = uvTagValue?.value;


        _pollutionTag =  tagResults?.tags?.firstWhere(
          (tag) {
            return tag.tagName == "POLLUTION_AQI";
          },
        );
        TagValue? pollutionTagValue = _pollutionTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'AirPollutionLevel';
        });
        pollutionLevelStr = pollutionTagValue?.value;

        TagValue? tipsTagValue = _pollutionTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'HealthImplications';
        });
        tipsStr = tipsTagValue?.value;
        // logger.d('Tags data: ${tagResults?.tags?.length} & Message: ${tagResults?.message}');
        logger.d(
            'Tags info: Pending count is -> ${tagResults?.pendingTagCount} & Processed count is: ${tagResults?.processedTagCount}');
      notifyListeners();
      });
      

      /// updating the data to controller
    } catch (e) {
      logger.e(e.toString());
    }
  }

  String calculateUVindexLevel(String? uvLevel){
    String uvLevelStr = '';
    if(uvLevel != null ){
      if(int.parse(uvLevel) > 0 && int.parse(uvLevel) <3){
        uvLevelStr = "Low";
      }else if(int.parse(uvLevel) ==3 || int.parse(uvLevel) ==4 || int.parse(uvLevel) ==5 ){
        uvLevelStr = "Moderate";
      }else if(int.parse(uvLevel) ==7 || int.parse(uvLevel) ==6){
        uvLevelStr = "High";
      }else if(int.parse(uvLevel) ==8 || int.parse(uvLevel) ==9|| int.parse(uvLevel) ==10){
        uvLevelStr = "Very High";
      }else if(int.parse(uvLevel) >= 11 ){
        uvLevelStr = "Very High";
      }
      
    }
    return uvLevelStr;
  } 

  getSkinConcernResults() {
    /// clearing the exiting skinConcernList data
    skinConcernList.clear();
    List scoreTags = [
      "ACNE_SEVERITY_SCORE_FAST", "SPOTS_SEVERITY_SCORE_FAST", "REDNESS_SEVERITY_SCORE_FAST", "WRINKLES_SEVERITY_SCORE_FAST", "DEHYDRATION_SEVERITY_SCORE_FAST",
      "DARK_CIRCLES_SEVERITY_SCORE_FAST", "UNEVEN_SKINTONE_SEVERITY_SCORE_FAST", "PORES_SEVERITY_SCORE_FAST", "SHININESS_SEVERITY_SCORE_FAST", "LIP_ROUGHNESS_SEVERITY_SCORE_FAST",
      "ELASTICITY", "FIRMNESS", "TEXTURE_SEVERITY_SCORE_FAST"
    ];
    tagResults?.tags?.forEach((Tag tag) {
      SkinConcernModel skinConcernModel =  SkinConcernModel();
      if(scoreTags.contains(tag.tagName)) {
         String? tagName = tag.tagName;
         skinConcernModel.setTagName = tagName?.split('_').first ?? 'N/A';
        skinConcernModel.setTagImage = tag.tagImage;
        tag.tagValues?.forEach((TagValue tagValue) {
          if(tagValue.valueName!.contains('Combined')) {
            skinConcernModel.setTagScore = int.parse(tagValue.value??'0');
            double percentage = (int.parse(tagValue.value??'0') * 20 / 100);
            skinConcernModel.setTagPercentage = percentage;
            logger.d('Percent: $percentage');

            if(percentage >= 0 && percentage <= 0.2) {
              skinConcernModel.setTagType = 'Low';
            } else if(percentage > 0.2 && percentage <= 0.4) {
              skinConcernModel.setTagType = 'Moderate-Low';
            }  else if(percentage > 0.4 && percentage <= 0.6) {
              skinConcernModel.setTagType = 'Moderate';
            }
            else if(percentage > 0.6 && percentage <= 0.8) {
              skinConcernModel.setTagType = 'Moderate-High';
            }
            else if(percentage > 0.8 && percentage <= 1) {
              skinConcernModel.setTagType = 'High';
            }
            /// Add the skin concern data to [skinConcernList] list
            skinConcernList.add(skinConcernModel);
          }
        });
      }
    });
    logger.d('Final Tag REsults: ${skinConcernList.length}');
  }
  Future<String> encodeImageToBase64(String filePath) async {
    // Read image file
    List<int> imageBytes = await File(filePath).readAsBytes();

    // Convert image bytes to base64
    String base64Image = base64Encode(imageBytes);

    return base64Image;
  }

}

class SkinConcernModel {
  String? tagName;
  int? tagScore;
  double? tagPercentage;
  String? tagImage;
  String? tagType;

  String? get getTagName {
    return tagName;
  }

  set setTagName(String? name) {
    tagName = name;
  }

  int? get getTagScore {
    return tagScore;
  }

  set setTagScore(int? score) {
    tagScore = score;
  }

  double? get getTagPercentage {
    return tagPercentage;
  }

  set setTagPercentage(double? value) {
    tagPercentage = value;
  }

  String? get getTagImage {
    return tagName;
  }

  set setTagImage(String? image) {
    tagImage = image;
  }

  String? get getTagType {
    return tagType;
  }

  set setTagType(String? type) {
    tagType = type;
  }

}