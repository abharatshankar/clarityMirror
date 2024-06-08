class SkinConcernModel {
  String? tagName;
  String? actualTagName;
  int? tagScore;
  double? tagPercentage;
  String? tagImage;
  String? tagType;

  String? get getTagName {
    return tagName;
  }

  set setTagName(String? name) {
    tagName = name;
  }

  String? get getActualTagName {
    return actualTagName;
  }

  set setActualTagName(String? name) {
    actualTagName = name;
  }

  int? get getTagScore {
    return tagScore;
  }

  set setTagScore(int? score) {
    tagScore = score;
  }

  double? get getTagPercentage {
    return tagPercentage;
  }

  set setTagPercentage(double? value) {
    tagPercentage = value;
  }

  String? get getTagImage {
    return tagImage;
  }

  set setTagImage(String? image) {
    tagImage = image;
  }

  String? get getTagType {
    return tagType;
  }

  set setTagType(String? type) {
    tagType = type;
  }
}

class TagImageModel {
String? tagImage;

String? tagName;

String? get getTagName {
  return tagName;
}

set setTagName(String? name) {
  tagName = name;
}
String? get getTagImage {
  return tagImage;
}

set setTagImage(String? image) {
  tagImage = image;
}
}