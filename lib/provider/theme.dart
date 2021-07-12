import 'package:flutter/material.dart';

class AppThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Color.fromRGBO(5, 0, 35, 1),
      colorScheme: ColorScheme.dark(),
      primaryColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white54),
      textTheme:
          TextTheme(bodyText1: TextStyle(color: Colors.white54, fontSize: 28)));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: ColorScheme.light(),
      iconTheme: IconThemeData(color: Color.fromRGBO(155, 155, 155, 1)),
      textTheme: TextTheme(
          bodyText1: TextStyle(
              color: Color.fromRGBO(155, 155, 155, 1), fontSize: 28)));
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isLightMode => themeMode == ThemeMode.light;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
