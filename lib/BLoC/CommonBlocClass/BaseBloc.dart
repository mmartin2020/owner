import 'package:rxdart/rxdart.dart';
import 'BaseMode.dart';
import 'Repository.dart';

abstract class BaseBloc<T extends BaseModel> {
  final repository = Repository();
  final fetcher = PublishSubject<T>();

  dispose() {
    fetcher.close();
  }
}
