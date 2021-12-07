import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelOrderDetails.dart';

class OrderDetailsBLoC extends BaseBloc<ResOrderDetails> {
  Stream<ResOrderDetails> get orderDetails => fetcher.stream;
  fetchOrderDetails(String orderID) async {
    ResOrderDetails addNewAddress = await repository.fetchOrderDetails(orderID);
    fetcher.sink.add(addNewAddress);
  }
}

final orderDetailsBLoC = OrderDetailsBLoC();
