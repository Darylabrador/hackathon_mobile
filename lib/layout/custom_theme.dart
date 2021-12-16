import 'package:flutter/material.dart';
import '../../utils/palette.dart';

class CustomTheme {
  static ThemeData appTheme() {
    return ThemeData(
      primarySwatch: Palette.bluePostale,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: Palette.yellowPostale[200],
        ),
      ),
      textTheme: ThemeData.light().textTheme.copyWith(
            headline1: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline3: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            headline4: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline5:  const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
    );
  }
}
