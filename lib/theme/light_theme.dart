import 'package:almanara/core/constrain/color.dart';
import 'package:flutter/material.dart';

final fontFamily = 'IBMPlexSansArabic';

class LightTheme {
  static final data = ThemeData(
    fontFamily: fontFamily,
    brightness: Brightness.light,
    primaryColor: orange,
    textTheme: const TextTheme(
        bodyMedium: TextStyle(
      color: grey,
    )),
    appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: brown,
            fontFamily: fontFamily,
            fontSize: 24)),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: orange, foregroundColor: white),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: orange,
      onPrimary: Colors.black,
      secondary: lightOrange,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
  );
}
