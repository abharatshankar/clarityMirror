import 'package:clarity_mirror/data/network/base_api_services.dart';
import 'package:clarity_mirror/data/network/network_api_services.dart';
import 'package:clarity_mirror/features/products/model/products_model.dart';

class ProductsRepository {
  final BaseApiServices _apiServices = NetworkApiServices();

  /// Get the recommended products and return the response model
  /// TODO handle the error response by adding right & left using dartz package
  Future<ProductsModel> getRecommendedProducts() async {
    try {
      dynamic response = await _apiServices.getRecommendedProducts();
      return response = ProductsModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}
