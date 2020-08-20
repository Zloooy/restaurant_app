import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:math';
class HexagonalButton extends StatelessWidget
{
	Widget build(BuildContext context) =>RaisedButton(
							child:Center(child: Text("hello")),
					shape:HexagonalBorder(),
					onPressed:(){}
					);
}

class HexagonalBorder extends ShapeBorder
{
	HexagonalBorder();

	@override
	EdgeInsetsGeometry get dimensions
	{
		return const EdgeInsets.only();
	}

	@override
	void paint(Canvas canvas, Rect rect, { TextDirection textDirection }) {}

	@override
	Path getInnerPath(Rect rect, {TextDirection textDirection}) => getOuterPath(rect,textDirection:textDirection);

	@override
	Path getOuterPath(Rect rect, {TextDirection textDirection})
	{
		print("arg rect: $rect ${rect.width} ${rect.height}");
		Vector2 sideVector = new Vector2(min(rect.width,rect.height)/2.0, 0)
				..postmultiply(Matrix2.rotation(pi/3));
		Matrix2 rotationMatrix = Matrix2.rotation(-pi/3.0);
		Path res = new Path()
				..moveTo(rect.left, rect.top + sideVector.length);
		if (rect.width < rect.height)
		{
				double diff = rect.height - rect.width;
				res = res..relativeMoveTo(0, diff/2.0);
		}
		else
		{
				double diff = rect.height - rect.width;
				res = res..relativeMoveTo(-diff/2.0, 0);
		}
		for (int i = 0; i<6; i++)
		{
			print("storage ${sideVector.storage}");
			res.relativeLineTo(sideVector.storage[0],sideVector.storage[1]);
			sideVector.postmultiply(rotationMatrix);
		}
		res.close();
		print("res rect: ${res.getBounds()} ${res.getBounds().width} ${res.getBounds().height}");
		return res;
	}

	@override
	ShapeBorder scale(double t) => null;	
}
