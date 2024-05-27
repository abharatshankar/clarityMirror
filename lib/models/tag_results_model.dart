// To parse this JSON data, do
//
//     final tagResults = tagResultsFromJson(jsonString);

import 'dart:convert';

TagResults tagResultsFromJson(String str) => TagResults.fromJson(json.decode(str));

String tagResultsToJson(TagResults data) => json.encode(data.toJson());

class TagResults {
  DateTime? timeStamp;
  String? imageId;
  String? message;
  List<Tag>? tags;
  int? processedTagCount;
  int? pendingTagCount;

  TagResults({
    this.timeStamp,
    this.imageId,
    this.message,
    this.tags,
    this.processedTagCount,
    this.pendingTagCount,
  });

  factory TagResults.fromJson(Map<String, dynamic> json) => TagResults(
    timeStamp: json["TimeStamp"] == null ? null : DateTime.parse(json["TimeStamp"]),
    imageId: json["ImageID"],
    message: json["Message"],
    tags: json["Tags"] == null ? [] : List<Tag>.from(json["Tags"]!.map((x) => Tag.fromJson(x))),
    processedTagCount: json["ProcessedTagCount"],
    pendingTagCount: json["PendingTagCount"],
  );

  Map<String, dynamic> toJson() => {
    "TimeStamp": timeStamp?.toIso8601String(),
    "ImageID": imageId,
    "Message": message,
    "Tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x.toJson())),
    "ProcessedTagCount": processedTagCount,
    "PendingTagCount": pendingTagCount,
  };
}

class Tag {
  String? tagName;
  dynamic tagImage;
  bool? status;
  String? message;
  int? statusCode;
  List<TagValue>? tagValues;

  Tag({
    this.tagName,
    this.tagImage,
    this.status,
    this.message,
    this.statusCode,
    this.tagValues,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    tagName: json["TagName"],
    tagImage: json["TagImage"],
    status: json["Status"],
    message: json["Message"],
    statusCode: json["StatusCode"],
    tagValues: json["TagValues"] == null ? [] : List<TagValue>.from(json["TagValues"]!.map((x) => TagValue.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "TagName": tagName,
    "TagImage": tagImage,
    "Status": status,
    "Message": message,
    "StatusCode": statusCode,
    "TagValues": tagValues == null ? [] : List<dynamic>.from(tagValues!.map((x) => x.toJson())),
  };
}

class TagValue {
  String? value;
  String? valueName;
  String? units;

  TagValue({
    this.value,
    this.valueName,
    this.units,
  });

  factory TagValue.fromJson(Map<String, dynamic> json) => TagValue(
    value: json["Value"],
    valueName: json["ValueName"],
    units: json["Units"],
  );

  Map<String, dynamic> toJson() => {
    "Value": value,
    "ValueName": valueName,
    "Units": units,
  };
}
