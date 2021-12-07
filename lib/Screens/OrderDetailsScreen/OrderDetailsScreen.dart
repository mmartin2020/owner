import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/OrderDetailsBLoC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/RequestManager.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelOrderDetails.dart';
import 'package:owner/generated/i18n.dart';

class OrderDetailsScreen extends StatefulWidget {
  updateOrder() => createState().updateOrderListData();
  final String orderId;
  OrderDetailsScreen({this.orderId});
  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  updateOrderListData() => _getOrderDetails();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    _getOrderDetails();
    super.initState();
  }

  _getOrderDetails() {
    orderDetailsBLoC.fetchOrderDetails(APIS.orderDetails + this.widget.orderId);
  }

  _doOrderAcceptRejectOperation(String status) async {
    //	1=>received, 2=>accepted, 3=>declined, 4=>on way, 5=>delivered
    final param = {
      "order_status": "$status",
      "order_id": "${this.widget.orderId}"
    };
    showSnackbar('${S.current.loading}', scaffoldKey, context);
    Requestmanager manager = Requestmanager();
    manager.orderOperation(param).then((value) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (value) {
        _getOrderDetails();
      } else {
        _getOrderDetails();
        SharedManager.shared
            .showAlertDialog('${S.current.somethingGoesWrong}', context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: commonAppbar(S.current.order_detail, []),
      body: StreamBuilder(
          stream: orderDetailsBLoC.orderDetails,
          builder: (context, AsyncSnapshot<ResOrderDetails> snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data.orderData;

              return Container(
                color: AppColor.white,
                child: ListView(
                  children: <Widget>[
                    _setCustomerDetails(result.customerName ?? '', result.name,
                        '', result.phone, result.address),
                    _setOrderDetails(
                      result.orderId,
                      result.orderStatus,
                      result.paymentType,
                      result.tipPrice,
                      result.discountPrice,
                      result.totalPrice,
                      result.deliveryTime,
                      result.deliveryDate,
                    ),
                    _setDeliveryItemsDetails(context, result.products),
                    _setOperationButtonWidgets(result.orderStatus, context)
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  _setCustomerDetails(String customerName, String name, String email,
      String phone, String address) {
    return Container(
      padding: new EdgeInsets.all(12),
      child: Material(
        color: AppColor.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText(S.current.customer_informations, AppColor.black,
                  15.0, FontWeight.w500, 1, TextAlign.start),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _setCommonView('Nombre del cliente :', '$customerName'),
                  setHeightSpace(5),
                  // _setCommonView('${S.current.name}  :', '$name'),
                  setHeightSpace(5),
                  // _setCommonView('${S.current.email} :', '$email'),
                  setHeightSpace(5),
                  _setCommonView('${S.current.phone} :', '$phone'),
                  setHeightSpace(8),
                  _setCommonView('${S.current.deliveryAddress} :', address),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _setDeliveryItemsDetails(BuildContext context, List<Products> productList) {
    return Container(
      padding: new EdgeInsets.all(12),
      height: (productList.length * 130).toDouble() + 30,
      child: Material(
        color: AppColor.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText(S.current.delivery_item_details, AppColor.black,
                  15.0, FontWeight.w500, 1, TextAlign.start),
              Divider(),
              Expanded(
                  child: Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Material(
                        color: AppColor.white,
                        elevation: 2.0,
                        // width: screenWidth(context),
                        // height: 70,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        color: AppColor.white,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                productList[index].image))),
                                  ),
                                ),
                                setWithSpace(10),
                                Expanded(
                                    child: Container(
                                  // color: AppColor.orange,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      setHeightSpace(5),
                                      setCommonText(
                                          productList[index].productName,
                                          AppColor.black,
                                          13.0,
                                          FontWeight.w500,
                                          2,
                                          TextAlign.start),
                                      Row(
                                        children: <Widget>[
                                          setCommonText(
                                              '${S.current.quantity}',
                                              AppColor.grey[600],
                                              12.0,
                                              FontWeight.w500,
                                              1,
                                              TextAlign.start),
                                          setWithSpace(5),
                                          setCommonText(
                                              'X',
                                              AppColor.grey[600],
                                              12.0,
                                              FontWeight.w500,
                                              1,
                                              TextAlign.start),
                                          setWithSpace(5),
                                          setCommonText(
                                              '${productList[index].productQuantity}',
                                              AppColor.grey[600],
                                              12.0,
                                              FontWeight.w500,
                                              1,
                                              TextAlign.start),
                                        ],
                                      ),
                                      setHeightSpace(5),
                                      Row(
                                        children: <Widget>[
                                          setCommonText(
                                              'Unit:',
                                              AppColor.grey[600],
                                              12.0,
                                              FontWeight.w500,
                                              1,
                                              TextAlign.start),
                                          setWithSpace(5),
                                          setCommonText(
                                              '${productList[index].unit}',
                                              AppColor.grey[600],
                                              12.0,
                                              FontWeight.w500,
                                              1,
                                              TextAlign.start),
                                        ],
                                      ),
                                      setHeightSpace(8)
                                    ],
                                  ),
                                ))
                              ],
                            ),
                            Divider()
                          ],
                        ),
                      );
                    }),
              )),
            ],
          ),
        ),
      ),
    );
  }

  _setOrderOperations(BuildContext context, String status) {
    return Container(
      padding: new EdgeInsets.all(12),
      height: 150,
      child: Material(
        color: AppColor.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText(S.current.order_operation, AppColor.black, 15.0,
                  FontWeight.w500, 1, TextAlign.start),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      if (status == '1') {
                        //Accept Order
                        // SharedManager.shared
                        //     .showAlertDialog('Accepting', context);
                        _doOrderAcceptRejectOperation('2');
                      } else {
                        //Preparing Order
                        // SharedManager.shared
                        //     .showAlertDialog('Preparing', context);
                        _doOrderAcceptRejectOperation('4');
                      }
                    },
                    child: Container(
                      height: 50,
                      color: AppColor.themeColor,
                      child: Center(
                        child: setCommonText(
                            (status == '1')
                                ? '${S.current.acceptOrder}'
                                : '${S.current.preparing}',
                            AppColor.white,
                            16.0,
                            FontWeight.w500,
                            1,
                            TextAlign.start),
                      ),
                    ),
                  )),
                  setWithSpace(12),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      // SharedManager.shared.showAlertDialog('Declined', context);
                      _doOrderAcceptRejectOperation('3');
                    },
                    child: Container(
                      height: 50,
                      color: AppColor.red,
                      child: Center(
                        child: setCommonText(
                            '${S.current.declinedorder}',
                            AppColor.white,
                            16.0,
                            FontWeight.w500,
                            1,
                            TextAlign.start),
                      ),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _setOrderDetails(
      String orderId,
      String status,
      String paymentType,
      String tip,
      String discount,
      String price,
      String deliveryTime,
      String deliveryDate) {
    return Container(
      // height: 300,
      padding: new EdgeInsets.all(12),
      child: Material(
        color: AppColor.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText(S.current.order_informations, AppColor.black, 15.0,
                  FontWeight.w500, 1, TextAlign.start),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _setCommonView('${S.current.orderId} :', '#$orderId'),
                  setHeightSpace(5),
                  _setCommonView(
                      'Tiempo de entrega :', '$deliveryDate - $deliveryTime'),
                  setHeightSpace(5),
                  _setCommonView('${S.current.orderStatus} :',
                      '${_setUpOrderStatus(status)}'),
                  setHeightSpace(5),
                  _setCommonView('${S.current.paymentStatus} :', ''),
                  setHeightSpace(5),
                  _setCommonView('${S.current.paymentType} :',
                      '${_setCardType(paymentType)}'),
                  setHeightSpace(5),
                  // _setCommonView('${S.current.tip} :', '${Currency.curr}$tip'),
                  // setHeightSpace(5),
                  _setCommonView(
                      '${S.current.discount} :', '${Currency.curr}$discount'),
                  setHeightSpace(5),
                  _setCommonView(
                      '${S.current.grandTotal} :', '${Currency.curr}$price'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _setCommonView(String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        setCommonText('$title', AppColor.black, 14.0, FontWeight.w500, 1,
            TextAlign.start),
        setCommonText(subtitle, AppColor.grey[600], 12.0, FontWeight.w400, 2,
            TextAlign.start),
      ],
    );
  }

  _setOrderDeliveredWidgets(BuildContext context, String status) {
    return Container(
      padding: new EdgeInsets.all(12),
      height: 150,
      child: Material(
        color: AppColor.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText('${S.current.orderStatus}', AppColor.black, 16.0,
                  FontWeight.w500, 1, TextAlign.start),
              Divider(),
              Row(
                children: <Widget>[
                  (status == '4')
                      ? Expanded(
                          child: Container(
                          height: 50,
                          color: AppColor.themeColor,
                          child: Center(
                            child: setCommonText(
                                '${S.current.preparing}',
                                AppColor.white,
                                15.0,
                                FontWeight.w500,
                                1,
                                TextAlign.start),
                          ),
                        ))
                      : Expanded(
                          child: Container(
                          height: 50,
                          color: (status == '3')
                              ? AppColor.red
                              : AppColor.themeColor,
                          child: Center(
                            child: setCommonText(
                                (status == '3')
                                    ? '${S.current.orderDeclined}'
                                    : '${S.current.orderDelivered}',
                                AppColor.white,
                                15.0,
                                FontWeight.w500,
                                1,
                                TextAlign.start),
                          ),
                        )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _setOrderPickedUpCancelled(BuildContext context, String status) {
    return Container(
      padding: new EdgeInsets.all(12),
      height: 150,
      child: Material(
        color: AppColor.white,
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              setCommonText('${S.current.orderStatus}', AppColor.black, 19.0,
                  FontWeight.w500, 1, TextAlign.start),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Container(
                    height: 50,
                    color: (status == '9') ? AppColor.red : AppColor.themeColor,
                    child: Center(
                      child: setCommonText(
                          (status == '6')
                              ? '${S.current.orderPickedUp}'
                              : '${S.current.orderCancelled}',
                          AppColor.white,
                          15.0,
                          FontWeight.w500,
                          1,
                          TextAlign.start),
                    ),
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _setOperationButtonWidgets(String status, BuildContext context) {
    if (status == '1') {
      return _setOrderOperations(context, status);
    } else if (status == '5') {
      return _setOrderDeliveredWidgets(context, status);
    } else if (status == '2') {
      return _setOrderOperations(context, status);
    } else if (status == '4') {
      return _setOrderDeliveredWidgets(context, status);
    } else if (status == '3') {
      return _setOrderDeliveredWidgets(context, status);
    } else if (status == '9') {
      return _setOrderPickedUpCancelled(context, status);
    } else if (status == '6') {
      return _setOrderPickedUpCancelled(context, status);
    } else {
      return Text('');
    }
  }

  String _setUpOrderStatus(String status) {
    switch (status) {
      case "1":
        return '${S.current.statusPending}';
      case "2":
        return '${S.current.statusAccepted}';
      case "3":
        return '${S.current.statusDeclined}';
      case "4":
        return '${S.current.statusPreparing}';
      case "5":
        return '${S.current.statucDelivered}';
      case "6":
        return '${S.current.statusPickedUp}';
      case "9":
        return '${S.current.statusCancelled}';
      default:
        return setCommonText(
            '', AppColor.themeColor, 16.0, FontWeight.w400, 1, TextAlign.start);
    }
  }

  String _setCardType(String type) {
    if (type == "1") {
      return '${S.current.paymentCOD}';
    } else if (type == "2") {
      return '${S.current.paymentCard}';
    } else if (type == "4") {
      return '${S.current.paymentRazorPay}';
    } else if (type == "5") {
      return '${S.current.paymentWallet}';
    } else {
      return '${S.current.paymentPaypal}';
    }
  }
}
