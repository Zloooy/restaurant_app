import "package:collection/collection.dart" show IterableExtension;
import "models/product_group.dart";

class CartStorage extends Iterable {
  static final CartStorage _storage = CartStorage._create();
  List<ProductGroup>? _cart;
  factory CartStorage() => _storage;
  CartStorage._create() {
    _cart = [];
  }
  List<ProductGroup>? get productGroups => _cart;
  void addGroupToCart<T>(ProductGroup<T> group2add) {
    ProductGroup<T?> matchedGroup =
        _cart!.firstWhere((group) => group == group2add, orElse: () {
      _cart!.add(group2add);
      return group2add;
    }) as ProductGroup<T?>;
    matchedGroup.addProduct();
  }

  void addToCart<T>(T product) {
    ProductGroup<T?> matchedGroup =
        _cart!.firstWhere((group) => group == product, orElse: () {
      var newGroup = ProductGroup<T>(product);
      _cart!.add(newGroup);
      return newGroup;
    }) as ProductGroup<T?>;
    matchedGroup.addProduct();
  }

  void removeGroupFromCart<T>(ProductGroup<T> group2remove) {
    ProductGroup<T?>? matchedGroup =
        _cart!.firstWhereOrNull((group) => group == group2remove)
            as ProductGroup<T?>?;
    if (matchedGroup == null) return;
    matchedGroup.removeProduct();
    if (matchedGroup.count == 0) {
      _cart!.remove(matchedGroup);
    }
  }

  void removeFromCart<T>(T product) {
    ProductGroup<T?>? matchedGroup = _cart!
        .firstWhereOrNull((group) => group == product) as ProductGroup<T?>?;
    if (matchedGroup == null) return;
    matchedGroup.removeProduct();
    if (matchedGroup.count == 0) {
      _cart!.remove(matchedGroup);
    }
  }

  int get count => _cart!.fold(0, (p, c) => p + c.count);
  @override
  Iterator get iterator => _cart!.map((group) => group.product).iterator;
}
