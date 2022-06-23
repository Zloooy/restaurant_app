import "package:collection/collection.dart" show IterableExtension;
import "./models/index.dart";

typedef RestaurantSorter = int Function(Restaurant r1, Restaurant r2);
typedef RestaurantFilter = bool Function(Restaurant r);
typedef MealSorter = int Function(Meal m1, Meal m2);
typedef MealFilter = bool Function(Meal m);

class RestaurantDatabase {
  static final RestaurantDatabase _singleton = RestaurantDatabase._create();
  List<Restaurant>? _restaurants;
  List<Holiday>? _holidays;
  List<Ad>? _ads;
  List<Kit>? _kits;
  factory RestaurantDatabase() => _singleton;
  RestaurantDatabase._create() {
    _restaurants = [
      Restaurant(
          id: "1",
          name: "Burger Shot",
          rating: 4.9,
          cuisine: "Американская кухня",
          mainImagePath: "assets/burger_shot.jpg",
          address: "ул. Ивана Иванова, 2",
          phone: "8(222)-32-32",
          description: "Kill your Hunger!",
          menu: [
            Meal(
                id: "1",
                name: "Meal 1",
                price: 100,
                imagePath: "assets/example_meal.jpg")
          ],
          tags: [
            "фастфуд"
          ]),
      Restaurant(
          id: "2",
          name: "Well Stacked Pizza",
          rating: 5.0,
          cuisine: "Итальянская кухня",
          mainImagePath: "assets/well_stacked_pizza.jpg",
          address: "ул. Ивана Федорова, 33",
          phone: "8(800)-35-35",
          description: 'Eat till you say "No, please"',
          menu: [],
          tags: ["пицца"]),
      Restaurant(
        id: "3",
        name: "Cluckin' Bell",
        rating: 4.5,
        cuisine: "Американская кухня",
        mainImagePath: "assets/cluckin_bell.jpg",
        address: "ул. Васи Пупкина, 43",
        phone: "8(567)-12-34",
        tags: ["цыплёнок"],
        menu: [],
        holidayIds: ["new_year"],
      ),
    ];
    _holidays = [
      Holiday(
          id: "new_year", name: "Новый год", iconPath: "assets/new_year.png")
    ];
    _ads = [
      Ad(
          id: "1",
          title: "Аттракцион невиданной щедрости",
          description: "Налетай, подeшевело. Было рубль, стало\n- два.",
          restaurantId: "2",
          imagePath: "assets/ad_1.jpg"),
      Ad(id: "2", restaurantId: "3", imagePath: "assets/ad_2.png")
    ];
    _kits = [
      Kit(
          id: "1",
          title: "Пончик + Кино",
          description: "Пончик и поход в кино со скидкой",
          mainImagePaths: [
            "assets/donuts.jpg",
            "assets/cinema.jpg",
          ])
    ];
  }

  Iterable<Restaurant> _getRestaurants(
      {RestaurantFilter? filter, RestaurantSorter? sorter}) {
    sorter ??= (r1, r2) => r1.name.compareTo(r2.name);
    filter ??= (r) => true;
    return _restaurants!.where(filter).toList()..sort(sorter);
  }

  List<Restaurant> getRestaurantsByName(String name,
          {RestaurantSorter? sorter}) =>
      _getRestaurants(filter: (r) => r.name.contains(name), sorter: sorter)
          .toList();
  List<Restaurant> getRestaurantsByTag(String tag,
          {RestaurantSorter? sorter}) =>
      _getRestaurants(filter: (r) => r.tags.contains(tag), sorter: sorter)
          as List<Restaurant>;
  List<Restaurant> getRestaurantByHoliday(Holiday holiday) =>
      _getRestaurants(filter: (r) => r.holidayIds.contains(holiday.id))
          as List<Restaurant>;
  List<Restaurant>? getRestaurants() => _restaurants;
  Restaurant? getRestaurantById(String? id) =>
      _restaurants!.firstWhereOrNull((r) => r.id == id);
  List<Holiday>? getHolidays() => _holidays;
  Ad getAdById(String? adId) => _ads!.firstWhere((ad) => ad.id == adId);
  List<Ad>? getAds() => _ads;
  List<Kit>? getKits() => _kits;
  Kit getKitById(String kitId) => _kits!.firstWhere((kit) => kit.id == kitId);
  List<Meal> getMenu(String? restaurantId) =>
      getRestaurantById(restaurantId)!.menu;
  Iterable<Meal> _getMeals(String? restaurantId,
      {MealFilter? filter, MealSorter? sorter}) {
    sorter ??= (m1, m2) => m1.name.compareTo(m2.name);
    filter ??= (m) => true;
    return getMenu(restaurantId).where(filter).toList()..sort(sorter);
  }

  List<Meal> getMealsByName(String? restaurantId, String name,
          {MealSorter? sorter}) =>
      _getMeals(restaurantId,
          filter: (r) => r.name.contains(name), sorter: sorter) as List<Meal>;
  List<String> getRestaurantTags() => ["фастфуд"];
}
