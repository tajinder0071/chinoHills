class ShopModel {
  String? message;
  bool? success;
  List<PackageDatum>? data;
  List<PackageHeaderImage>? packageHeaderImage;
  String? categoryDescription;
  String? categoryHeader;

  ShopModel(
      {this.message,
      this.success,
      this.data,
      this.packageHeaderImage,
      this.categoryDescription,
      this.categoryHeader});

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
      message: json["message"],
      success: json["success"],
      data: json["data"] == null
          ? []
          : List<PackageDatum>.from(
              json["data"]!.map((x) => PackageDatum.fromJson(x))),
      packageHeaderImage: json["packageHeaderImage"] == null
          ? []
          : List<PackageHeaderImage>.from(json["packageHeaderImage"]!
              .map((x) => PackageHeaderImage.fromJson(x))),
      categoryHeader: json['category_header'],
      categoryDescription: json['category_description']);

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "packageHeaderImage": packageHeaderImage == null
            ? []
            : List<dynamic>.from(packageHeaderImage!.map((x) => x.toJson())),
        "category_description": categoryDescription,
        "category_header": categoryHeader,
      };
}

class PackageDatum {
  String? pricing;
  dynamic membershipFinalPrice;
  var displayOrder;
  var careInstructions;
  var rewardsPercentage;
  List<String>? treatmentQuantity;
  List<String>? packageImages;
  String? description;
  List<String>? bodyAreas;
  var qty;
  String? addedAt;
  List<String>? addedTreatment;
  String? packageName;
  List<Concern>? concern;
  var packageId;

  PackageDatum({
    this.pricing,
    this.displayOrder,
    this.careInstructions,
    this.rewardsPercentage,
    this.treatmentQuantity,
    this.packageImages,
    this.description,
    this.bodyAreas,
    this.qty,
    this.addedAt,
    this.addedTreatment,
    this.packageName,
    this.concern,
    this.packageId,
    this.membershipFinalPrice,
  });

  factory PackageDatum.fromJson(Map<String, dynamic> json) => PackageDatum(
        pricing: json["pricing"],
        membershipFinalPrice: json["membershipDiscountAmount"],
        displayOrder: json["display_order"],
        careInstructions: json["care_instructions"],
        rewardsPercentage: json["rewards_percentage"],
        treatmentQuantity: json["treatment_quantity"] == null
            ? []
            : List<String>.from(json["treatment_quantity"]!.map((x) => x)),
        packageImages: json["package_images"] == null
            ? []
            : List<String>.from(json["package_images"]!.map((x) => x)),
        description: json["description"],
        bodyAreas: json["body_areas"] == null
            ? []
            : List<String>.from(json["body_areas"]!.map((x) => x)),
        qty: json["qty"],
        addedAt: json["added_at"],
        addedTreatment: json["added_treatment"] == null
            ? []
            : List<String>.from(json["added_treatment"]!.map((x) => x)),
        packageName: json["package_name"],
        concern: json["concern"] == null
            ? []
            : List<Concern>.from(
                json["concern"]!.map((x) => Concern.fromJson(x))),
        packageId: json["package_id"],
      );

  Map<String, dynamic> toJson() => {
        "pricing": pricing,
        "membershipDiscountAmount": membershipFinalPrice,
        "display_order": displayOrder,
        "care_instructions": careInstructions,
        "rewards_percentage": rewardsPercentage,
        "treatment_quantity": treatmentQuantity == null
            ? []
            : List<dynamic>.from(treatmentQuantity!.map((x) => x)),
        "package_images": packageImages == null
            ? []
            : List<dynamic>.from(packageImages!.map((x) => x)),
        "description": description,
        "body_areas": bodyAreas == null
            ? []
            : List<dynamic>.from(bodyAreas!.map((x) => x)),
        "qty": qty,
        "added_at": addedAt,
        "added_treatment": addedTreatment == null
            ? []
            : List<dynamic>.from(addedTreatment!.map((x) => x)),
        "package_name": packageName,
        "concern": concern == null
            ? []
            : List<dynamic>.from(concern!.map((x) => x.toJson())),
        "package_id": packageId,
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

class PackageHeaderImage {
  String? packageHeaderImage;
  var userId;
  var id;

  PackageHeaderImage({
    this.packageHeaderImage,
    this.userId,
    this.id,
  });

  factory PackageHeaderImage.fromJson(Map<String, dynamic> json) =>
      PackageHeaderImage(
        packageHeaderImage: json["packageImageCloudUrl"],
        userId: json["user_id"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "packageImageCloudUrl": packageHeaderImage,
        "user_id": userId,
        "id": id,
      };
}
