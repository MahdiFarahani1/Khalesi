import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThemeApp {
  static ThemeData lightThemeData(
      {required String fontFamily,
      required Color background,
      required Color item,
      required Color reverceColor,
      required Color shadowcolor}) {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        primaryColor: item,
        highlightColor: reverceColor,
        shadowColor: shadowcolor,
        fontFamily: fontFamily);
  }

  static ThemeData darkThemeData(
      {required String fontFamily,
      required Color background,
      required Color item,
      required Color reverceColor,
      required Color shadowcolor}) {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: background,
        primaryColor: item,
        shadowColor: shadowcolor,
        highlightColor: reverceColor,
        fontFamily: fontFamily);
  }
}
