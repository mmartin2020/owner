import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:owner/Helper/LocationManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Screens/TabBarScreens/TabbarScreen/TabbarScreen.dart';
import 'package:transformer_page_view/index_controller.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:owner/Helper/Constant.dart';

void main() => runApp(new Onboarding());

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final List<String> images = [
    "Assets/OnBoarding1.png",
    "Assets/OnBoarding2.png",
    "Assets/OnBoarding3.png",
  ];
  int slideIndex = 0;
  final IndexController controller = IndexController();

  _getAddressFromCurrentLocation(LatLng coordinate) async {
    // var coordinate = await SharedManager.shared.getLocationCoordinate();
    print("Stored Location:$coordinate");

    final coordinates =
        new Coordinates(coordinate.latitude, coordinate.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('${first.addressLine}, ${first.featureName}');
    setState(() {
      if (first.addressLine != null) {
        // SharedManager.shared.address = first.addressLine;
      }
    });
  }

  _setAddressState() async {
    _getAddressFromCurrentLocation(
        await SharedManager.shared.getLocationCoordinate());
  }

  @override
  void initState() {
    LocationManager.shared.getCurrentLocation();
    _setAddressState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransformerPageView transformerPageView = TransformerPageView(
        onPageChanged: (value) {
          print("Value:$value");
          setState(() {
            slideIndex = value;
          });
        },
        loop: false,
        controller: controller,
        transformer: new PageTransformerBuilder(
            builder: (Widget child, TransformInfo info) {
          return new Material(
            color: AppColor.white,
            textStyle: new TextStyle(color: AppColor.white),
            borderRadius: new BorderRadius.circular(12.0),
            child: new Container(
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(images[info.index]))),
            ),
          );
        }),
        itemCount: images.length);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: AppColor.white,
          body: new Stack(
            children: <Widget>[
              transformerPageView,
              new Positioned(
                  top: 40,
                  right: 10,
                  child: new Chip(
                    backgroundColor: AppColor.grey[200],
                    label: (this.slideIndex == 2)
                        ? new GestureDetector(
                            onTap: () async {
                              await SharedManager.shared
                                  .storeString("no", "isLoogedIn");
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => TabbarScreen()),
                                      ModalRoute.withName(AppRoute.tabbar));
                            },
                            child: new Text(
                              '  Home  ',
                              style: new TextStyle(
                                fontFamily: SharedManager.shared.fontFamilyName,
                              ),
                            ),
                          )
                        : new GestureDetector(
                            onTap: () async {
                              await SharedManager.shared
                                  .storeString("no", "isLoogedIn");
                              Navigator.of(context, rootNavigator: true)
                                  .pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => TabbarScreen()),
                                      ModalRoute.withName(AppRoute.tabbar));
                            },
                            child: new Text('  Skip  ',
                                style: new TextStyle(
                                  fontFamily:
                                      SharedManager.shared.fontFamilyName,
                                )),
                          ),
                  ))
            ],
          ),
        ));
  }
}
