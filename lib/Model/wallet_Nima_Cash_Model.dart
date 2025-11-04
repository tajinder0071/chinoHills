class WalletNimaCashModel {
  bool? success;
  var nimaCashBalance;
  List<NimaCashHistory>? nimaCashHistory;

  WalletNimaCashModel(
      {this.success, this.nimaCashBalance, this.nimaCashHistory});

  WalletNimaCashModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    nimaCashBalance = (json['nima_cash_balance'] is int)
        ? json['nima_cash_balance'].toDouble()
        : double.tryParse(json['nima_cash_balance'].toString()) ?? 0.0;
    if (json['nima_cash_history'] != null) {
      nimaCashHistory = <NimaCashHistory>[];
      json['nima_cash_history'].forEach((v) {
        nimaCashHistory!.add(new NimaCashHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['nima_cash_balance'] = this.nimaCashBalance;
    if (this.nimaCashHistory != null) {
      data['nima_cash_history'] =
          this.nimaCashHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NimaCashHistory {
  String? notes;
  String? rewardId;
  String? balanceType;
  String? orderId;
  var amount;
  String? membershipId;
  String? changeDate;

  NimaCashHistory(
      {this.notes,
        this.rewardId,
        this.balanceType,
        this.orderId,
        this.amount,
        this.membershipId,
        this.changeDate});

  NimaCashHistory.fromJson(Map<String, dynamic> json) {
    notes = json['notes']?.toString();
    rewardId = json['reward_id']?.toString();
    balanceType = json['balance_type']?.toString();
    orderId = json['order_id']?.toString();
    amount = (json['amount'] is int)
        ? json['amount'].toDouble()
        : double.tryParse(json['amount'].toString()) ?? 0.0;
    membershipId = json['membership_id']?.toString();
    changeDate = json['change_date']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes'] = this.notes;
    data['reward_id'] = this.rewardId;
    data['balance_type'] = this.balanceType;
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['membership_id'] = this.membershipId;
    data['change_date'] = this.changeDate;
    return data;
  }
}
