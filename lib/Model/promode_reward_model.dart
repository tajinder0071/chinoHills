// To parse this JSON data, do
//
//     final promoRewardModel = promoRewardModelFromJson(jsonString);

import 'dart:convert';

PromoRewardModel promoRewardModelFromJson(String str) =>
    PromoRewardModel.fromJson(json.decode(str));

String promoRewardModelToJson(PromoRewardModel data) =>
    json.encode(data.toJson());

class PromoRewardModel {
  Membership? membership;
  String? message;
  List<Reward>? rewards;
  bool? success;
  List<Offer>? offers;

  PromoRewardModel({
    this.membership,
    this.message,
    this.rewards,
    this.success,
    this.offers,
  });

  factory PromoRewardModel.fromJson(Map<String, dynamic> json) =>
      PromoRewardModel(
        membership: json["membership"] == null
            ? null
            : Membership.fromJson(json["membership"]),
        message: json["message"],
        rewards: json["rewards"] == null
            ? []
            : List<Reward>.from(
                json["rewards"]!.map((x) => Reward.fromJson(x))),
        success: json["success"],
        offers: json["offers"] == null
            ? []
            : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "membership": membership?.toJson(),
        "message": message,
        "rewards": rewards == null
            ? []
            : List<dynamic>.from(rewards!.map((x) => x.toJson())),
        "success": success,
        "offers": offers == null
            ? []
            : List<dynamic>.from(offers!.map((x) => x.toJson())),
      };
}

class Offer {
  String? offerUsage;
  String? promoCode;
  var discountValue;
  String? title;
  String? daysLeft;
  var id;
  bool? isApplied;
  String? offerType;
  String? discountType;

  Offer({
    this.offerUsage,
    this.promoCode,
    this.discountValue,
    this.title,
    this.daysLeft,
    this.id,
    this.isApplied,
    this.offerType,
    this.discountType,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        offerUsage: json["offer_usage"],
        promoCode: json["promo_code"],
        discountValue: json["discount_value"],
        title: json["title"],
        daysLeft: json["days_left"],
        id: json["id"],
        isApplied: json["is_applied"],
        offerType: json["offer_type"],
        discountType: json["discount_type"],
      );

  Map<String, dynamic> toJson() => {
        "offer_usage": offerUsage,
        "promo_code": promoCode,
        "discount_value": discountValue,
        "title": title,
        "days_left": daysLeft,
        "id": id,
        "is_applied": isApplied,
        "offer_type": offerType,
        "discount_type": discountType,
      };
}

class Reward {
  var rewardId;
  var discountAmount;
  String? rewardDisclaimer;
  bool? isApplied;
  String? discountType;
  String? rewardTitle;

  Reward({
    this.rewardId,
    this.discountAmount,
    this.rewardDisclaimer,
    this.isApplied,
    this.discountType,
    this.rewardTitle,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        rewardId: json["reward_id"],
        discountAmount: json["discount_amount"],
        rewardDisclaimer: json["reward_disclaimer"],
        isApplied: json["is_applied"],
        discountType: json["discount_type"],
        rewardTitle: json["reward_title"],
      );

  Map<String, dynamic> toJson() => {
        "reward_id": rewardId,
        "discount_amount": discountAmount,
        "reward_disclaimer": rewardDisclaimer,
        "is_applied": isApplied,
        "discount_type": discountType,
        "reward_title": rewardTitle,
      };
}

class Membership {
  String? membershipTitle;
  var membershipId;
  var membershipDiscount;
  bool? isApplied;

  Membership({
    this.membershipTitle,
    this.membershipId,
    this.membershipDiscount,
    this.isApplied,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        membershipTitle: json["membership_title"],
        membershipId: json["membership_id"],
        membershipDiscount: json["membership_discount"]?.toDouble(),
        isApplied: json["is_applied"],
      );

  Map<String, dynamic> toJson() => {
        "membership_title": membershipTitle,
        "membership_id": membershipId,
        "membership_discount": membershipDiscount,
        "is_applied": isApplied,
      };
}
