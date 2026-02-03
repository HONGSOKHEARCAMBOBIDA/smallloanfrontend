class CashierSessionModel {
  List<Data>? data;

  CashierSessionModel({this.data});

  CashierSessionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? sessionNumber;
  int? userId;
  String? userName;
  String? sessionDate;
  String? startTime;
  String? endTime;
  int? openingBalance;
  int? closingBalance;
  int? totalReceipts;
  int? difference;
  String? status;
  String? notes;
  int? verifiedBy;
  String? verifiedByName;
  String? verifiedAt;

  Data(
      {this.id,
      this.sessionNumber,
      this.userId,
      this.userName,
      this.sessionDate,
      this.startTime,
      this.endTime,
      this.openingBalance,
      this.closingBalance,
      this.totalReceipts,
      this.difference,
      this.status,
      this.notes,
      this.verifiedBy,
      this.verifiedByName,
      this.verifiedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionNumber = json['session_number'];
    userId = json['user_id'];
    userName = json['user_name'];
    sessionDate = json['session_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    openingBalance = json['opening_balance'];
    closingBalance = json['closing_balance'];
    totalReceipts = json['total_receipts'];
    difference = json['difference'];
    status = json['status'];
    notes = json['notes'];
    verifiedBy = json['verified_by'];
    verifiedByName = json['verified_by_name'];
    verifiedAt = json['verified_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_number'] = this.sessionNumber;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['session_date'] = this.sessionDate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['opening_balance'] = this.openingBalance;
    data['closing_balance'] = this.closingBalance;
    data['total_receipts'] = this.totalReceipts;
    data['difference'] = this.difference;
    data['status'] = this.status;
    data['notes'] = this.notes;
    data['verified_by'] = this.verifiedBy;
    data['verified_by_name'] = this.verifiedByName;
    data['verified_at'] = this.verifiedAt;
    return data;
  }
}
