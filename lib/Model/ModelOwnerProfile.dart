import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResOwnerProfile extends BaseModel {
  int code;
  String message;
  OwnerData ownerData;

  ResOwnerProfile({this.code, this.message, this.ownerData});

  ResOwnerProfile.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    ownerData =
        json['result'] != null ? new OwnerData.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.ownerData != null) {
      data['result'] = this.ownerData.toJson();
    }
    return data;
  }
}

class OwnerData {
  String ownerId;
  String name;
  String email;
  String profileImage;
  String phone;
  String totalOrders;
  String todaysOrders;
  String newOrders;
  String totalEarning;
  String currentMonthsEarning;

  OwnerData(
      {this.ownerId,
      this.name,
      this.email,
      this.profileImage,
      this.phone,
      this.totalOrders,
      this.todaysOrders,
      this.newOrders,
      this.totalEarning,
      this.currentMonthsEarning});

  OwnerData.fromJson(Map<String, dynamic> json) {
    ownerId = json['owner_id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    phone = json['phone'];
    totalOrders = json['total_orders'];
    todaysOrders = json['todays_orders'];
    newOrders = json['new_orders'];
    totalEarning = json['total_earnings'];
    currentMonthsEarning = json['current_month_earnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['owner_id'] = this.ownerId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['phone'] = this.phone;
    data['total_orders'] = this.totalOrders;
    data['todays_orders'] = this.todaysOrders;
    data['new_orders'] = this.newOrders;
    data['total_earnings'] = this.totalEarning;
    data['current_month_earnings'] = this.currentMonthsEarning;
    return data;
  }
}
