class OfferDetailModel {
  bool? success;
  Data? data;

  OfferDetailModel({
    this.success,
    this.data,
  });

  factory OfferDetailModel.fromJson(Map<String, dynamic> json) =>
      OfferDetailModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };
}

class Data {
  String? image;
  var promoCode;
  List<Treatment>? treatments;
  String? description;
  var discountValue;
  String? title;
  List<Package>? packages;
  List<Membership>? memberships;
  var id;
  String? offerType;
  String? discountType;

  Data({
    this.image,
    this.treatments,
    this.promoCode,
    this.description,
    this.discountValue,
    this.title,
    this.packages,
    this.memberships,
    this.id,
    this.offerType,
    this.discountType,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    image: json["image"],
    promoCode: json["promoCode"],
    treatments: json["treatments"] == null
        ? []
        : List<Treatment>.from(
        json["treatments"]!.map((x) => Treatment.fromJson(x))),
    description: json["description"],
    discountValue: json["discount_value"],
    title: json["title"],
    packages: json["packages"] == null
        ? []
        : List<Package>.from(
        json["packages"]!.map((x) => Package.fromJson(x))),
    memberships: json["memberships"] == null
        ? []
        : List<Membership>.from(
        json["memberships"]!.map((x) => Membership.fromJson(x))),
    id: json["id"],
    offerType: json["offer_type"],
    discountType: json["discount_type"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "promoCode": promoCode,
    "treatments": treatments == null
        ? []
        : List<dynamic>.from(treatments!.map((x) => x.toJson())),
    "description": description,
    "discount_value": discountValue,
    "title": title,
    "packages": packages == null
        ? []
        : List<dynamic>.from(packages!.map((x) => x.toJson())),
    "memberships": memberships == null
        ? []
        : List<dynamic>.from(memberships!.map((x) => x.toJson())),
    "id": id,
    "offer_type": offerType,
    "discount_type": discountType,
  };
}

class Membership {
  String? membershipName;
  var membershipId;

  Membership({
    this.membershipName,
    this.membershipId,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
    membershipName: json["membership_name"],
    membershipId: json["membership_id"],
  );

  Map<String, dynamic> toJson() => {
    "membership_name": membershipName,
    "membership_id": membershipId,
  };
}

class Package {
  String? packageName;
  var packageId;

  Package({
    this.packageName,
    this.packageId,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    packageName: json["package_name"],
    packageId: json["package_id"],
  );

  Map<String, dynamic> toJson() => {
    "package_name": packageName,
    "package_id": packageId,
  };
}

class Treatment {
  List<Variation>? variations;
  var treatmentId;
  String? treatmentName;

  Treatment({
    this.variations,
    this.treatmentId,
    this.treatmentName,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    variations: json["variations"] == null
        ? []
        : List<Variation>.from(
        json["variations"]!.map((x) => Variation.fromJson(x))),
    treatmentId: json["treatment_id"],
    treatmentName: json["treatment_name"],
  );

  Map<String, dynamic> toJson() => {
    "variations": variations == null
        ? []
        : List<dynamic>.from(variations!.map((x) => x.toJson())),
    "treatment_id": treatmentId,
    "treatment_name": treatmentName,
  };
}

class Variation {
  var variationId;
  String? variationName;

  Variation({
    this.variationId,
    this.variationName,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    variationId: json["variation_id"],
    variationName: json["variation_name"],
  );

  Map<String, dynamic> toJson() => {
    "variation_id": variationId,
    "variation_name": variationName,
  };
}
