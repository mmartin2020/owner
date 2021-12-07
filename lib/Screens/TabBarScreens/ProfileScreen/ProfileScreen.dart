import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/OwnerProfileBLoC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelOwnerProfile.dart';
import 'package:owner/Screens/EditProfileScreen/EditProfileScreen.dart';
import 'package:owner/Screens/TabBarScreens/ProfileScreen/Widgets/ProfileWidgets.dart';
import 'package:owner/generated/i18n.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  OwnerData result = OwnerData();

  @override
  void initState() {
    // TODO: implement initState
    _getOwnerData();
    super.initState();
  }

  _getOwnerData() async {
    ownerProfileBLoC.fetchOwnerProfileData(SharedManager.shared.ownerId);
  }

  @override
  Widget build(BuildContext context) {
    print(result.totalOrders);
    return Scaffold(
      appBar: commonAppbar(S.current.profile, [
        IconButton(
            icon: Icon(
              Icons.edit,
              color: AppColor.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                        name: this.result.name,
                        email: this.result.email,
                        mobile: this.result.phone,
                        image: this.result.profileImage,
                      )));
            })
      ]),
      body: StreamBuilder(
          stream: ownerProfileBLoC.ownerData,
          builder: (context, AsyncSnapshot<ResOwnerProfile> snapshot) {
            if (snapshot.hasData) {
              result = snapshot.data.ownerData;
              return Container(
                color: AppColor.white,
                child: ListView(
                  children: <Widget>[
                    ProfileWidgets(
                        '${result.name}',
                        "${result.email}",
                        '${result.profileImage}',
                        '${result.phone}',
                        result.totalEarning,
                        result.currentMonthsEarning),
                    _setOrderStatusView(context, result),
                    ProfileListWidget()
                  ],
                ),
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

_setOrderStatusView(BuildContext context, rs) {
  return Container(
    height: 71,
    color: AppColor.white,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              height: 70,
              // color: AppColor.red,
              child: _setCommonView(context, '${S.current.total_order}', "${rs.totalOrders}"),
            )),
            Container(
              color: AppColor.grey[300],
              width: 1,
              height: 70,
            ),
            Expanded(
                child: Container(
              height: 70,
              child: _setCommonView(
                  context, '${S.current.todays_order}', "${rs.todaysOrders}"),
              // color: AppColor.amber,
            )),
            Container(
              color: AppColor.grey[300],
              width: 1,
              height: 70,
            ),
            Expanded(
                child: Container(
              height: 70,
              // color: AppColor.orange,
              child: _setCommonView(
                  context, '${S.current.new_order}', "${rs.newOrders}"),
            )),
          ],
        ),
        Container(
          color: AppColor.grey[300],
          height: 1,
        ),
      ],
    ),
  );
}

_setCommonView(BuildContext context, String title, String subtitle) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      setCommonText('$title', AppColor.black87, 14.0, FontWeight.w500, 1,
          TextAlign.start),
      setHeightSpace(4),
      setCommonText('$subtitle', AppColor.grey[500], 13.0, FontWeight.w500, 1,
          TextAlign.start),
    ],
  );
}
