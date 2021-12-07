import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/NotificationListBloc.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelNotificationList.dart';
import 'package:owner/generated/i18n.dart';

void main() => runApp(new NotificationList());

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    notificationListBloc.fetchnotificationList(SharedManager.shared.ownerId);

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: AppColor.themeColor,
        title: setCommonText(S.current.notifications, AppColor.white, 20.0,
            FontWeight.w600, 1, TextAlign.start),
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: StreamBuilder(
          stream: notificationListBloc.notificationList,
          builder: (context, AsyncSnapshot<ResNotificationList> snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data.notificationList;
              if (result.length == 0) {
                return dataFound(
                    context,
                    "No tienes ninguna notificación en tu lista",
                    AssetImage('Assets/logo.png'),
                    "1");
              } else {
                return new Container(
                  child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return new Container(
                          padding: new EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'Assets/logo.png'),
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              new Expanded(
                                  child: new Container(
                                padding: new EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    setCommonText(
                                        result[index].title,
                                        AppColor.black87,
                                        16.0,
                                        FontWeight.w500,
                                        1,
                                        TextAlign.start),
                                    SizedBox(height: 2),
                                    setCommonText(
                                        result[index].date,
                                        AppColor.grey,
                                        14.0,
                                        FontWeight.w400,
                                        1,
                                        TextAlign.start),
                                    SizedBox(height: 2),
                                    Row(
                                      children: <Widget>[
                                        setCommonText(
                                            '${S.current.orderId}',
                                            AppColor.grey[800],
                                            14.0,
                                            FontWeight.w400,
                                            1,
                                            TextAlign.start),
                                        SizedBox(width: 2),
                                        setCommonText(
                                            "#${result[index].typeId}",
                                            AppColor.grey[700],
                                            14.0,
                                            FontWeight.w400,
                                            1,
                                            TextAlign.start),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      }),
                );
              }
            } else {
              return new Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }
}
