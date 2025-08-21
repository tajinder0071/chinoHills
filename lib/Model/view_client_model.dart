class ViewClientModel {
  String? message;
  bool? success;
  List<ClientDatum>? data;

  ViewClientModel({
    this.message,
    this.success,
    this.data,
  });

  factory ViewClientModel.fromJson(Map<String, dynamic> json) =>
      ViewClientModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ClientDatum>.from(
                json["data"]!.map((x) => ClientDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClientDatum {
  String? clientEmail;
  String? status;
  String? image;
  String? password;
  String? clientName;
  String? phone;
  String? address;
  var zipcode;
  var id;
  String? mainLocation;

  ClientDatum({
    this.clientEmail,
    this.status,
    this.image,
    this.password,
    this.clientName,
    this.phone,
    this.address,
    this.zipcode,
    this.id,
    this.mainLocation,
  });

  factory ClientDatum.fromJson(Map<String, dynamic> json) => ClientDatum(
        clientEmail: json["client_email"],
        status: json["status"],
        image: json["image"],
        password: json["password"],
        clientName: json["client_name"],
        phone: json["phone"],
        address: json["address"],
        zipcode: json["zipcode"],
        id: json["id"],
        mainLocation: json["main_location"],
      );

  Map<String, dynamic> toJson() => {
        "client_email": clientEmail,
        "status": status,
        "image": image,
        "password": password,
        "client_name": clientName,
        "phone": phone,
        "address": address,
        "zipcode": zipcode,
        "id": id,
        "main_location": mainLocation,
      };
}
