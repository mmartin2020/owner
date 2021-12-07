import 'dart:io';
import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/RestaurantDetailsBLoC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelResDetails.dart';
import 'package:owner/Screens/AddRestaurantScreen/AddRestaurantScreen.dart';
import 'package:owner/Screens/GoogleMapScreen/GoogleMapScreen.dart';
import 'package:owner/Screens/ProductDetails/ProductDetailsPage.dart';
import 'package:owner/Screens/RestaurantReviewList/ReviewListScreen.dart';
import 'package:owner/Screens/RestaurantSubcategories/RestaurantSubcategories.dart';
import 'package:owner/generated/i18n.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Helper/CommonWidgets.dart';
import '../../Helper/Constant.dart';
import 'package:share/share.dart';

class RestaurantDetailsScreen extends StatefulWidget {
  final String resId;
  RestaurantDetailsScreen({this.resId});

  @override
  _RestaurantDetailsScreenState createState() =>
      _RestaurantDetailsScreenState();
}

class _RestaurantDetailsScreenState extends State<RestaurantDetailsScreen> {
  RestaurantDetails result;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Subcategories> subcategoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    _getRestaurantDetails();
    super.initState();
  }

  _getRestaurantDetails() async {
    //
    restaurantDetailsBloc
        .fetchRestaurantDetails(APIS.resDetails + this.widget.resId);
  }

  _closeRestaurant(String resId, String status) async {
    final param = {"is_available": "$status", "shop_id": "$resId"};
    print('Close restaurant parameter:$param');

    showSnackbar('${S.current.loading}', scaffoldKey, context);
    Requestmanager manager = Requestmanager();
    await manager.closeRestaurant(param).then((value) {
      setState(() {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        restaurantDetailsBloc
            .fetchRestaurantDetails(APIS.resDetails + this.widget.resId);
      });
    });
  }

  _makeOutofStock(String id, String status) async {
    showSnackbar('${S.current.loading}', scaffoldKey, context);
    Requestmanager manager = Requestmanager();
    final param = {"status": "$status", "product_id": "$id"};

    await manager.outOfStockItem(param).then((value) {
      setState(() {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        restaurantDetailsBloc
            .fetchRestaurantDetails(APIS.resDetails + this.widget.resId);
      });
    });
  }

  // _deleteProduct(String id) async {
  //   showSnackbar('${S.current.loading}', scaffoldKey, context);
  //   Requestmanager manager = Requestmanager();
  //   await manager.deleteProduct(APIS.deleteProduct + id).then((value) {
  //     setState(() {
  //       SharedManager.shared.ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       restaurantDetailsBloc
  //           .fetchRestaurantDetails(APIS.resDetails + this.widget.resId);
  //     });
  //   });
  // }

  // _deleteRestaurant(String id) async {
  //   showSnackbar('${S.current.loading}');
  //   Requestmanager manager = Requestmanager();
  //   await manager.deleteRestaurant(APIS.deleteRestaurant + id).then((value) {
  //     setState(() {
  //       SharedManager.shared.ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       SharedManager.shared.currentIndex = 1;
  //       Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (context) => TabbarScreen()),
  //           ModalRoute.withName(AppRoute.tabbar));
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: EmptyAppBar(),
      primary: false,
      body: StreamBuilder(
          stream: restaurantDetailsBloc.restaurantDetails,
          builder: (context, AsyncSnapshot<ResRestaurantDetails> snapshot) {
            if (snapshot.hasData) {
              this.result = snapshot.data.restaurantDetails;
              _setCategoryList(result.categories);
              return Container(
                color: AppColor.white,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          _setRestaurantBanner(
                              context,
                              result.bannerImage,
                              result.name,
                              result.address,
                              result.openingTime,
                              result.closingTime,
                              result.averagePrice,
                              result.discount,
                              result.discountType,
                              result.isAvailable,
                              result.restaurantId,
                              result.phone),
                          setHeightSpace(15),
                          _setCategory(this.subcategoryList, context),
                          setHeightSpace(15),
                        ],
                      ),
                    ),
                    (result.categories.length > 0)
                        ? _setButtonSeeAll()
                        : Text('')
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      // floatingActionButton: FloatingActionButton(
      //   isExtended: true,
      //   onPressed: () {
      //     // Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      //     //     builder: (context) => AddSubCategoryScreen(
      //     //           resId: this.result.restaurantId,
      //     //           isEdit: false,
      //     //         ),
      //     //     fullscreenDialog: true));
      //   },
      //   child: Icon(Icons.add, color: AppColor.white),
      //   backgroundColor: AppColor.red,
      // ),
    );
  }

  _setButtonSeeAll() {
    return Container(
        height: 60,
        padding: EdgeInsets.only(left: 25, right: 25, top: 0, bottom: 12),
        child: InkWell(
          onTap: () async {
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => SubcategoryList(
            //           resID: this.widget.resId,
            //           resName: this.result.name,
            //         )));
            await Navigator.of(context, rootNavigator: true)
                .push(MaterialPageRoute(
                    builder: (context) => RestaurantSubcategories(
                          resID: this.widget.resId,
                          resName: this.result.name,
                        ),
                    fullscreenDialog: true))
                .then((value) {
              _getRestaurantDetails();
            });
          },
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.circular(40)),
            child: Center(
                child: setCommonText('${S.current.viewAll}', AppColor.white,
                    15.0, FontWeight.w700, 1, TextAlign.center)),
          ),
        ));
  }

  _setCategoryList(List<Categories> categoryList) {
    this.subcategoryList = [];

    for (var i = 0; i < categoryList.length; i++) {
      for (var j = 0; j < categoryList[i].subcategories.length; j++) {
        var subCat = categoryList[i].subcategories[j];
        subCat.categoryId = categoryList[i].categoryId;
        subCat.categoryName = categoryList[i].categoryName;
        if (subCat.quantity == "") {
          subCat.quantity = "0";
        }
        if (subCat.unit == "") {
          subCat.unit = "0";
        }
        this.subcategoryList.add(subCat);
      }
    }
  }

  _setCategory(List<Subcategories> subcategories, BuildContext context) {
    return Container(
      height: (subcategories.length * 145).toDouble(),
      // color: AppColor.amber,
      child: MediaQuery.removePadding(
        context: context,
        removeBottom: true,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: subcategories.length,
            itemBuilder: (context, index) {
              return Container(
                  // height: 120,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                                productId: subcategories[index].id,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: AppColor.grey[300],
                                offset: Offset(0, 0))
                          ]),
                      child: Row(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              subcategories[index].image))),
                                ),
                              ),
                            ],
                          ),
                          setWithSpace(8),
                          Expanded(
                              flex: 3,
                              child: Container(
                                // color: AppColor.amber,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Container(
                                          height: 18,
                                          width: 18,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: (subcategories[index]
                                                              .type ==
                                                          '1')
                                                      ? AppImages.vegFood
                                                      : AppImages.nonVegFood)),
                                        ),
                                        SizedBox(width: 3),
                                        Expanded(
                                          child: setCommonText(
                                              subcategories[index].name,
                                              AppColor.black,
                                              14.0,
                                              FontWeight.w500,
                                              1,
                                              TextAlign.start),
                                        )
                                      ],
                                    ),
                                    setCommonText(
                                        '${subcategories[index].categoryName}',
                                        AppColor.black87,
                                        12.0,
                                        FontWeight.w400,
                                        1,
                                        TextAlign.start),
                                    setCommonText(
                                        '${subcategories[index].description}',
                                        AppColor.grey[700],
                                        12.0,
                                        FontWeight.w400,
                                        2,
                                        TextAlign.start),
                                    setHeightSpace(8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            setCommonText(
                                                'Stock',
                                                AppColor.black87,
                                                12.0,
                                                FontWeight.w500,
                                                1,
                                                TextAlign.start),
                                            setCommonText(
                                                (int.parse('${subcategories[index].quantity}') >
                                                        0)
                                                    ? '${subcategories[index].quantity}'
                                                    : '0',
                                                AppColor.black54,
                                                10.0,
                                                FontWeight.w500,
                                                1,
                                                TextAlign.start),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            setCommonText(
                                                'U.Medida',
                                                AppColor.black87,
                                                12.0,
                                                FontWeight.w500,
                                                1,
                                                TextAlign.start),
                                            setCommonText(
                                                '${subcategories[index].unit}',
                                                AppColor.black54,
                                                10.0,
                                                FontWeight.w500,
                                                1,
                                                TextAlign.start),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            setCommonText(
                                                'Fecha Venc.',
                                                AppColor.black87,
                                                12.0,
                                                FontWeight.w500,
                                                1,
                                                TextAlign.start),
                                            setCommonText(
                                                '${subcategories[index].expDate}',
                                                AppColor.black54,
                                                10.0,
                                                FontWeight.w500,
                                                1,
                                                TextAlign.start),
                                          ],
                                        )
                                      ],
                                    ),
                                    setHeightSpace(15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: setCommonText(
                                              (int.parse('${subcategories[index].quantity}') >
                                                      0)
                                                  ? (subcategories[
                                                                  index]
                                                              .status ==
                                                          '1')
                                                      ? '${S.current.available}'
                                                      : '${S.current.out_of_stock}'
                                                  : '${S.current.out_of_stock}',
                                              (int.parse('${subcategories[index].quantity}') >
                                                      0)
                                                  ? (subcategories[index]
                                                              .status ==
                                                          '1')
                                                      ? Colors.green
                                                      : AppColor.red
                                                  : AppColor.red,
                                              12.0,
                                              FontWeight.bold,
                                              1,
                                              TextAlign.start),
                                        ),
                                        setCommonText(
                                            '${Currency.curr}${subcategories[index].price}',
                                            AppColor.black,
                                            12.0,
                                            FontWeight.bold,
                                            1,
                                            TextAlign.start),
                                      ],
                                    ),
                                    setHeightSpace(3)
                                  ],
                                ),
                              )),
                          Expanded(
                              child: Container(
                            // color: AppColor.amber,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                setHeightSpace(5),
                                InkWell(
                                  onTap: () {
                                    SharedManager.shared.showAlertDialog(
                                        '${S.current.disableDeleteFunctionality}',
                                        context);
                                    // _deleteProduct(subcategories[index].id);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColor.red,
                                    size: 20,
                                  ),
                                ),
                                (int.parse('${subcategories[index].quantity}') >
                                        0)
                                    ? Switch(
                                        value:
                                            (subcategories[index].status == '1')
                                                ? true
                                                : false,
                                        onChanged: (value) {
                                          _makeOutofStock(
                                              subcategories[index].id,
                                              (subcategories[index].status ==
                                                      '1')
                                                  ? '0'
                                                  : '1');
                                          setState(() {
                                            if (subcategories[index].status ==
                                                '1') {
                                              subcategories[index].status = '0';
                                            } else {
                                              subcategories[index].status = '1';
                                            }
                                          });
                                        })
                                    : Text(''),
                                // InkWell(
                                //   onTap: () {
                                //     // Navigator.of(context, rootNavigator: true).push(
                                //     //     MaterialPageRoute(
                                //     //         builder: (context) =>
                                //     //             AddSubCategoryScreen(
                                //     //               resId: this.result.restaurantId,
                                //     //               isEdit: true,
                                //     //               subcategory: subcategories[index],
                                //     //             ),
                                //     //         fullscreenDialog: true));
                                //   },
                                //   child: Icon(
                                //     Icons.edit,
                                //     color: AppColor.black,
                                //     size: 18,
                                //   ),
                                // ),
                                setHeightSpace(5),
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }

// Widget _setSubcategory(int count, BuildContext context, List category) {
//   List data = [];
//   for (var i = 0; i < count; i++) {
//     data.add(_setSubCategoryView(context, category));
//   }
//   return data;
// }

// 0==>flat value, 1=>percentage
  _launchCaller(String call) async {
    final url = "tel:$call";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _setRestaurantBanner(
    BuildContext context,
    String image,
    String name,
    String address,
    String open,
    String close,
    String avgCost,
    String discount,
    String type,
    String availability,
    String shopId,
    String phone,
  ) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: screenWidth(context) / 1.5,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)),
                ),
                Container(
                    padding: EdgeInsets.only(right: 8, bottom: 8),
                    height: screenWidth(context) / 1.5,
                    color: AppColor.black.withOpacity(0.3),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: InkWell(
                        onTap: () {
                          _closeRestaurant(this.widget.resId,
                              (availability == '1') ? '0' : '1');
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(20),
                            color: (availability == '1')
                                ? AppColor.themeColor.withOpacity(0.7)
                                : AppColor.red.withOpacity(0.7),
                            child: Center(
                              child: setCommonText(
                                  (availability == '1')
                                      ? '${S.current.closeRestaurant}'
                                      : '${S.current.restaurantClosed}',
                                  AppColor.white,
                                  14.0,
                                  FontWeight.w600,
                                  1,
                                  TextAlign.center),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            Container(
              // height: 70,
              padding: new EdgeInsets.only(left: 12, right: 12, top: 5),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                        // color: AppColor.red,
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        setCommonText(name, AppColor.black87, 14.0,
                            FontWeight.w500, 1, TextAlign.start),
                        setCommonText(address, AppColor.black54, 12.0,
                            FontWeight.w400, 2, TextAlign.start),
                      ],
                    )),
                  ),
                  setWithSpace(15),
                  Container(
                    height: 30,
                    width: 2,
                    color: AppColor.grey,
                  ),
                  setWithSpace(15),
                  Expanded(
                      child: Container(
                    // color: AppColor.amber,
                    child: InkWell(
                      onTap: () {
                        SharedManager.shared.latitude =
                            double.parse(result.latitude);
                        SharedManager.shared.longitude =
                            double.parse(result.longitude);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => GoogleMapScreen(
                                  resName: result.name,
                                  latitude: double.parse(result.latitude),
                                  longitude: double.parse(result.longitude),
                                )));
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.map,
                              color: AppColor.black87,
                            ),
                            setCommonText(
                                S.current.view_on_map,
                                AppColor.orange,
                                12.0,
                                FontWeight.w500,
                                2,
                                TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            setHeightSpace(10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Container(
                height: 2,
                width: screenWidth(context),
                color: AppColor.grey[300],
              ),
            ),
            setHeightSpace(10),
            Container(
              padding: new EdgeInsets.only(left: 12, right: 12),
              // height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                          child: InkWell(
                    onTap: () {
                      Share.share("https://flashliver.cf/shop-details/$shopId");
                    },
                    child: _setCommonColumn(S.current.share, Icon(Icons.share)),
                  ))),
                  Expanded(
                      flex: 2,
                      child: Container(
                          child: InkWell(
                        onTap: () {
                          _launchCaller('$phone');
                        },
                        child: _setCommonColumn(
                            S.current.contact, Icon(Icons.call)),
                      ))),
                  Expanded(
                      child: Container(
                          child: InkWell(
                    child: InkWell(
                      onTap: () {
                        if (result.avgReview != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReviewListScreen(
                                    restaurantId: result.restaurantId,
                                    restaurantName: result.name,
                                  )));
                        } else {
                          SharedManager.shared.showAlertDialog(
                              '${S.current.reviewNotFound}', context);
                        }
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              setCommonText(
                                  (result.avgReview != null)
                                      ? '${result.avgReview}'
                                      : '0.0',
                                  AppColor.orange,
                                  14.0,
                                  FontWeight.bold,
                                  1,
                                  TextAlign.center),
                              Icon(Icons.star,
                                  color: AppColor.orange, size: 16),
                            ],
                          ),
                          setCommonText(
                              '${S.current.showReview}',
                              AppColor.orange,
                              13.0,
                              FontWeight.w500,
                              1,
                              TextAlign.center),
                        ],
                      ),
                    ),
                  ))),
                ],
              ),
            ),
            setHeightSpace(10),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Container(
                height: 1,
                width: screenWidth(context),
                color: AppColor.grey[300],
              ),
            ),
            setHeightSpace(10),
            Container(
              // height: 130,
              // color: AppColor.red,
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    // color: AppColor.red,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setCommonText(
                                  'Hora de apertura:',
                                  AppColor.black87,
                                  14.0,
                                  FontWeight.w500,
                                  1,
                                  TextAlign.start),
                              SizedBox(height: 3),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColor.grey[300], width: 1),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    setCommonText('$open', AppColor.black, 13.0,
                                        FontWeight.w400, 1, TextAlign.start)
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setCommonText('Hora de cierre:', AppColor.black87,
                                  14.0, FontWeight.w500, 1, TextAlign.start),
                              SizedBox(height: 3),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColor.grey[300]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    setCommonText(
                                        '$close',
                                        AppColor.black,
                                        13.0,
                                        FontWeight.w400,
                                        1,
                                        TextAlign.start)
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  setHeightSpace(10),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    // color: AppColor.red,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              setCommonText('Descuento:', AppColor.black87,
                                  14.0, FontWeight.w500, 1, TextAlign.start),
                              SizedBox(height: 3),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: AppColor.grey[300]),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    SizedBox(width: 8),
                                    setCommonText(
                                        (type == '0')
                                            ? '${Currency.curr}$discount'
                                            : '$discount%',
                                        AppColor.black,
                                        13.0,
                                        FontWeight.w400,
                                        1,
                                        TextAlign.start)
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  setHeightSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          setCommonText(
                              S.current.availability,
                              AppColor.grey[500],
                              14.0,
                              FontWeight.w500,
                              1,
                              TextAlign.start),
                          setCommonText(
                              availability == '1'
                                  ? S.current.available
                                  : '${S.current.closed}',
                              availability == '1' ? Colors.green : AppColor.red,
                              12.0,
                              FontWeight.bold,
                              1,
                              TextAlign.start),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            setHeightSpace(10),
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0),
              child: Container(
                height: 1,
                width: screenWidth(context),
                color: AppColor.grey[300],
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            setHeightSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Platform.isAndroid
                          ? Icons.arrow_back
                          : Icons.arrow_back_ios,
                      color: AppColor.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: AppColor.white,
                        ),
                        onPressed: () {
                          SharedManager.shared.showAlertDialog(
                              '${S.current.disableDeleteFunctionality}',
                              context);
                          //Just enable bellow method
                          // _deleteRestaurant(this.widget.resId);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: AppColor.white,
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => AddRestaurantScreen(
                                        isEdit: true,
                                        resId: this.widget.resId,
                                        restaurantDetails: result,
                                      )));
                        }),
                  ],
                )
              ],
            ),
          ],
        ),
      ],
    );
  }

  _setCommonColumn(String title, Icon icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        icon,
        setCommonText(
            title, AppColor.black87, 12.0, FontWeight.w500, 2, TextAlign.center)
      ],
    );
  }
}
