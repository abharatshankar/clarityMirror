import 'dart:convert';
import 'dart:io';
import 'package:clarity_mirror/utils/btbp_constants.dart';
import 'package:http/http.dart' as http;
import 'package:clarity_mirror/data/app_exceptions.dart';
import 'package:clarity_mirror/data/network/base_api_services.dart';
import 'package:logger/logger.dart';

class NetworkApiServices extends BaseApiServices {
  var logger = Logger();

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
        throw InternetException(
            "${response.statusCode} : ${response.reasonPhrase}");
    }
  }

  @override
  Future getTagsAsync(String url, data) async {
    String? imageId = '';
    try {
      logger.i("Btbp tags: ${BTBPConstants.btbpTags}");
      Map<String, dynamic> requestBody = {
        'APIKey': 'PORP-UDGU-KVMG-6TLM',
        'UserId': 'clarity_mirror@btbp.org',
        "ClientId": "",
        "Latitude": 17.4065, //TODO: Add dynamic lat lang values
        "Longitude": 78.4772,
        // 'Tags': tags,
        'Tags': BTBPConstants.btbpTags,
        'ImageBytes': [data]
      };
      var encodedData = json.encode(requestBody);
      logger.d('Encoded data: $encodedData');
      final response = await http.post(Uri.parse(url),
          body: encodedData,
          headers: {"Content-type": "application/json", "Accept": "*/*"},
      ).timeout(const Duration(seconds: 30));
      Map<String, dynamic> responseData = responseJson(response);
      logger.i('Response: ${responseData.toString()}');
      if (responseData.containsKey('ImageId')) {
        return responseData['ImageId'];
      } else {
        throw Exception('ImageId is null');
      }
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    } catch (e, stackTrace) {
      logger.e('Api Error: $e \n Stack Trace: $stackTrace');
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
      };
      var encodedData = json.encode(requestBody);
      logger.d('Tag Results Encoded body: $encodedData');
      final response = await http.post(
        Uri.parse(
            "https://gserver1.btbp.org/deeptag/AppService.svc/getTagResults"),
        body: encodedData,
        headers: {"Content-type": "application/json", "Accept": "*/*"},
      ).timeout(const Duration(seconds: 40));
      responseData = responseJson(response);
      logger.i('Tag Results Response================>: ${responseData.toString()}');
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    } catch (e) {
      logger.e('Api Error: $e');
    }

    return responseData;
  }
}
