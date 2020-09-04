import "package:flutter/material.dart";
import "package:restaurant_app/ui/themes/theme_constants.dart";
import "package:restaurant_app/database/models/meal.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
typedef void MealCallback(Meal m);
final MealCallback _noAction = (m){};
class MealItem extends StatelessWidget
{
	final Meal meal;
	final VoidCallback onTap;
	final MealCallback _onAddToCart;	
	MealItem(Meal this.meal, 
			{@required this.onTap, MealCallback onAddToCart, Key key}):
		_onAddToCart = onAddToCart ?? _noAction,
		super(key:key);
	@override
	Widget build(BuildContext context) =>
	Card(
            elevation: ELEVATION,
            shape: BORDER_SHAPE,
            child: Wrap(runSpacing: DEFAULT_SPACING,
			    children: [
              GestureDetector(
			      onTap:onTap,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: CIRCULAR_RADIUS, topRight: CIRCULAR_RADIUS),
                      image: DecorationImage(
                        image: meal.image,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    width: double.infinity,
                    height: 50.dp),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
				      mainAxisAlignment:MainAxisAlignment.spaceBetween,
				      children: [
                        Expanded(
					child:Text(
					meal.name,
					style: Theme.of(context).textTheme.headline6
			)
					),
			IconButton(
				    icon: Icon(Icons.add_shopping_cart),
				    color:Theme.of(context).accentColor,
				    onPressed:() => _onAddToCart(meal)
					    ),
			SizedBox(height: (DEFAULT_SPACING / 2).dp, width: 1)
		      ])
		  ),
	      )
			      ])
			      );
}
