import 'package:owner/BLoC/CommonBlocClass/BaseBloc.dart';
import 'package:owner/Model/ModelNotificationList.dart';

class NotificationListBloc extends BaseBloc<ResNotificationList> {
  Stream<ResNotificationList> get notificationList => fetcher.stream;
  fetchnotificationList(String userId) async {
    ResNotificationList notificationList =
        await repository.fetchAllNotifications(userId);
    fetcher.sink.add(notificationList);
  }
}

final notificationListBloc = NotificationListBloc();
