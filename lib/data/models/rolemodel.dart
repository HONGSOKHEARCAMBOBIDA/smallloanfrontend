class RoleModel {
  List<Data>? data;

  RoleModel({this.data});

  RoleModel.fromJson(Map<String, dynamic> json) {
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
  String? displayName;
  bool? isActive;
  Null? permissions;

  Data({this.id, this.name, this.displayName, this.isActive, this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['display_name'];
    isActive = json['is_active'];
    permissions = json['Permissions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['is_active'] = this.isActive;
    data['Permissions'] = this.permissions;
    return data;
  }
}
