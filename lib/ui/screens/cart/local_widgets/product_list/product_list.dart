import "package:flutter/material.dart";
import "package:restaurant_app/database/models/product_group.dart";
import "product_group_item.dart";

class ProductList extends StatelessWidget {
  final List<ProductGroup>? productGroups;
  final ProductGroupCallback? onPlus, onMinus, onRemove;
  ProductList(
      {required this.productGroups,
      this.onPlus,
      this.onMinus,
      this.onRemove,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) => (productGroups!.length > 0)
      ? ListView.builder(
          shrinkWrap: true,
          itemCount: productGroups!.length,
          itemBuilder: (context, i) => ProductGroupItem(
              productGroup: productGroups![i],
              onPlus: onPlus,
              onMinus: onMinus,
              onRemove: onRemove),
        )
      : Expanded(child: Center(child: Text("Корзина пуста.")));
}
