class BalanchsheetModel {
  Data? data;

  BalanchsheetModel({this.data});

  BalanchsheetModel.fromJson(Map<String, dynamic> json) {
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
  String? reportTitle;
  String? reportDate;
  Assets? assets;
  Liabilities? liabilities;
  Assets? equity;
  Totals? totals;
  String? message;

  Data(
      {this.reportTitle,
      this.reportDate,
      this.assets,
      this.liabilities,
      this.equity,
      this.totals,
      this.message});

  Data.fromJson(Map<String, dynamic> json) {
    reportTitle = json['report_title'];
    reportDate = json['report_date'];
    assets =
        json['assets'] != null ? new Assets.fromJson(json['assets']) : null;
    liabilities = json['liabilities'] != null
        ? new Liabilities.fromJson(json['liabilities'])
        : null;
    equity =
        json['equity'] != null ? new Assets.fromJson(json['equity']) : null;
    totals =
        json['totals'] != null ? new Totals.fromJson(json['totals']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['report_title'] = this.reportTitle;
    data['report_date'] = this.reportDate;
    if (this.assets != null) {
      data['assets'] = this.assets!.toJson();
    }
    if (this.liabilities != null) {
      data['liabilities'] = this.liabilities!.toJson();
    }
    if (this.equity != null) {
      data['equity'] = this.equity!.toJson();
    }
    if (this.totals != null) {
      data['totals'] = this.totals!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Assets {
  String? title;
  List<Accounts>? accounts;
  int? total;

  Assets({this.title, this.accounts, this.total});

  Assets.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(new Accounts.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.accounts != null) {
      data['accounts'] = this.accounts!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class Accounts {
  String? accountCode;
  String? accountName;
  int? balance;

  Accounts({this.accountCode, this.accountName, this.balance});

  Accounts.fromJson(Map<String, dynamic> json) {
    accountCode = json['account_code'];
    accountName = json['account_name'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['balance'] = this.balance;
    return data;
  }
}

class Liabilities {
  String? title;
  Null? accounts;
  int? total;

  Liabilities({this.title, this.accounts, this.total});

  Liabilities.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    accounts = json['accounts'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['accounts'] = this.accounts;
    data['total'] = this.total;
    return data;
  }
}

class Totals {
  int? totalAssets;
  int? totalLiabilities;
  int? totalEquity;
  int? totalLiabilitiesEquity;
  bool? isBalanced;
  int? difference;

  Totals(
      {this.totalAssets,
      this.totalLiabilities,
      this.totalEquity,
      this.totalLiabilitiesEquity,
      this.isBalanced,
      this.difference});

  Totals.fromJson(Map<String, dynamic> json) {
    totalAssets = json['total_assets'];
    totalLiabilities = json['total_liabilities'];
    totalEquity = json['total_equity'];
    totalLiabilitiesEquity = json['total_liabilities_equity'];
    isBalanced = json['is_balanced'];
    difference = json['difference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_assets'] = this.totalAssets;
    data['total_liabilities'] = this.totalLiabilities;
    data['total_equity'] = this.totalEquity;
    data['total_liabilities_equity'] = this.totalLiabilitiesEquity;
    data['is_balanced'] = this.isBalanced;
    data['difference'] = this.difference;
    return data;
  }
}
