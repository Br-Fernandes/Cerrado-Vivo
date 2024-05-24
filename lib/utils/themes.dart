import 'package:flutter/material.dart';

enum MyThemeKeys { LIGHT, DARK }

class ThemesColors {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: const Color.fromARGB(255,83,172,60),
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color.fromARGB(255, 255, 234, 0)
    )
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey,
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.grey),
  );

  static ThemeData getThemeFromKey(MyThemeKeys themeKey) {
    switch (themeKey) {
      case MyThemeKeys.LIGHT:
        return lightTheme;
      case MyThemeKeys.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }
}