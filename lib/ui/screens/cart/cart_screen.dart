import "package:flutter/material.dart";
import "package:restaurant_app/database/models/product_group.dart";
import "package:restaurant_app/temporary_blocs/cart_bloc.dart";
import "local_widgets/product_list/product_list.dart";

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);
  @override
  _CartScreeenState createState() => _CartScreeenState();
}

class _CartScreeenState extends State<CartScreen> {
  final CartBloc _bloc = CartBloc();
  @override
  void initState() {
    super.initState();
    _bloc.updateCart();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text("Корзина")),
      body: Center(
        child: Column(children: [
          StreamBuilder(
              stream: _bloc.productGroupListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return ProductList(
                    productGroups: snapshot.data as List<ProductGroup>,
                    onPlus: (group) => _bloc.addGroupToCart(group),
                    onMinus: (group) => _bloc.removeGroupFromCart(group),
                  );
                else {
                  print("no cart snapshot data");
                  return SizedBox();
                }
              }),
          SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {}, child: Text("Оформить заказ")),
          )
        ]),
      ));
}
