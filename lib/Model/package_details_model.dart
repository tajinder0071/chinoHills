class PackageDetailsModel {
  bool? success;
  List<Datum>? data;

  PackageDetailsModel({
    this.success,
    this.data,
  });

  factory PackageDetailsModel.fromJson(Map<String, dynamic> json) =>
      PackageDetailsModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? pricing;
  var displayOrder;
  String? careInstructions;
  List<String>? treatmentQuantity;
  List<String>? packageImages;
  FetchPackageInstructions? fetchPackageInstructions;
  String? membershipDiscountAmount;
  String? description;
  var qty;
  List<String>? bodyAreas;
  String? addedAt;
  List<String>? addedTreatment;
  String? packageName;
  List<Concern>? concern;
  var packageId;
  MembershipData? membershipData;

  Datum({
    this.pricing,
    this.displayOrder,
    this.careInstructions,
    this.treatmentQuantity,
    this.packageImages,
    this.fetchPackageInstructions,
    this.membershipDiscountAmount,
    this.description,
    this.qty,
    this.bodyAreas,
    this.addedAt,
    this.addedTreatment,
    this.packageName,
    this.concern,
    this.packageId,
    this.membershipData,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pricing: json["pricing"],
        displayOrder: json["display_order"],
        careInstructions: json["care_instructions"],
        treatmentQuantity: json["treatment_quantity"] == null
            ? []
            : List<String>.from(json["treatment_quantity"]!.map((x) => x)),
        packageImages: json["package_images"] == null
            ? []
            : List<String>.from(json["package_images"]!.map((x) => x)),
        fetchPackageInstructions: json["fetchPackageInstructions"] == null
            ? null
            : FetchPackageInstructions.fromJson(
                json["fetchPackageInstructions"]),
        membershipDiscountAmount: json["membershipDiscountAmount"],
        description: json["description"],
        qty: json["qty"],
        bodyAreas: json["body_areas"] == null
            ? []
            : List<String>.from(json["body_areas"]!.map((x) => x)),
        addedAt: json["added_at"],
        addedTreatment: json["added_treatment"] == null
            ? []
            : List<String>.from(json["added_treatment"]!.map((x) => x)),
        packageName: json["package_name"],
        concern: json["concern"] == null
            ? []
            : List<Concern>.from(
                json["concern"]!.map((x) => Concern.fromJson(x))),
        packageId: json["package_id"],
        membershipData: json["membershipData"] == null
            ? null
            : MembershipData.fromJson(json["membershipData"]),
      );

  Map<String, dynamic> toJson() => {
        "pricing": pricing,
        "display_order": displayOrder,
        "care_instructions": careInstructions,
        "treatment_quantity": treatmentQuantity == null
            ? []
            : List<dynamic>.from(treatmentQuantity!.map((x) => x)),
        "package_images": packageImages == null
            ? []
            : List<dynamic>.from(packageImages!.map((x) => x)),
        "fetchPackageInstructions": fetchPackageInstructions?.toJson(),
        "membershipDiscountAmount": membershipDiscountAmount,
        "description": description,
        "qty": qty,
        "body_areas": bodyAreas == null
            ? []
            : List<dynamic>.from(bodyAreas!.map((x) => x)),
        "added_at": addedAt,
        "added_treatment": addedTreatment == null
            ? []
            : List<dynamic>.from(addedTreatment!.map((x) => x)),
        "package_name": packageName,
        "concern": concern == null
            ? []
            : List<dynamic>.from(concern!.map((x) => x.toJson())),
        "package_id": packageId,
        "membershipData": membershipData?.toJson(),
      };
}

class Concern {
  var concernId;
  String? concernName;

  Concern({
    this.concernId,
    this.concernName,
  });

  factory Concern.fromJson(Map<String, dynamic> json) => Concern(
        concernId: json["concern_id"],
        concernName: json["concern_name"],
      );

  Map<String, dynamic> toJson() => {
        "concern_id": concernId,
        "concern_name": concernName,
      };
}

class FetchPackageInstructions {
  List<String>? columns;
  List<List<String>>? data;

  FetchPackageInstructions({
    this.columns,
    this.data,
  });

  factory FetchPackageInstructions.fromJson(Map<String, dynamic> json) =>
      FetchPackageInstructions(
        columns: json["COLUMNS"] == null
            ? []
            : List<String>.from(json["COLUMNS"]!.map((x) => x)),
        data: json["DATA"] == null
            ? []
            : List<List<String>>.from(
                json["DATA"]!.map((x) => List<String>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "COLUMNS":
            columns == null ? [] : List<dynamic>.from(columns!.map((x) => x)),
        "DATA": data == null
            ? []
            : List<dynamic>.from(
                data!.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}

class MembershipData {
  String? membership;
  var membershipPrice;
  var memberId;

  MembershipData({
    this.membership,
    this.membershipPrice,
    this.memberId,
  });

  factory MembershipData.fromJson(Map<String, dynamic> json) => MembershipData(
        membership: json["membership"],
        membershipPrice: json["membership_price"],
        memberId: json["memberID"],
      );

  Map<String, dynamic> toJson() => {
        "membership": membership,
        "membership_price": membershipPrice,
        "memberID": memberId,
      };
}
