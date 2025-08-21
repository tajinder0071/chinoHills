class DiscoverModel {
  String? message;
  bool? success;
  Data? data;

  DiscoverModel({
    this.message,
    this.success,
    this.data,
  });

  factory DiscoverModel.fromJson(Map<String, dynamic> json) => DiscoverModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  List<ContentCard>? contentCards;
  List<OfferCard>? offerCards;

  Data({
    this.contentCards,
    this.offerCards,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        contentCards: json["contentCards"] == null
            ? []
            : List<ContentCard>.from(
                json["contentCards"]!.map((x) => ContentCard.fromJson(x))),
        offerCards: json["offerCards"] == null
            ? []
            : List<OfferCard>.from(
                json["offerCards"]!.map((x) => OfferCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contentCards": contentCards == null
            ? []
            : List<dynamic>.from(contentCards!.map((x) => x.toJson())),
        "offerCards": offerCards == null
            ? []
            : List<dynamic>.from(offerCards!.map((x) => x.toJson())),
      };
}

class ContentCard {
  String? availableLocations;
  String? imagePath;
  String? cloudUrl;
  String? createdAt;
  String? description;
  String? customUrl;
  String? customCallToAction;
  String? title;
  String? updatedAt;
  var id;
  String? headline;
  var callToAction;

  ContentCard({
    this.availableLocations,
    this.imagePath,
    this.cloudUrl,
    this.createdAt,
    this.description,
    this.customUrl,
    this.customCallToAction,
    this.title,
    this.updatedAt,
    this.id,
    this.headline,
    this.callToAction,
  });

  factory ContentCard.fromJson(Map<String, dynamic> json) => ContentCard(
        availableLocations: json["available_locations"],
        imagePath: json["image_path"] ?? "",
        createdAt: json["created_at"],
        description: json["description"],
        customUrl: json["custom_url"],
        cloudUrl: json["cloudUrl"],
        customCallToAction: json["custom_call_to_action"],
        title: json["title"],
        updatedAt: json["updated_at"],
        id: json["id"],
        headline: json["headline"],
        callToAction: json["call_to_action"],
      );

  Map<String, dynamic> toJson() => {
        "available_locations": availableLocations,
        "image_path": imagePath,
        "created_at": createdAt,
        "description": description,
        "custom_url": customUrl,
        "cloudUrl": cloudUrl,
        "custom_call_to_action": customCallToAction,
        "title": title,
        "updated_at": updatedAt,
        "id": id,
        "headline": headline,
        "call_to_action": callToAction,
      };
}

class OfferCard {
  List<ServiceName>? serviceName;
  String? description;
  String? promoCode;
  String? offerimage;
  String? cloudUrl;
  var discountValue;
  var treatmentvariationid;
  String? endDate;
  String? title;
  String? startDate;
  var promoCodeId;
  String? discountType;
  bool? isPromoCodeApplied;

  OfferCard({
    this.serviceName,
    this.cloudUrl,
    this.description,
    this.promoCode,
    this.treatmentvariationid,
    this.offerimage,
    this.discountValue,
    this.endDate,
    this.title,
    this.startDate,
    this.promoCodeId,
    this.discountType,
    this.isPromoCodeApplied,
  });

  factory OfferCard.fromJson(Map<String, dynamic> json) => OfferCard(
        serviceName: json["service_name"] == null
            ? []
            : List<ServiceName>.from(
                json["service_name"]!.map((x) => ServiceName.fromJson(x))),
        description: json["description"],
        promoCode: json["promo_code"],
        offerimage: json["offerimage"],
        discountValue: json["discount_value"],
        cloudUrl: json["cloudUrl"],
        treatmentvariationid: json["treatment_variation_id"],
        endDate: json["offer_end_date"],
        title: json["title"],
        startDate: json["start_date"],
        promoCodeId: json["promo_code_id"],
        discountType: json["discount_type"],
        isPromoCodeApplied: json["IsPromoCodeApplied"],
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName == null
            ? []
            : List<dynamic>.from(serviceName!.map((x) => x.toJson())),
        "description": description,
        "promo_code": promoCode,
        "cloudUrl": cloudUrl,
        "treatment_variation_id": treatmentvariationid,
        "offerimage": offerimage,
        "discount_value": discountValue,
        "offer_end_date": endDate,
        "title": title,
        "start_date": startDate,
        "promo_code_id": promoCodeId,
        "discount_type": discountType,
        "IsPromoCodeApplied": isPromoCodeApplied,
      };
}

class ServiceName {
  String? serviceName;
  var serviceId;
  ServiceType? serviceType;
  var treatment_variation_id;

  ServiceName(
      {this.serviceName,
      this.serviceId,
      this.serviceType,
      this.treatment_variation_id});

  factory ServiceName.fromJson(Map<String, dynamic> json) => ServiceName(
        serviceName: json["service_name"],
        serviceId: json["service_id"],
        serviceType: serviceTypeValues.map[json["service_type"]],
        treatment_variation_id:
            serviceTypeValues.map[json["treatment_variation_id"]],
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "service_id": serviceId,
        "service_type": serviceTypeValues.reverse[serviceType],
        "treatment_variation_id": treatment_variation_id,
      };
}

enum ServiceType { MEMBERSHIP, PACKAGE, TREATMENT }

final serviceTypeValues = EnumValues({
  "Memberships": ServiceType.MEMBERSHIP,
  "Packages": ServiceType.PACKAGE,
  "Treatments": ServiceType.TREATMENT
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
