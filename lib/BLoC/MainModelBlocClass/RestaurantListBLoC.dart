import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelRestaurantList.dart';

class RestaurantListBLoC extends BaseBloc<ResRestaurantList> {
  Stream<ResRestaurantList> get restaurantList => fetcher.stream;
  fetchAllRestaurant(String ownerId) async {
    ResRestaurantList addNewAddress =
        await repository.fetchAllRestaurantList(ownerId);
    fetcher.sink.add(addNewAddress);
  }
}

final restaurantListBloc = RestaurantListBLoC();
