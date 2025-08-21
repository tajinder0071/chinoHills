class TreatmentListModel {
  bool? success;
  List<TreatmentListData>? data;
  String? headerImage;
  String? categoryHeader;
  String? categoryDescription;

  TreatmentListModel({
    this.success,
    this.data,
    this.headerImage,
    this.categoryHeader,
    this.categoryDescription,
  });

  factory TreatmentListModel.fromJson(Map<String, dynamic> json) =>
      TreatmentListModel(
          success: json["success"],
          data: json["data"] == null
              ? []
              : List<TreatmentListData>.from(
                  json["data"]!.map((x) => TreatmentListData.fromJson(x))),
          headerImage: json["headerImage"],
          categoryHeader: json["category_header"],
          categoryDescription: json['category_description']);

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "headerImage": headerImage,
        "category_header": categoryHeader,
        "category_description": categoryDescription,
      };
}

class TreatmentListData {
  String? unitType;
  var membershipPrice;
  String? DiscountType;
  String? createdAt;
  var price;
  String? reward;
  String? treatmentDescription;
  String? bodyAreaIds;
  List<String>? treatmentImagePath;
  var treatmentPrice;
  String? updatedAt;
  var id;
  List<Concern>? concern;
  String? treatmentName;

  TreatmentListData({
    this.unitType,
    this.membershipPrice,
    this.createdAt,
    this.price,
    this.reward,
    this.DiscountType,
    this.treatmentDescription,
    this.bodyAreaIds,
    this.treatmentImagePath,
    this.treatmentPrice,
    this.updatedAt,
    this.id,
    this.concern,
    this.treatmentName,
  });

  factory TreatmentListData.fromJson(Map<String, dynamic> json) =>
      TreatmentListData(
        unitType: json["unit_type"],
        DiscountType: json["DiscountType"],
        membershipPrice: json["membershipDiscountAmount"],
        createdAt: json["created_at"],
        price: json["price"],
        reward: json["Discount"].toString(),
        treatmentDescription: json["treatment_description"],
        bodyAreaIds: json["body_area_ids"],
        treatmentImagePath: json["treatment_image_path"] == null
            ? []
            : List<String>.from(json["treatment_image_path"]!.map((x) => x)),
        treatmentPrice: json["treatment_price"],
        updatedAt: json["updated_at"],
        id: json["id"],
        concern: json["concern"] == null
            ? []
            : List<Concern>.from(
                json["concern"]!.map((x) => Concern.fromJson(x))),
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "unit_type": unitType,
        "membershipDiscountAmount": membershipPrice,
        "created_at": createdAt,
        "price": price,
        "DiscountType": DiscountType,
        "Discount": reward,
        "treatment_description": treatmentDescription,
        "body_area_ids": bodyAreaIds,
        "treatment_image_path": treatmentImagePath == null
            ? []
            : List<dynamic>.from(treatmentImagePath!.map((x) => x)),
        "treatment_price": treatmentPrice,
        "updated_at": updatedAt,
        "id": id,
        "concern": concern == null
            ? []
            : List<dynamic>.from(concern!.map((x) => x.toJson())),
        "treatment_name": treatmentName,
      };
}

class Concern {
  int? concernId;
  String? concernName;

  Concern({
    this.concernId,
    this.concernName,
  });

  factory Concern.fromJson(Map<String, dynamic> json) => Concern(
        concernId: json["concern_id"],
        concernName: json["concern_name"],
      );

  Map<String, dynamic> toJson() => {
        "concern_id": concernId,
        "concern_name": concernName,
      };
}
