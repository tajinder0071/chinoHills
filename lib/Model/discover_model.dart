class DiscoverModel {
  bool? success;
  List<ContentCard>? data;

  DiscoverModel({
    this.success,
    this.data,
  });

  factory DiscoverModel.fromJson(Map<String, dynamic> json) => DiscoverModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ContentCard>.from(
                json["data"]!.map((x) => ContentCard.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ContentCard {
  String? imagePath;
  var displayOrder;
  DateTime? createdAt;
  String? customCallToAction;
  var callToAction;
  String? availableLocations;
  var clientId;
  String? description;
  String? customUrl;
  String? title;
  DateTime? updatedAt;
  var id;
  String? headline;
  String? cloudUrl;

  ContentCard({
    this.imagePath,
    this.displayOrder,
    this.createdAt,
    this.customCallToAction,
    this.callToAction,
    this.availableLocations,
    this.clientId,
    this.description,
    this.customUrl,
    this.title,
    this.updatedAt,
    this.id,
    this.headline,
    this.cloudUrl,
  });

  factory ContentCard.fromJson(Map<String, dynamic> json) => ContentCard(
        imagePath: json["image_path"],
        displayOrder: json["display_order"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        customCallToAction: json["custom_call_to_action"],
        callToAction: json["call_to_action"],
        availableLocations: json["available_locations"],
        clientId: json["client_id"],
        description: json["description"],
        customUrl: json["custom_url"],
        title: json["title"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        id: json["id"],
        headline: json["headline"],
        cloudUrl: json["cloudUrl"],
      );

  Map<String, dynamic> toJson() => {
        "image_path": imagePath,
        "display_order": displayOrder,
        "created_at": createdAt?.toIso8601String(),
        "custom_call_to_action": customCallToAction,
        "call_to_action": callToAction,
        "available_locations": availableLocations,
        "client_id": clientId,
        "description": description,
        "custom_url": customUrl,
        "title": title,
        "updated_at": updatedAt?.toIso8601String(),
        "id": id,
        "headline": headline,
        "cloudUrl": cloudUrl,
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
