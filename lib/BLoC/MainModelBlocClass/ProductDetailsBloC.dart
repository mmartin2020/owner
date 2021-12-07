//

import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelProductDetails.dart';

class ProductDetailsBloC extends BaseBloc<ResProductDetails> {
  Stream<ResProductDetails> get productDetails => fetcher.stream;
  fetchProductDetails(dynamic param) async {
    ResProductDetails resDetails = await repository.fetchProductDetails(param);
    fetcher.sink.add(resDetails);
  }
}

final productDetailsBloC = ProductDetailsBloC();
