class FethMeberShipPerks {
  String? message;
  bool? success;
  List<DatumMemeber>? data;
  var totalCount;

  FethMeberShipPerks({
    this.message,
    this.success,
    this.data,
    this.totalCount,
  });

  factory FethMeberShipPerks.fromJson(Map<String, dynamic> json) =>
      FethMeberShipPerks(
          message: json["message"],
          success: json["success"],
          data: json["data"] == null
              ? []
              : List<DatumMemeber>.from(
                  json["data"]!.map((x) => DatumMemeber.fromJson(x))),
          totalCount: json['TotalCount']);

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        'totalCount': totalCount
      };
}

class DatumMemeber {
  String? membershipIcon;
  String? membershipPerk;
  String? createdAt;
  int? shopId;
  String? updatedAt;
  int? id;

  DatumMemeber({
    this.membershipIcon,
    this.membershipPerk,
    this.createdAt,
    this.shopId,
    this.updatedAt,
    this.id,
  });

  factory DatumMemeber.fromJson(Map<String, dynamic> json) => DatumMemeber(
        membershipIcon: json["membership_icon"],
        membershipPerk: json["membership_perk"],
        createdAt: json["created_at"],
        shopId: json["shop_id"],
        updatedAt: json["updated_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "membership_icon": membershipIcon,
        "membership_perk": membershipPerk,
        "created_at": createdAt,
        "shop_id": shopId,
        "updated_at": updatedAt,
        "id": id,
      };
}
