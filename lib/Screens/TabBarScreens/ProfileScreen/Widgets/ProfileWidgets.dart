import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Screens/ChangePasswordScreen/ChangePasswordScreen.dart';
import 'package:owner/Screens/LanguageScreen/LanguageScreen.dart';
import 'package:owner/Screens/LoginScreen/LoginPage.dart';
import 'package:owner/Screens/NotificationList/NotificationList.dart';
import 'package:owner/Screens/SupportScreens/SupportScreens.dart';
import 'package:owner/Screens/TabBarScreens/TabbarScreen/TabbarScreen.dart';
import 'package:owner/generated/i18n.dart';

class ProfileListWidget extends StatelessWidget {
  final List listOptions = [
    {
      "title": S.current.change_password,
      "icon": Icon(Icons.lock, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.support,
      "icon": Icon(Icons.headset_mic, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.languages,
      "icon": Icon(Icons.language, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.notifications,
      "icon": Icon(Icons.notifications, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.order,
      "icon": Icon(Icons.local_shipping, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.logout,
      "icon": Icon(Icons.settings_power, color: AppColor.grey[700], size: 18)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: (60.0 * listOptions.length),
        // color: AppColor.green,
        padding: new EdgeInsets.all(15),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: listOptions.length,
          itemBuilder: (context, index) {
            return new InkWell(
              onTap: () async {
                // await SharedManager.shared.facebookSignIn.logOut();
                // await SharedManager.shared.googleSignIn.signOut();
                if (index == 0) {
                  // SharedManager.shared
                  //     .showAlertDialog(S.current.coming_soon, context);

                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                } else if (index == 2) {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => LanguageScreen()));
                } else if (index == 1) {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => SupportScreen()));
                } else if (index == 3) {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => NotificationList()));
                } else if (index == 5) {
                  await SharedManager.shared.storeString("no", "isLoogedIn");
                  SharedManager.shared.currentIndex = 1;
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      ModalRoute.withName(AppRoute.login));

                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     // return object of type Dialog
                  //     return AlertDialog(
                  //       title: setCommonText(
                  //           '${S.current.are_sure_want_to_logout}',
                  //           AppColor.black,
                  //           18.0,
                  //           FontWeight.w500,
                  //           2,
                  //           TextAlign.start),
                  //       content: SingleChildScrollView(
                  //           // child: Container(
                  //           //   height: 80,
                  //           //   color: AppColor.amber,
                  //           // ),
                  //           ),
                  //       actions: <Widget>[
                  //         // usually buttons at the bottom of the dialog
                  //         new FlatButton(
                  //           child: setCommonText(
                  //               '${S.current.cancel}',
                  //               AppColor.themeColor,
                  //               15.0,
                  //               FontWeight.w500,
                  //               2,
                  //               TextAlign.start),
                  //           onPressed: () {
                  //             Navigator.of(context).pop();
                  //           },
                  //         ),
                  //         new FlatButton(
                  //           child: setCommonText(
                  //               '${S.current.ok}',
                  //               AppColor.themeColor,
                  //               15.0,
                  //               FontWeight.w500,
                  //               2,
                  //               TextAlign.start),
                  //           onPressed: () async {
                  //             await SharedManager.shared
                  //                 .storeString("no", "isLoogedIn");
                  //             SharedManager.shared.currentIndex = 1;
                  //             Navigator.of(context, rootNavigator: true)
                  //                 .pushAndRemoveUntil(
                  //                     MaterialPageRoute(
                  //                         builder: (context) => LoginPage()),
                  //                     ModalRoute.withName(AppRoute.login));
                  //           },
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // );
                } else if (index == 4) {
                  SharedManager.shared.currentIndex = 0;
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => TabbarScreen()),
                      ModalRoute.withName(AppRoute.tabbar));
                }
              },
              child: new Container(
                height: 55,
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        color: AppColor.white,
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: listOptions[index]['icon'],
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Container(
                                // color: AppColor.red,
                                padding:
                                    new EdgeInsets.only(left: 10, right: 10),
                                child: setCommonText(
                                    listOptions[index]['title'],
                                    AppColor.grey[500],
                                    15.0,
                                    FontWeight.w400,
                                    1,
                                    TextAlign.start),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Divider(
                      color: AppColor.black38,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}

class ProfileWidgets extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final String phone;
  final String totalEarning;
  final String currentMonthEarning;

  ProfileWidgets(this.name, this.email, this.image, this.phone,
      this.totalEarning, this.currentMonthEarning);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          // height: 180,
          color: AppColor.white,
          padding: new EdgeInsets.only(top: 0, right: 0, left: 30),
          child: new Column(
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     IconButton(
              //         icon: Icon(
              //           Icons.edit,
              //           color: AppColor.themeColor,
              //           size: 20,
              //         ),
              //         onPressed: () {
              //           // Navigator.of(context).push(MaterialPageRoute(
              //           //     builder: (context) => EditProfileScreen()));
              //         })
              //   ],
              // ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: <Widget>[
                  new Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.grey,
                          width: 2,
                        ),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: setCommonText(name, AppColor.black87, 15.0,
                        FontWeight.w500, 1, TextAlign.start),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: AppColor.grey[500],
                        size: 20,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      setCommonText(email, AppColor.grey[500], 14.0,
                          FontWeight.w400, 1, TextAlign.start),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: AppColor.grey[500],
                        size: 20,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      setCommonText('$phone', AppColor.grey[500], 14.0,
                          FontWeight.w400, 1, TextAlign.start)
                    ],
                  ),
                  SizedBox(height: 10)
                ],
              )
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColor.grey[300],
        ),
        Container(
          height: 60,
          color: AppColor.white,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText(
                        (this.totalEarning != null)
                            ? '${Currency.curr}${this.totalEarning}'
                            : '${Currency.curr}0.0',
                        AppColor.black,
                        14.0,
                        FontWeight.w500,
                        1,
                        TextAlign.start),
                    setCommonText(
                        '${S.current.total_earning}',
                        AppColor.grey[600],
                        12.0,
                        FontWeight.w500,
                        1,
                        TextAlign.start)
                  ],
                ),
              )),
              Container(
                width: 1,
                color: AppColor.grey[300],
              ),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText(
                        (this.currentMonthEarning != null)
                            ? '${Currency.curr}${this.currentMonthEarning}'
                            : '${Currency.curr}0.0',
                        AppColor.black,
                        14.0,
                        FontWeight.w500,
                        1,
                        TextAlign.start),
                    setCommonText('${S.current.this_month}', AppColor.grey[600],
                        12.0, FontWeight.w500, 1, TextAlign.start)
                  ],
                ),
              )),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColor.grey[300],
        ),
      ],
    );
  }
}
