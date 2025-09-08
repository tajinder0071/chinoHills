class PackageDetailsModel {
  String? message;
  bool? success;
  Package? package;

  PackageDetailsModel({
    this.message,
    this.success,
    this.package,
  });

  factory PackageDetailsModel.fromJson(Map<String, dynamic> json) =>
      PackageDetailsModel(
        message: json["message"],
        success: json["success"],
        package:
            json["package"] == null ? null : Package.fromJson(json["package"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "package": package?.toJson(),
      };
}

class Package {
  String? offeroffText;
  var price;
  MembershipInfo? membershipInfo;
  List<dynamic>? instructions;
  var packageQty;
  List<IncludedTreatment>? includedTreatments;
  List<String>? images;
  String? description;
  List<String>? concerns;
  List<String>? bodyAreas;
  String? packageName;
  var packageId;

  Package({
    this.offeroffText,
    this.price,
    this.membershipInfo,
    this.instructions,
    this.packageQty,
    this.includedTreatments,
    this.images,
    this.description,
    this.concerns,
    this.bodyAreas,
    this.packageName,
    this.packageId,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        offeroffText: json["offeroffText"],
        price: json["price"],
        membershipInfo: json["membership_info"] == null
            ? null
            : MembershipInfo.fromJson(json["membership_info"]),
        instructions: json["instructions"] == null
            ? []
            : List<dynamic>.from(json["instructions"]!.map((x) => x)),
        packageQty: json["package_qty"],
        includedTreatments: json["included_treatments"] == null
            ? []
            : List<IncludedTreatment>.from(json["included_treatments"]!
                .map((x) => IncludedTreatment.fromJson(x))),
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        description: json["description"],
        concerns: json["concerns"] == null
            ? []
            : List<String>.from(json["concerns"]!.map((x) => x)),
        bodyAreas: json["body_areas"] == null
            ? []
            : List<String>.from(json["body_areas"]!.map((x) => x)),
        packageName: json["package_name"],
        packageId: json["package_id"],
      );

  Map<String, dynamic> toJson() => {
        "offeroffText": offeroffText,
        "price": price,
        "membership_info": membershipInfo?.toJson(),
        "instructions": instructions == null
            ? []
            : List<dynamic>.from(instructions!.map((x) => x)),
        "package_qty": packageQty,
        "included_treatments": includedTreatments == null
            ? []
            : List<dynamic>.from(includedTreatments!.map((x) => x.toJson())),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "description": description,
        "concerns":
            concerns == null ? [] : List<dynamic>.from(concerns!.map((x) => x)),
        "body_areas": bodyAreas == null
            ? []
            : List<dynamic>.from(bodyAreas!.map((x) => x)),
        "package_name": packageName,
        "package_id": packageId,
      };
}

class IncludedTreatment {
  String? unitName;
  var quantity;
  String? description;
  String? treatmentName;

  IncludedTreatment({
    this.unitName,
    this.quantity,
    this.description,
    this.treatmentName,
  });

  factory IncludedTreatment.fromJson(Map<String, dynamic> json) =>
      IncludedTreatment(
        unitName: json["unitName"],
        quantity: json["quantity"],
        description: json["description"],
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "unitName": unitName,
        "quantity": quantity,
        "description": description,
        "treatment_name": treatmentName,
      };
}

class MembershipInfo {
  String? membershipName;
  var membershipOfferPrice;
  var membershipPrice;
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
    this.membershipPrice,
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
        membershipPrice: json["membership_pricing"],
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
        "membership_pricing": membershipPrice,
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
