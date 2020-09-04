import "package:rxdart/rxdart.dart";
import "package:restaurant_app/database/index.dart";
class KitBloc
{
	RestaurantDatabase _db;
	BehaviorSubject<String> _kitIdHandler;	
	BehaviorSubject<Null> _allKitsHandler;
	Stream<List<Kit>> _kitListStream;
	Stream<Kit> _kitStream;
	KitBloc():
		_db = RestaurantDatabase(),
		_kitIdHandler = new BehaviorSubject<String>(),
		_allKitsHandler = new BehaviorSubject<Null>(),
		_kitStream = new BehaviorSubject<Kit>()
	{
		_kitListStream = _allKitsHandler.map((_)=>_db.getKits());
		_kitStream = _kitIdHandler.map((kitId)=>_db.getKitById(kitId));
	}
	set kitId(String kitId) => _kitIdHandler.sink.add(kitId);
	void getKits() => _allKitsHandler.sink.add(null);
	Stream<Kit> get kitStream => _kitStream;
	Stream<List<Kit>> get kitListStream => _kitListStream;
	void dispose()
	{
		_kitIdHandler.close();
		_allKitsHandler.close();
	}
}
