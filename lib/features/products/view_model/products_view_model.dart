import 'package:clarity_mirror/features/products/model/products_model.dart';
import 'package:clarity_mirror/features/products/repository/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:collection/collection.dart';

import '../../../utils/utils.dart';

class ProductsViewModel extends ChangeNotifier {

  ProductsRepository productsRepository = ProductsRepository();
  Logger logger = Logger();

  /// Products model
  ProductsModel? productsModel;
  List<ProductRecommendation> productRecommendations = [];

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateLoader(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void addSelectedChoice(String choice) {
    selectedChoices.add(choice);
    // seperateByGroups();
    notifyListeners();
  }

  void removeSelectedChoice(String choice) {
    selectedChoices.remove(choice);
    // seperateByGroups();
    notifyListeners();
  }

   
  // user selected choices in products page by default all are selected
  Set<String> selectedChoices = {
    'Wrinkles',
    'Acne',
    'Pigmentation',
    'Hydration',
    'Texture',
    'Elasticity',
    'Redness',
    'Pores',
    'Dark Circles',
    'Dehydration',
    'Uneven Skintone',
    'Oiliness',
    'Lip Health',
    'Firmness',

    };

  Map<String, List<ProductRecommendation?>>? groupedProducts;

  Future<void> getProductRecommendations() async {
    try {
      // updateLoader(true);
      _isLoading = true;
      productsModel = await productsRepository.getRecommendedProducts();
      print(productsModel?.productRecommendations?.first.toJson());
      // updateLoader(false);
      print("Products000000000000000");
      groupedProducts = groupBy(productsModel?.productRecommendations ?? [],
        (product) => product?.regimentName ?? 'N/A');
      _isLoading = false;
      notifyListeners();
    } catch (e, s) {
      logger.e('Exception in Products View Model: $e \n $s');
    }
  }

  seperateByGroups() {
    groupedProducts = groupBy(productsModel?.productRecommendations ?? [],
        (product) => product?.regimentName ?? 'N/A');
        // if(groupedProducts?.values != null){
        //   for (var productRecomendataionsArr in groupedProducts!.values) {
        //   for(int i =0;i<productRecomendataionsArr.length;i++){
        //     for (var j = 0; j < (productRecomendataionsArr[i]?.recommendationCriteria ?? []).length; j++) {
        //       for (var k = 0; k < (productRecomendataionsArr[i]?.recommendationCriteria?[j].featureSeverityMapping?.length ?? 0) ; k++) {
        //         if(selectedChoices.contains(productRecomendataionsArr[i]?.recommendationCriteria?[j].featureSeverityMapping?[k].deepTagName)){

        //         }else{
        //           productRecomendataionsArr.removeAt(i);
        //         }
        //       }
        //     }
        //   }
        //   }
        // }
    if (groupedProducts?.values != null) {
      for (var productRecomendataionsArr in groupedProducts!.values) {
        for (ProductRecommendation? element in productRecomendataionsArr) {
          for (RecommendationCriterion? recomendedCriteria in element?.recommendationCriteria ?? []) {
            for (FeatureSeverityMapping featureSeverityMapping
                in recomendedCriteria?.featureSeverityMapping ?? []) {
              if (selectedChoices.contains(
                  Utils().getTagName(featureSeverityMapping.deepTagName))) {
                    element?.recommendationCriteria?.remove(recomendedCriteria);
              } else {
                
              }
            }
          }
        }
      }
    }
  }


}

class RecomendedProducts{
  final String titleName;
  final List<ProductRecommendation>? productRecommendations;

  RecomendedProducts({required this.titleName, required this.productRecommendations});

}