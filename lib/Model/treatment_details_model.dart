class TreatmentDetailsModel {
  String? message;
  bool? success;
  Treatment? treatment;

  TreatmentDetailsModel({
    this.message,
    this.success,
    this.treatment,
  });

  factory TreatmentDetailsModel.fromJson(Map<String, dynamic> json) =>
      TreatmentDetailsModel(
        message: json["message"],
        success: json["success"],
        treatment: json["treatment"] == null
            ? null
            : Treatment.fromJson(json["treatment"]),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "treatment": treatment?.toJson(),
  };
}

class Treatment {
  String? treatmentDescription;
  List<Variation>? variations;
  List<String>? images;
  List<dynamic>? treatmentBodyAreas;
  var treatmentId;
  List<String>? treatmentConcerns;
  String? treatmentName;
  var unitType;

  Treatment({
    this.treatmentDescription,
    this.variations,
    this.images,
    this.treatmentBodyAreas,
    this.treatmentId,
    this.treatmentConcerns,
    this.treatmentName,
    this.unitType,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    treatmentDescription: json["treatment_description"],
    variations: json["variations"] == null
        ? []
        : List<Variation>.from(
        json["variations"]!.map((x) => Variation.fromJson(x))),
    images: json["images"] == null
        ? []
        : List<String>.from(json["images"]!.map((x) => x)),
    treatmentBodyAreas: json["treatment_body_areas"] == null
        ? []
        : List<dynamic>.from(json["treatment_body_areas"]!.map((x) => x)),
    treatmentId: json["treatment_id"],
    treatmentConcerns: json["treatment_concerns"] == null
        ? []
        : List<String>.from(json["treatment_concerns"]!.map((x) => x)),
    treatmentName: json["treatment_name"],
    unitType: json["unit_type"],
  );

  Map<String, dynamic> toJson() => {
    "treatment_description": treatmentDescription,
    "variations": variations == null
        ? []
        : List<dynamic>.from(variations!.map((x) => x.toJson())),
    "images":
    images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "treatment_body_areas": treatmentBodyAreas == null
        ? []
        : List<dynamic>.from(treatmentBodyAreas!.map((x) => x)),
    "treatment_id": treatmentId,
    "treatment_concerns": treatmentConcerns == null
        ? []
        : List<dynamic>.from(treatmentConcerns!.map((x) => x)),
    "treatment_name": treatmentName,
    "unit_type": unitType,
  };
}

class Variation {
  List<Price>? prices;
  var variationId;
  String? treatmentVariationType;
  String? variationDescription;
  String? variationName;

  Variation({
    this.prices,
    this.variationId,
    this.treatmentVariationType,
    this.variationDescription,
    this.variationName,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
    prices: json["prices"] == null
        ? []
        : List<Price>.from(json["prices"]!.map((x) => Price.fromJson(x))),
    variationId: json["variation_id"],
    treatmentVariationType: json["treatment_variation_type"],
    variationDescription: json["variation_description"],
    variationName: json["variation_name"],
  );

  Map<String, dynamic> toJson() => {
    "prices": prices == null
        ? []
        : List<dynamic>.from(prices!.map((x) => x.toJson())),
    "variation_id": variationId,
    "treatment_variation_type": treatmentVariationType,
    "variation_description": variationDescription,
    "variation_name": variationName,
  };
}

class Price {
  var price;
  var treatmentvariationpriceid;
  MembershipInfo? membershipInfo;
  var qty;

  Price({
    this.price,
    this.treatmentvariationpriceid,
    this.membershipInfo,
    this.qty,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    price: json["price"],
    membershipInfo: json["membership_info"] == null
        ? null
        : MembershipInfo.fromJson(json["membership_info"]),
    qty: json["qty"],
    treatmentvariationpriceid: json["treatment_variation_price_id"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "membership_info": membershipInfo?.toJson(),
    "treatment_variation_price_id": treatmentvariationpriceid,
    "qty": qty,
  };
}

class MembershipInfo {
  var membershipName;
  var membershipOfferPrice;
  var membershipPrice;
  String? includedServiceName;
  var amount;
  var membershipId;
  var discountedPrice;
  var discounttext;
  var discountamount;
  var membershipBenefitId;
  var benefitIncludedTreatmentId;
  bool? found;
  var serviceVariationId;
  String? discountType;

  MembershipInfo({
    this.membershipName,
    this.membershipOfferPrice,
    this.membershipPrice,
    this.includedServiceName,
    this.discountamount,
    this.discounttext,
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
    membershipPrice: json["membership_pricing"],
    includedServiceName: json["included_service_name"],
    discountamount: json["discount_amount"],
    amount: json["amount"],
    discounttext: json["discount_text"],
    membershipId: json["membership_id"],
    discountedPrice: json["discounted_price"],
    membershipBenefitId: json["membership_benefit_id"],
    benefitIncludedTreatmentId: json["benefit_included_treatment_id"],
    found: json["found"],
    serviceVariationId: json["service_variation_id"],
    discountType: json["discount_type"],
  );

  Map<String, dynamic> toJson() => {
    "membership_offer_price": membershipOfferPrice,
    "membership_name": membershipName,
    "discount_amount": discountamount,
    "discount_text": discounttext,
    "membership_pricing": membershipPrice,
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
