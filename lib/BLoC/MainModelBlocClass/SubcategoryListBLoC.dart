import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelSubCategoryList.dart';

class SubcategoryListBLoC extends BaseBloc<ResSubcategoryList> {
  Stream<ResSubcategoryList> get subcategoryList => fetcher.stream;
  fetchSubcategoryList(String apiURL) async {
    ResSubcategoryList addNewAddress =
        await repository.fetchAllRestaurantSubcategories(apiURL);
    fetcher.sink.add(addNewAddress);
  }
}

final subcategoryListBloc = SubcategoryListBLoC();
