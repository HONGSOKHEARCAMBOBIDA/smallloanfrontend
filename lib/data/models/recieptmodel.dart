class RecieptModel {
  List<Data>? data;
  Pagination? pagination;
  bool? success;

  RecieptModel({this.data, this.pagination, this.success});

  RecieptModel.fromJson(Map<String, dynamic> json) {
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
  int? clientId;
  String? clientName;
  int? userId;
  String? userName;
  int? villageId;
  String? villageName;
  int? totalCollect;
  int? totalPenalty;
  int? penaltyDay;
  int? lumpSumPayment;

  Data(
      {this.id,
      this.clientId,
      this.clientName,
      this.userId,
      this.userName,
      this.villageId,
      this.villageName,
      this.totalCollect,
      this.totalPenalty,
      this.penaltyDay,
      this.lumpSumPayment});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    userId = json['user_id'];
    userName = json['user_name'];
    villageId = json['village_id'];
    villageName = json['village_name'];
    totalCollect = json['total_collect'];
    totalPenalty = json['total_penalty'];
    penaltyDay = json['penalty_day'];
    lumpSumPayment = json['lump_sum_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['village_id'] = this.villageId;
    data['village_name'] = this.villageName;
    data['total_collect'] = this.totalCollect;
    data['total_penalty'] = this.totalPenalty;
    data['penalty_day'] = this.penaltyDay;
    data['lump_sum_payment'] = this.lumpSumPayment;
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
