import './models/restaurant.dart';
typedef int RestaurantSorter(Restaurant r1, Restaurant r2);
typedef bool RestaurantFilter(Restaurant r);
class RestaurantDatabase
{
	static final RestaurantDatabase _singleton = RestaurantDatabase._create();
	List<Restaurant> restaurants;
	factory RestaurantDatabase() => _singleton;
	RestaurantDatabase._create()
	{
		restaurants = [
			Restaurant(
					id:"1",
					name:"Burger Shot",
					mainImagePath: "assets/burger_shot.jpg",
					address: "ул. Ивана Иванова, 2",
					tags: ["фастфуд"])
		];
	}

	Iterable<Restaurant> _getRestaurants({RestaurantFilter filter, RestaurantSorter sorter})
	{
		sorter = (sorter==null) ? (r1,r2)=>r1.name.compareTo(r2.name) : sorter;
		filter = (filter==null) ? (r)=>true : filter;
		return restaurants.where(filter).toList()..sort(sorter);
	}
	
	List<Restaurant> getRestaurantsByName(String name, {RestaurantSorter sorter})=> _getRestaurants(
			filter:(r)=>r.name.contains(name),
			sorter:sorter
			).toList();
	List<Restaurant> getRestaurantsByTag(String tag, {RestaurantSorter sorter})=> _getRestaurants(
			filter:(r)=>r.tags.contains(tag),
			sorter:sorter
			);
	List<String> getRestaurantTags()=>["фастфуд"];
}
