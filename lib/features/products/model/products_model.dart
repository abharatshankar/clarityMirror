// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  List<ProductRecommendation>? productRecommendations;
  Request? request;
  int? statusCode;
  String? statusMessage;

  ProductsModel({
    this.productRecommendations,
    this.request,
    this.statusCode,
    this.statusMessage,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    productRecommendations: json["ProductRecommendations"] == null ? [] : List<ProductRecommendation>.from(json["ProductRecommendations"]!.map((x) => ProductRecommendation.fromJson(x))),
    request: json["Request"] == null ? null : Request.fromJson(json["Request"]),
    statusCode: json["StatusCode"],
    statusMessage: json["StatusMessage"],
  );

  Map<String, dynamic> toJson() => {
    "ProductRecommendations": productRecommendations == null ? [] : List<dynamic>.from(productRecommendations!.map((x) => x.toJson())),
    "Request": request?.toJson(),
    "StatusCode": statusCode,
    "StatusMessage": statusMessage,
  };
}

class ProductRecommendation {
  String? claim;
  dynamic countrySpecific;
  String? description;
  int? displayOrder;
  String? ecommerce;
  String? genderName;
  String? imageName;
  String? ingredients;
  bool? isDependencyProduct;
  dynamic localizationInfo;
  String? lowerAge;
  String? nickName;
  dynamic originProductId;
  String? prescribedTimeToUse;
  String? productBrand;
  String? productCode;
  String? productId;
  String? productImageBase64;
  String? productImageUrl;
  String? productInStock;
  String? productLineId;
  String? productLineName;
  String? productLineWeightage;
  String? productLineActions;
  String? productLineNeeds;
  String? productName;
  String? productPrice;
  String? productWeightage;
  List<RecommendationCriterion>? recommendationCriteria;
  String? regimentId;
  String? regimentName;
  dynamic specificTimeTouse;
  String? subName;
  String? substituteProduct;
  String? upperAge;
  String? usageInfo;

  ProductRecommendation({
    this.claim,
    this.countrySpecific,
    this.description,
    this.displayOrder,
    this.ecommerce,
    this.genderName,
    this.imageName,
    this.ingredients,
    this.isDependencyProduct,
    this.localizationInfo,
    this.lowerAge,
    this.nickName,
    this.originProductId,
    this.prescribedTimeToUse,
    this.productBrand,
    this.productCode,
    this.productId,
    this.productImageBase64,
    this.productImageUrl,
    this.productInStock,
    this.productLineId,
    this.productLineName,
    this.productLineWeightage,
    this.productLineActions,
    this.productLineNeeds,
    this.productName,
    this.productPrice,
    this.productWeightage,
    this.recommendationCriteria,
    this.regimentId,
    this.regimentName,
    this.specificTimeTouse,
    this.subName,
    this.substituteProduct,
    this.upperAge,
    this.usageInfo,
  });

  factory ProductRecommendation.fromJson(Map<String, dynamic> json) => ProductRecommendation(
    claim: json["Claim"],
    countrySpecific: json["CountrySpecific"],
    description: json["Description"],
    displayOrder: json["DisplayOrder"],
    ecommerce: json["Ecommerce"],
    genderName: json["GenderName"],
    imageName: json["ImageName"],
    ingredients: json["Ingredients"],
    isDependencyProduct: json["IsDependencyProduct"],
    localizationInfo: json["LocalizationInfo"],
    lowerAge: json["LowerAge"],
    nickName: json["NickName"],
    originProductId: json["OriginProductID"],
    prescribedTimeToUse: json["PrescribedTimeToUse"],
    productBrand: json["ProductBrand"],
    productCode: json["ProductCode"],
    productId: json["ProductID"],
    productImageBase64: json["ProductImage_Base64"],
    productImageUrl: json["ProductImage_URL"],
    productInStock: json["ProductInStock"],
    productLineId: json["ProductLineID"],
    productLineName: json["ProductLineName"],
    productLineWeightage: json["ProductLineWeightage"],
    productLineActions: json["ProductLine_Actions"],
    productLineNeeds: json["ProductLine_Needs"],
    productName: json["ProductName"],
    productPrice: json["ProductPrice"],
    productWeightage: json["ProductWeightage"],
    recommendationCriteria: json["RecommendationCriteria"] == null ? [] : List<RecommendationCriterion>.from(json["RecommendationCriteria"]!.map((x) => RecommendationCriterion.fromJson(x))),
    regimentId: json["RegimentID"],
    regimentName: json["RegimentName"],
    specificTimeTouse: json["SpecificTimeTouse"],
    subName: json["SubName"],
    substituteProduct: json["SubstituteProduct"],
    upperAge: json["UpperAge"],
    usageInfo: json["UsageInfo"],
  );

  Map<String, dynamic> toJson() => {
    "Claim": claim,
    "CountrySpecific": countrySpecific,
    "Description": description,
    "DisplayOrder": displayOrder,
    "Ecommerce": ecommerce,
    "GenderName": genderName,
    "ImageName": imageName,
    "Ingredients": ingredients,
    "IsDependencyProduct": isDependencyProduct,
    "LocalizationInfo": localizationInfo,
    "LowerAge": lowerAge,
    "NickName": nickName,
    "OriginProductID": originProductId,
    "PrescribedTimeToUse": prescribedTimeToUse,
    "ProductBrand": productBrand,
    "ProductCode": productCode,
    "ProductID": productId,
    "ProductImage_Base64": productImageBase64,
    "ProductImage_URL": productImageUrl,
    "ProductInStock": productInStock,
    "ProductLineID": productLineId,
    "ProductLineName": productLineName,
    "ProductLineWeightage": productLineWeightage,
    "ProductLine_Actions": productLineActions,
    "ProductLine_Needs": productLineNeeds,
    "ProductName": productName,
    "ProductPrice": productPrice,
    "ProductWeightage": productWeightage,
    "RecommendationCriteria": recommendationCriteria == null ? [] : List<dynamic>.from(recommendationCriteria!.map((x) => x.toJson())),
    "RegimentID": regimentId,
    "RegimentName": regimentName,
    "SpecificTimeTouse": specificTimeTouse,
    "SubName": subName,
    "SubstituteProduct": substituteProduct,
    "UpperAge": upperAge,
    "UsageInfo": usageInfo,
  };
}

class RecommendationCriterion {
  int? concernId;
  String? concernTitle;
  String? concernDescription;
  int? lowerAge;
  int? upperAge;
  String? gender;
  String? usageTime;
  dynamic dependencyProductIdList;
  List<FeatureSeverityMapping>? featureSeverityMapping;
  List<dynamic>? questionnaireMapping;

  RecommendationCriterion({
    this.concernId,
    this.concernTitle,
    this.concernDescription,
    this.lowerAge,
    this.upperAge,
    this.gender,
    this.usageTime,
    this.dependencyProductIdList,
    this.featureSeverityMapping,
    this.questionnaireMapping,
  });

  factory RecommendationCriterion.fromJson(Map<String, dynamic> json) => RecommendationCriterion(
    concernId: json["ConcernID"],
    concernTitle: json["ConcernTitle"],
    concernDescription: json["ConcernDescription"],
    lowerAge: json["LowerAge"],
    upperAge: json["UpperAge"],
    gender: json["Gender"],
    usageTime: json["UsageTime"],
    dependencyProductIdList: json["DependencyProductIdList"],
    featureSeverityMapping: json["FeatureSeverityMapping"] == null ? [] : List<FeatureSeverityMapping>.from(json["FeatureSeverityMapping"]!.map((x) => FeatureSeverityMapping.fromJson(x))),
    questionnaireMapping: json["QuestionnaireMapping"] == null ? [] : List<dynamic>.from(json["QuestionnaireMapping"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "ConcernID": concernId,
    "ConcernTitle": concernTitle,
    "ConcernDescription": concernDescription,
    "LowerAge": lowerAge,
    "UpperAge": upperAge,
    "Gender": gender,
    "UsageTime": usageTime,
    "DependencyProductIdList": dependencyProductIdList,
    "FeatureSeverityMapping": featureSeverityMapping == null ? [] : List<dynamic>.from(featureSeverityMapping!.map((x) => x.toJson())),
    "QuestionnaireMapping": questionnaireMapping == null ? [] : List<dynamic>.from(questionnaireMapping!.map((x) => x)),
  };
}

class FeatureSeverityMapping {
  List<String>? configuredSeverities;
  String? deepTagName;
  String? featureName;
  String? userSeverityLevel;
  String? userSeverityScore;

  FeatureSeverityMapping({
    this.configuredSeverities,
    this.deepTagName,
    this.featureName,
    this.userSeverityLevel,
    this.userSeverityScore,
  });

  factory FeatureSeverityMapping.fromJson(Map<String, dynamic> json) => FeatureSeverityMapping(
    configuredSeverities: json["ConfiguredSeverities"] == null ? [] : List<String>.from(json["ConfiguredSeverities"]!.map((x) => x)),
    deepTagName: json["DeepTagName"],
    featureName: json["FeatureName"],
    userSeverityLevel: json["UserSeverityLevel"],
    userSeverityScore: json["UserSeverityScore"],
  );

  Map<String, dynamic> toJson() => {
    "ConfiguredSeverities": configuredSeverities == null ? [] : List<dynamic>.from(configuredSeverities!.map((x) => x)),
    "DeepTagName": deepTagName,
    "FeatureName": featureName,
    "UserSeverityLevel": userSeverityLevel,
    "UserSeverityScore": userSeverityScore,
  };
}

class Request {
  String? apiKey;
  String? imageId;
  dynamic skinConcernsList;
  dynamic userQuestionAnswers;

  Request({
    this.apiKey,
    this.imageId,
    this.skinConcernsList,
    this.userQuestionAnswers,
  });

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    apiKey: json["APIKey"],
    imageId: json["ImageId"],
    skinConcernsList: json["SkinConcernsList"],
    userQuestionAnswers: json["UserQuestionAnswers"],
  );

  Map<String, dynamic> toJson() => {
    "APIKey": apiKey,
    "ImageId": imageId,
    "SkinConcernsList": skinConcernsList,
    "UserQuestionAnswers": userQuestionAnswers,
  };
}
