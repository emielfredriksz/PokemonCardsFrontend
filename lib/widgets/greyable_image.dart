import 'package:flutter/material.dart';

Widget greyableImage({required Widget child, required bool greyedOut}) {
  if (!greyedOut) return child;

  return Opacity(
    opacity: 0.8,
    child: ColorFiltered(
      colorFilter: const ColorFilter.matrix([
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0.2126,
        0.7152,
        0.0722,
        0,
        0,
        0,
        0,
        0,
        1,
        0,
      ]),
      child: child,
    ),
  );
}
