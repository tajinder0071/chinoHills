// To parse this JSON data, do
//
//     final memberShipModel = memberShipModelFromJson(jsonString);

import 'dart:convert';

MemberShipModel memberShipModelFromJson(String str) =>
    MemberShipModel.fromJson(json.decode(str));

String memberShipModelToJson(MemberShipModel data) =>
    json.encode(data.toJson());

class MemberShipModel {
  List<MemberDatum>? data;
  String? categoryDescription;
  String? categoryHeader;
  String? getMembershipHeader;
  String? categoryHeaderCloudUrl;
  int? totalCount;

  MemberShipModel({
    this.data,
    this.categoryDescription,
    this.categoryHeaderCloudUrl,
    this.categoryHeader,
    this.getMembershipHeader,
    this.totalCount,
  });

  factory MemberShipModel.fromJson(Map<String, dynamic> json) =>
      MemberShipModel(
        data: json["data"] == null
            ? []
            : List<MemberDatum>.from(
                json["data"]!.map((x) => MemberDatum.fromJson(x))),
        categoryDescription: json["category_description"],
        categoryHeader: json["category_header"],
        categoryHeaderCloudUrl: json["category_header_cloudUrl"],
        totalCount: json["TotalCount"],
        getMembershipHeader: json["getMembershipHeader"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "category_description": categoryDescription,
        "category_header_cloudUrl": categoryHeaderCloudUrl,
        "category_header": categoryHeader,
        "TotalCount": totalCount,
        "getMembershipHeader": getMembershipHeader,
      };
}

class MemberDatum {
  String? location;
  String? treatmentOptionGroup;
  String? membershipHeader;
  var price;
  String? createdAt;
  var memberId;
  String? deletedAt;
  String? commitmentLength;
  String? minimumPeriod;
  String? membershipImage;
  String? membership;
  String? status;
  String? description;

  MemberDatum({
    this.location,
    this.treatmentOptionGroup,
    this.membershipHeader,
    this.price,
    this.createdAt,
    this.memberId,
    this.deletedAt,
    this.commitmentLength,
    this.minimumPeriod,
    this.membershipImage,
    this.membership,
    this.status,
    this.description,
  });

  factory MemberDatum.fromJson(Map<String, dynamic> json) => MemberDatum(
        location: json["location"],
        treatmentOptionGroup: json["treatment_option_group"],
        membershipHeader: json["membership_title"],
        price: json["membership_pricing"],
        createdAt: json["created_at"],
        memberId: json["membership_id"],
        deletedAt: json["deleted_at"],
        commitmentLength: json["commitment_length"],
        minimumPeriod: json["minimum_period"],
        membershipImage: json["membership_image"],
        membership: json["membership_title"],
        status: json["status"],
        description: json["benefit_descriptions"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "treatment_option_group": treatmentOptionGroup,
        "membership_title": membershipHeader,
        "membership_pricing": price,
        "created_at": createdAt,
        "membership_id": memberId,
        "deleted_at": deletedAt,
        "commitment_length": commitmentLength,
        "minimum_period": minimumPeriod,
        "membership_image": membershipImage,
        // "membership_title": membership,
        "status": status,
        "benefit_descriptions": description,
      };
}
