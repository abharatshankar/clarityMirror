
import 'package:flutter/material.dart';

import '../../features/registration/models/registration_entity.dart';

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getTagsAsync(dynamic data);
  Future<dynamic> getTagResults(String imageId);

  Future<dynamic> getRecommendedProducts();

  /// Abstract function to call sign in api from base api service
  Future<dynamic> signIn({required String? userName, required String? password,required BuildContext context});

  /// Abstract function to call signUp in api from base api service
  Future<dynamic> signUp({required RegistrationEntity registrationEntity,required BuildContext context});

}
