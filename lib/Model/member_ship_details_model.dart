class MemberShipDetailsModel {
  String? message;
  Membership? membership;
  bool? success;

  MemberShipDetailsModel({this.message, this.membership, this.success});

  factory MemberShipDetailsModel.fromJson(Map<String, dynamic> json) =>
      MemberShipDetailsModel(
        message: json["message"],
        membership: json["membership"] == null
            ? null
            : Membership.fromJson(json["membership"]),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "membership": membership?.toJson(),
    "success": success,
  };
}

class Membership {
  var membershipPricing;
  var isActive;
  String? offerofftext;
  var membershipId;
  String? membershipTitle;
  var minimumCommitment;
  String? membershipDescription;
  String? membershipImage;
  List<Benefit>? benefits;

  Membership({
    this.membershipPricing,
    this.offerofftext,
    this.membershipId,
    this.membershipTitle,
    this.minimumCommitment,
    this.membershipDescription,
    this.membershipImage,
    this.benefits,
    this.isActive,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
    membershipPricing: json["membership_pricing"],
    offerofftext: json["offeroffText"],
    isActive: json["is_active"],
    membershipId: json["membership_id"],
    membershipTitle: json["membership_title"],
    minimumCommitment: json["minimum_commitment"],
    membershipDescription: json["membership_description"],
    membershipImage: json["membership_image"],
    benefits: json["benefits"] == null
        ? []
        : List<Benefit>.from(
        json["benefits"]!.map((x) => Benefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "membership_pricing": membershipPricing,
    "offeroffText": offerofftext,
    "membership_id": membershipId,
    "is_active": isActive,
    "membership_title": membershipTitle,
    "minimum_commitment": minimumCommitment,
    "membership_description": membershipDescription,
    "membership_image": membershipImage,
    "benefits": benefits == null
        ? []
        : List<dynamic>.from(benefits!.map((x) => x.toJson())),
  };
}

class Benefit {
  String? availability;
  var amount;
  String? benefitTitle;

  Benefit({this.availability, this.amount, this.benefitTitle});

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
    availability: json["availability"],
    amount: json["amount"],
    benefitTitle: json["benefit_title"],
  );

  Map<String, dynamic> toJson() => {
    "availability": availability,
    "amount": amount,
    "benefit_title": benefitTitle,
  };
}
