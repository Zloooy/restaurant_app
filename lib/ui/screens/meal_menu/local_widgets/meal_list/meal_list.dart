import "package:flutter/material.dart";
import "package:restaurant_app/database/models/meal.dart";
import "meal_item.dart";

class MealList extends StatelessWidget
{
	final List<Meal> meals;
	final MealCallback onAddToCart;
	MealList({List<Meal> this.meals, this.onAddToCart, Key key}): super(key:key);
	@override
	Widget build(BuildContext context) 
	{
	return (meals.length == 0) ?
	SliverToBoxAdapter(child:SizedBox()):
	SliverList(
			delegate: SliverChildBuilderDelegate(
					(context, i) => MealItem(meals[i], onTap:(){}, onAddToCart:onAddToCart),
					childCount:meals.length
			)
	);
	}
}
