class BrowseModel {
  String? message;
  bool? success;
  List<ConcernDatum>? data;
  List<ConcernImageDatum>? concernImageData;

  BrowseModel({
    this.message,
    this.success,
    this.data,
    this.concernImageData,
  });

  factory BrowseModel.fromJson(Map<String, dynamic> json) => BrowseModel(
    message: json["message"],
    success: json["success"],
    data: json["data"] == null
        ? []
        : List<ConcernDatum>.from(
        json["data"]!.map((x) => ConcernDatum.fromJson(x))),
    concernImageData: json["concernImageData"] == null
        ? []
        : List<ConcernImageDatum>.from(json["concernImageData"]!
        .map((x) => ConcernImageDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "concernImageData": concernImageData == null
        ? []
        : List<dynamic>.from(concernImageData!.map((x) => x.toJson())),
  };
}

class ConcernImageDatum {
  int? id;
  String? concernsImage;

  ConcernImageDatum({
    this.id,
    this.concernsImage,
  });

  factory ConcernImageDatum.fromJson(Map<String, dynamic> json) =>
      ConcernImageDatum(
        id: json["id"],
        concernsImage: json["concerns_image"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "concerns_image": concernsImage,
  };
}

class ConcernDatum {
  String? createdAt;
  var treatmentCount;
  String? updatedAt;
  var id;
  String? concernName;

  ConcernDatum({
    this.createdAt,
    this.treatmentCount,
    this.updatedAt,
    this.id,
    this.concernName,
  });

  factory ConcernDatum.fromJson(Map<String, dynamic> json) => ConcernDatum(
    createdAt: json["created_at"],
    treatmentCount: json["treatments_count"],
    updatedAt: json["updated_at"],
    id: json["id"],
    concernName: json["concern_name"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt,
    "treatment_count": treatmentCount,
    "updated_at": updatedAt,
    "id": id,
    "concern_name": concernName,
  };
}
