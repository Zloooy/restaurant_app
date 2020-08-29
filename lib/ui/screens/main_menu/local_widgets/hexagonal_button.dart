import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';
import 'dart:math';

class HexagonalButton extends StatelessWidget {
  final double diameter;
  final Widget child;
  final VoidCallback onPressed;
  final Radius borderRadius;
  HexagonalButton(
      {@required this.child,
      this.diameter = double.infinity,
      this.borderRadius = const Radius.circular(0),
      @required this.onPressed});
  Widget build(BuildContext context) => RaisedButton(
      onPressed: this.onPressed,
      shape: HexagonalBorder(borderRadius: this.borderRadius),
      child: SizedBox(
        width: this.diameter,
        height: this.diameter,
        child: Padding(
          padding: EdgeInsets.only(
              //magic numbers
              top: this.diameter / 6,
              bottom: this.diameter / 6,
              left: this.diameter / 6,
              right: this.diameter / 6),
          child: this.child,
        ),
      ));
}

class HexagonalBorder extends ShapeBorder {
  final Radius borderRadius;
  HexagonalBorder({this.borderRadius});

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    print("given rect $rect");
    //print("min param ${min(rect.width, rect.height)}");
    //Vector2 pos = Vector2(0,0);
    double rotationAngle = -pi / 3;
    Vector2 sideVector = new Vector2(min(rect.width, rect.height), 0);
    Matrix2 rotationMatrix = Matrix2.rotation(rotationAngle);
    Path res = new Path()
      ..moveTo(rect.left + rect.width / 2 + sideVector.length / 4,
          rect.top + borderRadius.y.abs());
    /*pos
				..x = (rect.left + rect.width/2)
				..y = rect.top;*/
    //print("start pos:${pos.x} ${pos.y}");
    Matrix2 halfRotationMatrix = Matrix2.rotation(rotationAngle / 2);
    var halfSide = sideVector / 2;
    for (int i = 0; i < 6; i++) {
      Vector2 hsClone = halfSide.clone()
        ..normalize()
        ..postmultiply(halfRotationMatrix);
      hsClone *=
          sqrt(pow(borderRadius.x.abs(), 2) + pow(borderRadius.y.abs(), 2));
      //print("half side $halfSide");
      halfSide.postmultiply(rotationMatrix);
      res.relativeQuadraticBezierTo(
          hsClone.x, hsClone.y, halfSide.x, halfSide.y);
      //res.relativeLineTo(halfSide.x, halfSide.y);
      /*pos
				..x += halfSide.x
				..y += halfSide.y;*/
      //print("middle pos: ${pos.x} ${pos.y}");
    }
    /*for (int i = 0; i<6; i++)
		{
			res.relativeLineTo(sideVector.x,sideVector.y);
			sideVector.postmultiply(rotationMatrix);
		}*/
    //print("bounds: ${res.getBounds()}");
    res.close();
    return res;
  }

  @override
  ShapeBorder scale(double t) => null;
}
