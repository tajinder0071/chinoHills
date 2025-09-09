class CartModel1 {
  String? message;
  bool? success;
  Data? data;
  AvailableReward? reward;
  PromoCode? promoCode;

  CartModel1({
    this.message,
    this.success,
    this.data,
    this.reward,
    this.promoCode,
  });

  factory CartModel1.fromJson(Map<String, dynamic> json) => CartModel1(
    message: json["message"],
    success: json["success"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    promoCode: json["promocode"] == null
        ? null
        : PromoCode.fromJson(json["promocode"]),
    reward: json["reward"] == null
        ? null
        : AvailableReward.fromJson(json["reward"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "data": data?.toJson(),
    "promocode": promoCode?.toJson(),
    "reward": reward?.toJson(),
  };
}

class Data {
  var itemsCount;
  var subTotal;
  var finalCost;
  var discountPrice;
  var price;
  var convenienceFee;
  List<Item>? items;
  var cartId;
  var offerName;
  var offerType;

  Data({
    this.itemsCount,
    this.subTotal,
    this.finalCost,
    this.discountPrice,
    this.convenienceFee,
    this.items,
    this.cartId,
    this.offerName,
    this.offerType
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    itemsCount: json["items_count"],
    offerType: json["offer_type"],
    subTotal: json["sub_total"],
    finalCost: json["final_cost"]?.toDouble(),
    discountPrice: json["discount_price"],
    convenienceFee: json["convenience_fee"]?.toDouble(),
    items: json["items"] == null
        ? []
        : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    cartId: json["cart_id"],
    offerName: json["offer_name"],
  );

  Map<String, dynamic> toJson() => {
    "items_count": itemsCount,
    "sub_total": subTotal,
    "offer_type": offerType,
    "final_cost": finalCost,
    "discount_price": discountPrice,
    "convenience_fee": convenienceFee,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "cart_id": cartId,
    "offer_name": offerName,
  };
}

class Item {
  var cartItemId;
  var price;
  DateTime? createdAt;
  var quantity;
  var discountPrice;
  var itemVariantId;
  var itemId;
  String? itemType;
  String? variationName;
  String? name;
  String? imageUrl;

  Item({
    this.cartItemId,
    this.price,
    this.createdAt,
    this.quantity,
    this.discountPrice,
    this.itemVariantId,
    this.itemId,
    this.itemType,
    this.variationName,
    this.name,
    this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    cartItemId: json["cart_item_id"],
    price: json["price"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    quantity: json["quantity"],
    discountPrice: json["discount_price"],
    itemVariantId: json["item_variant_id"],
    itemId: json["item_id"],
    itemType: json["item_type"],
    variationName: json["variation_name"],
    name: json["name"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "cart_item_id": cartItemId,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "quantity": quantity,
    "discount_price": discountPrice,
    "item_variant_id": itemVariantId,
    "item_id": itemId,
    "item_type": itemType,
    "variation_name": variationName,
    "name": name,
    "image_url": imageUrl,
  };
}

class PromoCode {
  var discountValue;
  var id;
  String? discountType;
  String? name;

  PromoCode({
    this.discountValue,
    this.id,
    this.discountType,
    this.name,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) => PromoCode(
    discountValue: json["discount_value"],
    id: json["promo_code_id"],
    discountType: json["discount_type"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "discount_value": discountValue,
    "promo_code_id": id,
    "discount_type": discountType,
    "name": name,
  };
}

class AvailableReward {
  var discountValue;
  dynamic id;
  String? discountType;
  String? name;

  AvailableReward({
    this.discountValue,
    this.id,
    this.discountType,
    this.name,
  });

  factory AvailableReward.fromJson(Map<String, dynamic> json) =>
      AvailableReward(
        discountValue: json["discount_value"],
        id: json["id"],
        discountType: json["discount_type"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
    "discount_value": discountValue,
    "id": id,
    "discount_type": discountType,
    "name": name,
  };
}
