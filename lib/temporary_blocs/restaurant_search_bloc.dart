import "package:rxdart/rxdart.dart";
import "package:restaurant_app/database/index.dart";

class RestaurantSearchBloc {
  RestaurantDatabase _db = RestaurantDatabase();
  //Restaurant list & its props
  BehaviorSubject<List<Restaurant>> _restaurantListHandler;
  Stream<List<Restaurant>> _restaurantListHandlerStream;
  BehaviorSubject<String> _restaurantNameHandler = BehaviorSubject<String>();
  BehaviorSubject<String> _restaurantTagHandler = BehaviorSubject<String>();
  BehaviorSubject<List<String>> _restaurantTagListHandler;
  BehaviorSubject<Holiday> _restaurantHolidayHandler =
      BehaviorSubject<Holiday>();
  BehaviorSubject<Null> _restaurantAllHandler = BehaviorSubject<Null>();
  //Single Restaurant & its props
  BehaviorSubject<Restaurant> _oneRestaurantHandler;
  Stream<Restaurant> _oneRestaurantStream;
  BehaviorSubject<String> _restaurantIdHandler = BehaviorSubject<String>();
  //Holiday list & its props
  BehaviorSubject<List<Holiday>> _holidayListHandler;
  Stream<List<Holiday>> _holidayListHandlerStream;
  BehaviorSubject<List<Ad>> _adListHandler;
  BehaviorSubject<Null> _holidayHandler = BehaviorSubject<Null>();
  //Ad list & its props
  Stream<List<Ad>> _adHandlerStream;
  BehaviorSubject<Null> _adHandler = BehaviorSubject<Null>();
  RestaurantSearchBloc() {
    _restaurantListHandler =
        BehaviorSubject<List<Restaurant>>.seeded(_db.getRestaurants());
    _restaurantTagListHandler =
        BehaviorSubject<List<String>>.seeded(_db.getRestaurantTags());
    _restaurantListHandlerStream = _restaurantListHandler.mergeWith([
      _restaurantNameHandler.stream
          .map<List<Restaurant>>(_db.getRestaurantsByName),
      _restaurantTagHandler.stream
          .map<List<Restaurant>>(_db.getRestaurantsByTag),
      _restaurantHolidayHandler
          .map<List<Restaurant>>(_db.getRestaurantByHoliday),
      _restaurantAllHandler.stream
          .map<List<Restaurant>>((_) => _db.getRestaurants())
    ]);

    _oneRestaurantHandler = BehaviorSubject<Restaurant>();
    _oneRestaurantStream = _oneRestaurantHandler
        .mergeWith([_restaurantIdHandler.map(_db.getRestaurantById)]);
    _holidayListHandler =
        BehaviorSubject<List<Holiday>>.seeded(_db.getHolidays());
    _holidayListHandlerStream = _holidayListHandler
        .mergeWith([_holidayHandler.map((_) => _db.getHolidays())]);

    _adListHandler = BehaviorSubject<List<Ad>>.seeded(_db.getAds());
    _adHandlerStream =
        _adListHandler.mergeWith([_adHandler.map((_) => _db.getAds())]);
  }
  Stream<List<Restaurant>> get restaurantListStream =>
      _restaurantListHandlerStream;
  Stream<Restaurant> get singleRestaurantStream => _oneRestaurantStream;
  Stream<List<String>> get tagStream => _restaurantTagListHandler.stream;
  Stream<List<Holiday>> get holidayStream => _holidayListHandlerStream;
  Stream<List<Ad>> get adStream => _adHandlerStream;
  void searchByName(String name) => _restaurantNameHandler.sink.add(name);
  void searchByTag(String tag) => _restaurantTagHandler.sink.add(tag);
  void searchByHoliday(Holiday holiday) =>
      _restaurantHolidayHandler.sink.add(holiday);
  void getRestaurantById(String id) => _restaurantIdHandler.sink.add(id);
  void getHolidays() => _holidayHandler.sink.add(null);
  void getAds() => _adHandler.sink.add(null);
  void getAll() => _restaurantAllHandler.sink.add(null);
  void dispose() {
    _restaurantTagHandler.close();
    _restaurantNameHandler.close();
    _restaurantListHandler.close();
    _restaurantTagListHandler.close();
    _restaurantAllHandler.close();
    _restaurantHolidayHandler.close();
    _holidayHandler.close();
    _holidayListHandler.close();
    _adHandler.close();
    _adListHandler.close();
  }
}
