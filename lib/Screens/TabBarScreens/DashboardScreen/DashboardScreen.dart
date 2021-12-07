import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/RestaurantListBLoC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelRestaurantList.dart';
import 'package:owner/Screens/NotificationList/NotificationList.dart';
import 'package:owner/Screens/RestaurantDetailsScreen/RestaurantDetailsScreen.dart';
import 'package:owner/Screens/TermsAndConditionPage/TermsAndConditionPage.dart';
import 'package:owner/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Helper/Constant.dart';

class DashboardScreen extends StatefulWidget {
  updateOrder() => createState().updateOrderListData();
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //This is callback function
  updateOrderListData() => _getOwnerRestaurantList();

  @override
  void initState() {
    _getOwnerRestaurantList();
    super.initState();
  }

  _getOwnerRestaurantList() async {
    //Get Owner ID First

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString(DefaultKeys.userId);

    SharedManager.shared.ownerId = id;
    restaurantListBloc.fetchAllRestaurant(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(S.current.my_restaurant, [
        IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColor.white,
            ),
            onPressed: () {
              Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(builder: (context) => NotificationList()));
            }),
        // IconButton(
        //     icon: Icon(
        //       Icons.add,
        //       color: AppColor.white,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        //           builder: (context) => TermsAndConditionPage()));
        //     })
      ]),
      body: StreamBuilder(
          stream: restaurantListBloc.restaurantList,
          builder: (context, AsyncSnapshot<ResRestaurantList> snapshot) {
            if (snapshot.hasData) {
              List<Restaurant> resList = snapshot.data.restaurantList;
              return Container(
                color: AppColor.white,
                child: ListView.builder(
                    // itemCount: 1,
                    itemCount: resList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RestaurantDetailsScreen(
                                          resId: resList[index].id,
                                        )));
                          },
                          child: Container(
                            padding: new EdgeInsets.only(
                                left: 12, right: 12, top: 6, bottom: 6),
                            height: 200,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        spreadRadius: 1,
                                        color: AppColor.grey[300],
                                        offset: Offset(0, 0))
                                  ]),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                topRight: Radius.circular(8)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  resList[index].image),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 50,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: AppColor.themeColor,
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(8),
                                                    topLeft:
                                                        Radius.circular(8))),
                                            child: Center(
                                                child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                setCommonText(
                                                    (resList[index].review !=
                                                            null)
                                                        ? '${resList[index].review}'
                                                        : '0.0',
                                                    AppColor.white,
                                                    13.0,
                                                    FontWeight.w500,
                                                    1,
                                                    TextAlign.center),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: AppColor.white,
                                                  size: 15,
                                                )
                                              ],
                                            )),
                                          ))
                                    ],
                                  )),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8))),
                                    padding: new EdgeInsets.only(
                                        left: 5, right: 5, top: 5, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                            child: Container(
                                          child: Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  setCommonText(
                                                      '${resList[index].name}',
                                                      AppColor.black,
                                                      14.0,
                                                      FontWeight.w500,
                                                      1,
                                                      TextAlign.start),
                                                  setCommonText(
                                                      '${resList[index].address}${resList[index].address}',
                                                      AppColor.grey,
                                                      12.0,
                                                      FontWeight.w400,
                                                      2,
                                                      TextAlign.start)
                                                ],
                                              ),
                                            ],
                                          ),
                                        )),
                                        IconButton(
                                            icon: Icon(
                                              Icons.place,
                                              color: AppColor.red,
                                            ),
                                            onPressed: () {
                                              // Navigator.of(context).push(
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             GoogleMapScreen(
                                              //               resName:
                                              //                   resList[index]
                                              //                       .name,
                                              //               latitude: double
                                              //                   .parse(resList[
                                              //                           index]
                                              //                       .latitude),
                                              //               longitude: double
                                              //                   .parse(resList[
                                              //                           index]
                                              //                       .longitude),
                                              //             )));
                                            })
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
              );
            } else {
              return Container(
                color: AppColor.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
