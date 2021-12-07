import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/RestaurantReviewsBLoC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Model/ModelReviewList.dart';

class ReviewListScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  ReviewListScreen({this.restaurantId, this.restaurantName});

  @override
  _ReviewListScreenState createState() => _ReviewListScreenState();
}

class _ReviewListScreenState extends State<ReviewListScreen> {
  @override
  void initState() {
    super.initState();
    restaurantReviewBloC.fetchAllRestaurantReviews(
        APIS.getAllReviews + this.widget.restaurantId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        title: setCommonText('${this.widget.restaurantName}', AppColor.white,
            20.0, FontWeight.w500, 1, TextAlign.start),
      ),
      body: StreamBuilder(
          stream: restaurantReviewBloC.reviewList,
          builder: (context, AsyncSnapshot<ResReviewList> snapshot) {
            if (snapshot.hasData) {
              List<Reviews> reviewList = snapshot.data.reviewList;
              return Container(
                child: new ListView.builder(
                    itemCount: reviewList.length,
                    itemBuilder: (context, index) {
                      return new Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 60,
                              child: new Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Center(
                                          child: CircleAvatar(
                                            radius: 22,
                                            backgroundImage: NetworkImage(
                                                reviewList[index].userImage),
                                          ),
                                        ),
                                      )),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      // color: Colors.green,
                                      child: new Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              '${reviewList[index].userName}',
                                              AppColor.black87,
                                              16.0,
                                              FontWeight.w500,
                                              1,
                                              TextAlign.start),
                                          setCommonText(
                                              '${reviewList[index].city}',
                                              AppColor.grey[700],
                                              13.0,
                                              FontWeight.w400,
                                              2,
                                              TextAlign.start),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Container(
                                        // color:Colors.blue,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                setCommonText(
                                                    (reviewList[index].review !=
                                                            null)
                                                        ? reviewList[index]
                                                            .review
                                                        : '0.0',
                                                    AppColor.black,
                                                    16.0,
                                                    FontWeight.bold,
                                                    1,
                                                    TextAlign.start),
                                                Icon(Icons.star,
                                                    color: AppColor.orange,
                                                    size: 17)
                                              ],
                                            ),
                                            setCommonText(
                                                '${reviewList[index].date}',
                                                AppColor.grey[700],
                                                13.0,
                                                FontWeight.w400,
                                                1,
                                                TextAlign.start),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            setCommonText(
                                '${reviewList[index].message}',
                                AppColor.black87,
                                14.0,
                                FontWeight.w400,
                                10,
                                TextAlign.start),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(color: AppColor.grey),
                          ],
                        ),
                      );
                    }),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
