class UserModel {
  List<Data>? data;

  UserModel({this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
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
  String? username;
  int? roleId;
  String? roleName;
  String? email;
  String? phone;
  bool? isActive;

  Data(
      {this.id,
      this.name,
      this.username,
      this.roleId,
      this.roleName,
      this.email,
      this.phone,
      this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    roleId = json['role_id'];
    roleName = json['role_name'];
    email = json['email'];
    phone = json['phone'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['is_active'] = this.isActive;
    return data;
  }
}
