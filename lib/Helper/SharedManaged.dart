import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:owner/Helper/Constant.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  static final SharedManager shared = SharedManager._internal();

  factory SharedManager() {
    return shared;
  }

  SharedManager._internal();

  var fontFamilyName = "Quicksand";
  bool isRTL = false;
  var direction = TextDirection.ltr;
  bool isFromTab = true;
  var currentIndex = 1;
  var ownerId = "";
  double latitude;
  double longitude;
  //Set Distance Radius.
  //Order is only applicable between 15kms.

  double distanceFilter = 15.0;
  String token = "";

  String resName = 'Mocha Restaurant';
  String resAddress =
      'Shindhu Bhavan Road,S.G highway,Near iscon cross road, Ahmedabad 380060';

  ValueNotifier<Locale> locale = new ValueNotifier(Locale('en', ''));

  storeLocationCoordinate(LatLng coordinates) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (coordinates.latitude != 0.0 || coordinates.longitude != 0.0) {
      await prefs.setDouble("latitude", coordinates.latitude);
      await prefs.setDouble("longitude", coordinates.longitude);
    }
  }

  Future<LatLng> getLocationCoordinate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final latitude = prefs.get("latitude");
    final longitude = prefs.get("longitude");
    var latlong = LatLng(latitude, longitude);

    return latlong;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  Future<String> getPushToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get(DefaultKeys.pushToken);
    if (token != null) {
      return token;
    }
    return "";
  }

  Future<String> userName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = prefs.get(DefaultKeys.userName);
    if (name != null) {
      return name;
    }
    return "";
  }

  Future<String> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLoogedIn = prefs.get(DefaultKeys.isLoggedIn);
    if (isLoogedIn != null) {
      return isLoogedIn;
    }
    return "no";
  }

  Future<String> userEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.get(DefaultKeys.userEmail);
    if (email != null) {
      return email;
    }
    return "";
  }

  Future<String> userImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userImage = prefs.get(DefaultKeys.userImage);
    if (userImage != null) {
      return userImage;
    }
    return "";
  }

  Future<String> userPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userPhone = prefs.get(DefaultKeys.userPhone);
    if (userPhone != null) {
      return userPhone;
    }
    return "";
  }

  Future<String> userId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = prefs.get(DefaultKeys.userId);
    if (userId != null) {
      return userId;
    }
    return "";
  }

  Future<String> userAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userAddress = prefs.get(DefaultKeys.userAddress);
    if (userAddress != null) {
      return userAddress;
    }
    return "";
  }

  storeString(String value, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getStrng(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.get(key);
    if (value != null) {
      return value;
    } else {
      return "";
    }
  }

  void showAlertDialog(String message, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Flashliver - Tienda"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//Calculate Distance between two location.

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
