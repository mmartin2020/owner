import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Screens/ChangePasswordSuccess/ChangePasswordSuccess.dart';
import 'package:owner/generated/i18n.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isOldPassShow = true;
  bool isNewPassShow = true;
  bool isConfirmPassShow = true;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> _changePassword() async {
    if (oldPasswordController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.validEnterOldPass}', context);
      return false;
    } else if (newPasswordController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.validEnterNewPassword}', context);
      return false;
    } else if (confirmPasswordController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.validEnterConfirmpass}', context);
      return false;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      SharedManager.shared
          .showAlertDialog('${S.current.validNewpassConfirmPassSame}', context);
      return false;
    }

    showSnackbar('Loading', scaffoldKey, context);

    final param = {
      'old_password': oldPasswordController.text,
      'new_password': newPasswordController.text,
      'owner_id': SharedManager.shared.ownerId
    };
    Requestmanager manager = Requestmanager();
    bool status = false;
    await manager.changePassword(param, context).then((value) {
      status = value;
    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: setCommonText('${S.current.changePass}', AppColor.white, 20.0,
            FontWeight.w500, 1, TextAlign.start),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
      ),
      body: Container(
        color: AppColor.white,
        padding: new EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  setCommonText('', AppColor.black87, 15.0, FontWeight.w500, 1,
                      TextAlign.start),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: oldPasswordController,
                          obscureText: this.isOldPassShow ? true : false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${S.current.oldpass}'),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColor.grey,
                              fontFamily: SharedManager.shared.fontFamilyName),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isOldPassShow = !this.isOldPassShow;
                          });
                        },
                        child: Icon(
                          this.isOldPassShow
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: this.isOldPassShow
                              ? AppColor.grey
                              : AppColor.black54,
                          size: 20.0,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    color: AppColor.black54,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  setCommonText('', AppColor.black87, 15.0, FontWeight.w500, 1,
                      TextAlign.start),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: newPasswordController,
                          obscureText: this.isNewPassShow ? true : false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${S.current.newPss}'),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColor.grey,
                              fontFamily: SharedManager.shared.fontFamilyName),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isNewPassShow = !this.isNewPassShow;
                          });
                        },
                        child: Icon(
                          this.isNewPassShow
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: this.isNewPassShow
                              ? AppColor.grey
                              : AppColor.black54,
                          size: 20.0,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    color: AppColor.black54,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  setCommonText('', AppColor.black87, 15.0, FontWeight.w500, 1,
                      TextAlign.start),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: this.isConfirmPassShow ? true : false,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${S.current.confirmPas}'),
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColor.grey,
                              fontFamily: SharedManager.shared.fontFamilyName),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            this.isConfirmPassShow = !this.isConfirmPassShow;
                          });
                        },
                        child: Icon(
                          this.isConfirmPassShow
                              ? Icons.visibility_off
                              : Icons.remove_red_eye,
                          color: this.isConfirmPassShow
                              ? AppColor.grey
                              : AppColor.black54,
                          size: 20.0,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 1,
                    color: AppColor.black54,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            InkWell(
              onTap: () async {
                _changePassword().then((value) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  if (value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangePasswordSuccess()));
                  }
                  //else {
                  //   SharedManager.shared
                  //       .showAlertDialog('Please try after sometime', context);
                  // }
                });
              },
              child: Container(
                height: 45,
                // width: 120,
                decoration: BoxDecoration(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(22.5)),
                child: Center(
                  child: setCommonText(
                      '${S.current.changePass}',
                      AppColor.white,
                      17.0,
                      FontWeight.w500,
                      1,
                      TextAlign.start),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
