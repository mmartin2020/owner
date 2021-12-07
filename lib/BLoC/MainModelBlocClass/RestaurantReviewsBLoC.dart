import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelReviewList.dart';

class RestaurantReviewsBLoC extends BaseBloc<ResReviewList> {
  Stream<ResReviewList> get reviewList => fetcher.stream;
  fetchAllRestaurantReviews(String baseURL) async {
    ResReviewList addNewAddress = await repository.fetchAllReview(baseURL);
    fetcher.sink.add(addNewAddress);
  }
}

final restaurantReviewBloC = RestaurantReviewsBLoC();
