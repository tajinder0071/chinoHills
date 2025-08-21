class VisitModel {
  String? message;
  bool? success;
  List<Datum>? data;

  VisitModel({
    this.message,
    this.success,
    this.data,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) => VisitModel(
        message: json["message"],
        success: json["success"],
        data: json["rewards"] == null
            ? []
            : List<Datum>.from(json["rewards"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "rewards": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? createdAt;
  String? deletedAt;
  String? btnDiscountIncl;
  String? repeatCashSwitch;
  String? rewardTitle;
  String? btnRewardsFilter;
  String? btnDiscountType;
  String? btnFreeService;
  String? discountAmount;
  String? nimaCheck;
  String? discountPercent;
  String? updatedAt;
  int? id;
  String? rewardDisclaimer;
  String? repeatcashvalue;
  var unlocksAt;
  var visitLeft;
  String? includedServices;

  Datum({
    this.createdAt,
    this.visitLeft,
    this.deletedAt,
    this.btnDiscountIncl,
    this.repeatCashSwitch,
    this.rewardTitle,
    this.btnRewardsFilter,
    this.btnDiscountType,
    this.btnFreeService,
    this.discountAmount,
    this.nimaCheck,
    this.discountPercent,
    this.updatedAt,
    this.id,
    this.rewardDisclaimer,
    this.repeatcashvalue,
    this.unlocksAt,
    this.includedServices,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        createdAt: json["created_at"],
        visitLeft: json["visitLeft"],
        deletedAt: json["deleted_at"],
        btnDiscountIncl: json["btn_discount_incl"],
        repeatCashSwitch: json["repeatCashSwitch"],
        rewardTitle: json["reward_title"],
        btnRewardsFilter: json["btn_rewards_filter"],
        btnDiscountType: json["btn_discount_type"],
        btnFreeService: json["btn_free_service"],
        discountAmount: json["discount_amount"],
        nimaCheck: json["nima_check"],
        discountPercent: json["discount_percent"],
        updatedAt: json["updated_at"],
        id: json["id"],
        rewardDisclaimer: json["reward_disclaimer"],
        repeatcashvalue: json["repeat_cash_value"],
        unlocksAt: json["reward_unlocks_at"],
        includedServices: json["included_services"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "visitLeft": visitLeft,
        "btn_discount_incl": btnDiscountIncl,
        "repeatCashSwitch": repeatCashSwitch,
        "reward_title": rewardTitle,
        "btn_rewards_filter": btnRewardsFilter,
        "btn_discount_type": btnDiscountType,
        "btn_free_service": btnFreeService,
        "discount_amount": discountAmount,
        "nima_check": nimaCheck,
        "discount_percent": discountPercent,
        "updated_at": updatedAt,
        "id": id,
        "reward_disclaimer": rewardDisclaimer,
        "repeat_cash_value": repeatcashvalue,
        "reward_unlocks_at": unlocksAt,
        "included_services": includedServices,
      };
}
