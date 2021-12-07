import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Model/ModelLoginData.dart';
import 'package:owner/Model/ModelNotificationList.dart';
import 'package:owner/Model/ModelOrderDetails.dart';
import 'package:owner/Model/ModelOrderList.dart';
import 'package:owner/Model/ModelOwnerProfile.dart';
import 'package:owner/Model/ModelProductDetails.dart';
import 'package:owner/Model/ModelResDetails.dart';
import 'package:owner/Model/ModelRestaurantList.dart';
import 'package:owner/Model/ModelReviewList.dart';
import 'package:owner/Model/ModelSubCategoryList.dart';

class Repository {
  final reqManager = Requestmanager();
  //Fetch Login Data
  Future<ResLogin> getLoginData(dynamic param) =>
      reqManager.loginRestaurantOwner(param);
  //Fetch Restaurant List Data
  Future<ResRestaurantList> fetchAllRestaurantList(String ownerId) =>
      reqManager.getRestaurantList(ownerId);
  //Fetch Restaurant details
  Future<ResRestaurantDetails> restaurantDetails(String apiURL) =>
      reqManager.getRestaurantDetails(apiURL);
//Fetch Owner Profile
  Future<ResOwnerProfile> fetchOwnerProfile(String ownerID) =>
      reqManager.fetchOwnerData(ownerID);
//Fetch OrderList
  Future<ResOrderList> fetchOrderList(String ownerID) =>
      reqManager.fetchOrderList(ownerID);
//Fetch Order Details
  Future<ResOrderDetails> fetchOrderDetails(String orderId) =>
      reqManager.getOrderDetails(orderId);
//Fetch All Restaurant Subcategory
  Future<ResSubcategoryList> fetchAllRestaurantSubcategories(String apiURL) =>
      reqManager.getAllSubcategoryList(apiURL);
//Get All Reviews
  Future<ResReviewList> fetchAllReview(String apiURL) =>
      reqManager.getRestaurantReviewList(apiURL);
  //Fetch all Notification Lists.
  Future<ResNotificationList> fetchAllNotifications(String userId) =>
      reqManager.fetchAllNotificationList(userId);
  //Fetch Product Details
  Future<ResProductDetails> fetchProductDetails(dynamic param) =>
      reqManager.fetchProductDetails(param);
}
