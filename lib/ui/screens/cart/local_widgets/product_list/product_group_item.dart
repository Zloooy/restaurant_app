import "package:flutter/material.dart";
import "package:restaurant_app/ui/themes/theme_constants.dart";
import "package:restaurant_app/database/models/product_group.dart";
import "package:restaurant_app/database/models/index.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";
typedef void ProductGroupCallback(ProductGroup group);
final ProductGroupCallback _noAction = (g){};
class ProductGroupItem extends StatelessWidget
{
	final ProductGroup _pgroup;
	final  ProductGroupCallback _onPlus, _onMinus, _onRemove;
	ProductGroupItem({@required ProductGroup productGroup,
		ProductGroupCallback onPlus,
		ProductGroupCallback onMinus,
		ProductGroupCallback onRemove, Key key}):
		_pgroup = productGroup,
		_onPlus = onPlus ?? _noAction,
		_onMinus = onMinus ?? _noAction,
		_onRemove = onRemove ?? _noAction,
		super(key:key);
	@override
	Widget build(BuildContext context)
	{
		Widget itemInfo;
		print(_pgroup.runtimeType.toString());
		if (_pgroup is ProductGroup<Meal>)
		{
			Meal meal = _pgroup.product as Meal;
			itemInfo = Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children:
					[
						Expanded(
								flex:4,
						  child: Image(
						  		fit:BoxFit.fitWidth,
						  		image:meal.image
						  		),
						),
						Expanded(
								flex:1,
						  child: Padding(
						    padding: EdgeInsets.all(3.dp),
						    child: Text(
						  		meal.name,
						    		style:Theme.of(context).textTheme.headline6,
						  		textAlign:TextAlign.left
						    		),
						  ),
						),
					]
			);
		}
		else itemInfo = SizedBox();
		return SizedBox(
				height:80.dp,
		  child: Card(
		    elevation: ELEVATION,
		    shape: BORDER_SHAPE,
		  	clipBehavior:	Clip.antiAlias,
		  	child:Row(
		  			children:
		  			[
		  				Expanded(
								child: itemInfo
								),
							
		  				Column(
								mainAxisAlignment:MainAxisAlignment.center,
								crossAxisAlignment:CrossAxisAlignment.center,
		  				  children: <Widget>[
							  IconButton(
									  icon:Icon(Icons.add),
									  onPressed:()=>_onPlus(_pgroup)
									  ),
		  				    Text("x ${_pgroup.count}"),
							  IconButton(
									  icon:Icon(Icons.remove),
									  onPressed:()=>_onMinus(_pgroup)
									  ),
		  				  ],
		  				)
		  			]	
		  			)
		  		),
		);
	}
}
