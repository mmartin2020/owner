import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/generated/i18n.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  _setCategoryBanner() {
    return Container(
      // height: 250,
      padding: EdgeInsets.all(12),
      // color: AppColor.amber,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            // height: 80,
            width: screenWidth(context),
            padding: EdgeInsets.only(left: 15),
            // color: AppColor.amber,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                setCommonText(S.current.add_new_category, AppColor.black, 25.0,
                    FontWeight.bold, 1, TextAlign.start),
                setHeightSpace(4),
                setCommonText(S.current.add_category_note, AppColor.grey[600],
                    16.0, FontWeight.w400, 3, TextAlign.start),
              ],
            ),
          ),
          setHeightSpace(20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AppImages.resBanner, fit: BoxFit.cover),
                ),
              ),
              setWithSpace(20),
              Container(
                height: 50,
                width: 150,
                child: Center(
                  child: setCommonText(S.current.select_image, AppColor.white,
                      16.0, FontWeight.bold, 1, TextAlign.start),
                ),
                decoration: BoxDecoration(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(25)),
              )
            ],
          ),
        ],
      ),
    );
  }

  _setCategoryTitleView() {
    return new Container(
      height: 140,
      padding: new EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            padding: new EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: AppColor.grey),
                borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: S.current.tf_enter_category_name,
                  border: InputBorder.none),
              style: TextStyle(
                  fontFamily: SharedManager.shared.fontFamilyName,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          setHeightSpace(35),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColor.themeColor,
            ),
            child: Center(
              child: setCommonText(S.current.btn_add_category, AppColor.white,
                  16.0, FontWeight.w500, 1, TextAlign.center),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(S.current.add_category, []),
      body: Container(
        color: AppColor.white,
        child: ListView(
          children: <Widget>[
            _setCategoryBanner(),
            setHeightSpace(30),
            _setCategoryTitleView()
          ],
        ),
      ),
    );
  }
}
