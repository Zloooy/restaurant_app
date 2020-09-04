import "package:flutter/material.dart";
import "package:restaurant_app/database/models/kit.dart";
import "package:restaurant_app/ui/themes/theme_constants.dart";
import "package:restaurant_app/utils/dp_extension/index.dart";

class KitItem extends StatelessWidget {
  final Kit kit;
  KitItem(this.kit, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Card(
      elevation: ELEVATION,
      shape: BORDER_SHAPE,
      clipBehavior:Clip.antiAlias,
      child: Column(
		      crossAxisAlignment:CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: CIRCULAR_RADIUS, topRight: CIRCULAR_RADIUS),
            ),
	  child:Stack(
			  alignment:Alignment.center,
	    children: [
		    Row(
			  children: kit.mainImages.map((ip)=>
					  Expanded(
							  flex:1,
							  child:Image(
									  image:ip,
									  fit:BoxFit.fitHeight
									  )
							  )
					  ).toList()
			  ),
		    Row(
				    mainAxisAlignment:MainAxisAlignment.center,
						    children: List<Widget>.generate(
								    kit.mainImages.length + 1,
								    (i) => (i==0 || i==kit.mainImages.length) ?
								    Expanded(
										    flex:1,
										    child: SizedBox()
										    ):
								    Expanded(
										    flex:2,
										    child: Icon(
												    Icons.add,
												    size:14.dp
												    )
										    )
								    )
						    )
	    ]
	  )
          ),
	  
	  Padding(
	    padding: EdgeInsets.symmetric(horizontal:5.dp),
	    child: Text(
			    kit.title,
			    textAlign:TextAlign.left,
			    style:Theme.of(context).textTheme.headline6),
	  )
        ],
      ));
}
