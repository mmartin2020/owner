import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelCategoryList.dart';
import 'package:owner/Model/ModelResDetails.dart';
import 'package:owner/Screens/TabBarScreens/TabbarScreen/TabbarScreen.dart';
import 'package:owner/generated/i18n.dart';
import 'package:image/image.dart' as Im;
import 'package:http/http.dart' as http;

class AddSubCategoryScreen extends StatefulWidget {
  final String resId;
  final bool isEdit;
  final Subcategories subcategory;

  AddSubCategoryScreen({this.resId, this.isEdit, this.subcategory});

  @override
  _AddSubCategoryScreenState createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  bool isFlat = false;
  bool isPercentage = false;
  bool isVeg = false;
  bool isNonVeg = false;
  bool isCategory = false;
  bool isImageAdded = false;

  var categoryName = '';
  var categoryId = '';

  List<Category> categories = [];
  List<String> categoryList = <String>[];

  File _image;
  final picker = ImagePicker();
  String imageString;

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery, maxHeight: 300.0, maxWidth: 300.0);

    setState(() {
      this.isImageAdded = true;
      _image = File(pickedFile.path);
    });

    Im.Image image = Im.decodeJpg(_image.readAsBytesSync());
    List<int> imageBytes = Im.PngEncoder().encodeImage(image);
    imageString = base64Encode(imageBytes);
    print('$imageString');
  }

// select category
  _seletcCategory() async {
    this.categories = [];
    this.categoryList = [];
    showSnackbar('${S.current.loading}', scaffoldKey, context);
    Requestmanager manager = Requestmanager();
    manager.getAllCategoryList(APIS.getAllCategory).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      this.categories = value.categoryList;
      for (var i = 0; i < this.categories.length; i++) {
        this.categoryList.add(this.categories[i].categoryName);
      }

      showMaterialScrollPicker(
        context: context,
        title: "${S.current.selectCategory}",
        items: this.categoryList,
        selectedItem: '',
        headerColor: AppColor.themeColor,
        onChanged: (value) => setState(() {
          this.categoryName = value;
          this.isCategory = true;

          //store country ID
          for (var j = 0; j < this.categoryList.length; j++) {
            if (this.categories[j].categoryName == value) {
              this.categoryId = this.categories[j].categoryId;
            }
          }
        }),
      );
    });
  }

//Check validation before going to add product

  bool _checkValidation() {
    if (!this.isImageAdded) {
      SharedManager.shared.showAlertDialog('${S.current.addImage}', context);
      return false;
    } else if (this.categoryId == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.selectCategory}', context);
      return false;
    } else if (nameController.text == "") {
      SharedManager.shared.showAlertDialog('${S.current.enterName}', context);
      return false;
    } else if (descriptionController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.enterDescription}', context);
      return false;
    } else if (priceController.text == "") {
      SharedManager.shared.showAlertDialog('${S.current.addPrice}', context);
      return false;
    } else if (discountController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.itemDiscount}', context);
      return false;
    } else if (!this.isFlat && !this.isPercentage) {
      SharedManager.shared.showAlertDialog('${S.current.addDiscount}', context);
      return false;
    } else if (!this.isVeg && !this.isNonVeg) {
      SharedManager.shared
          .showAlertDialog('${S.current.selectFoodType}', context);
      return false;
    }
    return true;
  }

  _addNewProduct() async {
    final param = {
      "title": nameController.text,
      "category_id": this.categoryId,
      "type": this.isFlat ? '1' : '2',
      "shop_id": this.widget.resId,
      "description": descriptionController.text,
      "discount": discountController.text,
      "discount_type": this.isPercentage ? '0' : '1',
      "price": priceController.text,
      "image": this.imageString
    };

    print(param);

    loadingShowSnackbar('${S.current.pleaseWaitProductisAdding}');
    Requestmanager manager = Requestmanager();
    var finalUrl = '';
    if (this.widget.isEdit) {
      finalUrl = APIS.updateProduct + this.widget.subcategory.id;
    } else {
      finalUrl = APIS.addNewProduct;
    }

    await manager.addRestaurantProduct(param, finalUrl).then((value) {
      if (value) {
        SharedManager.shared.currentIndex = 1;
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => TabbarScreen()),
            ModalRoute.withName(AppRoute.tabbar));
      } else {
        SharedManager.shared
            .showAlertDialog('${S.current.pleaseTryAfterSometime}', context);
      }
    });
  }

  loadingShowSnackbar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 15),
        content: new Row(
          children: <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              height: 25.0,
              width: 25.0,
            ),
            SizedBox(width: 15),
            new Expanded(
                child: setCommonText(value, AppColor.white, 17.0,
                    FontWeight.w500, 2, TextAlign.start))
          ],
        )));
  }

  _setCategoryBanner() {
    return Container(
      // height: 250,
      padding: EdgeInsets.all(12),
      // color: AppColor.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: 80,
            width: screenWidth(context),
            padding: EdgeInsets.only(left: 15),
            // color: AppColor.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                setCommonText(S.current.add_new_item, AppColor.black, 18.0,
                    FontWeight.bold, 1, TextAlign.start),
                setHeightSpace(4),
                setCommonText(S.current.add_item_note, AppColor.grey[600], 13.0,
                    FontWeight.w400, 3, TextAlign.start),
              ],
            ),
          ),
          setHeightSpace(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _image == null
                  ? this.widget.isEdit
                      ? Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(this.widget.subcategory.image),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AppImages.placeholder,
                                fit: BoxFit.cover),
                          ),
                        )
                  : Container(
                      height: 120,
                      width: 120,
                      child: Image.file(
                        _image,
                        fit: BoxFit.cover,
                      )),
              setWithSpace(20),
              InkWell(
                onTap: () {
                  // _selectImage()
                  getImage();
                },
                child: Container(
                  height: 50,
                  width: 150,
                  child: Center(
                    child: setCommonText(S.current.select_image, AppColor.white,
                        15.0, FontWeight.bold, 1, TextAlign.start),
                  ),
                  decoration: BoxDecoration(
                      color: AppColor.themeColor,
                      borderRadius: BorderRadius.circular(25)),
                ),
              )
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
                // .showAlertDialog('Validation done..', context);
                _addNewProduct();
              }
              //
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColor.themeColor,
              ),
              child: Center(
                child: setCommonText(S.current.btn_add_item, AppColor.white,
                    16.0, FontWeight.w500, 1, TextAlign.center),
              ),
            ),
          )
        ],
      ),
    );
  }

  _setAddItemFields() {
    return new Container(
      height: 600,
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
                setCommonText("${S.current.categories}", AppColor.black, 14.0,
                    FontWeight.w500, 1, TextAlign.start),
                setHeightSpace(8),
                InkWell(
                  onTap: () {
                    _seletcCategory();
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: AppColor.grey[200],
                    // height: 50,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: setCommonText(
                              this.isCategory
                                  ? this.categoryName
                                  : "${S.current.selectCategory}",
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
          setHeightSpace(15),
          Container(
            // padding: EdgeInsets.only(left: 5, right: 5),
            // height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText("${S.current.name}", AppColor.black, 14.0,
                    FontWeight.w500, 1, TextAlign.start),
                setHeightSpace(8),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    color: AppColor.grey[200],
                    // height: 50,
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: '${S.current.addproductName}',
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
            //  height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText("${S.current.itemDescription}", AppColor.black,
                    14.0, FontWeight.w500, 1, TextAlign.start),
                setHeightSpace(8),
                Container(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    decoration:
                        BoxDecoration(border: Border.all(color: AppColor.grey)),
                    // height: 80,
                    child: TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          hintText: '${S.current.additemDescription}',
                          border: InputBorder.none),
                      maxLines: 2,
                      keyboardType: TextInputType.text,
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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.itemPrice}", AppColor.black,
                          14.0, FontWeight.w500, 1, TextAlign.start),
                      setHeightSpace(8),
                      Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.grey[200],
                          //  height: 50,
                          child: TextFormField(
                            controller: priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: '320', border: InputBorder.none),
                            style: TextStyle(
                                fontFamily: SharedManager.shared.fontFamilyName,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400),
                          )),
                    ],
                  ),
                ),
                setWithSpace(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      setCommonText("${S.current.itemDiscount}", AppColor.black,
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
                                fontWeight: FontWeight.w400),
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
                                    this.isPercentage = false;
                                  });
                                }),
                            setCommonText("${S.current.flat}", AppColor.black,
                                14.0, FontWeight.w400, 1, TextAlign.start),
                          ],
                        ),
                        setWithSpace(10),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: this.isPercentage,
                                onChanged: (value) {
                                  setState(() {
                                    this.isPercentage = value;
                                    this.isFlat = false;
                                  });
                                }),
                            setCommonText(
                                "${S.current.percentage}",
                                AppColor.black,
                                13.0,
                                FontWeight.w400,
                                1,
                                TextAlign.start),
                          ],
                        ),
                      ],
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
                setCommonText("${S.current.foodType}", AppColor.black, 13.0,
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
                                value: this.isVeg,
                                onChanged: (value) {
                                  setState(() {
                                    this.isVeg = value;
                                    this.isNonVeg = false;
                                  });
                                }),
                            setCommonText("${S.current.veg}", AppColor.black,
                                13.0, FontWeight.w400, 1, TextAlign.start),
                          ],
                        ),
                        setWithSpace(10),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                value: this.isNonVeg,
                                onChanged: (value) {
                                  setState(() {
                                    this.isVeg = false;
                                    this.isNonVeg = value;
                                  });
                                }),
                            setCommonText("${S.current.nonVeg}", AppColor.black,
                                13.0, FontWeight.w400, 1, TextAlign.start),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getImageStringFromUrl(String imageUrl) async {
    http.Response response = await http.get(
      Uri.parse(imageUrl),
    );
    this.imageString = base64.encode(response.bodyBytes);
    this.isImageAdded = true;
  }

  _setupEditProductData() {
    this.categoryId = this.widget.subcategory.categoryId;
    this.isCategory = true;
    this.categoryName = this.widget.subcategory.categoryName;
    nameController.text = this.widget.subcategory.name;
    descriptionController.text = this.widget.subcategory.description;
    priceController.text = this.widget.subcategory.price;
    discountController.text = this.widget.subcategory.discount;
    _getImageStringFromUrl(this.widget.subcategory.image);

    if (this.widget.subcategory.discountType == '0') {
      this.isFlat = true;
      this.isPercentage = false;
    } else {
      this.isFlat = false;
      this.isPercentage = true;
    }

    if (this.widget.subcategory.type == '1') {
      this.isVeg = true;
      this.isNonVeg = false;
    } else {
      this.isVeg = false;
      this.isNonVeg = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (this.widget.isEdit) {
      _setupEditProductData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: commonAppbar('${S.current.addproduct}', []),
      body: Container(
        color: AppColor.white,
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
