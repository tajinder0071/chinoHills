class SearchModel {
  int? total;
  bool? success;
  List<SearchDatum>? data;

  SearchModel({
    this.total,
    this.success,
    this.data,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    total: json["total"],
    success: json["success"],
    data: json["data"] == null ? [] : List<SearchDatum>.from(json["data"]!.map((x) => SearchDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SearchDatum {
  String? createdAt;
  String? description;
 var concerns;
  dynamic minPrice;
  int? serviceId;
  String? serviceType;
  String? name;
  String? imageurl;

  SearchDatum({
    this.createdAt,
    this.description,
    this.concerns,
    this.minPrice,
    this.serviceId,
    this.serviceType,
    this.name,
    this.imageurl,
  });

  factory SearchDatum.fromJson(Map<String, dynamic> json) => SearchDatum(
    createdAt: json["created_at"],
    description: json["description"],
    concerns: json["concerns"],
    minPrice: json["min_price"],
    serviceId: json["service_id"],
    serviceType: json["service_type"],
    name: json["name"],
    imageurl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "created_at": createdAt,
    "description": description,
    "concerns": concerns,
    "min_price": minPrice,
    "service_id": serviceId,
    "service_type": serviceType,
    "name": name,
    "image_url": imageurl,
  };
}
