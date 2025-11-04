class RewardDetailsModel {
  String? message;
  RewardDetails? data;
  bool? success;

  RewardDetailsModel({this.message, this.data, this.success});

  RewardDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['reward_details'] != null
        ? new RewardDetails.fromJson(json['reward_details'])
        : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['reward_details'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class RewardDetails {
  String? createdAt;
  List<Treatments>? treatments;
  List<Packages>? packages;
  String? discountType;
  String? rewardTitle;
  String? rewardValidAt;
  var rewardUnlocksAt;
  String? repeatCashValue;
  String? discountAmount;
  List<Memberships>? memberships;
  var id;
  String? rewardDisclaimer;

  RewardDetails(
      {this.createdAt,
        this.treatments,
        this.packages,
        this.discountType,
        this.rewardTitle,
        this.rewardValidAt,
        this.rewardUnlocksAt,
        this.repeatCashValue,
        this.discountAmount,
        this.memberships,
        this.id,
        this.rewardDisclaimer});

  RewardDetails.fromJson(Map<String, dynamic> json) {
    createdAt = json['created_at'];
    if (json['treatments'] != null) {
      treatments = <Treatments>[];
      json['treatments'].forEach((v) {
        treatments!.add(new Treatments.fromJson(v));
      });
    }
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(new Packages.fromJson(v));
      });
    }
    discountType = json['discount_type'];
    rewardTitle = json['reward_title'];
    rewardValidAt = json['reward_valid_at'];
    rewardUnlocksAt = json['reward_unlocks_at'];
    repeatCashValue = json['repeat_cash_value'];
    discountAmount = json['discount_amount'];
    if (json['memberships'] != null) {
      memberships = <Memberships>[];
      json['memberships'].forEach((v) {
        memberships!.add(new Memberships.fromJson(v));
      });
    }
    id = json['id'];
    rewardDisclaimer = json['reward_disclaimer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at'] = this.createdAt;
    if (this.treatments != null) {
      data['treatments'] = this.treatments!.map((v) => v.toJson()).toList();
    }
    if (this.packages != null) {
      data['packages'] = this.packages!.map((v) => v.toJson()).toList();
    }
    data['discount_type'] = this.discountType;
    data['reward_title'] = this.rewardTitle;
    data['reward_valid_at'] = this.rewardValidAt;
    data['reward_unlocks_at'] = this.rewardUnlocksAt;
    data['repeat_cash_value'] = this.repeatCashValue;
    data['discount_amount'] = this.discountAmount;
    if (this.memberships != null) {
      data['memberships'] = this.memberships!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['reward_disclaimer'] = this.rewardDisclaimer;
    return data;
  }
}

class Treatments {
  List<Variations>? variations;
  int? treatmentId;
  String? treatmentName;

  Treatments({this.variations, this.treatmentId, this.treatmentName});

  Treatments.fromJson(Map<String, dynamic> json) {
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
    treatmentId = json['treatment_id'];
    treatmentName = json['treatment_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    data['treatment_id'] = this.treatmentId;
    data['treatment_name'] = this.treatmentName;
    return data;
  }
}

class Variations {
  int? variationId;
  String? variationName;

  Variations({this.variationId, this.variationName});

  Variations.fromJson(Map<String, dynamic> json) {
    variationId = json['variation_id'];
    variationName = json['variation_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variation_id'] = this.variationId;
    data['variation_name'] = this.variationName;
    return data;
  }
}

class Packages {
  String? packageName;
  int? packageId;

  Packages({this.packageName, this.packageId});

  Packages.fromJson(Map<String, dynamic> json) {
    packageName = json['package_name'];
    packageId = json['package_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['package_name'] = this.packageName;
    data['package_id'] = this.packageId;
    return data;
  }
}

class Memberships {
  String? membershipName;
  int? membershipId;

  Memberships({this.membershipName, this.membershipId});

  Memberships.fromJson(Map<String, dynamic> json) {
    membershipName = json['membership_name'];
    membershipId = json['membership_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['membership_name'] = this.membershipName;
    data['membership_id'] = this.membershipId;
    return data;
  }
}

// class RewardDetailsModel {
//   String? message;
//   bool? success;
//   Data? data;
//
//   RewardDetailsModel({
//     this.message,
//     this.success,
//     this.data,
//   });
//
//   factory RewardDetailsModel.fromJson(Map<String, dynamic> json) =>
//       RewardDetailsModel(
//         message: json["message"],
//         success: json["success"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "success": success,
//         "data": data?.toJson(),
//       };
// }
//
// class Data {
//   List<Membership>? membership;
//   int? rewardId;
//   List<Treatment>? treatments;
//   List<Package>? packages;
//   String? reward;
//
//   Data({
//     this.membership,
//     this.rewardId,
//     this.treatments,
//     this.packages,
//     this.reward,
//   });
//
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         membership: json["membership"] == null
//             ? []
//             : List<Membership>.from(
//                 json["membership"]!.map((x) => Membership.fromJson(x))),
//         rewardId: json["reward_id"],
//         treatments: json["treatments"] == null
//             ? []
//             : List<Treatment>.from(
//                 json["treatments"]!.map((x) => Treatment.fromJson(x))),
//         packages: json["packages"] == null
//             ? []
//             : List<Package>.from(
//                 json["packages"]!.map((x) => Package.fromJson(x))),
//         reward: json["reward"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "membership": membership == null
//             ? []
//             : List<dynamic>.from(membership!.map((x) => x.toJson())),
//         "reward_id": rewardId,
//         "treatments": treatments == null
//             ? []
//             : List<dynamic>.from(treatments!.map((x) => x.toJson())),
//         "packages": packages == null
//             ? []
//             : List<dynamic>.from(packages!.map((x) => x.toJson())),
//         "reward": reward,
//       };
// }
//
// class Membership {
//   String membership;
//
//   int memberId;
//
//   Membership({
//     required this.membership,
//     required this.memberId,
//   });
//
//   factory Membership.fromJson(Map<String, dynamic> json) => Membership(
//         membership: json["membership"],
//         memberId: json["MemberID"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "membership": membership,
//         "MemberID": memberId,
//       };
// }
//
// class Package {
//   String packageName;
//   int packageId;
//
//   Package({
//     required this.packageName,
//     required this.packageId,
//   });
//
//   factory Package.fromJson(Map<String, dynamic> json) => Package(
//         packageName: json["package_name"],
//         packageId: json["package_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "package_name": packageName,
//         "package_id": packageId,
//       };
// }
//
// class Treatment {
//   int treatmentId;
//   String treatmentName;
//
//   Treatment({
//     required this.treatmentId,
//     required this.treatmentName,
//   });
//
//   factory Treatment.fromJson(Map<String, dynamic> json) => Treatment(
//         treatmentId: json["treatment_id"],
//         treatmentName: json["treatment_name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "treatment_id": treatmentId,
//         "treatment_name": treatmentName,
//       };
// }

