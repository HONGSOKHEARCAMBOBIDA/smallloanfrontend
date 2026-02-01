class LoanCheckModel {
  List<Data>? data;

  LoanCheckModel({this.data});

  LoanCheckModel.fromJson(Map<String, dynamic> json) {
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
  int? clientId;
  String? clientName;
  String? clientImage;
  int? clientGender;
  String? clientMaritalStatus;
  String? clientDateOfBirth;
  String? clientOccupation;
  String? clientPhone;
  int? provinceId;
  String? provinceName;
  int? districtId;
  String? districtName;
  int? communceId;
  String? communceName;
  int? villageId;
  String? villageName;
  double? latitude;
  double? longitude;
  int? coId;
  String? coName;
  int? loanProductId;
  String? loanProductName;
  int? loanAmount;
  int? interestRate;
  int? processFee;
  String? approveDate;
  String? loanStartDate;
  String? loanEndDate;
  String? disbursedDate;
  int? disbursedBy;
  String? disburseByName;
  int? dailyPaymentAmount;
  String? purpose;
  String? duration;
  String? status;
  int? documentTypeId;
  String? documentTypeName;
  int? checkById;
  String? checkByName;
  int? approveById;
  String? approveByName;
  String? closeDate;
  String? closeReason;

  Data(
      {this.id,
      this.clientId,
      this.clientName,
      this.clientImage,
      this.clientGender,
      this.clientMaritalStatus,
      this.clientDateOfBirth,
      this.clientOccupation,
      this.clientPhone,
      this.provinceId,
      this.provinceName,
      this.districtId,
      this.districtName,
      this.communceId,
      this.communceName,
      this.villageId,
      this.villageName,
      this.latitude,
      this.longitude,
      this.coId,
      this.coName,
      this.loanProductId,
      this.loanProductName,
      this.loanAmount,
      this.interestRate,
      this.processFee,
      this.approveDate,
      this.loanStartDate,
      this.loanEndDate,
      this.disbursedDate,
      this.disbursedBy,
      this.disburseByName,
      this.dailyPaymentAmount,
      this.purpose,
      this.duration,
      this.status,
      this.documentTypeId,
      this.documentTypeName,
      this.checkById,
      this.checkByName,
      this.approveById,
      this.approveByName,
      this.closeDate,
      this.closeReason});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    clientName = json['client_name'];
    clientImage = json['client_image'];
    clientGender = json['client_gender'];
    clientMaritalStatus = json['client_marital_status'];
    clientDateOfBirth = json['client_date_of_birth'];
    clientOccupation = json['client_occupation'];
    clientPhone = json['client_phone'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    communceId = json['communce_id'];
    communceName = json['communce_name'];
    villageId = json['village_id'];
    villageName = json['village_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    coId = json['co_id'];
    coName = json['co_name'];
    loanProductId = json['loan_product_id'];
    loanProductName = json['loan_product_name'];
    loanAmount = json['loan_amount'];
    interestRate = json['interest_rate'];
    processFee = json['process_fee'];
    approveDate = json['approve_date'];
    loanStartDate = json['loan_start_date'];
    loanEndDate = json['loan_end_date'];
    disbursedDate = json['disbursed_date'];
    disbursedBy = json['disbursed_by'];
    disburseByName = json['disburse_by_name'];
    dailyPaymentAmount = json['daily_payment_amount'];
    purpose = json['purpose'];
    duration = json['duration'];
    status = json['status'];
    documentTypeId = json['document_type_id'];
    documentTypeName = json['document_type_name'];
    checkById = json['check_by_id'];
    checkByName = json['check_by_name'];
    approveById = json['approve_by_id'];
    approveByName = json['approve_by_name'];
    closeDate = json['close_date'];
    closeReason = json['close_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['client_name'] = this.clientName;
    data['client_image'] = this.clientImage;
    data['client_gender'] = this.clientGender;
    data['client_marital_status'] = this.clientMaritalStatus;
    data['client_date_of_birth'] = this.clientDateOfBirth;
    data['client_occupation'] = this.clientOccupation;
    data['client_phone'] = this.clientPhone;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['communce_id'] = this.communceId;
    data['communce_name'] = this.communceName;
    data['village_id'] = this.villageId;
    data['village_name'] = this.villageName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['co_id'] = this.coId;
    data['co_name'] = this.coName;
    data['loan_product_id'] = this.loanProductId;
    data['loan_product_name'] = this.loanProductName;
    data['loan_amount'] = this.loanAmount;
    data['interest_rate'] = this.interestRate;
    data['process_fee'] = this.processFee;
    data['approve_date'] = this.approveDate;
    data['loan_start_date'] = this.loanStartDate;
    data['loan_end_date'] = this.loanEndDate;
    data['disbursed_date'] = this.disbursedDate;
    data['disbursed_by'] = this.disbursedBy;
    data['disburse_by_name'] = this.disburseByName;
    data['daily_payment_amount'] = this.dailyPaymentAmount;
    data['purpose'] = this.purpose;
    data['duration'] = this.duration;
    data['status'] = this.status;
    data['document_type_id'] = this.documentTypeId;
    data['document_type_name'] = this.documentTypeName;
    data['check_by_id'] = this.checkById;
    data['check_by_name'] = this.checkByName;
    data['approve_by_id'] = this.approveById;
    data['approve_by_name'] = this.approveByName;
    data['close_date'] = this.closeDate;
    data['close_reason'] = this.closeReason;
    return data;
  }
}
