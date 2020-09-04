import "dart:async";
import "package:rxdart/rxdart.dart";
import "package:restaurant_app/database/index.dart";
class MealMenuBloc
{
	RestaurantDatabase _db;
  final BehaviorSubject<List<Meal>> _mealListHandler;
  Stream<List<Meal>> _mealListStream;
  final BehaviorSubject<String> _restaurantIdHandler;
  final BehaviorSubject<String> _mealNameHandler;
  Future<void> _inited;
  MealMenuBloc():
	  _restaurantIdHandler = new BehaviorSubject<String>(),
	  _mealListHandler = new BehaviorSubject<List<Meal>>(),
	  _mealNameHandler = new BehaviorSubject<String>
	  .seeded("aaa"), // non-empty string
	  _db = RestaurantDatabase()
	{
		Stream<GroupByStream<String, bool>> groupedQueries =
				_mealNameHandler .groupBy<bool>(
					(String s) => s.isEmpty
					);
		_inited = groupedQueries.map((stream)
		{
			if (stream.key)
			{
				print("initing empty string stream");
				return Rx.combineLatest2(
								_restaurantIdHandler,
								stream.map((_)
										{
											print("got empty string");
											return _;
										}),
								(restaurantId, _)
								{
								print("empty string on $restaurantId");
								return _db.getMenu(restaurantId);
								}
								);
			}
			else
			{
				print("initing non-empty string stream");
						return Rx.combineLatest2(
								_restaurantIdHandler,
								stream.map(
										(s){
											print("got non-empty string $s");
											return s;
										}
										),
								(restaurantId, mealName)
								{
									print("$mealName on $restaurantId");
									return _db.getMealsByName(restaurantId, mealName);
								}
								);
								

			}
		}
		)
				.asBroadcastStream()
				.take(2)
				.toList()
				.then((streamList){
					print("streamList $streamList");
						_mealListStream = _mealListHandler.mergeWith(streamList);
				print("mealListStream inited $_mealListStream");
				});
		searchMeals("");  // empty string
		searchMeals("112");
	}
  Future<void> get inited => _inited;
  set restaurantId(String id) => _restaurantIdHandler.sink.add(id);
  void searchMeals(String mealName) {
	  print("searching meals");
	  _mealNameHandler.sink.add(mealName);}
  Stream<List<Meal>> get mealListStream => _mealListStream;
  void dispose()
  {
	  _restaurantIdHandler.close();
	  _mealNameHandler.close();
	  _mealListHandler.close();
  }

}
