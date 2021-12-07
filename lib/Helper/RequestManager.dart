import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelCategoryList.dart';
import 'package:owner/Model/ModelCityList.dart';
import 'package:owner/Model/ModelCountryList.dart';
import 'package:owner/Model/ModelLoginData.dart';
import 'package:owner/Model/ModelNotificationList.dart';
import 'package:owner/Model/ModelOrderDetails.dart';
import 'package:owner/Model/ModelOrderList.dart';
import 'package:owner/Model/ModelOwnerProfile.dart';
import 'package:owner/Model/ModelProductDetails.dart';
import 'package:owner/Model/ModelResDetails.dart';
import 'package:owner/Model/ModelRestaurantList.dart';
import 'package:owner/Model/ModelReviewList.dart';
import 'package:owner/Model/ModelStateList.dart';
import 'package:owner/Model/ModelSubCategoryList.dart';

import 'Constant.dart';

class Requestmanager {
//Order Details
  Future<ResLogin> loginRestaurantOwner(dynamic param) async {
    http.Response response = await _apiRequest(APIS.login, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResLogin();
        object.code = 0;
        object.message = result['message'];
        object.user = UserData();
        return object;
      } else {
        return ResLogin.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Get all Restaurant List

  Future<ResRestaurantList> getRestaurantList(String ownerId) async {
    final param = {"owner_id": ownerId};

    http.Response response = await _apiRequest(APIS.resList, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant List:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResRestaurantList();
        object.code = 0;
        object.message = result['message'];
        object.restaurantList = [];
        return object;
      } else {
        return ResRestaurantList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Fetch Restaurant Details
  Future<ResRestaurantDetails> getRestaurantDetails(String apiURL) async {
    print("Restaurant Details URL:--->$apiURL");
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResRestaurantDetails();
        object.code = 0;
        object.message = result['message'];
        object.restaurantDetails = RestaurantDetails();
        return object;
      } else {
        return ResRestaurantDetails.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Fetch Owner Profile

  Future<ResOwnerProfile> fetchOwnerData(String ownerId) async {
    final param = {"owner_id": ownerId};

    http.Response response = await _apiRequest(APIS.ownerProfile, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Owner Data:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResOwnerProfile();
        object.code = 0;
        object.message = result['message'];
        object.ownerData = OwnerData();
        return object;
      } else {
        return ResOwnerProfile.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Fetch Order List
  Future<ResOrderList> fetchOrderList(String ownerId) async {
    final param = {"owner_id": ownerId};
    print("Order list parameter:$param");
    http.Response response = await _apiRequest(APIS.orderList, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order List Data:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResOrderList();
        object.code = 0;
        object.message = result['message'];
        object.orderList = [];
        return object;
      } else {
        return ResOrderList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }
//Fetch products Details

  Future<ResProductDetails> fetchProductDetails(dynamic param) async {
    // final param = {'product_id': productId};
    print("Restaurant product details ID:$param");
    print("Restaurant product details API:${APIS.productDetails}");
    http.Response response = await _apiRequest(APIS.productDetails, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant Shope Products:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResProductDetails();
        object.code = 0;
        object.message = "error";
        object.result = Result();
        return object;
      } else {
        return ResProductDetails.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Add Restaurant
  Future<bool> addRestaurant(dynamic param, String apiUrl) async {
    http.Response response = await _apiRequest(apiUrl, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order List Data:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Add Product
  Future<bool> addRestaurantProduct(dynamic param, String url) async {
    http.Response response = await _apiRequest(url, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order List Data:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Order Operations
  Future<bool> orderOperation(dynamic param) async {
    http.Response response = await _apiRequest(APIS.orderOperation, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order Operation:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Close Restaurant
  Future<bool> closeRestaurant(dynamic param) async {
    http.Response response = await _apiRequest(APIS.closeRestaurant, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order List Data:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Make outof Stock Item
  Future<bool> outOfStockItem(dynamic param) async {
    http.Response response = await _apiRequest(APIS.outofStockItem, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order List Data:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Delete Product
  Future<bool> deleteProduct(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Delete Product Status:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Delete Restaurant
  Future<bool> deleteRestaurant(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Delete Product Status:------>$result");
      final code = result['code'];
      if (code == 0) {
        return false;
      } else {
        return true;
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Fetch All Restaurant SubCategories

  Future<ResSubcategoryList> getAllSubcategoryList(String apiURL) async {
    print('Sub Category URL:$apiURL');
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResSubcategoryList();
        object.code = 0;
        object.message = result['message'];
        object.subcategoryList = [];
        return object;
      } else {
        return ResSubcategoryList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Fetch All Category List
  Future<ResCategoryList> getAllCategoryList(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResCategoryList();
        object.code = 0;
        object.message = result['message'];
        object.categoryList = [];
        return object;
      } else {
        return ResCategoryList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Fetch Order Details
  Future<ResOrderDetails> getOrderDetails(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResOrderDetails();
        object.code = 0;
        object.message = result['message'];
        object.orderData = OrderData();
        return object;
      } else {
        return ResOrderDetails.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  Future<ResNotificationList> fetchAllNotificationList(String userId) async {
    final param = {"owner_id": userId};
    http.Response response = await _apiRequest(APIS.notificationList, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final notificationList = ResNotificationList();
        notificationList.code = 0;
        notificationList.message = "Error";
        notificationList.notificationList = [];
        return notificationList;
      } else {
        return ResNotificationList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Get All Review List
  Future<ResReviewList> getRestaurantReviewList(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Review List:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResReviewList();
        object.code = 0;
        object.message = result['message'];
        object.reviewList = [];
        return object;
      } else {
        return ResReviewList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Fetch Country List
  Future<ResCountryList> getCountryList(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResCountryList();
        object.code = 0;
        object.message = result['message'];
        object.result = [];
        return object;
      } else {
        return ResCountryList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Fetch State List
  Future<ResStateList> getStateList(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResStateList();
        object.code = 0;
        object.message = result['message'];
        object.stateList = [];
        return object;
      } else {
        return ResStateList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Fetch City List
  Future<ResCityList> getCityList(String apiURL) async {
    http.Response response = await _apiRequestWithGet(apiURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Order Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        var object = ResCityList();
        object.code = 0;
        object.message = result['message'];
        object.cityList = [];
        return object;
      } else {
        return ResCityList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

  //Change Password

  Future<bool> changePassword(dynamic param, BuildContext context) async {
    http.Response response = await _apiRequest(APIS.changePassword, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else if (responseData['code'] == 4) {
        SharedManager.shared.showAlertDialog(responseData['message'], context);
        return false;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//Common Method for request api

//POST
  Future<http.Response> _apiRequest(String url, Map jsonMap) async {
    var body = jsonEncode(jsonMap);
    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: body,
    );
    print(response.body);
    return response;
  }

  //GET
  Future<http.Response> _apiRequestWithGet(String url) async {
    var response = await http.get(Uri.parse(url));
    print(response.body);
    return response;
  }
}
