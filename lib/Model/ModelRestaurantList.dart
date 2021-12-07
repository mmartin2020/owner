import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

// class ResRestaurantList extends BaseModel {
//   int code;
//   String message;
//   List<Restaurant> restaurantList;

//   ResRestaurantList({this.code, this.message, this.restaurantList});

//   ResRestaurantList.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     if (json['result'] != null) {
//       restaurantList = new List<Restaurant>();
//       json['result'].forEach((v) {
//         restaurantList.add(new Restaurant.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.restaurantList != null) {
//       data['result'] = this.restaurantList.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Restaurant {
//   String id;
//   Null review;
//   String isAvailable;
//   String name;
//   String image;
//   String address;
//   String latitude;
//   String longitude;

//   Restaurant(
//       {this.id,
//       this.review,
//       this.isAvailable,
//       this.name,
//       this.image,
//       this.address,
//       this.latitude,
//       this.longitude});

//   Restaurant.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     review = (json['review'] != null) ? json['review'] : '';
//     isAvailable = json['is_available'];
//     name = json['name'];
//     image = json['image'];
//     address = json['address'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['review'] = this.review;
//     data['is_available'] = this.isAvailable;
//     data['name'] = this.name;
//     data['image'] = this.image;
//     data['address'] = this.address;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     return data;
//   }
// }

class ResRestaurantList extends BaseModel {
  int code;
  String message;
  List<Restaurant> restaurantList;

  ResRestaurantList({this.code, this.message, this.restaurantList});

  ResRestaurantList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      restaurantList = [];
      json['result'].forEach((v) {
        restaurantList.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.restaurantList != null) {
      data['result'] = this.restaurantList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String id;
  String review;
  String isAvailable;
  String name;
  String image;
  String address;
  String latitude;
  String longitude;

  Restaurant(
      {this.id,
      this.review,
      this.isAvailable,
      this.name,
      this.image,
      this.address,
      this.latitude,
      this.longitude});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    isAvailable = json['is_available'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['is_available'] = this.isAvailable;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
