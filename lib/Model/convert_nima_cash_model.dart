class RewardConvertNimaCashModel {
  String? message;
  bool? success;
  Data? data;

  RewardConvertNimaCashModel({this.message, this.success, this.data});

  RewardConvertNimaCashModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? rewardId;
  int? clientId;
  String? nimaCash;
  int? userId;

  Data({this.rewardId, this.clientId, this.nimaCash, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    rewardId = json['reward_id'];
    clientId = json['client_id'];
    nimaCash = json['nima_cash'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reward_id'] = this.rewardId;
    data['client_id'] = this.clientId;
    data['nima_cash'] = this.nimaCash;
    data['user_id'] = this.userId;
    return data;
  }
}
