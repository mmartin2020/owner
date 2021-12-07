import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Screens/TabBarScreens/TabbarScreen/TabbarScreen.dart';
import 'package:owner/generated/i18n.dart';

class ChangePasswordSuccess extends StatefulWidget {
  @override
  _ChangePasswordSuccessState createState() => _ChangePasswordSuccessState();
}

class _ChangePasswordSuccessState extends State<ChangePasswordSuccess> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          color: AppColor.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AppImages.changePasswordSuccess)),
              ),
              SizedBox(
                height: 10,
              ),
              setCommonText('${S.current.passReset}', AppColor.black, 25.0,
                  FontWeight.bold, 1, TextAlign.start),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: new EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    '${S.current.passwordSetSuccessFully}',
                    style: TextStyle(
                      color: AppColor.themeColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: SharedManager.shared.fontFamilyName,
                    ),
                    textAlign: TextAlign.center,
                  )),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  SharedManager.shared.currentIndex = 1;
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => TabbarScreen()),
                      ModalRoute.withName(AppRoute.tabbar));
                },
                child: Container(
                  height: 45,
                  width: 220,
                  decoration: BoxDecoration(
                      color: AppColor.themeColor,
                      borderRadius: BorderRadius.circular(22.5)),
                  child: Center(
                    child: setCommonText(
                        '${S.current.continueStr}',
                        AppColor.white,
                        16.0,
                        FontWeight.w500,
                        1,
                        TextAlign.start),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
