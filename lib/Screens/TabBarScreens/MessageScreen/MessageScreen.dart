import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/generated/i18n.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(S.current.message, [
        IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColor.white,
            ),
            onPressed: () {})
      ]),
    );
  }
}
