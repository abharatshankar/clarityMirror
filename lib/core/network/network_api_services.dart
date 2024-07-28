import 'dart:convert';
import 'dart:io';
import 'package:clarity_mirror/utils/api_constants.dart';
import 'package:clarity_mirror/utils/btbp_constants.dart';
import 'package:clarity_mirror/utils/navigation_service.dart';
import 'package:clarity_mirror/features/dashboard/view_model/dashboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:clarity_mirror/core/app_exceptions.dart';
import 'package:clarity_mirror/core/network/base_api_services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../features/registration/models/registration_entity.dart';
import '../../utils/common_widgets/custom_alert_dialog.dart';

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
  Future getTagsAsync(data) async {
    String? imageId = '';
    try {
      var url = ApiConstants.baseUrl + ApiConstants.getTagsAsync;
      // logger.i("Btbp tags: ${BTBPConstants.btbpTags}");
      Map<String, dynamic> requestBody = {
        'APIKey': ApiConstants.androidApiKey1,
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
      final response = await http.post(
        Uri.parse(url),
        body: encodedData,
        headers: {"Content-type": "application/json", "Accept": "*/*"},
      ).timeout(const Duration(seconds: 30));
      Map<String, dynamic> responseData = responseJson(response);
      logger.i('Response: ${responseData.toString()}');
      if (responseData.containsKey('ImageId')) {
        /// Updating the image id to dashboard view mode for further use
        Provider.of<DashboardViewModel>(
                NavigationService.navigatorKey.currentContext!,
                listen: false)
            .setImageId(responseData['ImageId']);
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
      var url = ApiConstants.baseUrl + ApiConstants.getTagResults;
      Map<String, dynamic> requestBody = {
        'APIKey': ApiConstants.androidApiKey1,
        'ImageId': imageId,
      };
      var encodedData = json.encode(requestBody);
      logger.d('Tag Results Encoded body: $encodedData');
      final response = await http.post(
        Uri.parse(url),
        body: encodedData,
        headers: {"Content-type": "application/json", "Accept": "*/*"},
      );
      responseData = responseJson(response);
      logger.i(
          'Tag Results Response================>: ${responseData.toString()}');
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    } catch (e, s) {
      logger.e('Api Error: $e');
      print(s);
    }

    return responseData;
  }

  @override
  Future getRecommendedProducts() async {
    dynamic responseData;
    try {
      // var url = ApiConstants.baseUrl + ApiConstants.getTagResults;
      var url = ApiConstants.getProductRecommendations;
      Map<String, dynamic> requestBody = {
        'APIKey': ApiConstants.androidApiKey1,
        'ImageId': Provider.of<DashboardViewModel>(
                NavigationService.navigatorKey.currentContext!,
                listen: false)
            .imageId,
      };
      var encodedData = json.encode(requestBody);
      logger.d('Product Recommendations Encoded body: $encodedData');
      final response = await http.post(
        Uri.parse(url),
        body: encodedData,
        headers: {"Content-type": "application/json", "Accept": "*/*"},
      );
      responseData = responseJson(response);
      logger.i(
          'Recommended products data Response================>: ${responseData.toString()}');
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    } catch (e, s) {
      logger.e('Api Error: $e');
      print(s);
    }

    return responseData;
  }



  /// Api implementation for user sign up
  @override
  Future signUp({required RegistrationEntity registrationEntity,required BuildContext context}) async {
    dynamic responseData;
    try {
      /// show the progress indicator
      // CustomAlertDialog.showLoadingDialog();

      /// Test object
      // RegistrationEntity registrationEntity = RegistrationEntity(email: 'test', expertise: 'exp', firstName: 'first name', lastName: 'last name', mobile: '8019977327', password: 'password');

      /// Preparing the URL for sign up
      var url = ApiConstants.baseUrlPreLogin + ApiConstants.signUp;

      /// data encoding to pass to the post method in body
      var encodedData = json.encode(registrationEntity.toJson());
      logger.d('signUp body params: $encodedData');

      /// Making the actual api call for sign up with http client
      final response = await http.post(
        Uri.parse(url),
        body: encodedData,
        headers: {"Content-type": "application/json", "Accept": "*/*"},
      );
      responseData = responseJson(response);
      /// dismiss the loading indicator
      // CustomAlertDialog.stopLoadingIndicator();

      return responseData;
    } on SocketException {
      /// dismiss the loading indicator
      // CustomAlertDialog.stopLoadingIndicator();
      throw InternetException("NO Internet is available right now");
    } catch (e, s) {
      /// dismiss the loading indicator
      // CustomAlertDialog.stopLoadingIndicator();
      logger.e('Api Error Sign up: $e \n $s');
      return responseData;
    }
  }

  /// Api implementation for user sign in with the user data
  /// and return the response back to repository
  ///
  @override
  Future signIn({required String? userName, required String? password,required BuildContext context}) async {
    dynamic responseData;
    try {
      /// show the progress indicator
      CustomAlertDialog.showLoadingDialog(context);
      /// URL for user sign in
      var url = ApiConstants.baseUrlPreLogin + ApiConstants.signIn;

      /// Test data
      /*Map<String, dynamic> signInParams = {
        "UserName": 'mallikarjunreddy751@gmail.com',
        "Password": 'Malli@123',
      };*/

      /// body parameters for user sign
      Map<String, dynamic> signInParams = {
        "UserName": userName,
        "Password": password,
      };

      /// encoding the user data for sending in body params of the api call
      var encodedData = json.encode(signInParams);
      logger.d('signIn body params: $encodedData');

      /// Making the actual api call with the sign in url and body parameters obtained from the user input
      ///
      final response = await http.post(
        Uri.parse(url),
        body: encodedData,
        headers: {"Content-type": "application/json", "Accept": "*/*"},
      );
      responseData = responseJson(response);
      logger.i('SignIn Response================>: ${responseData.toString()}');
      /// dismiss the loading indicator
      CustomAlertDialog.stopLoadingIndicator(context);
      return responseData;
    } on SocketException {
      /// dismiss the loading indicator
      CustomAlertDialog.stopLoadingIndicator(context);
      throw InternetException("NO Internet is available right now");
    } catch (e, s) {
      /// dismiss the loading indicator
      CustomAlertDialog.stopLoadingIndicator(context);
      logger.e('Api Error Sign In: $e \n $s');
      return responseData;
    }
  }

}
