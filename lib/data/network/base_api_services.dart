
abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getTagsAsync(dynamic data);
  Future<dynamic> getTagResults(String imageId);

  Future<dynamic> getRecommendedProducts();
}
