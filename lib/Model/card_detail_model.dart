class CardDetailModel {
  bool? success;
  Data? data;

  CardDetailModel({
    this.success,
    this.data,
  });

  factory CardDetailModel.fromJson(Map<String, dynamic> json) => CardDetailModel(
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  String? availableLocations;
  String? imagePath;
  bool? success;
  String? createdAt;
  String? title;
  String? updatedAt;
  String? headline;
  String? callToAction;

  Data({
    this.availableLocations,
    this.imagePath,
    this.success,
    this.createdAt,
    this.title,
    this.updatedAt,
    this.headline,
    this.callToAction,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    availableLocations: json["available_locations"],
    imagePath: json["image_path"],
    success: json["success"],
    createdAt: json["created_at"],
    title: json["title"],
    updatedAt: json["updated_at"],
    headline: json["headline"],
    callToAction: json["call_to_action"],
  );

  Map<String, dynamic> toJson() => {
    "available_locations": availableLocations,
    "image_path": imagePath,
    "success": success,
    "created_at": createdAt,
    "title": title,
    "updated_at": updatedAt,
    "headline": headline,
    "call_to_action": callToAction,
  };
}
