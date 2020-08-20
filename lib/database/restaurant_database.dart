import './models/index.dart';
typedef int RestaurantSorter(Restaurant r1, Restaurant r2);
typedef bool RestaurantFilter(Restaurant r);
class RestaurantDatabase
{
	static final RestaurantDatabase _singleton = RestaurantDatabase._create();
	List<Restaurant> _restaurants;
	factory RestaurantDatabase() => _singleton;
	RestaurantDatabase._create()
	{
		_restaurants = [
			Restaurant(
					id:"1",
					name:"Burger Shot",
					rating: 4.9,
					cuisine:"Американская кухня",
					mainImagePath: "assets/burger_shot.jpg",
					address: "ул. Ивана Иванова, 2",
					tags: ["фастфуд"])
		];
	}

	Iterable<Restaurant> _getRestaurants({RestaurantFilter filter, RestaurantSorter sorter})
	{
		sorter ??=(r1,r2)=>r1.name.compareTo(r2.name);
		filter ??= (r)=>true;
		return _restaurants.where(filter).toList()..sort(sorter);
	}
	
	List<Restaurant> getRestaurantsByName(String name, {RestaurantSorter sorter})=> _getRestaurants(
			filter:(r)=>r.name.contains(name),
			sorter:sorter
			).toList();
	List<Restaurant> getRestaurantsByTag(String tag, {RestaurantSorter sorter})=> _getRestaurants(
			filter:(r)=>r.tags.contains(tag),
			sorter:sorter
			);
	List<Restaurant> getRestaurants() => _restaurants;
	List<String> getRestaurantTags()=>["фастфуд"];
}
