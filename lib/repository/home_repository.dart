import 'package:clarity_mirror/data/network/base_api_services.dart';
import 'package:clarity_mirror/data/network/network_api_services.dart';
import 'package:clarity_mirror/models/movies_model.dart';
import 'package:clarity_mirror/res/widgets/app_urls.dart';

class HomeRepository {
  final BaseApiServices _apiServices = NetworkApiServices();
  Future<MovieListModel> fetchMoviesList() async {
    try {
      print("first line fetchMoviesList function");
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrls.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getTagsAsync(dynamic data) async {
    return await _apiServices.getTagsAsync(data);
    /// handle the response
  }

  Future<dynamic> getTagResults(dynamic imageId) async {
    return await _apiServices.getTagResults(imageId);
    /// handle the response
  }
}
