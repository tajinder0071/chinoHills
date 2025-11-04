class DynaminTabModel {
  HeaderDetails? headerDetails;
  bool? success;
  List<Datum>? data;

  DynaminTabModel({
    this.success,
    this.data,
    this.headerDetails,
  });

  factory DynaminTabModel.fromJson(Map<String, dynamic> json) =>
      DynaminTabModel(
        success: json["success"],
        headerDetails: json["headerDetails"] == null
            ? null
            : HeaderDetails.fromJson(json["headerDetails"]),
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "headerDetails": headerDetails?.toJson(),
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HeaderDetails {
  String? headerTitle;
  String? headerDescription;
  String? headerimage;

  HeaderDetails({
    this.headerTitle,
    this.headerDescription,
    this.headerimage,
  });

  factory HeaderDetails.fromJson(Map<String, dynamic> json) => HeaderDetails(
        headerTitle: json["category_header"] ?? json["headerTitle"],
        headerDescription:
            json["category_description"] ?? json["headerDescription"],
        headerimage: json["categoryHeaderCloudUrl"] ?? json["headerImage"],
      );

  Map<String, dynamic> toJson() => {
        "category_header": headerTitle,
        "category_description": headerDescription,
        "categoryHeaderCloudUrl": headerimage,
      };
}

class Datum {
  var price;
  String? description;
  String? image;
  dynamic concerns;
  dynamic id;
  var type;
  MembershipInfo? membershipInfo;
  String? name;
  String? offeroffText;
  var membershipOfferPrice;

  Datum(
      {this.price,
      this.image,
      this.description,
      this.concerns,
      this.membershipInfo,
      this.id,
      this.type,
      this.name,
      this.offeroffText,
      this.membershipOfferPrice});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        price: json["price"],
        image: json["image"],
        description: json["description"],
        concerns: json["concerns"],
        id: json["id"],
        type: json["type"],
        name: json["name"],
        membershipInfo: json["membership_info"] == null
            ? null
            : MembershipInfo.fromJson(json["membership_info"]),
        membershipOfferPrice: json["membership_offer_price"],
        offeroffText: json["offeroffText"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "image": image,
        "description": description,
        "concerns": concerns,
        "membership_offer_price": concerns,
        "membership_info": membershipInfo?.toJson(),
        "id": id,
        "type": type,
        "name": name,
        "offeroffText": offeroffText,
      };
}

class MembershipInfo {
  String? membershipName;
  var membershipOfferPrice;
  String? includedServiceName;
  var membershipId;
  var membershipBenefitId;
  var benefitIncludedTreatmentId;
  String? discountType;
  var amount;
  var discountedPrice;
  var discountAmount;
  var discountPercent;
  var serviceVariationId;
  bool? found;
  String? discountText;

  MembershipInfo({
    this.membershipName,
    this.membershipOfferPrice,
    this.includedServiceName,
    this.membershipId,
    this.membershipBenefitId,
    this.benefitIncludedTreatmentId,
    this.discountType,
    this.amount,
    this.discountedPrice,
    this.discountAmount,
    this.discountPercent,
    this.serviceVariationId,
    this.found,
    this.discountText,
  });

  factory MembershipInfo.fromJson(Map<String, dynamic> json) => MembershipInfo(
        membershipName: json["membership_name"],
        membershipOfferPrice: json["membership_offer_price"],
        includedServiceName: json["included_service_name"],
        membershipId: json["membership_id"],
        membershipBenefitId: json["membership_benefit_id"],
        benefitIncludedTreatmentId: json["benefit_included_treatment_id"],
        discountType: json["discount_type"],
        amount: json["amount"],
        discountedPrice: json["discounted_price"],
        discountAmount: json["discount_amount"],
        discountPercent: json["discount_percent"],
        serviceVariationId: json["service_variation_id"],
        found: json["found"],
        discountText: json["discount_text"],
      );

  Map<String, dynamic> toJson() => {
        "membership_name": membershipName,
        "membership_offer_price": membershipOfferPrice,
        "included_service_name": includedServiceName,
        "membership_id": membershipId,
        "membership_benefit_id": membershipBenefitId,
        "benefit_included_treatment_id": benefitIncludedTreatmentId,
        "discount_type": discountType,
        "amount": amount,
        "discounted_price": discountedPrice,
        "discount_amount": discountAmount,
        "discount_percent": discountPercent,
        "service_variation_id": serviceVariationId,
        "found": found,
        "discount_text": discountText,
      };
}

/*enum Type { MEMBERSHIP, PACKAGE, TREATMENT }

final typeValues = EnumValues({
  "Membership": Type.MEMBERSHIP,
  "Package": Type.PACKAGE,s
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
}*/
