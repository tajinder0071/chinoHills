class NewBrowseModel {
  String? message;
  bool? success;
  List<NewDatum>? data;

  NewBrowseModel({
    this.message,
    this.success,
    this.data,
  });

  factory NewBrowseModel.fromJson(Map<String, dynamic> json) => NewBrowseModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<NewDatum>.from(
                json["data"]!.map((x) => NewDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NewDatum {
  int? concernId;
  ConcernStatus? concernStatus;
  String? concernName;

  NewDatum({
    this.concernId,
    this.concernStatus,
    this.concernName,
  });

  factory NewDatum.fromJson(Map<String, dynamic> json) => NewDatum(
        concernId: json["concern_id"],
        concernStatus: concernStatusValues.map[json["concern_status"]]!,
        concernName: json["concern_name"],
      );

  Map<String, dynamic> toJson() => {
        "concern_id": concernId,
        "concern_status": concernStatusValues.reverse[concernStatus],
        "concern_name": concernName,
      };
}

enum ConcernStatus { DISABLED, ENABLED }

final concernStatusValues = EnumValues(
    {"Disabled": ConcernStatus.DISABLED, "Enabled": ConcernStatus.ENABLED});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
