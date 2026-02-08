class IncomeStateMenModel {
  Data? data;

  IncomeStateMenModel({this.data});

  IncomeStateMenModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalIncome;
  int? totalExpense;

  Data({this.totalIncome, this.totalExpense});

  Data.fromJson(Map<String, dynamic> json) {
    totalIncome = json['total_income'];
    totalExpense = json['total_expense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_income'] = this.totalIncome;
    data['total_expense'] = this.totalExpense;
    return data;
  }
}
