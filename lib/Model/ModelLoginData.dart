import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResLogin extends BaseModel {
  int code;
  String message;
  UserData user;

  ResLogin({this.code, this.message, this.user});

  ResLogin.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    user =
        json['result'] != null ? new UserData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.user != null) {
      data['result'] = this.user.toJson();
    }
    return data;
  }
}

class UserData {
  String id;
  String name;
  String email;
  String profileImage;
  String phone;
  String address;
  String pincode;

  UserData(
      {this.id,
      this.name,
      this.email,
      this.profileImage,
      this.phone,
      this.address,
      this.pincode});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    phone = json['phone'];
    address = json['address'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    return data;
  }
}
