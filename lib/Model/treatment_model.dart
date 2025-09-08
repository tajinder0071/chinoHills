class TreatmentModel {
  bool? success;
  List<TreatmentData>? data;

  TreatmentModel({
    this.success,
    this.data,
  });

  factory TreatmentModel.fromJson(Map<String, dynamic> json) => TreatmentModel(
    success: json["success"],
    data: List<TreatmentData>.from(
        json["data"].map((x) => TreatmentData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TreatmentData {
  int treatmentId;
  String createdAt;
  String description;
  String treatment;
  String serviceUnitType;

  TreatmentData({
    required this.treatmentId,
    required this.createdAt,
    required this.description,
    required this.treatment,
    required this.serviceUnitType,
  });

  factory TreatmentData.fromJson(Map<String, dynamic> json) => TreatmentData(
    treatmentId: json["treatmentID"],
    createdAt: json["created_at"],
    description: json["description"],
    treatment: json["treatment"],
    serviceUnitType: json["service_unit_type"],
  );

  Map<String, dynamic> toJson() => {
    "treatmentID": treatmentId,
    "created_at": createdAt,
    "description": description,
    "treatment": treatment,
    "service_unit_type": serviceUnitType,
  };
}
