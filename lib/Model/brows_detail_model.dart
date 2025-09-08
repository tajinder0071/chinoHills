class BrowseDetailModel {
  HeaderDetails? headerDetails;
  bool? success;
  List<BrowseDatum>? data;

  BrowseDetailModel({
    this.headerDetails,
    this.success,
    this.data,
  });

  factory BrowseDetailModel.fromJson(Map<String, dynamic> json) => BrowseDetailModel(
    headerDetails: json["headerDetails"] == null ? null : HeaderDetails.fromJson(json["headerDetails"]),
    success: json["success"],
    data: json["data"] == null ? [] : List<BrowseDatum>.from(json["data"]!.map((x) => BrowseDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "headerDetails": headerDetails?.toJson(),
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BrowseDatum {
  String? membershipOfferPrice;
  String? offeroffText;
  var price;
  String? createdAt;
  String? name;
  String? image;
  String? description;
  List<String>? concerns;
  var treatmentVariationId;
  List<dynamic>? bodyAreas;
  var id;
  String? type;

  BrowseDatum({
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
  });

  factory BrowseDatum.fromJson(Map<String, dynamic> json) => BrowseDatum(
    membershipOfferPrice: json["membership_offer_price"],
    offeroffText: json["offeroffText"],
    price: json["price"],
    createdAt: json["created_at"],
    name: json["name"],
    image: json["image"],
    description: json["description"],
    concerns: json["concerns"] == null ? [] : List<String>.from(json["concerns"]!.map((x) => x)),
    treatmentVariationId: json["treatment_variation_id"],
    bodyAreas: json["body_areas"] == null ? [] : List<dynamic>.from(json["body_areas"]!.map((x) => x)),
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "membership_offer_price": membershipOfferPrice,
    "offeroffText": offeroffText,
    "price": price,
    "created_at": createdAt,
    "name": name,
    "image": image,
    "description": description,
    "concerns": concerns == null ? [] : List<dynamic>.from(concerns!.map((x) => x)),
    "treatment_variation_id": treatmentVariationId,
    "body_areas": bodyAreas == null ? [] : List<dynamic>.from(bodyAreas!.map((x) => x)),
    "id": id,
    "type": type,
  };
}

class HeaderDetails {
  String? headerTitle;
  String? headerDescription;
  String? headerImage;

  HeaderDetails({
    this.headerTitle,
    this.headerDescription,
    this.headerImage,
  });

  factory HeaderDetails.fromJson(Map<String, dynamic> json) => HeaderDetails(
    headerTitle: json["headerTitle"],
    headerDescription: json["headerDescription"],
    headerImage: json["headerImage"],
  );

  Map<String, dynamic> toJson() => {
    "headerTitle": headerTitle,
    "headerDescription": headerDescription,
    "headerImage": headerImage,
  };
}
