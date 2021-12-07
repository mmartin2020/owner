import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/generated/i18n.dart';

class SubCategoryListScreen extends StatefulWidget {
  @override
  _SubCategoryListScreenState createState() => _SubCategoryListScreenState();
}

class _SubCategoryListScreenState extends State<SubCategoryListScreen> {
  final List subCategoryList = [
    {
      'title': 'Pizza',
      'subTitle': "Farmhouse Pizza",
      'bannerImage': 'Assets/Food/pizza.jpg',
      'descriprion': 'Medium range farmhouse pizza',
      'isAvailable': 1,
      'price': '25'
    },
    {
      'title': 'Italiyan',
      'subTitle': "Italiyan Pasta",
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'descriprion': 'Best italiyan pasta,with double gravey',
      'isAvailable': 0,
      'price': '30'
    },
    {
      'title': 'Pizza',
      'subTitle': "Farmhouse Pizza",
      'bannerImage': 'Assets/Food/pizza.jpg',
      'descriprion': 'Medium range farmhouse pizza',
      'isAvailable': 1,
      'price': '25'
    },
    {
      'title': 'Italiyan',
      'subTitle': "Italiyan Pasta",
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'descriprion': 'Best italiyan pasta,with double gravey',
      'isAvailable': 0,
      'price': '30'
    },
    {
      'title': 'Pizza',
      'subTitle': "Farmhouse Pizza",
      'bannerImage': 'Assets/Food/pizza.jpg',
      'descriprion': 'Medium range farmhouse pizza',
      'isAvailable': 1,
      'price': '25'
    },
    {
      'title': 'Italiyan',
      'subTitle': "Italiyan Pasta",
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'descriprion': 'Best italiyan pasta,with double gravey',
      'isAvailable': 0,
      'price': '30'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(S.current.subCategory, [
        // IconButton(
        //     icon: Icon(
        //       Icons.add,
        //       color: AppColor.white,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).push(MaterialPageRoute(
        //           builder: (context) => AddSubCategoryScreen()));
        //     })
      ]),
      body: Container(
        color: AppColor.white,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: subCategoryList.length,
            itemBuilder: (builder, index) {
              return Container(
                  // height: 100,
                  padding:
                      EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.grey[300],
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5)),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(subCategoryList[index]
                                          ['bannerImage']))),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                color: AppColor.black.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AppImages.nonVegFood)),
                                  )
                                ],
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
                                  setCommonText(
                                      subCategoryList[index]['subTitle'],
                                      AppColor.black87,
                                      18.0,
                                      FontWeight.w500,
                                      1,
                                      TextAlign.start),
                                  setCommonText(
                                      subCategoryList[index]['title'],
                                      AppColor.black87,
                                      15.0,
                                      FontWeight.w500,
                                      1,
                                      TextAlign.start),
                                  setCommonText(
                                      '${subCategoryList[index]['descriprion']}',
                                      AppColor.grey[700],
                                      13.0,
                                      FontWeight.w500,
                                      1,
                                      TextAlign.start),
                                  setHeightSpace(10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      setCommonText(
                                          (subCategoryList[index]
                                                      ['isAvailable'] ==
                                                  1)
                                              ? '${S.current.available}'
                                              : '${S.current.out_of_stock}',
                                          (subCategoryList[index]
                                                      ['isAvailable'] ==
                                                  1)
                                              ? Colors.green
                                              : AppColor.red,
                                          14.0,
                                          FontWeight.bold,
                                          1,
                                          TextAlign.start),
                                      setCommonText(
                                          '\$${subCategoryList[index]['price']}',
                                          AppColor.black,
                                          14.0,
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              setHeightSpace(5),
                              Icon(
                                Icons.delete,
                                color: AppColor.red,
                                size: 20,
                              ),
                              Switch(
                                  value: (subCategoryList[index]
                                              ['isAvailable'] ==
                                          1)
                                      ? true
                                      : false,
                                  onChanged: (value) {}),
                              Icon(
                                Icons.edit,
                                color: AppColor.black,
                                size: 18,
                              ),
                              setHeightSpace(5),
                            ],
                          ),
                        ))
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
