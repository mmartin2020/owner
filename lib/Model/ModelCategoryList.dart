import 'package:owner/BLoC/CommonBlocClass/BaseMode.dart';

class ResCategoryList extends BaseModel {
  int code;
  String message;
  List<Category> categoryList;

  ResCategoryList({this.code, this.message, this.categoryList});

  ResCategoryList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      categoryList = [];
      json['result'].forEach((v) {
        categoryList.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.categoryList != null) {
      data['result'] = this.categoryList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String categoryName;
  String image;
  String categoryId;
  String totalCount;

  Category({this.categoryName, this.image, this.categoryId, this.totalCount});

  Category.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    image = json['image'];
    categoryId = json['category_id'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['total_count'] = this.totalCount;
    return data;
  }
}
