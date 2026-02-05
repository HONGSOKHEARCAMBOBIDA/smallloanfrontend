class RecieptListModel {
  List<Data>? data;
  Pagination? pagination;
  bool? success;

  RecieptListModel({this.data, this.pagination, this.success});

  RecieptListModel.fromJson(Map<String, dynamic> json) {
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
  int? loanId;
  String? clientName;
  String? clientImage;
  String? coName;
  String? receiptDate;
  int? totalAmount;
  String? notes;
  int? principalAmount;
  int? interestAmount;
  int? penaltyAmount;
  String? receiveByName;

  Data(
      {this.id,
      this.loanId,
      this.clientName,
      this.clientImage,
      this.coName,
      this.receiptDate,
      this.totalAmount,
      this.notes,
      this.principalAmount,
      this.interestAmount,
      this.penaltyAmount,
      this.receiveByName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loanId = json['loan_id'];
    clientName = json['client_name'];
    clientImage = json['client_image'];
    coName = json['co_name'];
    receiptDate = json['receipt_date'];
    totalAmount = json['total_amount'];
    notes = json['notes'];
    principalAmount = json['principal_amount'];
    interestAmount = json['interest_amount'];
    penaltyAmount = json['penalty_amount'];
    receiveByName = json['receive_by_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loan_id'] = this.loanId;
    data['client_name'] = this.clientName;
    data['client_image'] = this.clientImage;
    data['co_name'] = this.coName;
    data['receipt_date'] = this.receiptDate;
    data['total_amount'] = this.totalAmount;
    data['notes'] = this.notes;
    data['principal_amount'] = this.principalAmount;
    data['interest_amount'] = this.interestAmount;
    data['penalty_amount'] = this.penaltyAmount;
    data['receive_by_name'] = this.receiveByName;
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
