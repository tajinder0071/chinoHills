class TreatmentListModel {
  HeaderDetails? headerDetails;
  bool? success;
  List<Treatment>? treatments;

  TreatmentListModel({
    this.headerDetails,
    this.success,
    this.treatments,
  });

  factory TreatmentListModel.fromJson(Map<String, dynamic> json) =>
      TreatmentListModel(
        headerDetails: json["headerDetails"] == null
            ? null
            : HeaderDetails.fromJson(json["headerDetails"]),
        success: json["success"],
        treatments: json["treatments"] == null
            ? []
            : List<Treatment>.from(
            json["treatments"]!.map((x) => Treatment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "headerDetails": headerDetails?.toJson(),
    "success": success,
    "treatments": treatments == null
        ? []
        : List<dynamic>.from(treatments!.map((x) => x.toJson())),
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
    headerTitle: json["headerTitle"],
    headerDescription: json["headerDescription"],
    headerimage: json["headerimage"],
  );

  Map<String, dynamic> toJson() => {
    "headerTitle": headerTitle,
    "headerDescription": headerDescription,
    "headerimage": headerimage,
  };
}

class Treatment {
  String? membershipOfferPrice;
  String? offeroffText;
  var price;
  DateTime? createdAt;
  String? name;
  String? image;
  String? description;
  var treatmentVariationId;
  List<String>? concerns;
  List<dynamic>? bodyAreas;
  var id;
  String? type;

  Treatment({
    this.membershipOfferPrice,
    this.offeroffText,
    this.price,
    this.createdAt,
    this.name,
    this.image,
    this.description,
    this.treatmentVariationId,
    this.concerns,
    this.bodyAreas,
    this.id,
    this.type,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
    membershipOfferPrice: json["membership_offer_price"],
    offeroffText: json["offeroffText"],
    price: json["price"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    name: json["name"],
    image: json["image"],
    description: json["description"],
    treatmentVariationId: json["treatment_variation_id"],
    concerns: json["concerns"] == null
        ? []
        : List<String>.from(json["concerns"]!.map((x) => x)),
    bodyAreas: json["body_areas"] == null
        ? []
        : List<dynamic>.from(json["body_areas"]!.map((x) => x)),
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "membership_offer_price": membershipOfferPrice,
    "offeroffText": offeroffText,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "name": name,
    "image": image,
    "description": description,
    "treatment_variation_id": treatmentVariationId,
    "concerns":
    concerns == null ? [] : List<dynamic>.from(concerns!.map((x) => x)),
    "body_areas": bodyAreas == null
        ? []
        : List<dynamic>.from(bodyAreas!.map((x) => x)),
    "id": id,
    "type": type,
  };
}
