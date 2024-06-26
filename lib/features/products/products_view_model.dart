import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/features/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class ProductsViewModel extends ChangeNotifier {

  ProductsRepository productsRepository = ProductsRepository();
  Logger logger = Logger();

  /// Products model
  ProductsModel? productsModel;

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
      // updateLoader(false);
      _isLoading = false;
      notifyListeners();
    }catch(e,s) {
      logger.e('Exception in Products View Model: $e \n $s');
    }
  }
}