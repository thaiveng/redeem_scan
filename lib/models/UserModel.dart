class UserModel {
  String? token;
  Staff? staff;

  UserModel({this.token, this.staff});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    return data;
  }
}

class Staff {
  String? phone;

  Staff({this.phone});

  Staff.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    return data;
  }
}
