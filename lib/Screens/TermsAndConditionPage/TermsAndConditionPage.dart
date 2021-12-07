import 'package:flutter/material.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Screens/AddRestaurantScreen/AddRestaurantScreen.dart';
import 'package:owner/generated/i18n.dart';

class TermsAndConditionPage extends StatelessWidget {
  final List terms = [
    S.current.terms1,
    S.current.terms2,
    S.current.terms3,
    S.current.terms4,
    S.current.terms5,
    S.current.terms6,
    S.current.terms7,
    S.current.terms8,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar('${S.current.termsAndConditions}', []),
      body: Container(
        color: AppColor.white,
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
              child: ListView.builder(
                  itemCount: terms.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.forward,
                                color: AppColor.black54,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                  child: setCommonText(
                                      terms[index],
                                      AppColor.black87,
                                      15.0,
                                      FontWeight.w400,
                                      5,
                                      TextAlign.start))
                            ],
                          ),
                          Divider()
                        ],
                      ),
                    );
                  }),
            )),
            Container(
              height: 60,
              color: AppColor.themeColor,
              child: InkWell(
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .push(MaterialPageRoute(
                          builder: (context) => AddRestaurantScreen(
                                isEdit: false,
                              )));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText(
                        '${S.current.acceptTermsandConditions}',
                        AppColor.white,
                        16.0,
                        FontWeight.w600,
                        1,
                        TextAlign.center),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColor.white,
                      size: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
