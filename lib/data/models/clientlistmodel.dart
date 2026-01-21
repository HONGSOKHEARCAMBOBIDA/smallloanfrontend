class ListClientModel {
  List<Data>? data;
  Pagination? pagination;
  bool? success;

  ListClientModel({this.data, this.pagination, this.success});

  ListClientModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  int? gender;
  String? maritalStatus;
  String? dateOfBirth;
  String? occupation;
  String? idCardNumber;
  String? phone;
  double? latitude;
  double? longitude;
  String? imagePath;
  String? notes;
  bool? isActive;
  int? createdBy;
  String? createByName;
  int? provinceId;
  String? provinceName;
  int? districtId;
  String? districtName;
  int? communceId;
  String? communceName;
  int? villageId;
  String? villageName;

  Data(
      {this.id,
      this.name,
      this.gender,
      this.maritalStatus,
      this.dateOfBirth,
      this.occupation,
      this.idCardNumber,
      this.phone,
      this.latitude,
      this.longitude,
      this.imagePath,
      this.notes,
      this.isActive,
      this.createdBy,
      this.createByName,
      this.provinceId,
      this.provinceName,
      this.districtId,
      this.districtName,
      this.communceId,
      this.communceName,
      this.villageId,
      this.villageName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    dateOfBirth = json['date_of_birth'];
    occupation = json['occupation'];
    idCardNumber = json['id_card_number'];
    phone = json['phone'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    imagePath = json['image_path'];
    notes = json['notes'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createByName = json['create_by_name'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    communceId = json['communce_id'];
    communceName = json['communce_name'];
    villageId = json['village_id'];
    villageName = json['village_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['marital_status'] = this.maritalStatus;
    data['date_of_birth'] = this.dateOfBirth;
    data['occupation'] = this.occupation;
    data['id_card_number'] = this.idCardNumber;
    data['phone'] = this.phone;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image_path'] = this.imagePath;
    data['notes'] = this.notes;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['create_by_name'] = this.createByName;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['communce_id'] = this.communceId;
    data['communce_name'] = this.communceName;
    data['village_id'] = this.villageId;
    data['village_name'] = this.villageName;
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
