// To parse this JSON data, do
//
//     final browseDetailModel = browseDetailModelFromJson(jsonString);

import 'dart:convert';

BrowseDetailModel browseDetailModelFromJson(String str) =>
    BrowseDetailModel.fromJson(json.decode(str));

String browseDetailModelToJson(BrowseDetailModel data) =>
    json.encode(data.toJson());

class BrowseDetailModel {
  bool? success;
  List<Treatment>? treatments;
  String? concernDescription;
  List<Package>? packages;
  String? concernName;

  BrowseDetailModel({
    this.success,
    this.treatments,
    this.concernDescription,
    this.packages,
    this.concernName,
  });

  factory BrowseDetailModel.fromJson(Map<String, dynamic> json) =>
      BrowseDetailModel(
        success: json["success"],
        treatments: json["treatments"] == null
            ? []
            : List<Treatment>.from(
                json["treatments"]!.map((x) => Treatment.fromJson(x))),
        concernDescription: json["concern_description"],
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
                json["packages"]!.map((x) => Package.fromJson(x))),
        concernName: json["concern_name"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "treatments": treatments == null
            ? []
            : List<dynamic>.from(treatments!.map((x) => x.toJson())),
        "concern_description": concernDescription,
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "concern_name": concernName,
      };
}

class Package {
  List<String>? packageImages;
  String? pricing;
  String? membershipDiscountAmount;
  String? description;
  List<Concern>? concerns;
  var qty;
  String? packageName;
  var packageId;

  Package({
    this.packageImages,
    this.pricing,
    this.membershipDiscountAmount,
    this.description,
    this.concerns,
    this.qty,
    this.packageName,
    this.packageId,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageImages: json["package_images"] == null
            ? []
            : List<String>.from(json["package_images"]!.map((x) => x)),
        pricing: json["pricing"],
        membershipDiscountAmount: json["membershipDiscountAmount"],
        description: json["description"],
        concerns: json["concerns"] == null
            ? []
            : List<Concern>.from(
                json["concerns"]!.map((x) => Concern.fromJson(x))),
        qty: json["qty"],
        packageName: json["package_name"],
        packageId: json["package_id"],
      );

  Map<String, dynamic> toJson() => {
        "package_images": packageImages == null
            ? []
            : List<dynamic>.from(packageImages!.map((x) => x)),
        "pricing": pricing,
        "membershipDiscountAmount": membershipDiscountAmount,
        "description": description,
        "concerns": concerns == null
            ? []
            : List<dynamic>.from(concerns!.map((x) => x.toJson())),
        "qty": qty,
        "package_name": packageName,
        "package_id": packageId,
      };
}

class Concern {
  var concernId;
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

class Treatment {
  String? treatmentDescription;
  String? unitType;
  String? membershipDiscountAmount;
  String? bodyAreaIds;
  String? price;
  List<Concern>? concerns;
  var id;
  List<String>? treatmentImagePaths;
  String? treatmentName;

  Treatment({
    this.treatmentDescription,
    this.unitType,
    this.membershipDiscountAmount,
    this.bodyAreaIds,
    this.price,
    this.concerns,
    this.id,
    this.treatmentImagePaths,
    this.treatmentName,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        treatmentDescription: json["treatment_description"],
        unitType: json["unit_type"],
        membershipDiscountAmount: json["membershipDiscountAmount"],
        bodyAreaIds: json["body_area_ids"],
        price: json["price"],
        concerns: json["concerns"] == null
            ? []
            : List<Concern>.from(
                json["concerns"]!.map((x) => Concern.fromJson(x))),
        id: json["id"],
        treatmentImagePaths: json["treatmentImagePaths"] == null
            ? []
            : List<String>.from(json["treatmentImagePaths"]!.map((x) => x)),
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "treatment_description": treatmentDescription,
        "unit_type": unitType,
        "membershipDiscountAmount": membershipDiscountAmount,
        "body_area_ids": bodyAreaIds,
        "price": price,
        "concerns": concerns == null
            ? []
            : List<dynamic>.from(concerns!.map((x) => x.toJson())),
        "id": id,
        "treatmentImagePaths": treatmentImagePaths == null
            ? []
            : List<dynamic>.from(treatmentImagePaths!.map((x) => x)),
        "treatment_name": treatmentName,
      };
}
