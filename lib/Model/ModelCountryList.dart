import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResCountryList extends BaseModel {
  int code;
  String message;
  List<Country> result;

  ResCountryList({this.code, this.message, this.result});

  ResCountryList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      result = [];
      json['result'].forEach((v) {
        result.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  String countryName;
  String countryId;

  Country({this.countryName, this.countryId});

  Country.fromJson(Map<String, dynamic> json) {
    countryName = json['country_name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_name'] = this.countryName;
    data['country_id'] = this.countryId;
    return data;
  }
}
