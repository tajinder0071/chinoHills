class CardListModel {
  bool? success;
  Data? data;

  CardListModel({
    this.success,
    this.data,
  });

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  bool? success;
  List<Datum>? data;

  Data({
    this.success,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? availableLocations;
  String? imagePath;
  String? title;
  int? id;
  String? headline;
  var callToAction;

  Datum({
    this.availableLocations,
    this.imagePath,
    this.title,
    this.id,
    this.headline,
    this.callToAction,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        availableLocations: json["available_locations"],
        imagePath: json["image_path"],
        title: json["title"],
        id: json["id"],
        headline: json["headline"],
        callToAction: json["call_to_action"],
      );

  Map<String, dynamic> toJson() => {
        "available_locations": availableLocations,
        "image_path": imagePath,
        "title": title,
        "id": id,
        "headline": headline,
        "call_to_action": callToAction,
      };
}
