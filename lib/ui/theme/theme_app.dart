import 'package:flutter/material.dart';
import 'package:text/ui/theme/storage_manager.dart';

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

const String keyThemeStory = 'themeMode';

class MyThemeNotifier with ChangeNotifier {
  static final lightTheme = ThemeData.dark().copyWith(
    textTheme: textThemeLight,
    primaryTextTheme: textThemeLight,
    scaffoldBackgroundColor: ThemeColors.kBGColor,
    primaryColor: ThemeColors.kAccent,
    splashColor: ThemeColors.kFrontColor,
  );
  static final darkTheme = ThemeData.dark().copyWith(
    textTheme: textThemeDark,
    primaryTextTheme: textThemeDark,
    scaffoldBackgroundColor: Colors.grey[600],
    primaryColor: ThemeColors.kAccent,
    splashColor: Colors.grey,
  );

  ThemeData _themeData = lightTheme;
  ThemeData get getTheme => _themeData;

  MyThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value;
      switch (themeMode) {
        case 'light':
          _setLightMode();
          break;
        case ' dark':
          _setDarkMode();
          break;
        default:
          _setDarkMode();
      }
      notifyListeners();
    });
  }

  void toggTheme() {
    _themeData != darkTheme ? _setDarkMode() : _setLightMode();
    notifyListeners();
  }

  void _setDarkMode() async {
    _themeData = darkTheme;
    await StorageManager.saveData(keyThemeStory, 'dark');
  }

  void _setLightMode() async {
    _themeData = lightTheme;
    await StorageManager.saveData(keyThemeStory, 'light');
  }
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
