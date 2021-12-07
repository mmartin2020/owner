import 'package:flutter/material.dart';
import 'package:owner/BLoC/MainModelBlocClass/OrderListBLoC.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/Constant.dart';
import 'package:owner/Helper/SharedManaged.dart';
import 'package:owner/Model/ModelOrderList.dart';
import 'package:owner/Screens/OrderDetailsScreen/OrderDetailsScreen.dart';
import 'package:owner/generated/i18n.dart';

class OrdersScreen extends StatefulWidget {
  updateOrder() => createState().updateOrderListData();
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrderStatus> orderStatusList = [
    OrderStatus('Todos', true, '0'),
    OrderStatus('Recibido', false, '1'),
    OrderStatus('Aceptado', false, '2'),
    OrderStatus('Rechazado', false, '3'),
    OrderStatus('Cancelado', false, '9'),
    OrderStatus('Embalaje', false, '4'),
    OrderStatus('Entregado', false, '5'),
  ];

  List<Order> result = [];
  List<Order> orderListTmp = [];
  bool isFirst = true;

  //This is callback function
  updateOrderListData() => _getOrderList();

  @override
  void initState() {
    // TODO: implement initState
    _getOrderList();
    super.initState();
  }

  _getOrderList() async {
    orderListBLoC.fetchOrderList(SharedManager.shared.ownerId);
  }

  _setOrderList(String status) {
    this.result = [];
    for (var order in this.orderListTmp) {
      if (status == '0') {
        this.result = this.orderListTmp;
      } else {
        if (status == order.orderStatus) {
          this.result.add(order);
        }
      }
    }
    // setState(() {});
    print('Final Filter count:${this.result.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(S.current.order, [
        IconButton(
            icon: Icon(
              Icons.notifications,
              color: AppColor.white,
            ),
            onPressed: () {})
      ]),
      body: StreamBuilder(
          stream: orderListBLoC.orderList,
          builder: (context, AsyncSnapshot<ResOrderList> snapshot) {
            if (snapshot.hasData) {
              this.orderListTmp = snapshot.data.orderList;
              if (isFirst) {
                _setOrderList('0');
                this.isFirst = false;
              }
              return Column(
                children: [
                  Container(
                    height: 45,
                    color: AppColor.white,
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 3),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: orderStatusList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: AppColor.white,
                            padding: EdgeInsets.only(
                                left: 5, right: 5, top: 0, bottom: 0),
                            child: InkWell(
                              onTap: () {
                                for (var status in this.orderStatusList) {
                                  status.isSelect = false;
                                }
                                _setOrderList(
                                    this.orderStatusList[index].value);
                                setState(() {
                                  this.orderStatusList[index].isSelect = true;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.white,
                                    border: Border.all(
                                        color: (orderStatusList[index].isSelect)
                                            ? AppColor.themeColor
                                            : AppColor.black54),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(
                                  child: setCommonText(
                                      '   ${orderStatusList[index].status}   ',
                                      (orderStatusList[index].isSelect)
                                          ? AppColor.themeColor
                                          : AppColor.black87,
                                      13.0,
                                      (orderStatusList[index].isSelect)
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                      1,
                                      TextAlign.start),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  Divider(),
                  Expanded(
                    child: (result.length > 0)
                        ? Container(
                            color: AppColor.white,
                            child: ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    // height: 170,
                                    padding: EdgeInsets.only(
                                        left: 8, right: 8, top: 5, bottom: 5),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetailsScreen(
                                                      orderId:
                                                          result[index].orderId,
                                                    )));
                                      },
                                      child: Material(
                                        color: AppColor.white,
                                        elevation: 4.0,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Expanded(
                                                    child: Row(
                                                      children: <Widget>[
                                                        setCommonText(
                                                            '${S.current.orderId}:',
                                                            AppColor.black87,
                                                            14.0,
                                                            FontWeight.w500,
                                                            1,
                                                            TextAlign.start),
                                                        setWithSpace(3),
                                                        Container(
                                                          width: 20,
                                                          // color: AppColor.amber,
                                                          child: setCommonText(
                                                              '${result[index].orderId}',
                                                              AppColor.black,
                                                              12.0,
                                                              FontWeight.w400,
                                                              1,
                                                              TextAlign.start),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        setCommonText(
                                                            '${S.current.date}:',
                                                            AppColor.black87,
                                                            14.0,
                                                            FontWeight.w500,
                                                            1,
                                                            TextAlign.start),
                                                        setWithSpace(3),
                                                        setCommonText(
                                                            '${result[index].created}',
                                                            AppColor.grey[700],
                                                            12.0,
                                                            FontWeight.w400,
                                                            1,
                                                            TextAlign.start)
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              setHeightSpace(4),
                                              setCommonText(
                                                  'Cliente:',
                                                  AppColor.black,
                                                  14.0,
                                                  FontWeight.w500,
                                                  1,
                                                  TextAlign.start),
                                              setCommonText(
                                                  '${result[index].customerName}',
                                                  AppColor.grey[800],
                                                  12.0,
                                                  FontWeight.w400,
                                                  2,
                                                  TextAlign.start),
                                              setHeightSpace(4),
                                              setCommonText(
                                                  '${S.current.address}:',
                                                  AppColor.black,
                                                  14.0,
                                                  FontWeight.w500,
                                                  1,
                                                  TextAlign.start),
                                              setCommonText(
                                                  result[index].address,
                                                  AppColor.grey[800],
                                                  12.0,
                                                  FontWeight.w400,
                                                  2,
                                                  TextAlign.start),
                                              setHeightSpace(4),
                                              setCommonText(
                                                  'Tiempo de entrega:',
                                                  AppColor.red,
                                                  14.0,
                                                  FontWeight.w500,
                                                  1,
                                                  TextAlign.start),
                                              setCommonText(
                                                  '${result[index].deliveryDate} - ${result[index].deliveryTime}',
                                                  AppColor.grey[800],
                                                  12.0,
                                                  FontWeight.w400,
                                                  2,
                                                  TextAlign.start),
                                              setHeightSpace(8),
                                              Container(
                                                height: 1,
                                                color: AppColor.grey[300],
                                              ),
                                              setHeightSpace(8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      setCommonText(
                                                          '${S.current.payment}:',
                                                          AppColor.black87,
                                                          14.0,
                                                          FontWeight.w500,
                                                          1,
                                                          TextAlign.start),
                                                      setWithSpace(3),
                                                      setCommonText(
                                                          '${_setCardType(result[index].paymentType)}',
                                                          AppColor.black87,
                                                          12.0,
                                                          FontWeight.w400,
                                                          1,
                                                          TextAlign.start)
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      setCommonText(
                                                          '${Currency.curr}${result[index].totalPrice}',
                                                          AppColor.black,
                                                          12.0,
                                                          FontWeight.w500,
                                                          1,
                                                          TextAlign.start)
                                                    ],
                                                  )
                                                ],
                                              ),
                                              setHeightSpace(8),
                                              Row(
                                                children: <Widget>[
                                                  setCommonText(
                                                      '${S.current.order}:',
                                                      AppColor.black87,
                                                      12.0,
                                                      FontWeight.w400,
                                                      1,
                                                      TextAlign.start),
                                                  setWithSpace(3),
                                                  _setUpOrderStatus(
                                                      result[index].orderStatus)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        : Container(
                            child: Center(
                              child: setCommonText(
                                  'Datos no encontrados',
                                  AppColor.black87,
                                  16.0,
                                  FontWeight.w500,
                                  2,
                                  TextAlign.center),
                            ),
                          ),
                  ),
                ],
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

  _setUpOrderStatus(String status) {
    switch (status) {
      case "1":
        return setCommonText('${S.current.statusPending}', AppColor.black87,
            12.0, FontWeight.w500, 1, TextAlign.start);
      case "2":
        return setCommonText('${S.current.statusAccepted}', AppColor.black87,
            12.0, FontWeight.w500, 1, TextAlign.start);
      case "3":
        return setCommonText('${S.current.statusDeclined}', AppColor.red, 12.0,
            FontWeight.w500, 1, TextAlign.start);
      case "4":
        return setCommonText('${S.current.statusPreparing}', AppColor.orange,
            12.0, FontWeight.w500, 1, TextAlign.start);
      case "5":
        return setCommonText('${S.current.statucDelivered}',
            AppColor.themeColor, 12.0, FontWeight.w500, 1, TextAlign.start);
      case "6":
        return setCommonText('${S.current.statusPickedUp}', AppColor.black,
            12.0, FontWeight.w500, 1, TextAlign.start);
      case "9":
        return setCommonText('${S.current.statusCancelled}', AppColor.red, 12.0,
            FontWeight.w500, 1, TextAlign.start);
      default:
        return setCommonText(
            '', AppColor.themeColor, 12.0, FontWeight.w400, 1, TextAlign.start);
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

class OrderStatus {
  String status;
  bool isSelect;
  String value;
  OrderStatus(this.status, this.isSelect, this.value);
}
