class ChooseClientModel {
  String? message;
  bool? success;
  List<ChooseDatum>? data;

  ChooseClientModel({
    this.message,
    this.success,
    this.data,
  });

  factory ChooseClientModel.fromJson(Map<String, dynamic> json) =>
      ChooseClientModel(
        message: json["message"],
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ChooseDatum>.from(
                json["data"]!.map((x) => ChooseDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ChooseDatum {
  String? createdAt;
  String? phone;
  String? userEmail;
  var userId;
  var visitsCount;
  String? userName;
  var flag;
  String? lastName;
  String? mainLocation;
  var totalInAppSpend;
  String? firstName;
  String? profileStatus;
  String? role;
  String? status;
  String? image;
  String? password;
  var visit;
  String? clientId;
  String? membershipStatus;
  String? lastVisit;
  String? verificationCode;
  String? birthday;

  ChooseDatum({
    this.createdAt,
    this.phone,
    this.userEmail,
    this.userId,
    this.visitsCount,
    this.userName,
    this.flag,
    this.lastName,
    this.mainLocation,
    this.totalInAppSpend,
    this.firstName,
    this.profileStatus,
    this.role,
    this.status,
    this.image,
    this.password,
    this.visit,
    this.clientId,
    this.membershipStatus,
    this.lastVisit,
    this.verificationCode,
    this.birthday,
  });

  factory ChooseDatum.fromJson(Map<String, dynamic> json) => ChooseDatum(
        createdAt: json["created_at"],
        phone: json["phone"],
        userEmail: json["user_email"],
        userId: json["user_id"],
        visitsCount: json["visits_count"],
        userName: json["user_name"],
        flag: json["flag"],
        lastName: json["last_name"],
        mainLocation: json["main_location"],
        totalInAppSpend: json["total_in_app_spend"],
        firstName: json["first_name"],
        profileStatus: json["profile_status"],
        role: json["role"],
        status: json["status"],
        image: json["image"],
        password: json["password"],
        visit: json["visit"],
        clientId: json["client_id"],
        membershipStatus: json["membership_status"],
        lastVisit: json["last_visit"],
        verificationCode: json["verification_code"],
        birthday: json["birthday"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "phone": phone,
        "user_email": userEmail,
        "user_id": userId,
        "visits_count": visitsCount,
        "user_name": userName,
        "flag": flag,
        "last_name": lastName,
        "main_location": mainLocation,
        "total_in_app_spend": totalInAppSpend,
        "first_name": firstName,
        "profile_status": profileStatus,
        "role": role,
        "status": status,
        "image": image,
        "password": password,
        "visit": visit,
        "client_id": clientId,
        "membership_status": membershipStatus,
        "last_visit": lastVisit,
        "verification_code": verificationCode,
        "birthday": birthday,
      };
}
