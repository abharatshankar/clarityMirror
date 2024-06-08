import 'dart:convert';
import 'dart:io';

import 'package:clarity_mirror/models/skin_concern_model.dart';
import 'package:clarity_mirror/models/tag_results_model.dart';
import 'package:clarity_mirror/repository/home_repository.dart';
import 'package:clarity_mirror/utils/btbp_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class DashboardViewModel extends ChangeNotifier {
  MethodChannel channel =
      const MethodChannel('com.example.clarity_mirror/mirror_channel');
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
  String? hairColor;
  String? hairType;
  String? hairLossLevel;
  String? facialHairType;
  bool isLoading = false;

  List<String> _tagsForSkinHealth = [
    'ACNE_SEVERITY_SCORE_FAST',
    'SPOTS_SEVERITY_SCORE_FAST',
    'REDNESS_SEVERITY_SCORE_FAST',
    'UNEVEN_SKINTONE_SEVERITY_SCORE_FAST',
    'PORES_SEVERITY_SCORE_FAST',
    'TEXTURE_SEVERITY_SCORE_FAST'
  ];
  List<Tag>? _skinHealthTags = [];
  int? avgOfTags;

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

   calculateHealthIndex() {
      _skinHealthTags = tagResults?.tags?.where(
          (element) {
            return _tagsForSkinHealth.contains(element.tagName);
          },
        ).toList();

        int? sumOfTags = _skinHealthTags?.fold(
            0,
            (sum, tag) =>
                (sum ?? 0) +
                int.parse(tag.tagValues?.firstWhere((combineVal) {
                      return combineVal.valueName == 'Combined';
                    }).value ??
                    '0'));

        avgOfTags = (((sumOfTags ?? 0) / 6).toInt() / 5 * 100).toInt();
  }

  calculateTemperature(){
     _tempTag = tagResults?.tags?.firstWhere(
          (tag) {
            return tag.tagName == "WEATHER";
          },
        );
        TagValue? tempTagValue = _tempTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'TEMPARATURE_C';
        });
        temperatureStr = tempTagValue?.value;
  }

  calculateUvIndex(){

        _uvTag = tagResults?.tags?.firstWhere(
          (tag) {
            return tag.tagName == "UVINDEX";
          },
        );
        TagValue? uvTagValue = _uvTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'Category';
        });
        uvIndexTxt = uvTagValue?.value;
  }


  calculatePollutionLevel(){
    _pollutionTag = tagResults?.tags?.firstWhere(
          (tag) {
            return tag.tagName == "POLLUTION_AQI";
          },
        );
        TagValue? pollutionTagValue =
            _pollutionTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'AirPollutionLevel';
        });
        pollutionLevelStr = pollutionTagValue?.value;
  }

  calculateTips(){

        TagValue? tipsTagValue =
            _pollutionTag?.tagValues?.firstWhere((tagValue) {
          return tagValue.valueName == 'HealthImplications';
        });
        tipsStr = tipsTagValue?.value;
  }

  Future<void> convertImageAndMakeApiCall(String imagePath) async {
    try {
      String base64Image = await encodeImageToBase64(imagePath);
      isLoading = true;
      dynamic imageId = await homeRepository.getTagsAsync(base64Image);
      Future.delayed(const Duration(seconds: 16), () async {
        dynamic tagResultsData = await homeRepository.getTagResults(imageId);
        tagResults = TagResults.fromJson(tagResultsData);

       calculateHealthIndex();

       calculateTemperature();

       calculateUvIndex();

       calculatePollutionLevel();

       calculateTips();
        // logger.d('Tags data: ${tagResults?.tags?.length} & Message: ${tagResults?.message}');
        logger.d(
            'Tags info: Pending count is -> ${tagResults?.pendingTagCount} & Processed count is: ${tagResults?.processedTagCount}');
        isLoading = false;
        notifyListeners();
      });

      /// updating the data to controller
    } catch (e) {
      logger.e(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  String calculateUVindexLevel(String? uvLevel) {
    String uvLevelStr = '';
    if (uvLevel != null) {
      if (int.parse(uvLevel) > 0 && int.parse(uvLevel) < 3) {
        uvLevelStr = "Low";
      } else if (int.parse(uvLevel) == 3 ||
          int.parse(uvLevel) == 4 ||
          int.parse(uvLevel) == 5) {
        uvLevelStr = "Moderate";
      } else if (int.parse(uvLevel) == 7 || int.parse(uvLevel) == 6) {
        uvLevelStr = "High";
      } else if (int.parse(uvLevel) == 8 ||
          int.parse(uvLevel) == 9 ||
          int.parse(uvLevel) == 10) {
        uvLevelStr = "Very High";
      } else if (int.parse(uvLevel) >= 11) {
        uvLevelStr = "Very High";
      }
    }
    return uvLevelStr;
  }

  getSkinConcernResults() {
    /// clearing the exiting skinConcernList data
    skinConcernList.clear();

    List scoreTags = BTBPConstants.scoreTags;
    List imageTags = BTBPConstants.imageTags;
    logger.d('Actual Score Tags Length: ${scoreTags.length}');
    tagResults?.tags?.forEach((Tag tag) {
      SkinConcernModel skinConcernModel = SkinConcernModel();
      /// adding the skin concerns to the list based on [scoreTags] list
      if (scoreTags.contains(tag.tagName)) {
        String? tagName = tag.tagName;
        skinConcernModel.setTagName = getTagName(tagName);
        skinConcernModel.setActualTagName = tag.tagName;
        tag.tagValues?.forEach((TagValue tagValue) {
          if (tagValue.valueName!.contains('Combined')) {
            skinConcernModel.setTagScore = int.parse(tagValue.value ?? '0');
            double percentage = (int.parse(tagValue.value ?? '0') * 20 / 100);
            skinConcernModel.setTagPercentage = percentage;
            logger.d('Percent: $percentage');

            if (percentage >= 0 && percentage <= 0.2) {
              skinConcernModel.setTagType = 'Low';
            } else if (percentage > 0.2 && percentage <= 0.4) {
              skinConcernModel.setTagType = 'Moderate-Low';
            } else if (percentage > 0.4 && percentage <= 0.6) {
              skinConcernModel.setTagType = 'Moderate';
            } else if (percentage > 0.6 && percentage <= 0.8) {
              skinConcernModel.setTagType = 'Moderate-High';
            } else if (percentage > 0.8 && percentage <= 1) {
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

  String getTagImage(String tagName) {

    return '';
  }
  /// Get tag title based on the tag name
  String getTagName(String? tagName) {
    logger.d('Tag Title Name: $tagName');
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

  ///
  getHairData() {
    try {
      Tag? hairColourTag = tagResults?.tags?.firstWhere(
            (tag) {
          return tag.tagName == BTBPConstants.hairColourTag;
        },
      );
      hairColor = hairColourTag?.tagValues?.first.value;

      Tag? hairTypeTag = tagResults?.tags?.firstWhere(
            (tag) {
          return tag.tagName == BTBPConstants.hairTypeTag;
        },
      );
      hairType = hairTypeTag?.tagValues?.first.value;

      Tag? hairLossLevelTag = tagResults?.tags?.firstWhere(
            (tag) {
          return tag.tagName == BTBPConstants.hairLossLevelTag;
        },
      );
      hairLossLevel = hairLossLevelTag?.tagValues?.first.value;

      Tag? facialHairTypeTag = tagResults?.tags?.firstWhere(
            (tag) {
          return tag.tagName == BTBPConstants.facialHairTypeTag;
        },
      );
      facialHairType = facialHairTypeTag?.tagValues?.first.value;
    }catch(e,s){
      logger.e('Exception: $e \n trace: $s');
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
