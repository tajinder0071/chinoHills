class PromoRewardModel {
  String? message;
  List<Reward>? rewards;
  bool? success;
  List<Offer>? offers;

  PromoRewardModel({
    this.message,
    this.rewards,
    this.success,
    this.offers,
  });

  factory PromoRewardModel.fromJson(Map<String, dynamic> json) =>
      PromoRewardModel(
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
  dynamic finalCartTotal;
  String? createdAt;
  dynamic userId;
  dynamic offerId;
  dynamic discountValue;
  dynamic cartId;
  String? offerType;
  String? discountType;
  var dayLeft;
  String? offerCode;
  var offerDiscountAmount;
  String? title;
  dynamic promo_code_id;
  String? removedAt;

  Offer({
    this.finalCartTotal,
    this.createdAt,
    this.userId,
    this.offerId,
    this.discountValue,
    this.cartId,
    this.offerType,
    this.dayLeft,
    this.discountType,
    this.offerDiscountAmount,
    this.offerCode,
    this.title,
    this.promo_code_id,
    this.removedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        finalCartTotal: json["final_cart_total"],
        createdAt: json["created_at"],
        userId: json["user_id"],
        offerId: json["promo_code_id"],
    offerDiscountAmount: json["offerDiscountAmount"],
        discountValue: json["discount_value"],
        cartId: json["cart_id"],
        offerType: json["offer_type"],
        discountType: json["discount_type"],
        offerCode: json["promo_code"],
        title: json["title"],
        dayLeft: json["days_left"],
        promo_code_id: json["promo_code_id"],
        removedAt: json["removed_at"],
      );

  Map<String, dynamic> toJson() => {
        "final_cart_total": finalCartTotal,
        "created_at": createdAt,
        "user_id": userId,
        "offer_id": offerId,
        "discount_value": discountValue,
        "cart_id": cartId,
        "offerDiscountAmount": offerDiscountAmount,
        "offer_type": offerType,
        "discount_type": discountType,
        "promo_code": offerCode,
        "title": title,
        "promo_code_id": promo_code_id,
        "removed_at": removedAt,
      };
}

class Reward {
  dynamic rewardId;
  String? createdAt;
  String? discountAmount;
  String? rewardDisclaimer;
  var rewardTotalDiscount;
  String? discountType;
  String? rewardTitle;

  Reward({
    this.rewardId,
    this.createdAt,
    this.discountAmount,
    this.rewardDisclaimer,
    this.discountType,
    this.rewardTotalDiscount,
    this.rewardTitle,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        rewardId: json["reward_id"],
        createdAt: json["created_at"],
        discountAmount: json["discount_amount"],
        rewardTotalDiscount: json["rewardTotalDiscount"],
        rewardDisclaimer: json["reward_disclaimer"],
        discountType: json["discount_type"],
        rewardTitle: json["reward_title"],
      );

  Map<String, dynamic> toJson() => {
        "reward_id": rewardId,
        "created_at": createdAt,
        "discount_amount": discountAmount,
        "reward_disclaimer": rewardDisclaimer,
        "rewardTotalDiscount": rewardTotalDiscount,
        "discount_type": discountType,
        "reward_title": rewardTitle,
      };
}
