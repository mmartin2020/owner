import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Screens/TabBarScreens/DashboardScreen/DashboardScreen.dart';
import 'package:owner/Screens/TabBarScreens/OrdersScreen/OrdersScreen.dart';
import 'package:owner/Screens/TabBarScreens/ProfileScreen/ProfileScreen.dart';
import 'package:owner/generated/i18n.dart';

import '../../../Helper/Constant.dart';

class TabbarScreen extends StatefulWidget {
  @override
  _TabbarScreenState createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _children = [
    OrdersScreen(),
    DashboardScreen(),
    ProfileScreen(),
  ];

  _onTapped(int index) {
    setState(() {
      print("index $index");
      SharedManager.shared.isFromTab = true;
      SharedManager.shared.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return new Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          _children[SharedManager.shared.currentIndex],
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: AppColor.white,
        type: BottomNavigationBarType
            .fixed, //if you remove this tab bar will white.
        currentIndex: SharedManager.shared.currentIndex,
        selectedItemColor: AppColor.themeColor,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.local_shipping, size: 25),
              activeIcon: new Icon(Icons.local_shipping,
                  color: AppColor.themeColor, size: 25),
              label: '${S.current.order}'
              // title: setCommonText(
              //     S.current.order,
              //     (SharedManager.shared.currentIndex == 0)
              //         ? AppColor.themeColor
              //         : null,
              //     1.0,
              //     FontWeight.w500,
              //     1,
              //     TextAlign.center),
              ),
          BottomNavigationBarItem(
            icon: new Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.grey[400],
                      blurRadius:
                          10.0, // has the effect of softening the shadow
                      spreadRadius:
                          3.0, // has the effect of extending the shadow
                      offset: Offset(
                        0.0, // horizontal, move right 10
                        0.0, // vertical, move down 10
                      ),
                    )
                  ],
                  color: AppColor.themeColor,
                  borderRadius: new BorderRadius.circular(15),
                ),
                child: new Center(
                  child: new Icon(
                    Icons.home,
                    color: AppColor.white,
                    size: 23,
                  ),
                )),
            label: '${S.current.dashboard}',
            // title: setCommonText(
            //     S.current.dashboard,
            //     (SharedManager.shared.currentIndex == 1)
            //         ? AppColor.themeColor
            //         : null,
            //     1.0,
            //     FontWeight.w500,
            //     1,
            //     TextAlign.center)
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person, size: 25),
            activeIcon:
                new Icon(Icons.person, color: AppColor.themeColor, size: 25),
            label: '${S.current.profile}',
            // title: setCommonText(
            //     S.current.profile,
            //     (SharedManager.shared.currentIndex == 2)
            //         ? AppColor.themeColor
            //         : null,
            //     1.0,
            //     FontWeight.w500,
            //     1,
            //     TextAlign.center)
          ),
        ],
      ),
    );
  }
}
