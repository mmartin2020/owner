import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelOwnerProfile.dart';

class OwnerProfileBLoC extends BaseBloc<ResOwnerProfile> {
  Stream<ResOwnerProfile> get ownerData => fetcher.stream;
  fetchOwnerProfileData(String ownerID) async {
    ResOwnerProfile addNewAddress = await repository.fetchOwnerProfile(ownerID);
    fetcher.sink.add(addNewAddress);
  }
}

final ownerProfileBLoC = OwnerProfileBLoC();
