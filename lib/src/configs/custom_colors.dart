import 'package:flutter/material.dart';

const Map<int, Color> _swatchShader = {
  50: Color.fromRGBO(139, 195, 74, 0.1),
  10: Color.fromRGBO(139, 195, 74, 0.2),
  200: Color.fromRGBO(139, 195, 74, 0.3),
  300: Color.fromRGBO(139, 195, 74, 0.4),
  400: Color.fromRGBO(139, 195, 74, 0.5),
  500: Color.fromRGBO(139, 195, 74, 0.6),
  600: Color.fromRGBO(139, 195, 74, 0.7),
  700: Color.fromRGBO(139, 195, 74, 0.8),
  800: Color.fromRGBO(139, 195, 74, 0.9),
  900: Color.fromRGBO(139, 195, 74, 1.0)
};

abstract class CustomColors {
  static Color customContrastColor = Colors.red.shade700;

  static MaterialColor customSwatchColor =
      const MaterialColor(0xFF8BC34A, _swatchShader);
}
