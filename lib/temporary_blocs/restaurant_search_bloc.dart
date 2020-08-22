import 'package:rxdart/rxdart.dart';
import 'package:restaurant_app/database/index.dart';
class RestaurantSearchBloc
{
	RestaurantDatabase _db = RestaurantDatabase();
	BehaviorSubject<List<Restaurant>> _restaurantListHandler;
	Stream<List<Restaurant>> _restaurantListHandlerStream;
	BehaviorSubject<List<Holiday>> _holidayListHandler;
	Stream<List<Holiday>> _holidayListHandlerStream;
	BehaviorSubject<String> _restaurantNameHandler = new BehaviorSubject<String>();
	BehaviorSubject<String> _restaurantTagHandler = new BehaviorSubject<String>();
	BehaviorSubject<Holiday> _restaurantHolidayHandler = new BehaviorSubject<Holiday>();
	BehaviorSubject<List<String>> _restaurantTagListHandler;
	BehaviorSubject<Null> _restaurantAllHandler = new BehaviorSubject<Null>();
	BehaviorSubject<Null> _holidayHandler = new BehaviorSubject<Null>();
	RestaurantSearchBloc()
	{
		_restaurantListHandler = new BehaviorSubject<List<Restaurant>>.seeded(_db.getRestaurants());
		_restaurantListHandlerStream = _restaurantListHandler.mergeWith([
			_restaurantNameHandler.stream.map<List<Restaurant>>(_db.getRestaurantsByName),
			_restaurantTagHandler.stream.map<List<Restaurant>>(_db.getRestaurantsByTag),
			_restaurantHolidayHandler.map<List<Restaurant>>(_db.getRestaurantByHoliday),
			_restaurantAllHandler.stream.map<List<Restaurant>>((_)=>_db.getRestaurants())
		]);
		_restaurantTagListHandler = new BehaviorSubject<List<String>>.seeded(_db.getRestaurantTags());
		_holidayListHandler = new BehaviorSubject<List<Holiday>>.seeded(_db.getHolidays());
		_holidayListHandlerStream = _holidayListHandler.mergeWith([
			_holidayHandler.map((_)=>_db.getHolidays())
		]);
	}
	Stream<List<Restaurant>> get restaurantListStream => _restaurantListHandlerStream;
	Stream<List<String>> get tagStream => _restaurantTagListHandler.stream;
	Stream<List<Holiday>> get holidayStream => _holidayListHandlerStream;
	void searchByName(String name) => _restaurantNameHandler.sink.add(name);
	void searchByTag(String tag) => _restaurantTagHandler.sink.add(tag);
	void searchByHoliday(Holiday holiday) => _restaurantHolidayHandler.sink.add(holiday);
	void getHolidays() => _holidayHandler.sink.add(null);
	void getAll() => _restaurantAllHandler.sink.add(null);
	void dispose()
	{
		_restaurantTagHandler.close();
		_restaurantNameHandler.close();
		_restaurantListHandler.close();
		_restaurantTagListHandler.close();
		_restaurantAllHandler.close();
		_restaurantHolidayHandler.close();
		_holidayHandler.close();
		_holidayListHandler.close();
	}
}
