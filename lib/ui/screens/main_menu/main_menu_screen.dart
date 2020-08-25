import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;
import 'dart:math';
import './local_widgets/hexagonal_button.dart';
class MainMenuScreen extends StatelessWidget
{
	static final double buttonDiameter = 130;
	static final double buttonRadius = buttonDiameter/2;
	static final double padding = 15;
	Widget build(BuildContext context) {
		final size = MediaQuery.of(context).size;
		final Vector2 distanceV = Vector2(0, buttonRadius * sqrt(3) + padding);
		//TODO: Fix with other code
		final Vector2 topPosV = Vector2(size.width/2 - padding, size.height/2 - buttonRadius) - Vector2.all(buttonRadius);
		print("top $topPosV");
		//IDK why here padding is needed
		final Vector2 bottomPosV = (topPosV + distanceV);
		print("bottom $bottomPosV");
		//
		final Vector2 rightPosV = topPosV + (distanceV.clone()..postmultiply(Matrix2.rotation(pi/3)));
		final Vector2 leftPosV = topPosV + (distanceV.clone()..postmultiply(Matrix2.rotation(-pi/3)));
			return Scaffold(
			body: Container(
							width:size.width,
							height:size.height,
					child: Stack(
					alignment:AlignmentDirectional.center,
					fit:StackFit.passthrough,
					overflow:Overflow.clip,
						children: [
							/*SizedBox(
									width:size.width, 
									height:size.height, 
									//child: DecoratedBox(decoration: BoxDecoration(color: Colors.red))
									),*/
							Positioned(
									left:topPosV.x,
									top:topPosV.y,
								child: _mainMenuButton(
									context,
									iconPath:"assets/open_air.png",	
									text:"На открытом воздухе",
									onPressed:()=>{}
										)
							),
							Positioned(
									left:leftPosV.x,
									top:leftPosV.y,
								child: _mainMenuButton(
									context,
									iconPath:"assets/meeting.png",	
									text:"Первое свидание",
									onPressed:()=>{}
										)
							),
							Positioned(
									left:rightPosV.x,
									top:rightPosV.y,
								
								child: _mainMenuButton(
									context,
									iconPath:"assets/evening.png",	
									text:"Тёплый вечер",
									onPressed:()=>{}
										)

							),
							Positioned(
									left:bottomPosV.x,
									top:bottomPosV.y,
								child: _mainMenuButton(
									context,
									iconPath:"assets/collection.png",	
									text:"Наборы",
									onPressed:()=>{}
										)
							),
							Align(
									alignment:Alignment.bottomLeft,
									child:_bottom_button(
											child:Icon(Icons.search),
									)
								),
							Align(
									alignment:Alignment.bottomRight,
									child:_bottom_button(
											child: ImageIcon(AssetImage("assets/account.png")),
											onPressed: (){}
											)
								)
						]
						)
			)
			);
	}
	Widget _mainMenuButton(context, {@required String iconPath, @required String text, @required VoidCallback onPressed}) => HexagonalButton(
			onPressed: onPressed,
										child: Column(
												mainAxisAlignment: MainAxisAlignment.center,
												crossAxisAlignment: CrossAxisAlignment.center,
												children: [
													ImageIcon(
													AssetImage(
															iconPath,
															)),
													Text(text,
															textAlign:TextAlign.center,
															style:Theme.of(context).textTheme.caption.copyWith(fontSize:10.81))
												]
												),
										borderRadius:Radius.circular(10),
										diameter:buttonDiameter
										);
	Widget _bottom_button({@required Widget child, VoidCallback onPressed})=>SizedBox(
											height:70,
											child: RaisedButton(
												child:child,
												onPressed:(){}
									)
									);
}
