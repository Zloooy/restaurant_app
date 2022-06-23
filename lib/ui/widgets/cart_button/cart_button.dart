import "package:flutter/material.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";

class CartButton extends StatelessWidget {
  final int? productCount;
  final VoidCallback onPressed;
  CartButton({required this.productCount, required this.onPressed, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(alignment: Alignment(0.7, -0.7), children: [
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: onPressed),
        (productCount! > 0)
            ? Container(
                width: 7.dp,
                height: 7.dp,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                    child: Text("${productCount! > 9 ? "9+" : productCount}")))
            : SizedBox()
      ]),
    );
  }
}
