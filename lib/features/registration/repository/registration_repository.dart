
import 'package:clarity_mirror/core/network/base_api_services.dart';
import 'package:clarity_mirror/core/network/network_api_services.dart';
import 'package:clarity_mirror/features/registration/models/registration_entity.dart';
import 'package:clarity_mirror/features/registration/models/registration_model.dart';
import 'package:flutter/material.dart';

/// Repository class for registration
class RegistrationRepository {
  /// [_apiServices] Instance created for [NetworkApiServices] class for making the network api call for signup
  ///
  final BaseApiServices _apiServices = NetworkApiServices();

  /// Api Call invocation for user signup
  ///
  Future<RegistrationResponseModel> signUp({required RegistrationEntity registrationEntity,required BuildContext context}) async {
    try {
      Map<String, dynamic> response = await _apiServices.signUp(registrationEntity: registrationEntity,context: context);
      print('Response data: $response');
      return RegistrationResponseModel.fromJson(response);
    } catch(e,s) {
      // rethrow;
      print('Exception: $e \n $s');
      return RegistrationResponseModel();
    }
  }
}