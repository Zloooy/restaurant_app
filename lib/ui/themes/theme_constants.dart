import "package:flutter/material.dart";

const Radius CIRCULAR_RADIUS = Radius.circular(9.0);
const BorderRadius BORDER_RADIUS = BorderRadius.all(CIRCULAR_RADIUS);
const ShapeBorder BORDER_SHAPE =
    RoundedRectangleBorder(borderRadius: BORDER_RADIUS);
const OutlineInputBorder INPUT_BORDER =
    OutlineInputBorder(borderRadius: BORDER_RADIUS);
const EdgeInsets LIST_SEPARATOR_PADDING = EdgeInsets.only(bottom: 25);
const double ELEVATION = 5;
const double DEFAULT_SPACING = 7.0;
final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    shape: BORDER_SHAPE as OutlinedBorder?,
    elevation: ELEVATION,
    primary: Colors.white,
    onPrimary: Colors.black);
