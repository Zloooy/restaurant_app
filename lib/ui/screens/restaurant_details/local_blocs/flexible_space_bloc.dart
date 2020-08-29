import 'package:rxdart/rxdart.dart';

class FlexibleSpaceBloc {
  BehaviorSubject<bool> _collapsedHandler;
  Stream<bool> _isCollapsed;
  FlexibleSpaceBloc() {
    _collapsedHandler = new BehaviorSubject<bool>.seeded(false);
    _isCollapsed = _collapsedHandler.stream.distinct().map((x) {
      print("is collapsed $x");
      return x;
    });
  }
  Stream<bool> get isCollapsed => _isCollapsed;
  void setCollapsed(bool collapsed) => _collapsedHandler.sink.add(collapsed);
  void dispose() => _collapsedHandler.close();
}
