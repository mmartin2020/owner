import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/SubcategoryListBLoC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelSubCategoryList.dart';
import 'package:owner/Screens/ProductDetails/ProductDetailsPage.dart';
import 'package:owner/generated/i18n.dart';

class RestaurantSubcategories extends StatefulWidget {
  final String resID;
  final String resName;

  RestaurantSubcategories({this.resID, this.resName});

  @override
  _RestaurantSubcategoriesState createState() =>
      _RestaurantSubcategoriesState();
}

class _RestaurantSubcategoriesState extends State<RestaurantSubcategories> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  List<ItemStatus> statusList = [
    ItemStatus('All', true),
    ItemStatus('Available', false),
    ItemStatus('Out of stock', false),
  ];

  List<AllSubcategory> subcategories = [];
  List<AllSubcategory> subcategoriesTmp = [];
  bool isFirst = true;
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _getAllSubcategories();
    super.initState();
  }

  _getAllSubcategories() async {
    subcategoryListBloc
        .fetchSubcategoryList(APIS.getSubcategories + this.widget.resID);
  }

  _setProduct(int status) {
    this.subcategories = [];
    this.isFirst = false;
    for (var product in this.subcategoriesTmp) {
      if (status == 0) {
        this.subcategories.add(product);
      }
      //This is for available
      else if (status == 1) {
        if (product.status == "1") {
          this.subcategories.add(product);
        }
      }
      //This is for outof stock
      else if (status == 2) {
        if (product.status == "0") {
          this.subcategories.add(product);
        }
      }
    }
    setState(() {});
  }

  _filterSubCategory() {
    for (var subCat in this.subcategoriesTmp) {
      if (subCat.quantity == "") {
        subCat.quantity = "0";
        subCat.unit = "0";
      }
    }
    this.subcategories = [];
    this.subcategories = this.subcategoriesTmp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: commonAppbar(this.widget.resName, []),
      body: StreamBuilder(
          stream: subcategoryListBloc.subcategoryList,
          builder: (context, AsyncSnapshot<ResSubcategoryList> snapshot) {
            if (snapshot.hasData) {
              if (isFirst) {
                subcategoriesTmp = snapshot.data.subcategoryList;
                _filterSubCategory();
              }
              return Container(
                color: AppColor.white,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      child: ListView.builder(
                          itemCount: statusList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (contect, index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  left: 5, right: 5, top: 4, bottom: 4),
                              child: InkWell(
                                onTap: () {
                                  for (var status in statusList) {
                                    status.isSelect = false;
                                  }
                                  this.statusList[index].isSelect = true;
                                  this.selectedIndex = index;
                                  this._setProduct(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColor.white,
                                      border: Border.all(
                                          color: (statusList[index].isSelect)
                                              ? AppColor.themeColor
                                              : AppColor.black54),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: setCommonText(
                                        "   ${statusList[index].status}   ",
                                        (statusList[index].isSelect)
                                            ? AppColor.themeColor
                                            : AppColor.black54,
                                        13.0,
                                        FontWeight.w500,
                                        1,
                                        TextAlign.start),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Divider(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: subcategories.length,
                          itemBuilder: (context, index) {
                            return Container(
                                padding: EdgeInsets.only(
                                    left: 8, right: 8, bottom: 4, top: 4),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailsPage(
                                                  productId:
                                                      subcategories[index].id,
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 60,
                                                width: 60,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            subcategories[index]
                                                                .image))),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Container(
                                                        height: 18,
                                                        width: 18,
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: (subcategories[index]
                                                                            .type ==
                                                                        '1')
                                                                    ? AppImages
                                                                        .vegFood
                                                                    : AppImages
                                                                        .nonVegFood)),
                                                      ),
                                                      SizedBox(width: 3),
                                                      Expanded(
                                                        child: setCommonText(
                                                            subcategories[index]
                                                                .name,
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
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          setCommonText(
                                                              'QTY.',
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          setCommonText(
                                                              'unit',
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          setCommonText(
                                                              'Exp. Date',
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
                                                  setHeightSpace(10),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Expanded(
                                                        child: setCommonText(
                                                            (subcategories[index]
                                                                        .status ==
                                                                    '1')
                                                                ? '${S.current.available}'
                                                                : '${S.current.out_of_stock}',
                                                            (subcategories[index]
                                                                        .status ==
                                                                    '1')
                                                                ? Colors.green
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
                                                  )
                                                ],
                                              ),
                                            )),
                                        Expanded(
                                            child: Container(
                                          // color: AppColor.amber,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              setHeightSpace(5),
                                              InkWell(
                                                onTap: () {
                                                  SharedManager.shared
                                                      .showAlertDialog(
                                                          '${S.current.disableDeleteFunctionality}',
                                                          context);
                                                  // _deleteProduct(
                                                  // subcategories[index].id);
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: AppColor.red,
                                                  size: 20,
                                                ),
                                              ),
                                              Switch(
                                                  value: (subcategories[index]
                                                              .status ==
                                                          '1')
                                                      ? true
                                                      : false,
                                                  onChanged: (value) {
                                                    _makeOutofStock(
                                                        subcategories[index].id,
                                                        (subcategories[index]
                                                                    .status ==
                                                                '1')
                                                            ? '0'
                                                            : '1');
                                                    setState(() {
                                                      if (subcategories[index]
                                                              .status ==
                                                          '1') {
                                                        subcategories[index]
                                                            .status = '0';
                                                      } else {
                                                        subcategories[index]
                                                            .status = '1';
                                                      }
                                                    });
                                                  }),
                                              // InkWell(
                                              //   onTap: () {
                                              //     AllSubcategory subCat =
                                              //         subcategories[index];

                                              //     Subcategories subcategory =
                                              //         Subcategories();

                                              //     subcategory.categoryId =
                                              //         subCat.categoryId;
                                              //     subcategory.categoryName =
                                              //         subCat.categoryName;
                                              //     subcategory.description =
                                              //         subCat.description;
                                              //     subcategory.discount =
                                              //         subCat.discount;
                                              //     subcategory.discountType =
                                              //         subCat.discountType;
                                              //     subcategory.id = subCat.id;
                                              //     subcategory.image = subCat.image;
                                              //     subcategory.isAvailable =
                                              //         subCat.isAvailable;
                                              //     subcategory.name = subCat.name;
                                              //     subcategory.price = subCat.price;
                                              //     subcategory.status = subCat.status;
                                              //     subcategory.type = subCat.type;

                                              //     Navigator.of(context,
                                              //             rootNavigator: true)
                                              //         .push(MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 AddSubCategoryScreen(
                                              //                   resId:
                                              //                       this.widget.resID,
                                              //                   isEdit: true,
                                              //                   subcategory:
                                              //                       subcategory,
                                              //                 ),
                                              //             fullscreenDialog: true));
                                              //   },
                                              //   child: Icon(
                                              //     Icons.edit,
                                              //     color: AppColor.black,
                                              //     size: 18,
                                              //   ),
                                              // ),
                                              setHeightSpace(8),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ));
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _makeOutofStock(String id, String status) async {
    loadingShowSnackbar('${S.current.loading}');
    Requestmanager manager = Requestmanager();
    final param = {"status": "$status", "product_id": "$id"};

    await manager.outOfStockItem(param).then((value) {
      setState(() {
        _setProduct(selectedIndex);
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        subcategoryListBloc
            .fetchSubcategoryList(APIS.getSubcategories + this.widget.resID);
      });
    });
  }

  // _deleteProduct(String id) async {
  //   loadingShowSnackbar('${S.current.loading}');
  //   Requestmanager manager = Requestmanager();
  //   await manager.deleteProduct(APIS.deleteProduct + id).then((value) {
  //     setState(() {
  //       this.ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       subcategoryListBloc
  //           .fetchSubcategoryList(APIS.getSubcategories + this.widget.resID);
  //     });
  //   });
  // }

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
}

class ItemStatus {
  String status;
  bool isSelect;
  ItemStatus(this.status, this.isSelect);
}
