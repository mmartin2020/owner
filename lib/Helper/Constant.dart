import 'package:flutter/material.dart';

//All Api placed in this class.
//Just replace with existing base url here.
class APIS {
  static var baseurl = "https://flashliver.cf/owners_service/";

  //LOGIN
  static var login = baseurl + "login";
  //Restaurants LIST
  static var resList = baseurl + "shop_list";
  //Restaurnat Details
  static var resDetails = baseurl + 'details/';
  //Owner Profile
  static var ownerProfile = baseurl + 'profile';
  //Order List
  static var orderList = baseurl + 'orders_list';
  //Order Details
  static var orderDetails = baseurl + 'order_details/';
  //Change Password
  static var changePassword = baseurl + 'change_password';
  //Get Country List
  static var getAllCountry = baseurl + 'getCountry';
  //Get State List
  static var getAllStateList = baseurl + 'getState/';
  //Get City List
  static var getAllCityList = baseurl + 'getCity/';
  //Add Restaurant
  static var addRestaurant = baseurl + 'addUpdateShop';
  //Update Restaurant
  static var updateRestaurant = baseurl + 'addUpdateShop/';
  //Add Product
  static var addNewProduct = baseurl + 'addUpdateProduct';
  //Update Product
  static var updateProduct = baseurl + 'addUpdateProduct/';
  //Category List
  static var getAllCategory = baseurl + 'categories';
  //All SubcategoryList
  static var getSubcategories = baseurl + 'mealDeal/';
  //Close Restaurant
  static var closeRestaurant = baseurl + 'change_shop_availability';
  //OutofStock Item
  static var outofStockItem = baseurl + 'change_product_availability';
  //Delete Product
  static var deleteProduct = baseurl + 'delete_product/';
  //Delete Retaurant
  static var deleteRestaurant = baseurl + 'delete_shop/';
  //Restaurat Review
  static var getAllReviews = baseurl + 'get_all_review/';
  //Order Operations
  static var orderOperation = baseurl + 'accept_decline_order';
  //Notification List
  static var notificationList = baseurl + 'notifications';
  //Get Product Details
  static var productDetails = baseurl + 'product_details';
}

//We have used Shared preferance for storing some low level data.
//For this we have used this keys.
class DefaultKeys {
  static var userName = "name";
  static var userEmail = "email";
  static var userId = "userId";
  static var userImage = "image";
  static var userAddress = "address";
  static var userPhone = "phone";
  static var userPin = "pin";
  static var isLoggedIn = "isLoogedIn";
  static var pushToken = "firebaseToken";
}

//This is the app colors.
//You can change your theme color based on your requirements.
//This is the main application theme color.
class AppColor {
  static var themeColor = hexToColor('#5ec3a8');
  static var pagingIndicatorColor = Colors.red;
  static var black = Colors.black;
  static var orangeDeep = Colors.deepOrange;
  static var colorGyay_100 = Colors.grey[100];
  static var white = Colors.white;
  static var amber = Colors.amber;
  static var grey = Colors.grey;
  static var black87 = Colors.black87;
  static var red = Colors.red;
  static var black38 = Colors.black38;
  static var deepOrange = Colors.deepOrange;
  static var black54 = Colors.black54;
  static var orange = Colors.orange;
  static var teal = Colors.teal;
  static var facebookBG = hexToColor("#5B7CB4"); //Facebook icon color
  static var googleBG = hexToColor("#D95946"); //Google plus icon color

  // You can use sample theme color

  // static var themeColor = hexToColor('#bd333d'); //this is icon bg color.
  // static var themeColor = HexToColor("#79CABD");
  // static var themeColor = HexToColor("#f2bd68");
  // static var themeColor = HexToColor("#9468f2");
  // static var themeColor = HexToColor("#f268b4");
  // static var themeColor = HexToColor("#f26868");

}

//Convert color from hax color.
class HexToColor extends Color {
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }

  HexToColor(final String code) : super(_hexToColor(code));
}

//Important Images path we have used in application.
class AppImages {
  static var ob1 = AssetImage('Assets/OnBoarding1.png');
  static var ob2 = AssetImage('Assets/OnBoarding2.png');
  static var ob3 = AssetImage('Assets/OnBoarding3.png');
  static var appLogo = AssetImage('Assets/AppLogo/owner.png');
  static var resBanner = AssetImage('Assets/Dashboard/restaurant.jpg');
  static var addRestaurant = AssetImage('Assets/Dashboard/resBanner.jpg');
  static var vegFood = AssetImage('Assets/Food/veg.png');
  static var nonVegFood = AssetImage('Assets/Food/nonVeg.png');
  static var profile = AssetImage('Assets/Profile/myProfile.png');
  static var changePasswordSuccess =
      AssetImage('Assets/changePassword/passwordSuccess.png');
  static var mail = AssetImage('Assets/Success/mail.png');
  static var placeholder = AssetImage('Assets/AddRestaurant/placeholder.jpg');
}

class AppRoute {
  static const dashboard = '/dashboard';
  static const tabbar = '/tabbar';
  static const login = '/login';
  static const signUp = '/signUp';
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

setHeightSpace(double height) {
  return SizedBox(height: height);
}

setWithSpace(double width) {
  return SizedBox(
    width: width,
  );
}

class Currency {
  static const curr = '\$';
  // static const curr = '₹';
  // static const curr = ''';
}
