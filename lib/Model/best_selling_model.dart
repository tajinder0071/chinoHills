class BestSellingModel {
  bool? success;
  List<BestTreatment>? treatments;
  List<BestPackage>? packages;
  var signupReward;

  BestSellingModel({
    this.success,
    this.treatments,
    this.packages,
    this.signupReward,
  });

  factory BestSellingModel.fromJson(Map<String, dynamic> json) =>
      BestSellingModel(
        success: json["success"],
        treatments: json["treatments"] == null
            ? []
            : List<BestTreatment>.from(
                json["treatments"]!.map((x) => BestTreatment.fromJson(x))),
        packages: json["packages"] == null
            ? []
            : List<BestPackage>.from(
                json["packages"]!.map((x) => BestPackage.fromJson(x))),
        signupReward: json["signup_reward"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "treatments": treatments == null
            ? []
            : List<dynamic>.from(treatments!.map((x) => x.toJson())),
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "signup_reward": signupReward,
      };
}

class BestPackage {
  List<String>? packageImages;
  String? membershipFinalPrice;
  var pricing;
  var displayOrder;
  String? packageName;
  var packageId;
  var rewards;

  BestPackage({
    this.packageImages,
    this.membershipFinalPrice,
    this.pricing,
    this.displayOrder,
    this.packageName,
    this.packageId,
    this.rewards,
  });

  factory BestPackage.fromJson(Map<String, dynamic> json) => BestPackage(
        packageImages: json["package_images"] == null
            ? []
            : List<String>.from(json["package_images"]!.map((x) => x)),
        membershipFinalPrice: json["membershipFinalPrice"],
        pricing: json["pricing"],
        displayOrder: json["display_order"],
        packageName: json["package_name"],
        packageId: json["package_id"],
        rewards: json["rewards"],
      );

  Map<String, dynamic> toJson() => {
        "package_images": packageImages == null
            ? []
            : List<dynamic>.from(packageImages!.map((x) => x)),
        "membershipFinalPrice": membershipFinalPrice,
        "pricing": pricing,
        "display_order": displayOrder,
        "package_name": packageName,
        "package_id": packageId,
        "rewards": rewards,
      };
}

class BestTreatment {
  var price;
  var membershipPrice;
  var id;
  var reward;
  List<String>? treatmentImagePaths;
  String? treatmentName;

  BestTreatment({
    this.price,
    this.membershipPrice,
    this.id,
    this.reward,
    this.treatmentImagePaths,
    this.treatmentName,
  });

  factory BestTreatment.fromJson(Map<String, dynamic> json) => BestTreatment(
        price: json["price"],
        membershipPrice: json["membership_price"],
        id: json["id"],
        reward: json["reward"],
        treatmentImagePaths: json["treatmentImagePaths"] == null
            ? []
            : List<String>.from(json["treatmentImagePaths"]!.map((x) => x)),
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "membership_price": membershipPrice,
        "id": id,
        "reward": reward,
        "treatmentImagePaths": treatmentImagePaths == null
            ? []
            : List<dynamic>.from(treatmentImagePaths!.map((x) => x)),
        "treatment_name": treatmentName,
      };
}
