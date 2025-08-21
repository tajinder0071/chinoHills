class SpecialOffersModel {
  bool? success;
  List<SpecialOffersData>? data;

  SpecialOffersModel({
    this.success,
    this.data,
  });

  factory SpecialOffersModel.fromJson(Map<String, dynamic> json) =>
      SpecialOffersModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<SpecialOffersData>.from(
                json["data"]!.map((x) => SpecialOffersData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class SpecialOffersData {
  List<ServiceName>? serviceName;
  String? description;
  String? promoCode;
  String? offerimage;
  var discountValue;
  String? endDate;
  String? title;
  String? startDate;
  var promoCodeId;
  String? discountType;
  bool? isPromoCodeApplied;

  SpecialOffersData({
    this.serviceName,
    this.description,
    this.promoCode,
    this.offerimage,
    this.discountValue,
    this.endDate,
    this.title,
    this.startDate,
    this.promoCodeId,
    this.discountType,
    this.isPromoCodeApplied ,
  });

  factory SpecialOffersData.fromJson(Map<String, dynamic> json) =>
      SpecialOffersData(
        serviceName: json["service_name"] == null
            ? []
            : List<ServiceName>.from(
                json["service_name"]!.map((x) => ServiceName.fromJson(x))),
        description: json["description"],
        promoCode: json["promo_code"],
        offerimage: json["offerimage"],
        discountValue: json["discount_value"],
        endDate: json["end_date"],
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
        "offerimage": offerimage,
        "discount_value": discountValue,
        "end_date": endDate,
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

  ServiceName({
    this.serviceName,
    this.serviceId,
    this.serviceType,
  });

  factory ServiceName.fromJson(Map<String, dynamic> json) => ServiceName(
        serviceName: json["service_name"],
        serviceId: json["service_id"],
        serviceType: serviceTypeValues.map[json["service_type"]],
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "service_id": serviceId,
        "service_type": serviceTypeValues.reverse[serviceType],
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
