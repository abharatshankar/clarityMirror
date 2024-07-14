import 'package:clarity_mirror/core/network/base_api_services.dart';
import 'package:clarity_mirror/core/network/network_api_services.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();


  Future<dynamic> getTagsAsync(dynamic data) async {
    return await _apiServices.getTagsAsync(data);
    /// handle the response
  }

  Future<dynamic> getTagResults(dynamic imageId) async {
    return await _apiServices.getTagResults(imageId);
    /// handle the response
  }
}
