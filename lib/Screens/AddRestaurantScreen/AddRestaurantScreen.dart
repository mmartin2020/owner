import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelCityList.dart';
import 'package:owner/Model/ModelCountryList.dart';
import 'package:owner/Model/ModelResDetails.dart';
import 'package:owner/Model/ModelStateList.dart';
import 'package:owner/Screens/TabBarScreens/TabbarScreen/TabbarScreen.dart';
import 'package:owner/generated/i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:image/image.dart' as Im;
import 'package:http/http.dart' as http;

class AddRestaurantScreen extends StatefulWidget {
  final bool isEdit;
  final String resId;
  final RestaurantDetails restaurantDetails;

  AddRestaurantScreen({this.isEdit, this.restaurantDetails, this.resId});

  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  File _image;
  final picker = ImagePicker();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addresController = TextEditingController();
  TextEditingController averagePriceController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController openingTimeController = TextEditingController();
  TextEditingController closingTimeController = TextEditingController();

  bool isFlat = false;
  bool isDiscount = false;
  bool isImageAdded = false;
  var isCountrySelected = false;
  var isStateSelected = false;
  var isCitySelected = false;

  var countryName = '';
  var stateName = '';
  var cityName = '';

  var countryId = '';
  var stateId = '';
  var cityId = '';
  String imageString = '';

  List<Country> country = [];
  List<MyState> states = [];
  List<City> cities = [];

  List<String> countryList = <String>[];
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 350.0, maxWidth: 350.0);

    setState(() {
      isImageAdded = true;
      _image = File(pickedFile.path);
    });

    Im.Image image = Im.decodeJpg(_image.readAsBytesSync());
    List<int> imageBytes = Im.PngEncoder().encodeImage(image);
    imageString = base64Encode(imageBytes);
    print('$imageString');
  }

  _setCategoryBanner() {
    return Container(
      // height: 260,
      padding: EdgeInsets.all(12),
      // color: AppColor.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: 90,
            width: screenWidth(context),
            padding: EdgeInsets.only(left: 15),
            // color: AppColor.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                setCommonText(S.current.add_new_restaurant, AppColor.black,
                    18.0, FontWeight.bold, 1, TextAlign.start),
                setHeightSpace(4),
                setCommonText(S.current.add_res_note, AppColor.grey[600], 12.0,
                    FontWeight.w400, 3, TextAlign.start),
              ],
            ),
          ),
          setHeightSpace(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  flex: 7,
                  child: this.widget.isEdit
                      ? Container(
                          height: 120,
                          color: AppColor.amber,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(this
                                      .widget
                                      .restaurantDetails
                                      .bannerImage),
                                  fit: BoxFit.cover),
                            ),
                          ))
                      : Container(
                          height: 120,
                          color: AppColor.amber,
                          child: _image == null
                              ? Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AppImages.placeholder,
                                        fit: BoxFit.cover),
                                  ),
                                )
                              : Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                ))),
              setWithSpace(10),
              Expanded(
                  flex: 5,
                  child: Container(
                    // height: 120,
                    // color: AppColor.red,
                    child: InkWell(
                      onTap: () => getImage(),
                      child: Container(
                        height: 45,
                        width: 130,
                        child: Center(
                          child: setCommonText(
                              S.current.select_image,
                              AppColor.white,
                              14.0,
                              FontWeight.bold,
                              1,
                              TextAlign.start),
                        ),
                        decoration: BoxDecoration(
                            color: AppColor.themeColor,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  _setCategoryTitleView() {
    return new Container(
      height: 70,
      padding: new EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              bool status = _checkValidation();
              if (status) {
                // SharedManager.shared
                //     .showAlertDialog('validation done', context);
                _addRestaurant();
              }
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColor.themeColor,
              ),
              child: Center(
                child: setCommonText(S.current.btn_add_restaurant,
                    AppColor.white, 15.0, FontWeight.w500, 1, TextAlign.center),
              ),
            ),
          )
        ],
      ),
    );
  }

  _getCountryList() async {
    this.country = [];
    this.countryList = [];
    showSnackbar('${S.current.loading}', scaffoldKey, context);
    Requestmanager manager = Requestmanager();
    manager.getCountryList(APIS.getAllCountry).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      this.country = value.result;
      for (var i = 0; i < this.country.length; i++) {
        this.countryList.add(this.country[i].countryName);
      }

      showMaterialScrollPicker(
        context: context,
        title: "${S.current.select_country}",
        items: this.countryList,
        selectedItem: '',
        headerColor: AppColor.themeColor,
        onChanged: (value) => setState(() {
          this.countryName = value;
          this.isCountrySelected = true;

          //store country ID
          for (var j = 0; j < this.countryList.length; j++) {
            if (this.country[j].countryName == value) {
              this.countryId = this.country[j].countryId;
            }
          }
        }),
      );
    });
  }

  _getStateList() async {
    this.states = [];
    this.countryList = [];
    showSnackbar('${S.current.loading}', scaffoldKey, context);
    Requestmanager manager = Requestmanager();
    manager.getStateList(APIS.getAllStateList + this.countryId).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      this.states = value.stateList;
      for (var i = 0; i < this.states.length; i++) {
        this.countryList.add(this.states[i].stateName);
      }

      showMaterialScrollPicker(
        context: context,
        title: "${S.current.select_state}",
        items: this.countryList,
        selectedItem: '',
        headerColor: AppColor.themeColor,
        onChanged: (value) => setState(() {
          this.stateName = value;
          this.isStateSelected = true;

          //store country ID
          for (var j = 0; j < this.states.length; j++) {
            if (this.states[j].stateName == value) {
              this.stateId = this.states[j].stateId;
            }
          }
        }),
      );
    });
  }

  _getAllCities() async {
    this.cities = [];
    this.countryList = [];
    showSnackbar('${S.current.loading}', scaffoldKey, context);
    Requestmanager manager = Requestmanager();
    manager.getCityList(APIS.getAllCityList + this.stateId).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      this.cities = value.cityList;
      for (var i = 0; i < this.cities.length; i++) {
        this.countryList.add(this.cities[i].cityName);
      }

      showMaterialScrollPicker(
        context: context,
        title: "${S.current.select_city}",
        items: this.countryList,
        selectedItem: '',
        headerColor: AppColor.themeColor,
        onChanged: (value) => setState(() {
          this.cityName = value;
          this.isCitySelected = true;

          //store country ID
          for (var j = 0; j < this.cities.length; j++) {
            if (this.cities[j].cityName == value) {
              this.cityId = this.cities[j].cityId;
            }
          }
        }),
      );
    });
  }

  bool _checkValidation() {
    if (!this.isImageAdded) {
      SharedManager.shared.showAlertDialog('${S.current.addImage}', context);
      return false;
    } else if (nameController.text == "") {
      SharedManager.shared.showAlertDialog('${S.current.name}', context);
      return false;
    } else if (this.emailController.text == "") {
      SharedManager.shared.showAlertDialog('${S.current.enterEmail}', context);
      return false;
    } else if (this.phoneController.text == "") {
      SharedManager.shared.showAlertDialog('${S.current.enterPhone}', context);
      return false;
    } else if (this.countryId == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.select_country}', context);
      return false;
    } else if (this.stateId == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.select_state}', context);
      return false;
    } else if (this.cityId == "") {
      SharedManager.shared.showAlertDialog('${S.current.select_city}', context);
      return false;
    } else if (addresController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.enterAddress}', context);
      return false;
    } else if (openingTimeController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.addOpeningTime}', context);
      return false;
    } else if (closingTimeController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.addClosingTime}', context);
      return false;
    } else if (averagePriceController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.addAveragePrice}', context);
      return false;
    } else if (discountController.text == "") {
      SharedManager.shared.showAlertDialog('${S.current.addDiscount}', context);
      return false;
    } else if (!this.isFlat && !this.isDiscount) {
      SharedManager.shared
          .showAlertDialog('${S.current.selectDiscountType}', context);
      return false;
    }
    return true;
  }

  _addRestaurant() async {
    //validation is pending

    final param = {
      "name": nameController.text,
      "owner_id": SharedManager.shared.ownerId,
      "email": emailController.text,
      "phone": phoneController.text,
      "city_id": this.cityId,
      "state_id": this.stateId,
      "country_id": this.countryId,
      "pincode": pincodeController.text,
      "address": addresController.text,
      "discount": discountController.text,
      "discount_type": this.isFlat ? '0' : '1',
      "average_price": averagePriceController.text,
      "opening_time": openingTimeController.text,
      "closing_time": closingTimeController.text,
      "profile_image": this.imageString
    };
    print('Add restaurant parameter:$param');

    showSnackbar(
        '${S.current.pleaseWaitRestauranAdding}', scaffoldKey, context);

    Requestmanager manager = Requestmanager();

    if (this.widget.isEdit) {
      await manager
          .addRestaurant(param, APIS.updateRestaurant + this.widget.resId)
          .then((value) {
        if (value) {
          SharedManager.shared.currentIndex = 1;
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => TabbarScreen()),
              ModalRoute.withName(AppRoute.tabbar));
        } else {
          SharedManager.shared
              .showAlertDialog('${S.current.somethingGoesWrong}', context);
        }
      });
    } else {
      await manager.addRestaurant(param, APIS.addRestaurant).then((value) {
        if (value) {
          SharedManager.shared.currentIndex = 1;
          Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => TabbarScreen()),
              ModalRoute.withName(AppRoute.tabbar));
        } else {
          SharedManager.shared
              .showAlertDialog('${S.current.somethingGoesWrong}', context);
        }
      });
    }
  }

  _setAddItemFields() {
    return new Container(
      // height: 680,
      // color: AppColor.red,
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Container(
            // padding: EdgeInsets.only(left: 5, right: 5),
            // height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText(S.current.restaurant_name, AppColor.black, 15.0,
                    FontWeight.w500, 1, TextAlign.start),
                setHeightSpace(8),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: AppColor.grey[200],
                    // height: 50,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: S.current.enter_res_name,
                          border: InputBorder.none),
                      style: TextStyle(
                          fontFamily: SharedManager.shared.fontFamilyName,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          setHeightSpace(15),
          Container(
            // padding: EdgeInsets.only(left: 5, right: 5),
            // height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText("${S.current.email}", AppColor.black, 15.0,
                    FontWeight.w500, 1, TextAlign.start),
                setHeightSpace(8),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: AppColor.grey[200],
                    // height: 50,
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: '${S.current.valid_email_address}',
                          border: InputBorder.none),
                      style: TextStyle(
                          fontFamily: SharedManager.shared.fontFamilyName,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          setHeightSpace(15),
          Container(
            // padding: EdgeInsets.only(left: 5, right: 5),
            // height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText("${S.current.phone}", AppColor.black, 15.0,
                    FontWeight.w500, 1, TextAlign.start),
                setHeightSpace(8),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: AppColor.grey[200],
                    // height: 50,
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: '${S.current.valid_phone_number}',
                          border: InputBorder.none),
                      style: TextStyle(
                          fontFamily: SharedManager.shared.fontFamilyName,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          setHeightSpace(15),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  // padding: EdgeInsets.only(left: 5, right: 5),
                  // height: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.country}", AppColor.black,
                          14.0, FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      InkWell(
                        onTap: () {
                          _getCountryList();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.grey[200],
                          // height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: setCommonText(
                                    this.isCountrySelected
                                        ? this.countryName
                                        : "${S.current.select_country}",
                                    AppColor.black87,
                                    13.0,
                                    FontWeight.w400,
                                    1,
                                    TextAlign.start),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: AppColor.black87, size: 35)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              setWithSpace(15),
              Expanded(
                child: Container(
                  // padding: EdgeInsets.only(left: 5, right: 5),
                  // height: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText(S.current.state, AppColor.black, 14.0,
                          FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      InkWell(
                        onTap: () {
                          if (this.isCountrySelected) {
                            _getStateList();
                          } else {
                            SharedManager.shared.showAlertDialog(
                                '${S.current.pleaseSelectCountry}', context);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.grey[200],
                          // height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: setCommonText(
                                    this.isStateSelected
                                        ? this.stateName
                                        : S.current.select_state,
                                    AppColor.black87,
                                    12.0,
                                    FontWeight.w400,
                                    1,
                                    TextAlign.start),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: AppColor.black87, size: 35)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          setHeightSpace(15),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  // padding: EdgeInsets.only(left: 5, right: 5),
                  // height: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.city}", AppColor.black, 14.0,
                          FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      InkWell(
                        onTap: () {
                          if (this.isCountrySelected) {
                            if (this.isStateSelected) {
                              _getAllCities();
                            } else {
                              SharedManager.shared.showAlertDialog(
                                  '${S.current.pleaseSelectState}', context);
                            }
                          } else {
                            SharedManager.shared.showAlertDialog(
                                '${S.current.pleaseSelectCountry}', context);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.grey[200],
                          // height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: setCommonText(
                                    this.isCitySelected
                                        ? this.cityName
                                        : "${S.current.select_city}",
                                    AppColor.black87,
                                    12.0,
                                    FontWeight.w400,
                                    1,
                                    TextAlign.start),
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: AppColor.black87, size: 35)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              setWithSpace(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    setCommonText("${S.current.pincode}", AppColor.black, 14.0,
                        FontWeight.w500, 1, TextAlign.start),
                    setHeightSpace(8),
                    Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        color: AppColor.grey[200],
                        // height: 50,
                        child: TextFormField(
                          controller: pincodeController,
                          decoration: InputDecoration(
                              hintText: '${S.current.enter_pincode}',
                              border: InputBorder.none),
                          style: TextStyle(
                              fontFamily: SharedManager.shared.fontFamilyName,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w400),
                          keyboardType: TextInputType.number,
                        )),
                  ],
                ),
              ),
            ],
          ),
          setHeightSpace(15),
          Container(
            // padding: EdgeInsets.only(left: 5, right: 5),
            // height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    setCommonText("${S.current.address}", AppColor.black, 14.0,
                        FontWeight.w500, 1, TextAlign.start),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Container(
                      child: setCommonText(
                          '(${S.current.addProperAddress})',
                          AppColor.black54,
                          13.0,
                          FontWeight.w400,
                          2,
                          TextAlign.start),
                    ))
                  ],
                ),
                setHeightSpace(8),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration:
                        BoxDecoration(border: Border.all(color: AppColor.grey)),
                    // height: 80,
                    child: TextFormField(
                      controller: addresController,
                      decoration: InputDecoration(
                          hintText: '${S.current.add_address}',
                          border: InputBorder.none),
                      maxLines: 2,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          fontFamily: SharedManager.shared.fontFamilyName,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    )),
              ],
            ),
          ),
          setHeightSpace(15),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  // padding: EdgeInsets.only(left: 5, right: 5),
                  // height: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.opening_time}", AppColor.black,
                          14.0, FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        color: AppColor.grey[200],
                        // height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: openingTimeController,
                                decoration: InputDecoration(
                                    hintText: '8.00', border: InputBorder.none),
                                style: TextStyle(
                                    fontFamily:
                                        SharedManager.shared.fontFamilyName,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Icon(Icons.watch_later,
                                color: AppColor.black87, size: 16)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              setWithSpace(15),
              Expanded(
                child: Container(
                  // padding: EdgeInsets.only(left: 5, right: 5),
                  // height: 85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.closing_time}", AppColor.black,
                          14.0, FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      Container(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        color: AppColor.grey[200],
                        // height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: closingTimeController,
                                decoration: InputDecoration(
                                    hintText: '23.00',
                                    border: InputBorder.none),
                                style: TextStyle(
                                    fontFamily:
                                        SharedManager.shared.fontFamilyName,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            Icon(Icons.watch_later,
                                color: AppColor.black87, size: 18)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          setHeightSpace(15),
          Container(
            // padding: EdgeInsets.only(left: 5, right: 5),
            // height: 85,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.averagePrice}", AppColor.black,
                          14.0, FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.grey[200],
                          // height: 50,
                          child: TextFormField(
                            controller: averagePriceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'E.g 125', border: InputBorder.none),
                            style: TextStyle(
                                fontFamily: SharedManager.shared.fontFamilyName,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
                setWithSpace(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.discount}", AppColor.black,
                          14.0, FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.grey[200],
                          // height: 50,
                          child: TextFormField(
                            controller: discountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: '20', border: InputBorder.none),
                            style: TextStyle(
                                fontFamily: SharedManager.shared.fontFamilyName,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          setHeightSpace(15),
          Container(
            // padding: EdgeInsets.only(left: 5, right: 5),
            // height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText("${S.current.discountType}", AppColor.black, 14.0,
                    FontWeight.w500, 1, TextAlign.start),
                setHeightSpace(8),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: AppColor.grey[200],
                    // height: 50,
                    child: Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: this.isFlat,
                                onChanged: (value) {
                                  setState(() {
                                    this.isFlat = value;
                                    this.isDiscount = false;
                                  });
                                }),
                            setCommonText("${S.current.flat}", AppColor.black,
                                14.0, FontWeight.w500, 1, TextAlign.start),
                          ],
                        ),
                        setWithSpace(10),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: this.isDiscount,
                                onChanged: (value) {
                                  setState(() {
                                    this.isFlat = false;
                                    this.isDiscount = value;
                                  });
                                }),
                            setCommonText(
                                "${S.current.percentage}",
                                AppColor.black,
                                14.0,
                                FontWeight.w500,
                                1,
                                TextAlign.start),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
          setHeightSpace(25),
        ],
      ),
    );
  }

  _getImageStringFromUrl(String imageUrl) async {
    http.Response response = await http.get(
      Uri.parse(imageUrl),
    );
    this.imageString = base64.encode(response.bodyBytes);
    isImageAdded = true;
  }

  _setupEditRestaurantData() {
    nameController.text = this.widget.restaurantDetails.name;
    emailController.text = this.widget.restaurantDetails.email;
    phoneController.text = this.widget.restaurantDetails.phone;
    addresController.text = this.widget.restaurantDetails.address;
    openingTimeController.text = this.widget.restaurantDetails.openingTime;
    closingTimeController.text = this.widget.restaurantDetails.closingTime;
    averagePriceController.text = this.widget.restaurantDetails.averagePrice;
    discountController.text = this.widget.restaurantDetails.discount;

    _getImageStringFromUrl(this.widget.restaurantDetails.bannerImage);

    if (this.widget.restaurantDetails.discountType == '0') {
      this.isFlat = true;
    } else {
      this.isDiscount = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (this.widget.isEdit) {
      _setupEditRestaurantData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: commonAppbar(S.current.add_restaurant, []),
      body: Container(
        child: ListView(
          children: <Widget>[
            _setCategoryBanner(),
            setHeightSpace(20),
            _setAddItemFields(),
            _setCategoryTitleView()
          ],
        ),
      ),
    );
  }
}
