class SearchClientModel {
  String? message;
  bool? success;
  List<Datum>? data;

  SearchClientModel({
    this.message,
    this.success,
    this.data,
  });

  factory SearchClientModel.fromJson(Map<String, dynamic> json) =>
      SearchClientModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? clientEmail;
  String? status;
  String? image;
  String? password;
  String? clientName;
  String? phone;
  int? id;
  String? mainLocation;

  Datum({
    this.clientEmail,
    this.status,
    this.image,
    this.password,
    this.clientName,
    this.phone,
    this.id,
    this.mainLocation,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        clientEmail: json["client_email"],
        status: json["status"],
        image: json["linked_image"],
        password: json["password"],
        clientName: json["client_name"],
        phone: json["phone"],
        id: json["id"],
        mainLocation: json["main_location"],
      );

  Map<String, dynamic> toJson() => {
        "client_email": clientEmail,
        "status": status,
        "linked_image": image,
        "password": password,
        "client_name": clientName,
        "phone": phone,
        "id": id,
        "main_location": mainLocation,
      };
}
