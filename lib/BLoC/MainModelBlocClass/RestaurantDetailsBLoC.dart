import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelResDetails.dart';

class RestaurantDetailsBLoC extends BaseBloc<ResRestaurantDetails> {
  Stream<ResRestaurantDetails> get restaurantDetails => fetcher.stream;
  fetchRestaurantDetails(String apiURL) async {
    ResRestaurantDetails addNewAddress =
        await repository.restaurantDetails(apiURL);
    fetcher.sink.add(addNewAddress);
  }
}

final restaurantDetailsBloc = RestaurantDetailsBLoC();
