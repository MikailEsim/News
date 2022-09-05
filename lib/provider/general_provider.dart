import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  Locale _locale = const Locale('tr', 'TR');
  Locale get locale => _locale;
  void setLocale(Locale locale, BuildContext context) async {
    context.setLocale(locale);
    _locale = locale;
    notifyListeners();
  }

  ThemeMode themeMode = ThemeMode.dark;
  bool get isDarkMode => themeMode == ThemeMode.dark;
  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff010203),
    colorScheme: const ColorScheme.dark(),
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 20, color: Color(0xfff5f5f5)),
      bodyText1: TextStyle(fontSize: 15, color: Color(0xfff5f5f5)),
      bodyText2: TextStyle(fontSize: 15, color: Colors.blue),
      subtitle1: TextStyle(
          fontSize: 17.5,
          color: Color(0xfff5f5f5),
          fontWeight: FontWeight.bold),
      subtitle2: TextStyle(
          fontSize: 15, color: Color(0xfff5f5f5), fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff010203),
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          color: Color(0xfff5f5f5),
        ),
        elevation: 0,
        shape:
            Border(bottom: BorderSide(color: Color(0xff777777), width: 0.9))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Color(0xff010203),
      selectedIconTheme: IconThemeData(
        color: Colors.lightBlue,
      ),
      unselectedIconTheme: IconThemeData(color: Color(0xfff5f5f5)),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xfff5f5f5),
    colorScheme: const ColorScheme.light(),
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 20, color: Color(0xff010203)),
      bodyText1: TextStyle(fontSize: 15, color: Color(0xff010203)),
      bodyText2: TextStyle(fontSize: 15, color: Colors.blue),
      subtitle1: TextStyle(
          fontSize: 17.5,
          color: Color(0xff010203),
          fontWeight: FontWeight.bold),
      subtitle2: TextStyle(
          fontSize: 15, color: Color(0xff010203), fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xfff5f5f5),
        titleTextStyle: TextStyle(
          fontSize: 20.0,
          color: Color(0xff010203),
        ),
        elevation: 0,
        shape:
            Border(bottom: BorderSide(color: Color(0xff777777), width: 0.9))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Color(0xfff5f5f5),
      selectedIconTheme: IconThemeData(
        color: Colors.lightBlue,
      ),
      unselectedIconTheme: IconThemeData(color: Color(0xff010203)),
    ),
  );
}
