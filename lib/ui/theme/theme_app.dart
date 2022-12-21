import 'package:flutter/material.dart';

abstract class ThemeSize {
  static const kIndent = 12.0;
  static const kHeight = 33.0;
  static const kRadius = 12.0;
}

abstract class ThemeColors {
  static const Color kFrontColor = Color.fromARGB(255, 245, 245, 250);
  static const Color kBGColor = Color.fromARGB(255, 220, 220, 225);
  static const Color kAccent = Color.fromARGB(255, 10, 206, 144);
  static const Color kTextColorLight = kFrontColor;
  static const Color kTextColorDark = Color.fromARGB(255, 52, 51, 51);
}

class MyTheme {
  static final light = ThemeData.dark().copyWith(
    textTheme: textThemeLight,
    primaryTextTheme: textThemeLight,
    scaffoldBackgroundColor: ThemeColors.kBGColor,
    primaryColor: ThemeColors.kAccent,
    splashColor: ThemeColors.kFrontColor,
  );
  static final dark = ThemeData.dark().copyWith(
    textTheme: textThemeDark,
    primaryTextTheme: textThemeDark,
    scaffoldBackgroundColor: Colors.grey[600],
    primaryColor: ThemeColors.kAccent,
    splashColor: Colors.grey,
  );
}

const _textStyleDark = TextStyle(
  //fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  height: 1,
  color: ThemeColors.kTextColorLight,
);

const _textStyleLight = TextStyle(
  // fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
  height: 1,
  color: ThemeColors.kTextColorDark,
);

const textThemeDark = TextTheme(
  bodyMedium: _textStyleDark,
);
const textThemeLight = TextTheme(
  bodyMedium: _textStyleLight,
);
