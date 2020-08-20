import 'package:rxdart/rxdart.dart';
import 'package:restaurant_app/database/index.dart';
class RestaurantSearchBloc
{
	RestaurantDatabase _db = RestaurantDatabase();
	BehaviorSubject<List<Restaurant>> _listItemHandler;
	Stream<List<Restaurant>> _listItemHandlerStream;
	BehaviorSubject<String> _resturantNameHandler = new BehaviorSubject<String>();
	BehaviorSubject<String> _resturantTagHandler = new BehaviorSubject<String>();
	BehaviorSubject<List<String>> _restaurantTagListHandler;
	BehaviorSubject<Null> _restaurantAllHandler = new BehaviorSubject<Null>();
	RestaurantSearchBloc()
	{
		_listItemHandler = new BehaviorSubject<List<Restaurant>>.seeded(_db.getRestaurants());
		_listItemHandlerStream = _listItemHandler.mergeWith([
			_resturantNameHandler.stream.map<List<Restaurant>>(_db.getRestaurantsByName),
			_resturantTagHandler.stream.map<List<Restaurant>>(_db.getRestaurantsByTag),
			_restaurantAllHandler.stream.map<List<Restaurant>>((_)=>_db.getRestaurants())
		]);
		_restaurantTagListHandler = new BehaviorSubject<List<String>>.seeded(_db.getRestaurantTags());
	}
	Stream<List<Restaurant>> get restaurantListStream => _listItemHandlerStream;
	Stream<List<String>> get tagStream => _restaurantTagListHandler.stream;
	void searchByName(String name) => _resturantNameHandler.sink.add(name);
	void searchByTag(String tag) => _resturantTagHandler.sink.add(tag);
	void getAll() => _restaurantAllHandler.sink.add(null);
	void dispose()
	{
		_resturantTagHandler.close();
		_resturantNameHandler.close();
		_listItemHandler.close();
		_restaurantTagListHandler.close();
		_restaurantAllHandler.close();
	}
}
