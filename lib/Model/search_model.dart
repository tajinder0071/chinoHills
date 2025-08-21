class SearchModel {
  bool? success;
  List<Treatment>? treatments;
  List<Package>? packages;

  SearchModel({
    this.success,
    this.treatments,
    this.packages,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        success: json["success"],
        treatments: json["treatments"] == null
            ? []
            : List<Treatment>.from(
                json["treatments"]!.map((x) => Treatment.fromJson(x))),
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
                json["packages"]!.map((x) => Package.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "treatments": treatments == null
            ? []
            : List<dynamic>.from(treatments!.map((x) => x.toJson())),
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
      };
}

class Package {
  List<String>? packageImages;
  String? pricing;
  var displayOrder;
  String? description;
  var qty;
  List<String>? bodyAreas;
  String? addedAt;
  String? packageName;
  List<Concern>? concern;
  var packageId;
  MembershipData? membershipData;

  Package({
    this.packageImages,
    this.pricing,
    this.displayOrder,
    this.description,
    this.qty,
    this.bodyAreas,
    this.addedAt,
    this.packageName,
    this.concern,
    this.packageId,
    this.membershipData,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageImages: json["package_images"] == null
            ? []
            : List<String>.from(json["package_images"]!.map((x) => x)),
        pricing: json["pricing"],
        displayOrder: json["display_order"],
        description: json["description"],
        qty: json["qty"],
        bodyAreas: json["body_areas"] == null
            ? []
            : List<String>.from(json["body_areas"]!.map((x) => x)),
        addedAt: json["added_at"],
        packageName: json["package_name"],
        concern: json["concern"] == null
            ? []
            : List<Concern>.from(
                json["concern"]!.map((x) => Concern.fromJson(x))),
        packageId: json["package_id"],
        membershipData: json["membershipData"] == null
            ? null
            : MembershipData.fromJson(json["membershipData"]),
      );

  Map<String, dynamic> toJson() => {
        "package_images": packageImages == null
            ? []
            : List<dynamic>.from(packageImages!.map((x) => x)),
        "pricing": pricing,
        "display_order": displayOrder,
        "description": description,
        "qty": qty,
        "body_areas": bodyAreas == null
            ? []
            : List<dynamic>.from(bodyAreas!.map((x) => x)),
        "added_at": addedAt,
        "package_name": packageName,
        "concern": concern == null
            ? []
            : List<dynamic>.from(concern!.map((x) => x.toJson())),
        "package_id": packageId,
        "membershipData": membershipData?.toJson(),
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
  String? membership;
  int? membershipPrice;
  int? memberId;

  MembershipData({
    this.membership,
    this.membershipPrice,
    this.memberId,
  });

  factory MembershipData.fromJson(Map<String, dynamic> json) => MembershipData(
        membership: json["membership"],
        membershipPrice: json["membership_price"],
        memberId: json["memberID"],
      );

  Map<String, dynamic> toJson() => {
        "membership": membership,
        "membership_price": membershipPrice,
        "memberID": memberId,
      };
}

class Treatment {
  String? unitType;
  String? createdAt;
  List<Treatmentvarient>? treatmentvarient;
  String? price;
  int? membershipPrice;
  String? treatmentDescription;
  int? membershipDiscountAmount;
  String? bodyAreaIds;
  String? updatedAt;
  int? id;
  List<Concern>? concern;
  List<String>? treatmentImagePaths;
  MembershipData? membershipData;
  String? treatmentName;

  Treatment({
    this.unitType,
    this.createdAt,
    this.treatmentvarient,
    this.price,
    this.membershipPrice,
    this.treatmentDescription,
    this.membershipDiscountAmount,
    this.bodyAreaIds,
    this.updatedAt,
    this.id,
    this.concern,
    this.treatmentImagePaths,
    this.membershipData,
    this.treatmentName,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        unitType: json["unit_type"],
        createdAt: json["created_at"],
        treatmentvarient: json["treatmentvarient"] == null
            ? []
            : List<Treatmentvarient>.from(json["treatmentvarient"]!
                .map((x) => Treatmentvarient.fromJson(x))),
        price: json["price"],
        membershipPrice: json["membership_price"],
        treatmentDescription: json["treatment_description"],
        membershipDiscountAmount: json["membershipDiscountAmount"],
        bodyAreaIds: json["body_area_ids"],
        updatedAt: json["updated_at"],
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
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "unit_type": unitType,
        "created_at": createdAt,
        "treatmentvarient": treatmentvarient == null
            ? []
            : List<dynamic>.from(treatmentvarient!.map((x) => x.toJson())),
        "price": price,
        "membership_price": membershipPrice,
        "treatment_description": treatmentDescription,
        "membershipDiscountAmount": membershipDiscountAmount,
        "body_area_ids": bodyAreaIds,
        "updated_at": updatedAt,
        "id": id,
        "concern": concern == null
            ? []
            : List<dynamic>.from(concern!.map((x) => x.toJson())),
        "treatmentImagePaths": treatmentImagePaths == null
            ? []
            : List<dynamic>.from(treatmentImagePaths!.map((x) => x)),
        "membershipData": membershipData?.toJson(),
        "treatment_name": treatmentName,
      };
}

class Treatmentvarient {
  int? membershipPrice;
  int? treatmentVariationId;
  String? treatmentVariationName;
  int? discountAmount;
  int? treatmentVariationPrice;

  Treatmentvarient({
    this.membershipPrice,
    this.treatmentVariationId,
    this.treatmentVariationName,
    this.discountAmount,
    this.treatmentVariationPrice,
  });

  factory Treatmentvarient.fromJson(Map<String, dynamic> json) =>
      Treatmentvarient(
        membershipPrice: json["membership_price"],
        treatmentVariationId: json["treatment_variation_id"],
        treatmentVariationName: json["treatment_variation_name"],
        discountAmount: json["discountAmount"],
        treatmentVariationPrice: json["treatment_variation_price"],
      );

  Map<String, dynamic> toJson() => {
        "membership_price": membershipPrice,
        "treatment_variation_id": treatmentVariationId,
        "treatment_variation_name": treatmentVariationName,
        "discountAmount": discountAmount,
        "treatment_variation_price": treatmentVariationPrice,
      };
}
