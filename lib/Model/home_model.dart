class HomeModel {
  String? message;
  bool? success;
  List<HomeDatum>? data;

  HomeModel({
    this.message,
    this.success,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<HomeDatum>.from(
                json["data"]!.map((x) => HomeDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HomeDatum {
  String? createdAt;
  String? color;
  String? subheader;
  String? headerImage;
  String? updatedAt;
  var id;
  var unlock_at_count;
  var unlock_spend;
  String? linkedImage;
  String? mainheader;
  String? concernsImage;

  HomeDatum({
    this.createdAt,
    this.color,
    this.subheader,
    this.headerImage,
    this.updatedAt,
    this.unlock_at_count,
    this.unlock_spend,
    this.id,
    this.linkedImage,
    this.mainheader,
    this.concernsImage,
  });

  factory HomeDatum.fromJson(Map<String, dynamic> json) => HomeDatum(
        createdAt: json["created_at"],
        color: json["color"],
        unlock_at_count: json["unlock_at_count"],
        unlock_spend: json["unlock_spend"],
        subheader: json["subheader"],
        headerImage: json["header_image"],
        updatedAt: json["updated_at"],
        id: json["id"],
        linkedImage: json["linked_image"],
        mainheader: json["mainheader"],
        concernsImage: json["concerns_image"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "color": color,
        "subheader": subheader,
        "header_image": headerImage,
        "updated_at": updatedAt,
        "unlock_at_count": unlock_at_count,
        "unlock_spend": unlock_spend,
        "id": id,
        "linked_image": linkedImage,
        "mainheader": mainheader,
        "concerns_image": concernsImage,
      };
}
