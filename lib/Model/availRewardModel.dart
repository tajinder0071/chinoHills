class AvailRewardModel {
  List<Reward>? upcomingRewards;
  String? message;
  bool? success;
  List<Reward>? unlockedRewards;
  NextReward? nextReward;

  AvailRewardModel({
    this.upcomingRewards,
    this.message,
    this.success,
    this.unlockedRewards,
    this.nextReward,
  });

  factory AvailRewardModel.fromJson(Map<String, dynamic> json) =>
      AvailRewardModel(
        upcomingRewards: json["upcoming_rewards"] == null
            ? []
            : List<Reward>.from(
                json["upcoming_rewards"]!.map((x) => Reward.fromJson(x))),
        message: json["message"],
        success: json["success"],
        unlockedRewards: json["unlocked_rewards"] == null
            ? []
            : List<Reward>.from(
                json["unlocked_rewards"]!.map((x) => Reward.fromJson(x))),
        nextReward: json["next_reward"] == null
            ? null
            : NextReward.fromJson(json["next_reward"]),
      );

  Map<String, dynamic> toJson() => {
        "upcoming_rewards": upcomingRewards == null
            ? []
            : List<dynamic>.from(upcomingRewards!.map((x) => x.toJson())),
        "message": message,
        "success": success,
        "unlocked_rewards": unlockedRewards == null
            ? []
            : List<dynamic>.from(unlockedRewards!.map((x) => x.toJson())),
        "next_reward": nextReward?.toJson(),
      };
}

class NextReward {
  var nextRewardId;
  var unlockSpend;
  var unlockAtCount;
  var progressPercentage;

  NextReward({
    this.nextRewardId,
    this.unlockSpend,
    this.unlockAtCount,
    this.progressPercentage,
  });

  factory NextReward.fromJson(Map<String, dynamic> json) => NextReward(
        nextRewardId: json["next_reward_id"],
        unlockSpend: json["unlock_spend"],
        unlockAtCount: json["unlock_at_count"],
        progressPercentage: json["progress_percentage"],
      );

  Map<String, dynamic> toJson() => {
        "next_reward_id": nextRewardId,
        "unlock_spend": unlockSpend,
        "unlock_at_count": unlockAtCount,
        "progress_percentage": progressPercentage,
      };
}

class Reward {
  String? status;
  var rewardUnlocksAt;
  String? repeatCashValue;
  String? discountAmount;
  var id;
  String? rewardDisclaimer;
  var visitsNeeded;
  String? discountType;
  String? rewardTitle;
  String? rewardValidAt;

  Reward({
    this.status,
    this.rewardUnlocksAt,
    this.repeatCashValue,
    this.discountAmount,
    this.id,
    this.rewardDisclaimer,
    this.visitsNeeded,
    this.discountType,
    this.rewardTitle,
    this.rewardValidAt,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        status: json["status"],
        rewardUnlocksAt: json["reward_unlocks_at"],
        repeatCashValue: json["repeat_cash_value"],
        discountAmount: json["discount_amount"],
        id: json["id"],
        rewardDisclaimer: json["reward_disclaimer"],
        visitsNeeded: json["visits_needed"],
        discountType: json["discount_type"],
        rewardTitle: json["reward_title"],
        rewardValidAt: json["reward_valid_at"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "reward_unlocks_at": rewardUnlocksAt,
        "repeat_cash_value": repeatCashValue,
        "discount_amount": discountAmount,
        "id": id,
        "reward_disclaimer": rewardDisclaimer,
        "visits_needed": visitsNeeded,
        "discount_type": discountType,
        "reward_title": rewardTitle,
        "reward_valid_at": rewardValidAt,
      };
}
