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
					tags: ["фастфуд"]
					),
			Restaurant(
					id:"2",
					name:"Well Stacked Pizza",
					rating: 5.0,
					cuisine:"Итальянская кухня",
					mainImagePath: "assets/well_stacked_pizza.jpg",
					address: "ул. Ивана Федорова, 33",
					tags: ["пицца"]
					),
			Restaurant(
					id:"3",
					name:"Cluckin' Bell",
					rating: 4.5,
					cuisine:"Американская кухня",
					mainImagePath: "assets/cluckin_bell.jpg",
					address: "ул. Васи Пупкина, 43",
					tags: ["цыплёнок"]
					),
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
