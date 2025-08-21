class CartModel1 {
  String? message;
  bool? success;
  var afterOfferPrice;
  var finalCost;
  List<CartItem>? cartItems;
  String? totalPrice;
  String? totalConvenienceFee;
  PromoCode? promoCode;
  AvailableReward? reward;
  var appliedCartDiscountValue;

  CartModel1({
    this.message,
    this.success,
    this.afterOfferPrice,
    this.finalCost,
    this.cartItems,
    this.totalPrice,
    this.totalConvenienceFee,
    this.promoCode,
    this.reward,
    this.appliedCartDiscountValue,
  });

  factory CartModel1.fromJson(Map<String, dynamic> json) => CartModel1(
        message: json["message"],
        success: json["success"],
        afterOfferPrice: json["after_offer_price"],
        finalCost: json["final_cost"],
        cartItems: json["cartItems"] == null
            ? []
            : List<CartItem>.from(
                json["cartItems"]!.map((x) => CartItem.fromJson(x))),
        totalPrice: json["total_price"],
        totalConvenienceFee: json["totalConvenienceFee"],
        appliedCartDiscountValue: json["applied_cart_discount_value"],
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
        "after_offer_price": afterOfferPrice,
        "final_cost": finalCost,
        "cartItems": cartItems == null
            ? []
            : List<dynamic>.from(cartItems!.map((x) => x.toJson())),
        "total_price": totalPrice,
        "totalConvenienceFee": totalConvenienceFee,
        "promocode": promoCode?.toJson(),
        "reward": reward?.toJson(),
        "applied_cart_discount_value": appliedCartDiscountValue?.toJson(),
      };
}

class CartItem {
  String? membershipName;
  var cartItemId;
  dynamic price;
  var memberId;
  var cartId;
  String? itemType;
  String? membershipImage;

  List<String>? treatmentImagePath;

  // String? treatmentImagePath;
  var treatmentVariationId;
  var treatmentId;
  String? treatmentVariationName;
  List<TreatmentVariation>? treatmentVariations;
  String? treatmentName;
  String? packageImagePath;
  String? packageName;
  var packageId;
  var actualPrice;

  bool isLoad = false;
  bool isItemRemove = false;
  bool isItemDelete = false;
  bool isDeleteSingle = false;

  CartItem({
    this.membershipName,
    this.cartItemId,
    this.price,
    this.memberId,
    this.cartId,
    this.itemType,
    this.membershipImage,
    this.treatmentImagePath,
    this.treatmentVariationId,
    this.treatmentId,
    this.treatmentVariationName,
    this.treatmentVariations,
    this.treatmentName,
    this.packageImagePath,
    this.packageName,
    this.packageId,
    this.actualPrice,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        membershipName: json["membership_name"],
        cartItemId: json["cart_item_id"],
        price: json["price"],
        memberId: json["memberID"],
        cartId: json["cart_id"],
        actualPrice: json["actual_price"],
        itemType: json["item_type"],
        membershipImage: json["membership_image"],
        // treatmentImagePath: json['treatment_image_path'],
        treatmentImagePath: json["treatment_image_path"] == null
            ? []
            : List<String>.from(json["treatment_image_path"]!.map((x) => x)),
        treatmentVariationId: json["treatment_variation_id"],
        treatmentId: json["treatment_id"],
        treatmentVariationName: json["treatment_variation_name"],
        treatmentVariations: json["treatment_variations"] == null
            ? []
            : List<TreatmentVariation>.from(json["treatment_variations"]!
                .map((x) => TreatmentVariation.fromJson(x))),
        treatmentName: json["treatment_name"],
        packageImagePath: json["package_image_path"],
        packageName: json["package_name"],
        packageId: json["package_id"],
      );

  Map<String, dynamic> toJson() => {
        "membership_name": membershipName,
        "cart_item_id": cartItemId,
        "price": price,
        "memberID": memberId,
        "cart_id": cartId,
        "item_type": itemType,
        "membership_image": membershipImage,
        // "treatment_image_path": treatmentImagePath,
        "treatment_image_path": treatmentImagePath == null
            ? []
            : List<dynamic>.from(treatmentImagePath!.map((x) => x)),
        "treatment_variation_id": treatmentVariationId,
        "treatment_id": treatmentId,
        "actual_price": actualPrice,
        "treatment_variation_name": treatmentVariationName,
        "treatment_variations": treatmentVariations == null
            ? []
            : List<dynamic>.from(treatmentVariations!.map((x) => x.toJson())),
        "treatment_name": treatmentName,
        "package_image_path": packageImagePath,
        "package_name": packageName,
        "package_id": packageId,
      };
}

class TreatmentVariation {
  var treatmentVariationId;
  var treatmentPrice;
  String? treatmentVariationName;

  TreatmentVariation({
    this.treatmentVariationId,
    this.treatmentPrice,
    this.treatmentVariationName,
  });

  factory TreatmentVariation.fromJson(Map<String, dynamic> json) =>
      TreatmentVariation(
        treatmentVariationId: json["treatment_variation_id"],
        treatmentPrice: json["treatment_price"],
        treatmentVariationName: json["treatment_variation_name"],
      );

  Map<String, dynamic> toJson() => {
        "treatment_variation_id": treatmentVariationId,
        "treatment_price": treatmentPrice,
        "treatment_variation_name": treatmentVariationName,
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
