import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResReviewList extends BaseModel {
  int code;
  String message;
  List<Reviews> reviewList;

  ResReviewList({this.code, this.message, this.reviewList});

  ResReviewList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      reviewList = [];
      json['result'].forEach((v) {
        reviewList.add(new Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.reviewList != null) {
      data['result'] = this.reviewList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String review;
  String message;
  String userName;
  String city;
  String userImage;
  String date;

  Reviews(
      {this.review,
      this.message,
      this.userName,
      this.city,
      this.userImage,
      this.date});

  Reviews.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    message = json['message'];
    userName = json['user_name'];
    city = json['city'];
    userImage = json['user_image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['message'] = this.message;
    data['user_name'] = this.userName;
    data['city'] = this.city;
    data['user_image'] = this.userImage;
    data['date'] = this.date;
    return data;
  }
}
