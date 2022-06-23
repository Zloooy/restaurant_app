import "package:rxdart/rxdart.dart";
import "package:restaurant_app/database/index.dart";

class AdBloc {
  BehaviorSubject<String?> _adIdHandler;
  RestaurantDatabase _db;
  Stream<Ad>? _adStream;
  AdBloc()
      : _adIdHandler = new BehaviorSubject<String?>(),
        _db = RestaurantDatabase() {
    _adStream = _adIdHandler.map((adId) => _db.getAdById(adId));
  }
  void dispose() {
    _adIdHandler.close();
  }

  set adId(String? adId) => _adIdHandler.sink.add(adId);
  Stream<Ad>? get adStream => _adStream;
}
