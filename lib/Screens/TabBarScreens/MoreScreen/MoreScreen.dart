import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/generated/i18n.dart';

class MoreScreen extends StatefulWidget {
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(S.current.more, [
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
