class LoanProductModel {
  List<Data>? data;

  LoanProductModel({this.data});

  LoanProductModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? description;
  int? interestRate;
  int? processFeeRate;
  int? termDays;
  String? paymentFrequency;
  bool? skipWeekend;
  int? latePenaltyFixed;
  int? gracePeriodDays;
  bool? isActive;

  Data(
      {this.id,
      this.name,
      this.description,
      this.interestRate,
      this.processFeeRate,
      this.termDays,
      this.paymentFrequency,
      this.skipWeekend,
      this.latePenaltyFixed,
      this.gracePeriodDays,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    interestRate = json['interest_rate'];
    processFeeRate = json['process_fee_rate'];
    termDays = json['term_days'];
    paymentFrequency = json['payment_frequency'];
    skipWeekend = json['skip_weekend'];
    latePenaltyFixed = json['late_penalty_fixed'];
    gracePeriodDays = json['grace_period_days'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['interest_rate'] = this.interestRate;
    data['process_fee_rate'] = this.processFeeRate;
    data['term_days'] = this.termDays;
    data['payment_frequency'] = this.paymentFrequency;
    data['skip_weekend'] = this.skipWeekend;
    data['late_penalty_fixed'] = this.latePenaltyFixed;
    data['grace_period_days'] = this.gracePeriodDays;
    data['is_active'] = this.isActive;
    return data;
  }
}
