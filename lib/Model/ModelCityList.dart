import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResCityList extends BaseModel {
  int code;
  String message;
  List<City> cityList;

  ResCityList({this.code, this.message, this.cityList});

  ResCityList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      cityList = [];
      json['result'].forEach((v) {
        cityList.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.cityList != null) {
      data['result'] = this.cityList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  String cityName;
  String cityId;

  City({this.cityName, this.cityId});

  City.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['city_id'] = this.cityId;
    return data;
  }
}
