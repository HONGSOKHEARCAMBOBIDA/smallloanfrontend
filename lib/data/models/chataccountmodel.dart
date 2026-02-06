class ChatAccountModel {
  List<Data>? data;

  ChatAccountModel({this.data});

  ChatAccountModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? name;
  String? description;
  int? accountTypeId;
  String? accountTypeName;
  bool? isActive;

  Data(
      {this.id,
      this.code,
      this.name,
      this.description,
      this.accountTypeId,
      this.accountTypeName,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['description'];
    description = json['description'];
    accountTypeId = json['account_type_id'];
    accountTypeName = json['account_type_name'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['description'] = this.description;
    data['account_type_id'] = this.accountTypeId;
    data['account_type_name'] = this.accountTypeName;
    data['is_active'] = this.isActive;
    return data;
  }
}
