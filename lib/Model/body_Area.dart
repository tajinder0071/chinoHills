class BodyAreaModel {
  bool? success;
  List<BodyDatum>? data;

  BodyAreaModel({
    this.success,
    this.data,
  });

  factory BodyAreaModel.fromJson(Map<String, dynamic> json) => BodyAreaModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<BodyDatum>.from(
                json["data"]!.map((x) => BodyDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BodyDatum {
  String? createdAt;
  String? updatedAt;
  int? id;
  String? bodyName;

  BodyDatum({
    this.createdAt,
    this.updatedAt,
    this.id,
    this.bodyName,
  });

  factory BodyDatum.fromJson(Map<String, dynamic> json) => BodyDatum(
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        id: json["id"],
        bodyName: json["body_part_name"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "updated_at": updatedAt,
        "id": id,
        "body_part_name": bodyName,
      };
}
