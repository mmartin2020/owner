import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Screens/AddCategoryScreen/AddCategoryScreen.dart';
import 'package:owner/generated/i18n.dart';

class CategoryListScreen extends StatefulWidget {
  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final List categoryList = [
    {
      'title': 'Pizza',
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'count': '5',
      'isAvailable': 1
    },
    {
      'title': 'Italiyan',
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'count': '8',
      'isAvailable': 0
    },
    {
      'title': 'Pizza',
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'count': '5',
      'isAvailable': 1
    },
    {
      'title': 'Italiyan',
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'count': '8',
      'isAvailable': 0
    },
    {
      'title': 'Pizza',
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'count': '5',
      'isAvailable': 1
    },
    {
      'title': 'Italiyan',
      'bannerImage': 'Assets/Dashboard/restaurant.jpg',
      'count': '8',
      'isAvailable': 0
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(S.current.categories, [
        IconButton(
            icon: Icon(
              Icons.add,
              color: AppColor.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddCategoryScreen()));
            })
      ]),
      body: Container(
        color: AppColor.white,
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: categoryList.length,
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
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      categoryList[index]['bannerImage']))),
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
                                      categoryList[index]['title'],
                                      AppColor.black87,
                                      18.0,
                                      FontWeight.w500,
                                      1,
                                      TextAlign.start),
                                  setCommonText(
                                      '${categoryList[index]['count']} ${S.current.items}',
                                      AppColor.grey[700],
                                      16.0,
                                      FontWeight.w500,
                                      1,
                                      TextAlign.start),
                                  setHeightSpace(10),
                                  setCommonText(
                                      (categoryList[index]['isAvailable'] == 1)
                                          ? '${S.current.available}'
                                          : '${S.current.out_of_stock}',
                                      (categoryList[index]['isAvailable'] == 1)
                                          ? Colors.green
                                          : AppColor.red,
                                      15.0,
                                      FontWeight.bold,
                                      1,
                                      TextAlign.start),
                                ],
                              ),
                            )),
                        Expanded(
                            child: Container(
                          // color: AppColor.amber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColor.red,
                                    size: 20,
                                  ),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColor.black,
                                    size: 18,
                                  ),
                                  onPressed: () {})
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
