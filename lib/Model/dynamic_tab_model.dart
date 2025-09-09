class DynaminTabModel {
  HeaderDetails? headerDetails;
  bool? success;
  List<Datum>? data;

  DynaminTabModel({
    this.success,
    this.data,
    this.headerDetails,
  });

  factory DynaminTabModel.fromJson(Map<String, dynamic> json) => DynaminTabModel(
    success: json["success"],
    headerDetails: json["headerDetails"] == null
        ? null
        : HeaderDetails.fromJson(json["headerDetails"]),
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HeaderDetails {
  String? headerTitle;
  String? headerDescription;
  String? headerimage;

  HeaderDetails({
    this.headerTitle,
    this.headerDescription,
    this.headerimage,
  });

  factory HeaderDetails.fromJson(Map<String, dynamic> json) => HeaderDetails(
    headerTitle: json["category_header"],
    headerDescription: json["category_description"],
    headerimage: json["categoryHeaderCloudUrl"],
  );

  Map<String, dynamic> toJson() => {
    "category_header": headerTitle,
    "category_description": headerDescription,
    "categoryHeaderCloudUrl": headerimage,
  };
}

class Datum {
  var price;
  String? description;
  String? image;
  dynamic concerns;
  dynamic id;
  Type? type;
  String? name;
  String? offeroffText;

  Datum({
    this.price,
    this.image,
    this.description,
    this.concerns,
    this.id,
    this.type,
    this.name,
    this.offeroffText,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    price: json["price"],
    image: json["image"],
    description: json["description"],
    concerns: json["concerns"],
    id: json["id"],
    type: typeValues.map[json["type"]]!,
    name: json["name"],
    offeroffText: json["offeroffText"],
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "image": image,
    "description": description,
    "concerns": concerns,
    "id": id,
    "type": typeValues.reverse[type],
    "name": name,
    "offeroffText": offeroffText,
  };
}

enum Type {
  MEMBERSHIP,
  PACKAGE,
  TREATMENT
}

final typeValues = EnumValues({
  "Membership": Type.MEMBERSHIP,
  "Package": Type.PACKAGE,
  "Treatment": Type.TREATMENT
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
