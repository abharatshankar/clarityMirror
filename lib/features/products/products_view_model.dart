import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/features/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProductsViewModel extends ChangeNotifier {

  ProductsRepository productsRepository = ProductsRepository();
  Logger logger = Logger();

  /// Products model
  ProductsModel? productsModel;
  List<ProductRecommendation> productRecommendations = [];

  List<RecomendedProducts>? recomendedProductsArr ;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateLoader(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getProductRecommendations() async {
    try {
      // updateLoader(true);
      _isLoading = true;
      productsModel = await productsRepository.getRecommendedProducts();
      print(productsModel?.productRecommendations?.first.toJson());
      // updateLoader(false);
recomendedProductsArr = [RecomendedProducts(titleName: 'Regime for you',productRecommendations: productsModel?.productRecommendations ?? []),
RecomendedProducts(titleName: 'Other Products',productRecommendations: []),
RecomendedProducts(titleName: 'Customise products for you',productRecommendations:  []),
];
      _isLoading = false;
      notifyListeners();
    }catch(e,s) {
      logger.e('Exception in Products View Model: $e \n $s');
    }
  }
}

class RecomendedProducts{
  final String titleName;
  final List<ProductRecommendation>? productRecommendations;

  RecomendedProducts({required this.titleName, required this.productRecommendations});

}