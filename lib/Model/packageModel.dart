// To parse this JSON data, do
//
//     final shopModel = shopModelFromJson(jsonString);

import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  HeaderDetails? headerDetails;
  bool? success;
  List<Packages>? packages;

  ShopModel({
    this.headerDetails,
    this.success,
    this.packages,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
    headerDetails: json["headerDetails"] == null
        ? null
        : HeaderDetails.fromJson(json["headerDetails"]),
    success: json["success"],
    packages: json["packages"] == null
        ? []
        : List<Packages>.from(
        json["packages"]!.map((x) => Packages.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "headerDetails": headerDetails?.toJson(),
    "success": success,
    "packages": packages == null
        ? []
        : List<dynamic>.from(packages!.map((x) => x.toJson())),
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

class Packages {
  String? membershipOfferPrice;
  String? offeroffText;
  String? image;
  var price;
  DateTime? createdAt;
  String? description;
  List<String>? concerns;
  List<String>? bodyAreas;
  var id;
  String? type;
  String? name;

  Packages({
    this.membershipOfferPrice,
    this.offeroffText,
    this.image,
    this.price,
    this.createdAt,
    this.description,
    this.concerns,
    this.bodyAreas,
    this.id,
    this.type,
    this.name,
  });

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
    membershipOfferPrice: json["membership_offer_price"],
    offeroffText: json["offeroffText"],
    image: json["image"],
    price: json["price"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    description: json["description"],
    concerns: json["concerns"] == null
        ? []
        : List<String>.from(json["concerns"]!.map((x) => x)),
    bodyAreas: json["body_areas"] == null
        ? []
        : List<String>.from(json["body_areas"]!.map((x) => x)),
    id: json["id"],
    type: json["type"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "membership_offer_price": membershipOfferPrice,
    "offeroffText": offeroffText,
    "image": image,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "description": description,
    "concerns":
    concerns == null ? [] : List<dynamic>.from(concerns!.map((x) => x)),
    "body_areas": bodyAreas == null
        ? []
        : List<dynamic>.from(bodyAreas!.map((x) => x)),
    "id": id,
    "type": type,
    "name": name,
  };
}
