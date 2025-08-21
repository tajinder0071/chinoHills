class OtpModel {
  String? message;
  bool? success;
  int? otp;

  OtpModel({
    this.message,
    this.success,
    this.otp,
  });

  factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
    message: json["message"],
    success: json["success"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "success": success,
    "otp": otp,
  };
}
