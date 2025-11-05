class WalletMembershipActiveModel {
  String? message;
  Membership? membership;
  bool? success;
  List<MembershipPerk>? membershipPerks;
  List<ActiveMembership>? activeMemberships;
  List<MembershipList>? memberships;
  var nimaCashBalance;

  WalletMembershipActiveModel(
      {this.message,
      this.membership,
      this.success,
      this.membershipPerks,
      this.activeMemberships,
      this.memberships,
      this.nimaCashBalance});

  factory WalletMembershipActiveModel.fromJson(Map<String, dynamic> json) =>
      WalletMembershipActiveModel(
        message: json["message"],
        membership: json["membership"] == null
            ? null
            : Membership.fromJson(json["membership"]),
        success: json["success"],
        membershipPerks: json["membership_perks"] == null
            ? []
            : List<MembershipPerk>.from(json["membership_perks"]
                .map((x) => MembershipPerk.fromJson(x))),
        activeMemberships: json["active_memberships"] == null
            ? []
            : List<ActiveMembership>.from(json["active_memberships"]!
                .map((x) => ActiveMembership.fromJson(x))),
        memberships: json["memberships"] == null
            ? []
            : List<MembershipList>.from(
                json["memberships"].map((x) => MembershipList.fromJson(x))),
        nimaCashBalance: json["nima_cash_balance"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "membership": membership?.toJson(),
        "success": success,
        "membership_perks": membershipPerks == null
            ? []
            : List<dynamic>.from(membershipPerks!.map((x) => x)),
        "active_memberships": activeMemberships == null
            ? []
            : List<dynamic>.from(activeMemberships!.map((x) => x.toJson())),
        "memberships": memberships == null
            ? []
            : List<dynamic>.from(memberships!.map((x) => x)),
        "nima_cash_balance": nimaCashBalance,
      };
}

class ActiveMembership {
  String? offeroffText;
  var membershipId;
  List<IncludedTreatment>? includedTreatments;
  bool? isActive;
  String? offerName;
  String? membershipImage;
  SignupBonusClass? signupBonus;
  var membershipPricing;
  var beautyBank;
  String? membershipTitle;
  var minimumCommitment;
  String? membershipDescription;
  List<MembershipMilestoneBonus>? membershipMilestoneBonuses;
  List<ActiveMembershipBenefit>? benefits;

  ActiveMembership({
    this.offeroffText,
    this.membershipId,
    this.includedTreatments,
    this.isActive,
    this.offerName,
    this.membershipImage,
    this.signupBonus,
    this.membershipPricing,
    this.beautyBank,
    this.membershipTitle,
    this.minimumCommitment,
    this.membershipDescription,
    this.membershipMilestoneBonuses,
    this.benefits,
  });

  factory ActiveMembership.fromJson(Map<String, dynamic> json) =>
      ActiveMembership(
        offeroffText: json["offeroffText"],
        membershipId: json["membership_id"],
        includedTreatments: json["includedTreatments"] == null
            ? []
            : List<IncludedTreatment>.from(json["includedTreatments"]!
                .map((x) => IncludedTreatment.fromJson(x))),
        isActive: json["is_active"],
        offerName: json["offerName"],
        membershipImage: json["membership_image"],
        signupBonus: json["signupBonus"] == null
            ? null
            : (json["signupBonus"] is List
                ? (json["signupBonus"].isNotEmpty
                    ? SignupBonusClass.fromJson(json["signupBonus"][0])
                    : null)
                : SignupBonusClass.fromJson(json["signupBonus"])),
        membershipPricing: json["membership_pricing"],
        beautyBank: json["beauty_bank"],
        membershipTitle: json["membership_title"],
        minimumCommitment: json["minimum_commitment"],
        membershipDescription: json["membership_description"],
        membershipMilestoneBonuses: json["membershipMilestoneBonuses"] == null
            ? []
            : List<MembershipMilestoneBonus>.from(
                json["membershipMilestoneBonuses"]!
                    .map((x) => MembershipMilestoneBonus.fromJson(x))),
        benefits: json["benefits"] == null
            ? []
            : List<ActiveMembershipBenefit>.from(json["benefits"]!
                .map((x) => ActiveMembershipBenefit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offeroffText": offeroffText,
        "membership_id": membershipId,
        "includedTreatments": includedTreatments == null
            ? []
            : List<dynamic>.from(includedTreatments!.map((x) => x.toJson())),
        "is_active": isActive,
        "offerName": offerName,
        "membership_image": membershipImage,
        "signupBonus": signupBonus?.toJson(),
        "membership_pricing": membershipPricing,
        "beauty_bank": beautyBank,
        "membership_title": membershipTitle,
        "minimum_commitment": minimumCommitment,
        "membership_description": membershipDescription,
        "membershipMilestoneBonuses": membershipMilestoneBonuses == null
            ? []
            : List<dynamic>.from(
                membershipMilestoneBonuses!.map((x) => x.toJson())),
        "benefits": benefits == null
            ? []
            : List<dynamic>.from(benefits!.map((x) => x.toJson())),
      };
}

class ActiveMembershipBenefit {
  String? availability;
  dynamic amount;
  String? benefitTitle;

  ActiveMembershipBenefit({
    this.availability,
    this.amount,
    this.benefitTitle,
  });

  factory ActiveMembershipBenefit.fromJson(Map<String, dynamic> json) =>
      ActiveMembershipBenefit(
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

class IncludedTreatment {
  String? headertitle;
  String? treatmentGroupName;
  List<SignupBonusTreatment>? treatmentItems;
  var id;
  String? choosedOption;

  IncludedTreatment({
    this.headertitle,
    this.treatmentGroupName,
    this.treatmentItems,
    this.id,
    this.choosedOption,
  });

  factory IncludedTreatment.fromJson(Map<String, dynamic> json) =>
      IncludedTreatment(
        headertitle: json["headertitle"],
        treatmentGroupName: json["treatment_group_name"],
        treatmentItems: json["treatmentItems"] == null
            ? []
            : List<SignupBonusTreatment>.from(json["treatmentItems"]!
                .map((x) => SignupBonusTreatment.fromJson(x))),
        id: json["id"],
        choosedOption: json["choosed_option"],
      );

  Map<String, dynamic> toJson() => {
        "headertitle": headertitle,
        "treatment_group_name": treatmentGroupName,
        "treatmentItems": treatmentItems == null
            ? []
            : List<dynamic>.from(treatmentItems!.map((x) => x.toJson())),
        "id": id,
        "choosed_option": choosedOption,
      };
}

class SignupBonusTreatment {
  var quantity;
  var treatmentId;
  var id;
  String? treatmentName;

  SignupBonusTreatment({
    this.quantity,
    this.treatmentId,
    this.id,
    this.treatmentName,
  });

  factory SignupBonusTreatment.fromJson(Map<String, dynamic> json) =>
      SignupBonusTreatment(
        quantity: json["quantity"],
        treatmentId: json["treatment_id"],
        id: json["id"],
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "treatment_id": treatmentId,
        "id": id,
        "treatment_name": treatmentName,
      };
}

class MembershipMilestoneBonus {
  String? headertitle;
  String? milestonedescription;
  String? monthText;
  List<SignupBonusTreatment>? milestoneTreatmentItems;
  var id;
  String? choosedOption;

  MembershipMilestoneBonus({
    this.headertitle,
    this.milestonedescription,
    this.monthText,
    this.milestoneTreatmentItems,
    this.id,
    this.choosedOption,
  });

  factory MembershipMilestoneBonus.fromJson(Map<String, dynamic> json) =>
      MembershipMilestoneBonus(
        headertitle: json["headertitle"],
        milestonedescription: json["Milestonedescription"],
        monthText: json["monthText"],
        milestoneTreatmentItems: json["milestoneTreatmentItems"] == null
            ? []
            : List<SignupBonusTreatment>.from(json["milestoneTreatmentItems"]!
                .map((x) => SignupBonusTreatment.fromJson(x))),
        id: json["id"],
        choosedOption: json["choosed_option"],
      );

  Map<String, dynamic> toJson() => {
        "headertitle": headertitle,
        "Milestonedescription": milestonedescription,
        "monthText": monthText,
        "milestoneTreatmentItems": milestoneTreatmentItems == null
            ? []
            : List<dynamic>.from(
                milestoneTreatmentItems!.map((x) => x.toJson())),
        "id": id,
        "choosed_option": choosedOption,
      };
}

class SignupBonusClass {
  String? bonusDescription;
  var id;
  var treatmentChoiceCount;
  String? choosedOption;
  List<SignupBonusTreatment>? signupBonusTreatments;

  SignupBonusClass({
    this.bonusDescription,
    this.id,
    this.treatmentChoiceCount,
    this.choosedOption,
    this.signupBonusTreatments,
  });

  factory SignupBonusClass.fromJson(Map<String, dynamic> json) =>
      SignupBonusClass(
        bonusDescription: json["bonus_description"],
        id: json["id"],
        treatmentChoiceCount: json["treatment_choice_count"],
        choosedOption: json["choosed_option"],
        signupBonusTreatments: json["signupBonusTreatments"] == null
            ? []
            : List<SignupBonusTreatment>.from(json["signupBonusTreatments"]!
                .map((x) => SignupBonusTreatment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "bonus_description": bonusDescription,
        "id": id,
        "treatment_choice_count": treatmentChoiceCount,
        "choosed_option": choosedOption,
        "signupBonusTreatments": signupBonusTreatments == null
            ? []
            : List<dynamic>.from(signupBonusTreatments!.map((x) => x.toJson())),
      };
}

class Membership {
  String? offeroffText;
  var membershipId;
  List<IncludedTreatment>? includedTreatments;
  bool? isActive;
  String? offerName;
  String? membershipImage;
  SignupBonusClass? signupBonus;
  var membershipPricing;
  var beautyBank;
  String? membershipTitle;
  var minimumCommitment;
  String? membershipDescription;
  List<MembershipMilestoneBonus>? membershipMilestoneBonuses;
  List<MembershipBenefit>? benefits;

  Membership({
    this.offeroffText,
    this.membershipId,
    this.includedTreatments,
    this.isActive,
    this.offerName,
    this.membershipImage,
    this.signupBonus,
    this.membershipPricing,
    this.beautyBank,
    this.membershipTitle,
    this.minimumCommitment,
    this.membershipDescription,
    this.membershipMilestoneBonuses,
    this.benefits,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        offeroffText: json["offeroffText"],
        membershipId: json["membership_id"],
        includedTreatments: json["includedTreatments"] == null
            ? []
            : List<IncludedTreatment>.from(json["includedTreatments"]!
                .map((x) => IncludedTreatment.fromJson(x))),
        isActive: json["is_active"],
        offerName: json["offerName"],
        membershipImage: json["membership_image"],
        signupBonus: json["signupBonus"] == null
            ? null
            : (json["signupBonus"] is List
                ? (json["signupBonus"].isNotEmpty
                    ? SignupBonusClass.fromJson(json["signupBonus"][0])
                    : null)
                : SignupBonusClass.fromJson(json["signupBonus"])),
        membershipPricing: json["membership_pricing"],
        beautyBank: json["beauty_bank"],
        membershipTitle: json["membership_title"],
        minimumCommitment: json["minimum_commitment"],
        membershipDescription: json["membership_description"],
        membershipMilestoneBonuses: json["membershipMilestoneBonuses"] == null
            ? []
            : List<MembershipMilestoneBonus>.from(
                json["membershipMilestoneBonuses"]!
                    .map((x) => MembershipMilestoneBonus.fromJson(x))),
        benefits: json["benefits"] == null
            ? []
            : List<MembershipBenefit>.from(
                json["benefits"]!.map((x) => MembershipBenefit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offeroffText": offeroffText,
        "membership_id": membershipId,
        "includedTreatments": includedTreatments == null
            ? []
            : List<dynamic>.from(includedTreatments!.map((x) => x.toJson())),
        "is_active": isActive,
        "offerName": offerName,
        "membership_image": membershipImage,
        "signupBonus": signupBonus?.toJson(),
        "membership_pricing": membershipPricing,
        "beauty_bank": beautyBank,
        "membership_title": membershipTitle,
        "minimum_commitment": minimumCommitment,
        "membership_description": membershipDescription,
        "membershipMilestoneBonuses": membershipMilestoneBonuses == null
            ? []
            : List<dynamic>.from(
                membershipMilestoneBonuses!.map((x) => x.toJson())),
        "benefits": benefits == null
            ? []
            : List<dynamic>.from(benefits!.map((x) => x.toJson())),
      };
}

class MembershipBenefit {
  String? availability;
  var amount;
  String? benefitTitle;

  MembershipBenefit({
    this.availability,
    this.amount,
    this.benefitTitle,
  });

  factory MembershipBenefit.fromJson(Map<String, dynamic> json) =>
      MembershipBenefit(
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

class MembershipPerk {
  String membershipIcon;
  String membershipPerk;

  MembershipPerk({
    required this.membershipIcon,
    required this.membershipPerk,
  });

  factory MembershipPerk.fromJson(Map<String, dynamic> json) => MembershipPerk(
        membershipIcon: json["membership_icon"],
        membershipPerk: json["membership_perk"],
      );

  Map<String, dynamic> toJson() => {
        "membership_icon": membershipIcon,
        "membership_perk": membershipPerk,
      };
}

class MembershipList {
  var membershipPricing;
  String offeroffText;
  var membershipId;
  String membershipTitle;
  String membershipDescription;
  String membershipImage;

  MembershipList({
    required this.membershipPricing,
    required this.offeroffText,
    required this.membershipId,
    required this.membershipTitle,
    required this.membershipDescription,
    required this.membershipImage,
  });

  factory MembershipList.fromJson(Map<String, dynamic> json) => MembershipList(
        membershipPricing: json["membership_pricing"],
        offeroffText: json["offeroffText"],
        membershipId: json["membership_id"],
        membershipTitle: json["membership_title"],
        membershipDescription: json["membership_description"],
        membershipImage: json["membership_image"],
      );

  Map<String, dynamic> toJson() => {
        "membership_pricing": membershipPricing,
        "offeroffText": offeroffText,
        "membership_id": membershipId,
        "membership_title": membershipTitle,
        "membership_description": membershipDescription,
        "membership_image": membershipImage,
      };
}
