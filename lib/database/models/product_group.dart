class ProductGroup<T> {
  T _product;
  int _count;
  ProductGroup(this._product, [int count = 0]) : _count = count;
  T get product => _product;
  int get count => _count;
  void addProduct() => _count += 1;
  void removeProduct() => _count -= _count > 0 ? 1 : 0;
  @override
  bool operator ==(Object other) {
    if (other is T)
      return other == _product;
    else
      return (other is ProductGroup<T>) && (_product == other._product);
  }
}
