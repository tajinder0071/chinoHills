class DynaminTabModel {
  HeaderDetails? headerDetails;
  bool? success;
  List<Datum>? data;

  DynaminTabModel({this.headerDetails, this.success, this.data});

  factory DynaminTabModel.fromJson(Map<String, dynamic> json) =>
      DynaminTabModel(
        headerDetails: json["headerDetails"] == null
            ? null
            : HeaderDetails.fromJson(json["headerDetails"]),
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "headerDetails": headerDetails?.toJson(),
    "success": success,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  var membershipOfferPrice;
  String? offeroffText;
  var price;
  String? createdAt;
  String? name;
  String? image;
  String? description;
  List<dynamic>? concerns;
  var treatmentVariationId;
  List<String>? bodyAreas;
  var id;
  var type;
  MembershipInfo? membershipInfo;

  Datum({
    this.membershipOfferPrice,
    this.offeroffText,
    this.price,
    this.createdAt,
    this.name,
    this.image,
    this.description,
    this.concerns,
    this.treatmentVariationId,
    this.bodyAreas,
    this.id,
    this.type,
    this.membershipInfo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    membershipOfferPrice: json["membership_offer_price"],
    offeroffText: json["offeroffText"],
    price: json["price"],
    createdAt: json["created_at"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    concerns: json["concerns"] == null
        ? []
        : List<dynamic>.from(json["concerns"]!.map((x) => x)),
    treatmentVariationId: json["treatment_variation_id"],
    bodyAreas: json["body_areas"] == null
        ? []
        : List<String>.from(json["body_areas"]!.map((x) => x)),
    id: json["id"],
    type: json["type"],
    membershipInfo: json["membership_info"] == null
        ? null
        : MembershipInfo.fromJson(json["membership_info"]),
  );

  Map<String, dynamic> toJson() => {
    "membership_offer_price": membershipOfferPrice,
    "offeroffText": offeroffText,
    "price": price,
    "created_at": createdAt,
    "name": name,
    "image": image,
    "description": description,
    "concerns": concerns == null
        ? []
        : List<dynamic>.from(concerns!.map((x) => x)),
    "treatment_variation_id": treatmentVariationId,
    "body_areas": bodyAreas == null
        ? []
        : List<dynamic>.from(bodyAreas!.map((x) => x)),
    "id": id,
    "type": type,
    "membership_info": membershipInfo?.toJson(),
  };
}

class MembershipInfo {
  String? membershipName;
  var membershipOfferPrice;
  String? includedServiceName;
  var amount;
  var membershipId;
  var discountedPrice;
  var membershipBenefitId;
  var benefitIncludedTreatmentId;
  bool? found;
  var serviceVariationId;
  String? discountType;

  MembershipInfo({
    this.membershipName,
    this.membershipOfferPrice,
    this.includedServiceName,
    this.amount,
    this.membershipId,
    this.discountedPrice,
    this.membershipBenefitId,
    this.benefitIncludedTreatmentId,
    this.found,
    this.serviceVariationId,
    this.discountType,
  });

  factory MembershipInfo.fromJson(Map<String, dynamic> json) => MembershipInfo(
    membershipName: json["membership_name"],
    membershipOfferPrice: json["membership_offer_price"],
    includedServiceName: json["included_service_name"],
    amount: json["amount"],
    membershipId: json["membership_id"],
    discountedPrice: json["discounted_price"],
    membershipBenefitId: json["membership_benefit_id"],
    benefitIncludedTreatmentId: json["benefit_included_treatment_id"],
    found: json["found"],
    serviceVariationId: json["service_variation_id"],
    discountType: json["discount_type"],
  );

  Map<String, dynamic> toJson() => {
    "membership_name": membershipName,
    "membership_offer_price": membershipOfferPrice,
    "included_service_name": includedServiceName,
    "amount": amount,
    "membership_id": membershipId,
    "discounted_price": discountedPrice,
    "membership_benefit_id": membershipBenefitId,
    "benefit_included_treatment_id": benefitIncludedTreatmentId,
    "found": found,
    "service_variation_id": serviceVariationId,
    "discount_type": discountType,
  };
}

class HeaderDetails {
  String? categoryHeaderCloudUrl;
  String? categoryDescription;
  String? categoryHeader;

  HeaderDetails({
    this.categoryHeaderCloudUrl,
    this.categoryDescription,
    this.categoryHeader,
  });

  factory HeaderDetails.fromJson(Map<String, dynamic> json) => HeaderDetails(
    categoryHeaderCloudUrl: json["categoryHeaderCloudUrl"],
    categoryDescription: json["category_description"],
    categoryHeader: json["category_header"],
  );

  Map<String, dynamic> toJson() => {
    "categoryHeaderCloudUrl": categoryHeaderCloudUrl,
    "category_description": categoryDescription,
    "category_header": categoryHeader,
  };
}

enum Type { MEMBERSHIP, PACKAGE, TREATMENT }

final typeValues = EnumValues({
  "Membership": Type.MEMBERSHIP,
  "Package": Type.PACKAGE,
  "Treatment": Type.TREATMENT,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
