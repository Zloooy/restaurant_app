import "package:rxdart/rxdart.dart";

class FlexibleSpaceBloc {
  late BehaviorSubject<bool> _collapsedHandler;
  Stream<bool>? _isCollapsed;
  FlexibleSpaceBloc() {
    _collapsedHandler = BehaviorSubject<bool>.seeded(false);
    _isCollapsed = _collapsedHandler.stream.distinct().map((x) {
      print("is collapsed $x");
      return x;
    });
  }
  Stream<bool>? get isCollapsedStream => _isCollapsed;
  set isCollapsed(bool collapsed) => _collapsedHandler.sink.add(collapsed);
  void dispose() => _collapsedHandler.close();
}
