import "package:rxdart/rxdart.dart";
import "package:restaurant_app/database/models/product_group.dart";
import "package:restaurant_app/database/cart_storage.dart";
class CartBloc
{
	CartStorage _storage;
	BehaviorSubject<ProductGroup> _addHandler, _removeHandler;
	BehaviorSubject<Null> _cartHandler;
	Stream<List<ProductGroup>> _productGroupListStream;
	Stream<int> _productCountStream;
	CartBloc():
		_storage = CartStorage(),
		_cartHandler = new BehaviorSubject<Null>(),
		_addHandler = new BehaviorSubject<ProductGroup>(),
		_removeHandler = new BehaviorSubject<ProductGroup>()
	{
		Stream<Null> cartChangeStream = _cartHandler.mergeWith(
				[
			_addHandler.map(_storage.addGroupToCart),
			_removeHandler.map(_storage.removeGroupFromCart),
				].map((stream)=>stream.mapTo(null))
				);
		_productGroupListStream = cartChangeStream
			.map((_)=>_storage.productGroups);
		_productCountStream = cartChangeStream.map((_)=>_storage.count);
	}
	void dispose()
	{
		[_addHandler, _removeHandler, _cartHandler]
				.map((stream)=>stream.close())
				.toList();
	}
	void addGroupToCart<T>(ProductGroup<T> productGroup) =>
			_addHandler.sink.add(productGroup);
	void removeGroupFromCart<T>(ProductGroup<T> productGroup) =>
			_removeHandler.sink.add(productGroup);	
	void addToCart<T>(T product) =>
			addGroupToCart(new ProductGroup<T>(product));
	void removeFromCart<T>(T product) =>
			removeGroupFromCart<T>(new ProductGroup<T>(product));
	void updateCart() => _cartHandler.sink.add(null);
	Stream<List<ProductGroup>> get productGroupListStream =>
			_productGroupListStream;
	Stream<int> get productCountStream => _productCountStream;
}
