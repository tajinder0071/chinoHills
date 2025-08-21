
class OrderListModel {
  bool? success;
  var orderCount;
  List<Orders>? orders;

  OrderListModel({
    this.success,
    this.orderCount,
    this.orders,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    success: json["success"],
    orderCount: json["order_count"],
    orders: json["orders"] == null ? [] : List<Orders>.from(json["orders"]!.map((x) => Orders.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "order_count": orderCount,
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Orders {
  String? paymentStatus;
  String? orderId;
  String? orderDate;
  var userId;
  List<Item>? items;
  var totalAmount;

  Orders({
    this.paymentStatus,
    this.orderId,
    this.orderDate,
    this.userId,
    this.items,
    this.totalAmount,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
    paymentStatus: json["payment_status"],
    orderId: json["order_id"],
    orderDate: json["order_date"],
    userId: json["user_id"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    totalAmount: json["total_amount"],
  );

  Map<String, dynamic> toJson() => {
    "payment_status": paymentStatus,
    "order_id": orderId,
    "order_date": orderDate,
    "user_id": userId,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "total_amount": totalAmount,
  };
}

class Item {
  TreatmentImage? treatmentImage;
  MembershipPrice? membershipPrice;
  var quantity;
  dynamic packagePrice;
  TreatmentVariationName? treatmentVariationName;
  PackageImage? packageImage;
  Membership? membership;
  TreatmentVariationDescription? treatmentVariationDescription;
  dynamic treatmentPrice;
  PackageName? packageName;
  ItemType? itemType;
  TreatmentName? treatmentName;

  Item({
    this.treatmentImage,
    this.membershipPrice,
    this.quantity,
    this.packagePrice,
    this.treatmentVariationName,
    this.packageImage,
    this.membership,
    this.treatmentVariationDescription,
    this.treatmentPrice,
    this.packageName,
    this.itemType,
    this.treatmentName,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    treatmentImage: treatmentImageValues.map[json["treatment_image"]],
    membershipPrice: membershipPriceValues.map[json["membership_price"]],
    quantity: json["quantity"],
    packagePrice: json["package_price"],
    treatmentVariationName: treatmentVariationNameValues.map[json["treatment_variation_name"]],
    packageImage: packageImageValues.map[json["package_image"]],
    membership: membershipValues.map[json["membership"]],
    treatmentVariationDescription: treatmentVariationDescriptionValues.map[json["treatment_variation_description"]],
    treatmentPrice: json["treatment_price"],
    packageName: packageNameValues.map[json["package_name"]],
    itemType: itemTypeValues.map[json["item_type"]],
    treatmentName: treatmentNameValues.map[json["treatment_name"]],
  );

  Map<String, dynamic> toJson() => {
    "treatment_image": treatmentImageValues.reverse[treatmentImage],
    "membership_price": membershipPriceValues.reverse[membershipPrice],
    "quantity": quantity,
    "package_price": packagePrice,
    "treatment_variation_name": treatmentVariationNameValues.reverse[treatmentVariationName],
    "package_image": packageImageValues.reverse[packageImage],
    "membership": membershipValues.reverse[membership],
    "treatment_variation_description": treatmentVariationDescriptionValues.reverse[treatmentVariationDescription],
    "treatment_price": treatmentPrice,
    "package_name": packageNameValues.reverse[packageName],
    "item_type": itemTypeValues.reverse[itemType],
    "treatment_name": treatmentNameValues.reverse[treatmentName],
  };
}

enum ItemType {
  MEMBER_SHIP,
  PACKAGE,
  TREATMENT
}

final itemTypeValues = EnumValues({
  "member ship": ItemType.MEMBER_SHIP,
  "package": ItemType.PACKAGE,
  "treatment": ItemType.TREATMENT
});

enum Membership {
  EMPTY,
  HORMONE_REPLACEMENT_THERAPY,
  TOXIN_MEMBERSHIP_FOR_BOTOX
}

final membershipValues = EnumValues({
  "": Membership.EMPTY,
  "Hormone Replacement Therapy": Membership.HORMONE_REPLACEMENT_THERAPY,
  "Toxin Membership for Botox": Membership.TOXIN_MEMBERSHIP_FOR_BOTOX
});

enum MembershipPrice {
  EMPTY,
  THE_12200,
  THE_49900
}

final membershipPriceValues = EnumValues({
  "": MembershipPrice.EMPTY,
  "122.00": MembershipPrice.THE_12200,
  "499.00": MembershipPrice.THE_49900
});

enum PackageImage {
  ADMIN_APPBUILDER_PACKAGES_IMAGES_MEN_3_JPG,
  EMPTY
}

final packageImageValues = EnumValues({
  "/admin/appbuilder/packages/images/men-3.jpg": PackageImage.ADMIN_APPBUILDER_PACKAGES_IMAGES_MEN_3_JPG,
  "": PackageImage.EMPTY
});

enum PackageName {
  EMPTY,
  MEN_DURANCE_3
}

final packageNameValues = EnumValues({
  "": PackageName.EMPTY,
  "MenDurance #3": PackageName.MEN_DURANCE_3
});

enum TreatmentImage {
  ADMIN_APPBUILDER_TREATMENTS_IMAGES_CONCERN_JPG,
  EMPTY
}

final treatmentImageValues = EnumValues({
  "/admin/appbuilder/treatments/images/concern.jpg": TreatmentImage.ADMIN_APPBUILDER_TREATMENTS_IMAGES_CONCERN_JPG,
  "": TreatmentImage.EMPTY
});

enum TreatmentName {
  EMPTY,
  THE_4_D_HI_FU
}

final treatmentNameValues = EnumValues({
  "": TreatmentName.EMPTY,
  "4D HiFu": TreatmentName.THE_4_D_HI_FU
});

enum TreatmentVariationDescription {
  A_SERIES_OF_5_FACIALS_WITH_A_DISCOUNTED_PRICE_FOR_BULK_PURCHASE,
  EMPTY
}

final treatmentVariationDescriptionValues = EnumValues({
  "A series of 5 facials with a discounted price for bulk purchase.": TreatmentVariationDescription.A_SERIES_OF_5_FACIALS_WITH_A_DISCOUNTED_PRICE_FOR_BULK_PURCHASE,
  "": TreatmentVariationDescription.EMPTY
});

enum TreatmentVariationName {
  EMPTY,
  FACIAL_BUNDLE
}

final treatmentVariationNameValues = EnumValues({
  "": TreatmentVariationName.EMPTY,
  "Facial Bundle": TreatmentVariationName.FACIAL_BUNDLE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
