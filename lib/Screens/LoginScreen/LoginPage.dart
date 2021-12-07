import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/LocationManager.dart';
import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Screens/TabBarScreens/TabbarScreen/TabbarScreen.dart';
import 'package:owner/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var width = 40.0;
  var height = 40.0;
  var status = true;

  var widthgp = 40.0;
  var heightgp = 40.0;
  var statusgp = true;

  static TextEditingController emailController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();
  bool isSecure = true;
  double latitude = 0.00;
  double longitude = 0.00;

//Social Media Integrations for login.

  @override
  void initState() {
    super.initState();
    //Select default language
    LocationManager.shared.getCurrentLocation();
    _getUserCurrentLocation();
    emailController.text = "";
  }

  // var facebookLogin = FacebookLogin();

  _getUserCurrentLocation() async {
    LatLng coordinate = await SharedManager.shared.getLocationCoordinate();
    latitude = coordinate.latitude;
    longitude = coordinate.longitude;
  }

  _setLoginMethod() async {
    var validator = SharedManager.shared.validateEmail(emailController.text);

    if (emailController.text == "" || validator == "Enter Valid Email") {
      Navigator.pop(context);
      SharedManager.shared
          .showAlertDialog("${S.current.enterEmailFirst}", context);
      return;
    } else if (passwordController.text == "") {
      Navigator.pop(context);
      SharedManager.shared
          .showAlertDialog("${S.current.enterPasswoedFirst}", context);
      return;
    }

    var param = {
      "email": emailController.text,
      "password": passwordController.text,
      "device_token": SharedManager.shared.token,
    };
    print("Request Parameter:$param");

    Requestmanager manager = Requestmanager();
    await manager.loginRestaurantOwner(param).then((value) async {
      if (value.code == 1) {
        var user = value.user;
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString(DefaultKeys.userName, user.name);
        await prefs.setString(DefaultKeys.userEmail, user.email);
        await prefs.setString(DefaultKeys.userImage, user.profileImage);
        await prefs.setString(DefaultKeys.userPhone, user.phone);
        await prefs.setString(DefaultKeys.userAddress, user.address);
        await prefs.setString(DefaultKeys.userPin, user.pincode);
        await prefs.setString(DefaultKeys.userId, user.id);

        await SharedManager.shared.storeString("yes", "isLoogedIn");
        SharedManager.shared.currentIndex = 1;
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => TabbarScreen()),
            ModalRoute.withName(AppRoute.tabbar));
      } else {
        Navigator.of(context).pop();
        SharedManager.shared
            .showAlertDialog('${S.current.invalidEmailOrpass}', context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      body: Container(
        color: AppColor.white,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // color: AppColor.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'Assets/AppLogo/owner.png'))),
                          ),
                          setCommonText(
                              '${S.current.foodOwner}',
                              AppColor.black54,
                              20.0,
                              FontWeight.w500,
                              1,
                              TextAlign.start)
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  // color: AppColor.amber,
                  child: Column(
                    children: <Widget>[
                      Container(
                        // height: 60,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '${S.current.email}'),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.grey,
                                  fontFamily:
                                      SharedManager.shared.fontFamilyName),
                            ),
                            Container(
                              height: 1,
                              color: AppColor.black38,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // height: 60,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: this.isSecure ? true : false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${S.current.password}'),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.grey,
                                        fontFamily: SharedManager
                                            .shared.fontFamilyName),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      this.isSecure = !this.isSecure;
                                    });
                                  },
                                  child: Icon(
                                    this.isSecure
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye,
                                    color: this.isSecure
                                        ? AppColor.grey
                                        : AppColor.black54,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              color: AppColor.black38,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    // Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ForgotPassword()));
                                  },
                                  child: setCommonText(
                                      '${S.current.forgotPassword}',
                                      AppColor.grey,
                                      14.0,
                                      FontWeight.w500,
                                      1,
                                      TextAlign.start),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          _setLoginMethod();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColor.themeColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: setCommonText(
                                '${S.current.login}',
                                AppColor.white,
                                16.0,
                                FontWeight.bold,
                                1,
                                TextAlign.start),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      // Container(
                      //   height: 45,
                      //   child: Row(
                      //     children: <Widget>[
                      //       Expanded(
                      //           child: Container(
                      //         decoration: BoxDecoration(
                      //             color: AppColor.facebookBG,
                      //             borderRadius: BorderRadius.circular(5)),
                      //         child: Center(
                      //           child: setCommonText(
                      //               '${S.current.facebook}',
                      //               AppColor.white,
                      //               16.0,
                      //               FontWeight.bold,
                      //               1,
                      //               TextAlign.start),
                      //         ),
                      //       )),
                      //       SizedBox(
                      //         width: 15,
                      //       ),
                      //       Expanded(
                      //           child: Container(
                      //         decoration: BoxDecoration(
                      //             color: AppColor.googleBG,
                      //             borderRadius: BorderRadius.circular(5)),
                      //         child: Center(
                      //           child: setCommonText(
                      //               '${S.current.google}',
                      //               AppColor.white,
                      //               16.0,
                      //               FontWeight.bold,
                      //               1,
                      //               TextAlign.start),
                      //         ),
                      //       )),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
