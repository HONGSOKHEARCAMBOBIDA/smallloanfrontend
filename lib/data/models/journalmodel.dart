class JournalModel {
  List<Data>? data;
  Pagination? pagination;
  bool? success;

  JournalModel({this.data, this.pagination, this.success});

  JournalModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? id;
  String? transactionDate;
  int? chartAccountId;
  String? chartAccountCode;
  String? chartAccountName;
  int? debitAmount;
  int? creditAmount;
  String? description;
  int? referenceId;
  String? referenceCode;
  int? createdBy;
  String? createdByName;

  Data(
      {this.id,
      this.transactionDate,
      this.chartAccountId,
      this.chartAccountCode,
      this.chartAccountName,
      this.debitAmount,
      this.creditAmount,
      this.description,
      this.referenceId,
      this.referenceCode,
      this.createdBy,
      this.createdByName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionDate = json['transaction_date'];
    chartAccountId = json['chart_account_id'];
    chartAccountCode = json['chart_account_code'];
    chartAccountName = json['chart_account_name'];
    debitAmount = json['debit_amount'];
    creditAmount = json['credit_amount'];
    description = json['description'];
    referenceId = json['reference_id'];
    referenceCode = json['reference_code'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_date'] = this.transactionDate;
    data['chart_account_id'] = this.chartAccountId;
    data['chart_account_code'] = this.chartAccountCode;
    data['chart_account_name'] = this.chartAccountName;
    data['debit_amount'] = this.debitAmount;
    data['credit_amount'] = this.creditAmount;
    data['description'] = this.description;
    data['reference_id'] = this.referenceId;
    data['reference_code'] = this.referenceCode;
    data['created_by'] = this.createdBy;
    data['created_by_name'] = this.createdByName;
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool? hasNext;
  bool? hasPrev;

  Pagination(
      {this.page,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasNext,
      this.hasPrev});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    hasNext = json['hasNext'];
    hasPrev = json['hasPrev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['totalCount'] = this.totalCount;
    data['totalPages'] = this.totalPages;
    data['hasNext'] = this.hasNext;
    data['hasPrev'] = this.hasPrev;
    return data;
  }
}
