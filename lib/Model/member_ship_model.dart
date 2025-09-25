class MemberShipModel {
  HeaderDetails? headerDetails;
  bool? success;
  List<MembershipData>? memberships;

  MemberShipModel({
    this.headerDetails,
    this.success,
    this.memberships,
  });

  factory MemberShipModel.fromJson(Map<String, dynamic> json) =>
      MemberShipModel(
        headerDetails: json["headerDetails"] == null
            ? null
            : HeaderDetails.fromJson(json["headerDetails"]),
        success: json["success"],
        memberships: json["memberships"] == null
            ? []
            : List<MembershipData>.from(
            json["memberships"]!.map((x) => MembershipData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "headerDetails": headerDetails?.toJson(),
    "success": success,
    "memberships": memberships == null
        ? []
        : List<dynamic>.from(memberships!.map((x) => x.toJson())),
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

class MembershipData {
  var membershipPricing;
  String? offeroffText;
  var membershipId;
  String? membershipTitle;
  String? membershipDescription;
  String? membershipImage;
  List<Benefit>? benefits;

  MembershipData({
    this.membershipPricing,
    this.offeroffText,
    this.membershipId,
    this.membershipTitle,
    this.membershipDescription,
    this.membershipImage,
    this.benefits,
  });

  factory MembershipData.fromJson(Map<String, dynamic> json) => MembershipData(
    membershipPricing: json["membership_pricing"],
    offeroffText: json["offeroffText"],
    membershipId: json["membership_id"],
    membershipTitle: json["membership_title"],
    membershipDescription: json["membership_description"],
    membershipImage: json["membership_image"],
    benefits: json["benefits"] == null
        ? []
        : List<Benefit>.from(
        json["benefits"]!.map((x) => Benefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "membership_pricing": membershipPricing,
    "offeroffText": offeroffText,
    "membership_id": membershipId,
    "membership_title": membershipTitle,
    "membership_description": membershipDescription,
    "membership_image": membershipImage,
    "benefits": benefits == null
        ? []
        : List<dynamic>.from(benefits!.map((x) => x.toJson())),
  };
}

class Benefit {
  String? benefitTitle;

  Benefit({
    this.benefitTitle,
  });

  factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
    benefitTitle: json["benefit_title"],
  );

  Map<String, dynamic> toJson() => {
    "benefit_title": benefitTitle,
  };
}
