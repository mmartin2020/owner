import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelOrderList.dart';

class OrderListBLoC extends BaseBloc<ResOrderList> {
  Stream<ResOrderList> get orderList => fetcher.stream;
  fetchOrderList(String ownerID) async {
    ResOrderList addNewAddress = await repository.fetchOrderList(ownerID);
    fetcher.sink.add(addNewAddress);
  }
}

final orderListBLoC = OrderListBLoC();
