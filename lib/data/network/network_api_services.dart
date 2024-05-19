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
        throw BadRequestException("achi request nhi hai yeh");
      default:
        throw InternetException("${response.statusCode} : ${response.reasonPhrase}");
    }
  }

  @override
  Future getTagsAsync(String url, data) async {
    var logger = Logger();
    print('getTagsAsync fn');
    print('image data inside network class: ${data.toString()}');
    dynamic responsejson;
    try {
      Map<String, dynamic> requestBody = {
        'APIKey': 'PORP-UDGU-KVMG-6TLM',
        'UserId': ' btbpdev@gmail.com',
        'Latitude': 0.0,
        'Longitude': 0.0,
        'Tags': ["Acne", "ACNE_SEVERITY_SCORE_FAST", "ACNE_IMAGE_FAST"],
        // 'IsGrayOrBlue': false,
        // 'IsSoftFocusBG': false,
        // 'Contrast': 10,
        'ImageBytes': data
      };
      logger.d('Request body: ${requestBody}');
      var encodedData = json.encode(requestBody);
      logger.d('Encoded data: ${encodedData}');
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
      logger.i('Response: ${responsejson.toString()}');
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    } catch(e) {
      logger.e('Api Error: $e');
    }

    return responsejson;
  }
}
