class RewardDetailsModel {
  String? message;
  bool? success;
  Data? data;

  RewardDetailsModel({
    this.message,
    this.success,
    this.data,
  });

  factory RewardDetailsModel.fromJson(Map<String, dynamic> json) =>
      RewardDetailsModel(
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
  List<Membership>? membership;
  int? rewardId;
  List<Treatment>? treatments;
  List<Package>? packages;
  String? reward;

  Data({
    this.membership,
    this.rewardId,
    this.treatments,
    this.packages,
    this.reward,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        membership: json["membership"] == null
            ? []
            : List<Membership>.from(
                json["membership"]!.map((x) => Membership.fromJson(x))),
        rewardId: json["reward_id"],
        treatments: json["treatments"] == null
            ? []
            : List<Treatment>.from(
                json["treatments"]!.map((x) => Treatment.fromJson(x))),
        packages: json["packages"] == null
            ? []
            : List<Package>.from(
                json["packages"]!.map((x) => Package.fromJson(x))),
        reward: json["reward"],
      );

  Map<String, dynamic> toJson() => {
        "membership": membership == null
            ? []
            : List<dynamic>.from(membership!.map((x) => x.toJson())),
        "reward_id": rewardId,
        "treatments": treatments == null
            ? []
            : List<dynamic>.from(treatments!.map((x) => x.toJson())),
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "reward": reward,
      };
}

class Membership {
  String membership;

  int memberId;

  Membership({
    required this.membership,
    required this.memberId,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        membership: json["membership"],
        memberId: json["MemberID"],
      );

  Map<String, dynamic> toJson() => {
        "membership": membership,
        "MemberID": memberId,
      };
}

class Package {
  String packageName;
  int packageId;

  Package({
    required this.packageName,
    required this.packageId,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageName: json["package_name"],
        packageId: json["package_id"],
      );

  Map<String, dynamic> toJson() => {
        "package_name": packageName,
        "package_id": packageId,
      };
}

class Treatment {
  int treatmentId;
  String treatmentName;

  Treatment({
    required this.treatmentId,
    required this.treatmentName,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
        treatmentId: json["treatment_id"],
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "treatment_id": treatmentId,
        "treatment_name": treatmentName,
      };
}
