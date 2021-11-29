import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor bluePostale = MaterialColor(
    0xFF141A4E, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff121746), //10%
      100: Color(0xff10153E), //20%
      200: Color(0xff0E1237), //30%
      300: Color(0xff0C102F), //40%
      400: Color(0xff0A0D27), //50%
      500: Color(0xff080A1F), //60%
      600: Color(0xff060817), //70%
      700: Color(0xff040510), //80%
      800: Color(0xff020308), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const MaterialColor yellowPostale = MaterialColor(
    0xFFFFDB00, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffE6C500), //10%
      100: Color(0xffCCAF00), //20%
      200: Color(0xffB39900), //30%
      300: Color(0xff998300), //40%
      400: Color(0xff806E00), //50%
      500: Color(0xff665800), //60%
      600: Color(0xff4C4200), //70%
      700: Color(0xff332C00), //80%
      800: Color(0xff191600), //90%
      900: Color(0xff000000), //100%
    },
  );
}
