import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResStateList extends BaseModel {
  int code;
  String message;
  List<MyState> stateList;

  ResStateList({this.code, this.message, this.stateList});

  ResStateList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      stateList = [];
      json['result'].forEach((v) {
        stateList.add(new MyState.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.stateList != null) {
      data['result'] = this.stateList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyState {
  String stateName;
  String stateId;

  MyState({this.stateName, this.stateId});

  MyState.fromJson(Map<String, dynamic> json) {
    stateName = json['state_name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_name'] = this.stateName;
    data['state_id'] = this.stateId;
    return data;
  }
}
