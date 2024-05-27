import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:clarity_mirror/utils/navigation_service.dart';
import 'package:clarity_mirror/utils/routes/routes_names.dart';
import 'package:clarity_mirror/view/tabbar_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clarity_mirror/data/app_exceptions.dart';
import 'package:clarity_mirror/data/network/base_api_services.dart';
import 'package:logger/logger.dart';

class NetworkApiServices extends BaseApiServices {
  var logger = Logger();
  List tags = [
    "Acne", "ACNE_SEVERITY_SCORE_FAST", "ACNE_IMAGE_FAST",
    "Wrinkles", "WRINKLES_SEVERITY_SCORE_FAST", "WRINKLES_IMAGE_FAST",
    "Redness", "REDNESS_SEVERITY_SCORE_FAST", "REDNESS_IMAGE_FAST",
    "DarkCircles", "DARK_CIRCLES_SEVERITY_SCORE_FAST", "DARK_CIRCLES_IMAGE_FAST",
    "Spots", "SPOTS_SEVERITY_SCORE_FAST", "SPOTS_IMAGE_FAST",
    "UnevenSkinTone", "UNEVEN_SKINTONE_SEVERITY_SCORE_FAST", "UNEVEN_SKINTONE_IMAGE_FAST",
    "Dehydration", "DEHYDRATION_SEVERITY_SCORE_FAST", "DEHYDRATION_CONTOURS_COLORIZED_IMAGE_FAST",
    "Oiliness", "SHININESS_SEVERITY_SCORE_FAST", "SHININESS_IMAGE_FAST",
    "Pores", "PORES_SEVERITY_SCORE_FAST", "PORES_IMAGE_FAST", "FACIALHAIRTYPE", "HAIRLOSSLEVEL", "HAIRTYPE"
  ];
  @override
  Future getGetApiResponse(String url) async {
    dynamic responsejson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responsejson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  dynamic responseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException("Bad request exception");
      default:
        throw InternetException("${response.statusCode} : ${response.reasonPhrase}");
    }
  }

  @override
  Future getTagsAsync(String url, data) async {
    String? imageId = '';
    try {
      Map<String, dynamic> requestBody = {
        'APIKey': 'PORP-UDGU-KVMG-6TLM',
        'UserId': 'clarity_mirror@btbp.org',
        'Latitude': 0.0,
        'Longitude': 0.0,
        // 'Tags': ["ACNE_IMAGE_FAST"],
        'Tags': tags,
        'ImageBytes': [data]
      };
      logger.d('Request body: $requestBody');
      var encodedData = json.encode(requestBody);
      logger.d('Encoded data: $encodedData');
      final response = await http
          .post(Uri.parse(url), body: encodedData, headers: {
        "Content-type": "application/json", "Accept": "application/json"
      })
          .timeout(const Duration(seconds: 30));
     Map<String, dynamic> responseData = responseJson(response);
      logger.i('Response: ${responseData.toString()}');
      if(responseData.containsKey('ImageId')) {
        return responseData['ImageId'];
        logger.i('ImageId is --> ${responseData['ImageId']}');
        await getTagResults(responseData['ImageId']);
      } else {
        throw Exception('ImageId is null');
      }
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    } catch(e) {
      logger.e('Api Error: $e');
    }

    return imageId;
  }

  @override
  Future getTagResults(String? imageId) async {
    dynamic responseData;
    try {
      Map<String, dynamic> requestBody = {
        'APIKey': 'PORP-UDGU-KVMG-6TLM',
        'ImageId': imageId,
        // 'Tags': ["ACNE_IMAGE_FAST"],
        'Tags': tags,
      };
      var encodedData = json.encode(requestBody);
      logger.d('Tag Results Encoded body: $encodedData');
      final response = await http
          .post(Uri.parse("https://gserver1.btbp.org/deeptag/AppService.svc/getTagResults"), body: encodedData, headers: {
        "Content-type": "application/json", "Accept": "application/json"
      })
          .timeout(const Duration(seconds: 30));
      responseData = responseJson(response);
      logger.i('Response: ${responseData.toString()}');
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    } catch(e) {
      logger.e('Api Error: $e');
    }

    return responseData;
  }
}
