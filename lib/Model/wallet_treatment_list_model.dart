class WalletTreatmentListModel {
  bool? success;
  List<TreatmentList>? treatmentList;

  WalletTreatmentListModel({
    this.success,
    this.treatmentList,
  });

  factory WalletTreatmentListModel.fromJson(Map<String, dynamic> json) =>
      WalletTreatmentListModel(
        success: json["success"],
        treatmentList: json["treatment_list"] == null
            ? []
            : List<TreatmentList>.from(
                json["treatment_list"]!.map((x) => TreatmentList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "treatment_list": treatmentList == null
            ? []
            : List<dynamic>.from(treatmentList!.map((x) => x.toJson())),
      };
}

class TreatmentList {
  String? orderDate;
  String? orderId;
  String? treatmentVariantName;
  var quantity;
  String? itemVariantId;
  var itemId;
  String? fullTreatmentName;
  String? treatmentTitle;

  TreatmentList({
    this.orderDate,
    this.orderId,
    this.treatmentVariantName,
    this.quantity,
    this.itemVariantId,
    this.itemId,
    this.fullTreatmentName,
    this.treatmentTitle,
  });

  factory TreatmentList.fromJson(Map<String, dynamic> json) => TreatmentList(
        orderDate: json["order_date"],
        orderId: json["order_id"],
        treatmentVariantName: json["treatment_variant_name"],
        quantity: json["quantity"],
        itemVariantId: json["item_variant_id"],
        itemId: json["item_id"],
        fullTreatmentName: json["full_treatment_name"],
        treatmentTitle: json["treatment_title"],
      );

  Map<String, dynamic> toJson() => {
        "order_date": orderDate,
        "order_id": orderId,
        "treatment_variant_name": treatmentVariantName,
        "quantity": quantity,
        "item_variant_id": itemVariantId,
        "item_id": itemId,
        "full_treatment_name": fullTreatmentName,
        "treatment_title": treatmentTitle,
      };
}
