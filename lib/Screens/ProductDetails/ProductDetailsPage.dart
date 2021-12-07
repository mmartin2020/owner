import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/ProductDetailsBloC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Model/ModelProductDetails.dart';
import 'package:owner/Screens/ZoomableImage/ZoomableImagePage.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;
  final String storeId;

  ProductDetailsPage({this.productId, this.storeId});
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  PageController _controller;

  List<Widget> items = [];

  // List unitList = [
  //   {'title': '100 gm', 'isSelect': '1', 'isAdded': '0'},
  //   {'title': '200 gm', 'isSelect': '0', 'isAdded': '0'},
  //   {'title': '500 gm', 'isSelect': '0', 'isAdded': '0'},
  //   {'title': '1 kg', 'isSelect': '0', 'isAdded': '0'},
  // ];

  bool isAdded = false;
  var index = 0;

  var productDescription =
      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry.
   Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer 
   took a galley of type and scrambled it to make a type specimen book.''';

  var selectedUnit = 0;
  var price = '';
  var discount = '';
  var discountType = '';
  var expDate = '';
  bool isFirst = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ResProductDetails result;

  @override
  void initState() {
    // TODO: implement initState

    final param = {
      "product_id": "${this.widget.productId}",
    };
    _controller = PageController();
    productDetailsBloC.fetchProductDetails(param);
    super.initState();
  }

  List<Widget> setItems(List<String> images) {
    for (var i = 0; i < images.length; i++) {
      final tmp = buildPage("${images[i]}", Colors.red);
      items.add(tmp);
    }
    return items;
  }

  _setBannerImage(List<String> images) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.4,
      color: AppColor.white,
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ZoomableImagePage(
                              images: images,
                            ),
                        fullscreenDialog: true));
                  },
                  child: PageView(
                    children: setItems(images),
                    controller: _controller,
                  ),
                ),
              ),
              ScrollingPageIndicator(
                dotColor: AppColor.black,
                dotSelectedColor: AppColor.red,
                dotSize: 6,
                dotSelectedSize: 8,
                dotSpacing: 12,
                controller: _controller,
                itemCount: items.length,
                orientation: Axis.horizontal,
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: AppColor.themeColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }

  _setProductBasicDescription(
      String discount, String name, String price, String discountType) {
    return Container(
      // color: AppColor.amber,
      // height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            color: AppColor.grey,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColor.themeColor,
                  ),
                  child: Center(
                    child: setCommonText(
                        (discountType == "0")
                            ? '$discount flat'
                            : '$discount% off',
                        AppColor.white,
                        15.0,
                        FontWeight.bold,
                        1,
                        TextAlign.start),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                setCommonText('$name', AppColor.black, 15.0, FontWeight.bold, 2,
                    TextAlign.start),
                SizedBox(
                  height: 8,
                ),
                setCommonText('${result.result.description}', AppColor.black,
                    13.0, FontWeight.w400, 5, TextAlign.start),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: AppColor.grey,
            height: 1,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  _setProductUnitsDetails() {
    return Container(
      height: 200,
      color: AppColor.white,
      child: DataTable(columns: const <DataColumn>[
        DataColumn(
          label: Text(
            'U.Medida',
            style: TextStyle(
                fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Stock',
            style: TextStyle(
                fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Fecha Venc.',
            style: TextStyle(
                fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
          ),
        ),
      ], rows: _setDataRows(result.result.measurement)),
    );
  }

  List<DataRow> _setDataRows(List<Measurement> measurement) {
    List<DataRow> tmpDataRow = [];
    for (var unit in measurement) {
      tmpDataRow.add(DataRow(
        cells: <DataCell>[
          DataCell(Text((unit.unit != '') ? '${unit.unit}' : 'Invalid Unit')),
          DataCell((unit.quantity != "")
              ? Text((int.parse(unit.quantity) > 0) ? '${unit.quantity}' : '0')
              : Text('0')),
          DataCell(Text('${unit.expiryDate}')),
        ],
      ));
    }
    return tmpDataRow;
    // return <DataRow>[
    //   DataRow(
    //     cells: <DataCell>[
    //       DataCell(Text('Ravi')),
    //       DataCell(Text('19')),
    //       DataCell(Text('Student')),
    //     ],
    //   ),
    //   DataRow(
    //     cells: <DataCell>[
    //       DataCell(Text('Jane')),
    //       DataCell(Text('43')),
    //       DataCell(Text('Professor')),
    //     ],
    //   ),
    //   DataRow(
    //     cells: <DataCell>[
    //       DataCell(Text('William')),
    //       DataCell(Text('27')),
    //       DataCell(Text('Professor')),
    //     ],
    //   ),
    // ];
  }

  _productUnits(List<Measurement> unitList) {
    return Container(
      // height: 80,
      color: AppColor.white,
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          setCommonText('Unidades disponibles:', AppColor.black87, 17.0,
              FontWeight.w600, 1, TextAlign.start),
          SizedBox(
            height: 8,
          ),
          Container(height: 40, color: AppColor.red),
        ],
      ),
    );
  }

  _setProductDescription(String title, String value) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              setCommonText('$title', AppColor.black, 17.0, FontWeight.w600, 1,
                  TextAlign.start),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColor.black87,
              )
            ],
          ),
          SizedBox(height: 5),
          setCommonText('$value', AppColor.black54, 16.0, FontWeight.w600, 10,
              TextAlign.start),
        ],
      ),
    );
  }

  _setComonDivider() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Container(
          height: 12,
          color: AppColor.grey[200],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      primary: false,
      body: StreamBuilder<ResProductDetails>(
          stream: productDetailsBloC.productDetails,
          builder: (context, AsyncSnapshot<ResProductDetails> snapshot) {
            if (snapshot.hasData) {
              result = snapshot.data;
              return Container(
                  color: AppColor.white,
                  child: ListView(
                    children: [
                      (result.result.image.length > 0)
                          ? _setBannerImage(result.result.image)
                          : setHeightSpace(1),
                      _setProductBasicDescription(
                          result.result.discount,
                          result.result.name,
                          '0.0',
                          result.result.discountType),
                      _setProductUnitsDetails()
                      // _productUnits([]),
                      // _setComonDivider(),
                      // _setProductDescription(
                      //     '${S.current.descriptions}', result.description),
                      // _setComonDivider(),
                      // _setProductDescription('${S.current.storageLife}',
                      //     result.measurement[0].expiryDate),
                      // _setComonDivider(),
                      // _setProductDescription(
                      //     '${S.current.marketeBy}', result.shopAddress),
                      // _setComonDivider(),
                      // _setProductDescription(
                      //     '${S.current.seller}', result.shopName),
                      // _setComonDivider(),
                      // _setProductDescription('${S.current.countryOfOrigin}',
                      //     '${result.shopCountry}'),
                    ],
                  ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

Widget buildPage(String text, Color color) {
  return Container(
    decoration:
        BoxDecoration(image: DecorationImage(image: NetworkImage(text))),
  );
}
