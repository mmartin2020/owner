import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResSubcategoryList extends BaseModel {
  int code;
  String message;
  List<AllSubcategory> subcategoryList;

  ResSubcategoryList({this.code, this.message, this.subcategoryList});

  ResSubcategoryList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      subcategoryList = [];
      json['result'].forEach((v) {
        subcategoryList.add(new AllSubcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.subcategoryList != null) {
      data['result'] = this.subcategoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllSubcategory {
  String id;
  String name;
  String categoryId;
  String categoryName;
  String isAvailable;
  String status;
  String restaurantName;
  String image;
  String price;
  String discount;
  String latitude;
  String longitude;
  String discountType;
  String description;
  String type;
  String unit;
  String expDate;
  String quantity;

  AllSubcategory({
    this.id,
    this.name,
    this.categoryId,
    this.categoryName,
    this.isAvailable,
    this.status,
    this.restaurantName,
    this.image,
    this.price,
    this.discount,
    this.latitude,
    this.longitude,
    this.discountType,
    this.description,
    this.type,
    this.unit,
    this.expDate,
    this.quantity,
  });

  AllSubcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    isAvailable = json['is_available'];
    status = json['status'];
    restaurantName = json['shop_name'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    description = json['description'];
    longitude = json['longitude'];
    type = json['type'];
    unit = json['unit'];
    expDate = json['expiry_date'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['is_available'] = this.isAvailable;
    data['status'] = this.status;
    data['shop_name'] = this.restaurantName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['discount_type'] = this.discountType;
    data['description'] = this.description;
    data['type'] = this.type;
    data['unit'] = this.unit;
    data['expiry_date'] = this.expDate;
    data['quantity'] = this.quantity;
    return data;
  }
}
