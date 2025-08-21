class OfferListModel {
  bool? success;
  Data? data;

  OfferListModel({
    this.success,
    this.data,
  });

  factory OfferListModel.fromJson(Map<String, dynamic> json) => OfferListModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class Data {
  bool? success;
  List<Datum>? data;

  Data({
    this.success,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? offerUsage;
  String? createdAt;
  var services;
  String? offerimage;
  var discountValue;
  String? offerType;
  String? discountType;
  String? additionalDetail;
  String? availableLocations;
  String? offerStartDate;
  String? disclaimerMessage;
  String? visibility;
  String? offerEndDate;
  String? promoCode;
  String? title;
  String? updatedAt;
  var id;
  String? headline;
  String? includedServices;
  String? description;

  Datum({
    this.offerUsage,
    this.createdAt,
    this.services,
    this.offerimage,
    this.discountValue,
    this.offerType,
    this.discountType,
    this.additionalDetail,
    this.availableLocations,
    this.offerStartDate,
    this.disclaimerMessage,
    this.visibility,
    this.offerEndDate,
    this.promoCode,
    this.title,
    this.updatedAt,
    this.id,
    this.headline,
    this.includedServices,
    this.description,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        offerUsage: json["offer_usage"],
        createdAt: json["created_at"],
        services: json["services"],
        offerimage: json["offerimage"],
        discountValue: json["discount_value"],
        offerType: json["offer_type"],
        discountType: json["discount_type"],
        additionalDetail: json["additional_detail"],
        availableLocations: json["available_locations"],
        offerStartDate: json["offer_start_date"],
        disclaimerMessage: json["disclaimer_message"],
        visibility: json["visibility"],
        offerEndDate: json["offer_end_date"],
        promoCode: json["promo_code"],
        title: json["title"],
        updatedAt: json["updated_at"],
        id: json["id"],
        headline: json["headline"],
        includedServices: json["included_services"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "offer_usage": offerUsage,
        "created_at": createdAt,
        "services": services,
        "offerimage": offerimage,
        "discount_value": discountValue,
        "offer_type": offerType,
        "discount_type": discountType,
        "additional_detail": additionalDetail,
        "available_locations": availableLocations,
        "offer_start_date": offerStartDate,
        "disclaimer_message": disclaimerMessage,
        "visibility": visibility,
        "offer_end_date": offerEndDate,
        "promo_code": promoCode,
        "title": title,
        "updated_at": updatedAt,
        "id": id,
        "headline": headline,
        "included_services": includedServices,
        "description": description,
      };
}
