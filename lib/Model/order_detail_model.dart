// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) =>
    OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) =>
    json.encode(data.toJson());

class OrderDetailModel {
  bool? success;
  var orderCount;
  List<Order>? orders;

  OrderDetailModel({
    this.success,
    this.orderCount,
    this.orders,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        success: json["success"],
        orderCount: json["order_count"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "order_count": orderCount,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  String? paymentNotes;
  String? orderDate;
  var cartFinalCost;
  var userId;
  var cartOfferPrice;
  String? paymentMethod;
  List<Item>? items;
  var convenienceFree;
  String? paymentStatus;
  String? orderId;
  String? transactionId;
  var totalAmount;
  var cartTotalPrice;
  List<Orderitem>? orderitems;

  Order({
    this.paymentNotes,
    this.orderDate,
    this.cartFinalCost,
    this.userId,
    this.cartOfferPrice,
    this.paymentMethod,
    this.items,
    this.convenienceFree,
    this.paymentStatus,
    this.orderId,
    this.transactionId,
    this.totalAmount,
    this.cartTotalPrice,
    this.orderitems,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        paymentNotes: json["payment_notes"],
        orderDate: json["order_date"],
        cartFinalCost: json["cart_final_cost"],
        userId: json["user_id"],
        paymentMethod: json["payment_method"],
        cartOfferPrice: json["cart_offer_price"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        convenienceFree: json["convenience_free"],
        paymentStatus: json["payment_status"],
        orderId: json["order_id"],
        transactionId: json["transaction_id"],
        totalAmount: json["total_amount"],
        cartTotalPrice: json["cart_sub_price"],
        orderitems: json["orderitems"] == null
            ? []
            : List<Orderitem>.from(
                json["orderitems"]!.map((x) => Orderitem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payment_notes": paymentNotes,
        "order_date": orderDate,
        "cart_final_cost": cartFinalCost,
        "user_id": userId,
        "payment_method": paymentMethod,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "convenience_free": convenienceFree,
        "cart_offer_price": cartOfferPrice,
        "payment_status": paymentStatus,
        "order_id": orderId,
        "transaction_id": transactionId,
        "total_amount": totalAmount,
        "cart_sub_price": cartTotalPrice,
        "orderitems": orderitems == null
            ? []
            : List<dynamic>.from(orderitems!.map((x) => x.toJson())),
      };
}

class Item {
  String? treatmentImage;
  var membershipPrice;
  var quantity;
  var packagePrice;
  String? treatmentVariationName;
  var treatmentOfferPrice;
  String? membershipImage;
  String? packageImage;
  String? membership;
  String? treatmentVariationDescription;
  var treatmentPrice;
  String? packageName;
  String? itemType;
  String? treatmentName;

  Item({
    this.treatmentImage,
    this.membershipPrice,
    this.quantity,
    this.packagePrice,
    this.treatmentVariationName,
    this.treatmentOfferPrice,
    this.membershipImage,
    this.packageImage,
    this.membership,
    this.treatmentVariationDescription,
    this.treatmentPrice,
    this.packageName,
    this.itemType,
    this.treatmentName,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        treatmentImage: json["treatment_image"],
        membershipPrice: json["membership_price"],
        quantity: json["quantity"],
        packagePrice: json["package_price"],
        treatmentVariationName: json["treatment_variation_name"],
        treatmentOfferPrice: json["treatment_offer_price"],
        membershipImage: json["membership_image"],
        packageImage: json["package_image"],
        membership: json["membership"],
        treatmentVariationDescription: json["treatment_variation_description"],
        treatmentPrice: json["treatment_price"],
        packageName: json["package_name"],
        itemType: json["item_type"],
        treatmentName: json["treatment_name"],
      );

  Map<String, dynamic> toJson() => {
        "treatment_image": treatmentImage,
        "membership_price": membershipPrice,
        "quantity": quantity,
        "package_price": packagePrice,
        "treatment_variation_name": treatmentVariationName,
        "treatment_offer_price": treatmentOfferPrice,
        "membership_image": membershipImage,
        "package_image": packageImage,
        "membership": membership,
        "treatment_variation_description": treatmentVariationDescription,
        "treatment_price": treatmentPrice,
        "package_name": packageName,
        "item_type": itemType,
        "treatment_name": treatmentName,
      };
}

class Orderitem {
  String? image;
  String? orderId;
  var price;
  var quantity;
  String? variationDescription;
  String? itemType;
  var offerPrice;
  String? itemName;

  Orderitem({
    this.image,
    this.orderId,
    this.price,
    this.quantity,
    this.variationDescription,
    this.itemType,
    this.offerPrice,
    this.itemName,
  });

  factory Orderitem.fromJson(Map<String, dynamic> json) => Orderitem(
        image: json["image"],
        orderId: json["order_id"],
        price: json["price"],
        quantity: json["quantity"],
        variationDescription: json["variation_description"],
        itemType: json["item_type"],
        offerPrice: json["item_offer_price"],
        itemName: json["item_name"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "order_id": orderId,
        "price": price,
        "quantity": quantity,
        "variation_description": variationDescription,
        "item_type": itemType,
        "item_offer_price": offerPrice,
        "item_name": itemName,
      };
}
