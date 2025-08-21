class MemberShipDetailsModel {
  String? message;
  bool? success;
  Data? data;

  MemberShipDetailsModel({
    this.message,
    this.success,
    this.data,
  });

  factory MemberShipDetailsModel.fromJson(Map<String, dynamic> json) =>
      MemberShipDetailsModel(
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
  int? membershipPricing;
  String? createdAt;
  int? clientId;
  int? membershipId;
  String? membershipTitle;
  String? updatedAt;
  List<String>? benefitDescriptions;
  String? membershipDescription;
  String? membershipImage;

  Data({
    this.membershipPricing,
    this.createdAt,
    this.clientId,
    this.membershipId,
    this.membershipTitle,
    this.updatedAt,
    this.benefitDescriptions,
    this.membershipDescription,
    this.membershipImage,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        membershipPricing: json["membership_pricing"],
        createdAt: json["created_at"],
        clientId: json["client_id"],
        membershipId: json["membership_id"],
        membershipTitle: json["membership_title"],
        updatedAt: json["updated_at"],
        benefitDescriptions: json["benefit_descriptions"] == null
            ? []
            : List<String>.from(json["benefit_descriptions"]!.map((x) => x)),
        membershipDescription: json["membership_description"],
        membershipImage: json["membership_image"],
      );

  Map<String, dynamic> toJson() => {
        "membership_pricing": membershipPricing,
        "created_at": createdAt,
        "client_id": clientId,
        "membership_id": membershipId,
        "membership_title": membershipTitle,
        "updated_at": updatedAt,
        "benefit_descriptions": benefitDescriptions == null
            ? []
            : List<dynamic>.from(benefitDescriptions!.map((x) => x)),
        "membership_description": membershipDescription,
        "membership_image": membershipImage,
      };
}
