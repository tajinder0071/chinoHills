class MemberShipDetailsModel {
  String? message;
  Membership? membership;
  bool? success;

  MemberShipDetailsModel({
    this.message,
    this.membership,
    this.success,
  });

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
  String? offeroffText;
  var membershipId;
  List<IncludedTreatment>? includedTreatments;
  var isActive;
  String? membershipImage;
  SignupBonus? signupBonus;
  var membershipPricing;
  String? membershipTitle;
  var minimumCommitment;
  String? membershipDescription;
  List<MembershipMilestoneBonuses>? membershipMilestoneBonuses;
  List<Benefit>? benefits;

  Membership({
    this.offeroffText,
    this.membershipId,
    this.includedTreatments,
    this.isActive,
    this.membershipImage,
    this.signupBonus,
    this.membershipPricing,
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
    membershipImage: json["membership_image"],
    signupBonus: json["signupBonus"] == null
        ? null
        : (json["signupBonus"] is List)
        ? null
        : SignupBonus.fromJson(json["signupBonus"]),
    membershipPricing: json["membership_pricing"],
    membershipTitle: json["membership_title"],
    minimumCommitment: json["minimum_commitment"],
    membershipDescription: json["membership_description"],
    membershipMilestoneBonuses: json["membershipMilestoneBonuses"] == null
        ? []
        : List<MembershipMilestoneBonuses>.from(
        json["membershipMilestoneBonuses"]
            .map((x) => MembershipMilestoneBonuses.fromJson(x))),
    benefits: json["benefits"] == null
        ? []
        : List<Benefit>.from(
        json["benefits"]!.map((x) => Benefit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "offeroffText": offeroffText,
    "membership_id": membershipId,
    "includedTreatments": includedTreatments == null
        ? []
        : List<dynamic>.from(includedTreatments!.map((x) => x.toJson())),
    "is_active": isActive,
    "membership_image": membershipImage,
    "signupBonus": signupBonus?.toJson(),
    "membership_pricing": membershipPricing,
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

class Benefit {
  String? availability;
  var amount;
  String? benefitTitle;

  Benefit({
    this.availability,
    this.amount,
    this.benefitTitle,
  });

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

class IncludedTreatment {
  String? headertitle;
  String? treatmentGroupName;
  List<TreatmentItem>? treatmentItems;
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
            : List<TreatmentItem>.from(
            json["treatmentItems"]!.map((x) => TreatmentItem.fromJson(x))),
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

class TreatmentItem {
  var quantity;
  var treatmentId;
  var id;
  String? treatmentName;

  TreatmentItem({
    this.quantity,
    this.treatmentId,
    this.id,
    this.treatmentName,
  });

  factory TreatmentItem.fromJson(Map<String, dynamic> json) => TreatmentItem(
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

class SignupBonus {
  String? bonusDescription;
  var id;
  var treatmentChoiceCount;
  String? choosedOption;
  List<SignupBonusTreatment>? signupBonusTreatments;

  SignupBonus({
    this.bonusDescription,
    this.id,
    this.treatmentChoiceCount,
    this.choosedOption,
    this.signupBonusTreatments,
  });

  factory SignupBonus.fromJson(Map<String, dynamic> json) => SignupBonus(
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

class MembershipMilestoneBonuses {
  String? headertitle;
  String? milestonedescription;
  String? monthText;
  List<MilestoneTreatmentItems>? milestoneTreatmentItems;
  int? id;
  String? choosedOption;

  MembershipMilestoneBonuses(
      {this.headertitle,
        this.milestonedescription,
        this.monthText,
        this.milestoneTreatmentItems,
        this.id,
        this.choosedOption});

  MembershipMilestoneBonuses.fromJson(Map<String, dynamic> json) {
    headertitle = json['headertitle'];
    milestonedescription = json['Milestonedescription'];
    monthText = json['monthText'];
    if (json['milestoneTreatmentItems'] != null) {
      milestoneTreatmentItems = <MilestoneTreatmentItems>[];
      json['milestoneTreatmentItems'].forEach((v) {
        milestoneTreatmentItems!.add(new MilestoneTreatmentItems.fromJson(v));
      });
    }
    id = json['id'];
    choosedOption = json['choosed_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headertitle'] = this.headertitle;
    data['Milestonedescription'] = this.milestonedescription;
    data['monthText'] = this.monthText;
    if (this.milestoneTreatmentItems != null) {
      data['milestoneTreatmentItems'] =
          this.milestoneTreatmentItems!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['choosed_option'] = this.choosedOption;
    return data;
  }
}

class MilestoneTreatmentItems {
  var quantity;
  var treatmentId;
  var id;
  String? treatmentName;

  MilestoneTreatmentItems(
      {this.quantity, this.treatmentId, this.id, this.treatmentName});

  MilestoneTreatmentItems.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    treatmentId = json['treatment_id'];
    id = json['id'];
    treatmentName = json['treatment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['treatment_id'] = treatmentId;
    data['id'] = id;
    data['treatment_name'] = treatmentName;
    return data;
  }
}
