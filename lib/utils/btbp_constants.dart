/// Constant class which will have all the BTBP tags and the tags info
class BTBPConstants {

  /// Score tags only [13 Tags]
  static List scoreTags = [
    "ACNE_SEVERITY_SCORE_FAST",
    "SPOTS_SEVERITY_SCORE_FAST",
    "REDNESS_SEVERITY_SCORE_FAST",
    "WRINKLES_SEVERITY_SCORE_FAST",
    "DEHYDRATION_SEVERITY_SCORE_FAST",
    "DARK_CIRCLES_SEVERITY_SCORE_FAST",
    "UNEVEN_SKINTONE_SEVERITY_SCORE_FAST",
    "PORES_SEVERITY_SCORE_FAST",
    "SHININESS_SEVERITY_SCORE_FAST",
    "LIP_ROUGHNESS_SEVERITY_SCORE_FAST",
    "ELASTICITY",
    "FIRMNESS",
    "TEXTURE_SEVERITY_SCORE_FAST"
  ];

  /// Images tags only [11 Tags]
  static List imageTags = [
    "ACNE_IMAGE_FAST",
    "SPOTS_IMAGE_FAST",
    "REDNESS_IMAGE_FAST",
    "WRINKLES_IMAGE_FAST",
    "DEHYDRATION_CONTOURS_COLORIZED_IMAGE_FAST",
    "DARK_CIRCLES_IMAGE_FAST",
    "UNEVEN_SKINTONE_IMAGE_FAST",
    "PORES_IMAGE_FAST",
    "SHININESS_IMAGE_FAST",
    "LIP_ROUGHNESS_IMAGE_FAST",
    "INPUT_IMAGE_THUMB", /// It will return the Original image to compare
  ];

  /// Weather related tags only [5 Tags]
  static List weatherTags = [
    "WEATHER",
    "GEOLOCATION_COUNTRY",
    "ELEVATION",
    "POLLUTION_AQI",
    "UVINDEX",
  ];

  static List hairCareTags = [
    "FACIALHAIRTYPE",
    "HAIRLOSSLEVEL",
    "HAIRTYPE",
    "HAIRCOLOR",
  ];

  ///"ELASTICITY","FIRMNESS", "TEXTURE_SEVERITY_SCORE_FAST" -> NO-Images available for these tags.
  /// INPUT_IMAGE_THUMB -> Will return original image for comparison
  ///
  /// Combination of all the tags [scoreTags], [imageTags] & [weatherTags]
  /// [29 Tags]
  static List btbpTags = scoreTags + imageTags + weatherTags + hairCareTags;

  /// Hair care tag names
  static String hairColourTag = "HAIRCOLOR";
  static String hairTypeTag = "HAIRTYPE";
  static String hairLossLevelTag = "HAIRLOSSLEVEL";
  static String facialHairTypeTag = "FACIALHAIRTYPE";

  // Skin concern titles
  static String acne = "Acne";
  static String pigmentation = "Pigmentation";
  static String redness = "Redness";
  static String wrinkles = "Wrinkles";
  static String dehydration = "Dehydration";
  static String darkCircles = "Dark Circles";
  static String unevenSkintone = "Uneven Skintone";
  static String pores = "Pores";
  static String oiliness = "Oiliness";
  static String lipHealth = "Lip Health";
  static String elasticity = "Elasticity";
  static String firmness = "Firmness";
  static String texture = "Texture";

}