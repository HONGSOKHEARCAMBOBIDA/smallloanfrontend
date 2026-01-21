class ViewClientModel {
  List<Data>? data;

  ViewClientModel({this.data});

  ViewClientModel.fromJson(Map<String, dynamic> json) {
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
  int? gender;
  String? maritalStatus;
  String? dateOfBirth;
  String? occupation;
  String? idCardNumber;
  String? phone;
  int? villageId;
  double? latitude;
  double? longitude;
  String? imagePath;
  String? notes;
  bool? isActive;
  int? createdBy;

  Data(
      {this.id,
      this.name,
      this.gender,
      this.maritalStatus,
      this.dateOfBirth,
      this.occupation,
      this.idCardNumber,
      this.phone,
      this.villageId,
      this.latitude,
      this.longitude,
      this.imagePath,
      this.notes,
      this.isActive,
      this.createdBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    maritalStatus = json['marital_status'];
    dateOfBirth = json['date_of_birth'];
    occupation = json['occupation'];
    idCardNumber = json['id_card_number'];
    phone = json['phone'];
    villageId = json['village_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    imagePath = json['image_path'];
    notes = json['notes'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
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
    data['village_id'] = this.villageId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['image_path'] = this.imagePath;
    data['notes'] = this.notes;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    return data;
  }
}
