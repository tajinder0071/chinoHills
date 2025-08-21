class SignupRewardModel {
  String? message;
  bool? success;
  List<RewardDatum>? data;

  var clientId;

  SignupRewardModel({
    this.message,
    this.success,
    this.data,
    this.clientId,
  });

  factory SignupRewardModel.fromJson(Map<String, dynamic> json) =>
      SignupRewardModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<RewardDatum>.from(
                json["data"]!.map((x) => RewardDatum.fromJson(x))),
        clientId: json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "client_id": clientId,
      };
}

class RewardDatum {
  String? location;
  String? createdAt;
  String? deletedAt;
  String? discountType;
  String? rewardValidAt;
  String? rewardType;
  String? rewardTitle;
  var rewardUnlocksAt;

  String? repeatCashValue;
  String? discountAmount;
  String? includedServiceType;
  String? updatedAt;
  var id;
  String? rewardDisclaimer;
  String? selectedServiceType;

  RewardDatum({
    this.location,
    this.createdAt,
    this.deletedAt,
    this.discountType,
    this.rewardValidAt,
    this.rewardType,
    this.rewardTitle,
    this.rewardUnlocksAt,
    this.repeatCashValue,
    this.discountAmount,
    this.includedServiceType,
    this.updatedAt,
    this.id,
    this.rewardDisclaimer,
    this.selectedServiceType,
  });

  factory RewardDatum.fromJson(Map<String, dynamic> json) => RewardDatum(
        location: json["location"],
        createdAt: json["created_at"],
        deletedAt: json["deleted_at"],
        discountType: json["discount_type"],
        rewardValidAt: json["reward_valid_at"],
        rewardType: json["reward_type"],
        rewardTitle: json["reward_title"],
        rewardUnlocksAt: json["reward_unlocks_at"],
        repeatCashValue: json["repeat_cash_value"],
        discountAmount: json["discount_amount"],
        includedServiceType: json["included_service_type"],
        updatedAt: json["updated_at"],
        id: json["id"],
        rewardDisclaimer: json["reward_disclaimer"],
        selectedServiceType: json["selected_service_type"],
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "created_at": createdAt,
        "deleted_at": deletedAt,
        "discount_type": discountType,
        "reward_valid_at": rewardValidAt,
        "reward_type": rewardType,
        "reward_title": rewardTitle,
        "reward_unlocks_at": rewardUnlocksAt,
        "repeat_cash_value": repeatCashValue,
        "discount_amount": discountAmount,
        "included_service_type": includedServiceType,
        "updated_at": updatedAt,
        "id": id,
        "reward_disclaimer": rewardDisclaimer,
        "selected_service_type": selectedServiceType,
      };
}
