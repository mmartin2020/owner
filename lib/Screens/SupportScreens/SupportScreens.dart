import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/generated/i18n.dart';

void main() => runApp(new SupportScreen());

class SupportScreen extends StatefulWidget {
  @override
  _SupportScreenState createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColor.themeColor,
        centerTitle: true,
        title: setCommonText(S.current.support, AppColor.white, 20.0,
            FontWeight.w500, 1, TextAlign.start),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.themeColor,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AppImages.mail)),
                      ),
                      SizedBox(height: 5),
                      setCommonText(S.current.contactUs, AppColor.white, 20.0,
                          FontWeight.bold, 1, TextAlign.start)
                    ],
                  ),
                )),
            Expanded(
                flex: 7,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.white,
                  padding: new EdgeInsets.all(40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(Icons.place, color: AppColor.red, size: 30),
                      SizedBox(height: 5),
                      Text(
                        'Reyes Lavalle 3350, Las Condes, Región Metropolitana',
                        style: TextStyle(
                          color: AppColor.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Icon(Icons.mobile_screen_share,
                          color: AppColor.red, size: 30),
                      SizedBox(height: 5),
                      Text(
                        '+56 9 56762031',
                        style: TextStyle(
                          color: AppColor.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Icon(Icons.computer, color: AppColor.red, size: 30),
                      SizedBox(height: 5),
                      Text(
                        '${S.current.email}: info@flashliver.cf',
                        style: TextStyle(
                          color: AppColor.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Icon(Icons.watch_later, color: AppColor.red, size: 30),
                      SizedBox(height: 5),
                      Text(
                        'De lunes a viernes',
                        style: TextStyle(
                          color: AppColor.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '10:00 a 18:00 ',
                        style: TextStyle(
                          color: AppColor.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Sábado',
                        style: TextStyle(
                          color: AppColor.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '11:00 a 17:00',
                        style: TextStyle(
                          color: AppColor.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
