class TreatmentDetailsModel {
  bool? success;
  Data? data;

  TreatmentDetailsModel({
    this.success,
    this.data,
  });

  factory TreatmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      TreatmentDetailsModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  String? unitType;
  String? createdAt;
  List<Treatmentvarient>? treatmentvarient;
  String? price;
  var discountAmount;
  TreatmentInstructionData? treatmentInstructionData;
  String? treatmentDescription;
  String? bodyAreaIds;
  var id;
  List<Concern>? concern;
  List<String>? treatmentImagePaths;
  MembershipData? membershipData;
  List<RelatePackagesDatum>? relatePackagesData;
  String? treatmentName;

  Data({
    this.unitType,
    this.createdAt,
    this.treatmentvarient,
    this.price,
    this.discountAmount,
    this.treatmentInstructionData,
    this.treatmentDescription,
    this.bodyAreaIds,
    this.id,
    this.concern,
    this.treatmentImagePaths,
    this.membershipData,
    this.relatePackagesData,
    this.treatmentName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        unitType: json["unit_type"],
        createdAt: json["created_at"],
        treatmentvarient: json["treatmentvarient"] == null
            ? []
            : List<Treatmentvarient>.from(json["treatmentvarient"]!
                .map((x) => Treatmentvarient.fromJson(x))),
        price: json["price"],
        discountAmount: json["DiscountAmount"],
        treatmentInstructionData: json["treatmentInstructionData"] == null
            ? null
            : TreatmentInstructionData.fromJson(
                json["treatmentInstructionData"]),
        treatmentDescription: json["treatment_description"],
        bodyAreaIds: json["body_area_ids"],
        id: json["id"],
        concern: json["concern"] == null
            ? []
            : List<Concern>.from(
                json["concern"]!.map((x) => Concern.fromJson(x))),
        treatmentImagePaths: json["treatmentImagePaths"] == null
            ? []
            : List<String>.from(json["treatmentImagePaths"]!.map((x) => x)),
        membershipData: json["membershipData"] == null
            ? null
            : MembershipData.fromJson(json["membershipData"]),
        relatePackagesData: json["RelatePackagesData"] == null
            ? []
            : List<RelatePackagesDatum>.from(json["RelatePackagesData"]!
                .map((x) => RelatePackagesDatum.fromJson(x))),
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "unit_type": unitType,
        "created_at": createdAt,
        "treatmentvarient": treatmentvarient == null
            ? []
            : List<dynamic>.from(treatmentvarient!.map((x) => x.toJson())),
        "price": price,
        "DiscountAmount": discountAmount,
        "treatmentInstructionData": treatmentInstructionData?.toJson(),
        "treatment_description": treatmentDescription,
        "body_area_ids": bodyAreaIds,
        "id": id,
        "concern": concern == null
            ? []
            : List<dynamic>.from(concern!.map((x) => x.toJson())),
        "treatmentImagePaths": treatmentImagePaths == null
            ? []
            : List<dynamic>.from(treatmentImagePaths!.map((x) => x)),
        "membershipData": membershipData?.toJson(),
        "RelatePackagesData": relatePackagesData == null
            ? []
            : List<dynamic>.from(relatePackagesData!.map((x) => x.toJson())),
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

class MembershipData {
  int? membershipPricing;
  String? membershipTitle;
  int? membershipId;

  MembershipData({
    this.membershipPricing,
    this.membershipTitle,
    this.membershipId,
  });

  factory MembershipData.fromJson(Map<String, dynamic> json) => MembershipData(
        membershipPricing: json["membership_pricing"],
        membershipTitle: json["membership_title"],
        membershipId: json["membership_id"],
      );

  Map<String, dynamic> toJson() => {
        "membership_pricing": membershipPricing,
        "membership_title": membershipTitle,
        "membership_id": membershipId,
      };
}

class RelatePackagesDatum {
  String? membershipPrice;
  List<String>? packageImages;
  String? pricing;
  int? displayOrder;
  String? packageName;
  int? packageId;

  RelatePackagesDatum({
    this.membershipPrice,
    this.packageImages,
    this.pricing,
    this.displayOrder,
    this.packageName,
    this.packageId,
  });

  factory RelatePackagesDatum.fromJson(Map<String, dynamic> json) =>
      RelatePackagesDatum(
        membershipPrice: json["membershipPrice"],
        packageImages: json["package_images"] == null
            ? []
            : List<String>.from(json["package_images"]!.map((x) => x)),
        pricing: json["pricing"],
        displayOrder: json["display_order"],
        packageName: json["package_name"],
        packageId: json["package_id"],
      );

  Map<String, dynamic> toJson() => {
        "membershipPrice": membershipPrice,
        "package_images": packageImages == null
            ? []
            : List<dynamic>.from(packageImages!.map((x) => x)),
        "pricing": pricing,
        "display_order": displayOrder,
        "package_name": packageName,
        "package_id": packageId,
      };
}

class TreatmentInstructionData {
  List<String>? columns;
  List<List<String>>? data;

  TreatmentInstructionData({
    this.columns,
    this.data,
  });

  factory TreatmentInstructionData.fromJson(Map<String, dynamic> json) =>
      TreatmentInstructionData(
        columns: json["COLUMNS"] == null
            ? []
            : List<String>.from(json["COLUMNS"]!.map((x) => x)),
        data: json["DATA"] == null
            ? []
            : List<List<String>>.from(
                json["DATA"]!.map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "COLUMNS":
            columns == null ? [] : List<dynamic>.from(columns!.map((x) => x)),
        "DATA": data == null
            ? []
            : List<dynamic>.from(
                data!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class Treatmentvarient {
  String? membershipDiscountAmount;
  int? treatmentVariationId;
  int? treatmentVariationqty;
  String? treatmentVariationName;
  String? treatmentVariationPrice;

  Treatmentvarient({
    this.membershipDiscountAmount,
    this.treatmentVariationId,
    this.treatmentVariationName,
    this.treatmentVariationqty,
    this.treatmentVariationPrice,
  });

  factory Treatmentvarient.fromJson(Map<String, dynamic> json) =>
      Treatmentvarient(
        membershipDiscountAmount: json["membershipDiscountAmount"],
        treatmentVariationId: json["treatment_variation_id"],
        treatmentVariationqty: json["treatment_variation_qty"],
        treatmentVariationName: json["treatment_variation_name"],
        treatmentVariationPrice: json["treatment_variation_price"],
      );

  Map<String, dynamic> toJson() => {
        "membershipDiscountAmount": membershipDiscountAmount,
        "treatment_variation_id": treatmentVariationId,
        "treatment_variation_qty": treatmentVariationqty,
        "treatment_variation_name": treatmentVariationName,
        "treatment_variation_price": treatmentVariationPrice,
      };
}
