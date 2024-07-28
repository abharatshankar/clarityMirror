import 'package:clarity_mirror/core/network/base_api_services.dart';
import 'package:clarity_mirror/core/network/network_api_services.dart';
import 'package:clarity_mirror/features/signin/models/signin_response_model.dart';
import 'package:flutter/material.dart';

/// Repository class for sign in to interact with api layer
/// and return the data to view model
class SignInRepository {
  /// [_apiServices] Instance created for [NetworkApiServices] class for making the network api call for signIn
  ///
  final BaseApiServices _apiServices = NetworkApiServices();

  /// Api Call invocation for user signIn
  ///
  Future<SignInResponseModel> signIn({required String? userName, required String? password,required BuildContext context}) async {
    try {
      Map<String, dynamic> response = await _apiServices.signIn(userName: userName, password: password,context: context);
      print('SignIn Response data: $response');
      return SignInResponseModel.fromJson(response);
    } catch(e,s) {
      // rethrow;
      print('Exception: $e \n $s');
      return SignInResponseModel();
    }
  }
}