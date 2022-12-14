import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralProvider extends ChangeNotifier {
  Locale _locale = const Locale('tr', 'TR');
  Locale get locale => _locale;
  void setLocale(Locale locale, BuildContext context) async {
    context.setLocale(locale);
    _locale = locale;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("langIsTr", locale.toString() == 'tr_TR');
    notifyListeners();
  }

  ThemeMode themeMode = ThemeMode.light;
  void toggleTheme(bool isRunApp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isRunApp) {
      themeMode = prefs.getBool("isDarkMode") == true
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      themeMode = prefs.getBool("isDarkMode") == true
          ? ThemeMode.light
          : ThemeMode.dark;
    }
    prefs.setBool("isDarkMode", themeMode == ThemeMode.dark);
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
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Color(0xfff5f5f5),
      ),
      elevation: 0,
      shape: Border(bottom: BorderSide(color: Color(0xff777777), width: 0.9)),
      iconTheme: IconThemeData(color: Color(0xfff5f5f5)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Color(0xff010203),
      selectedIconTheme: IconThemeData(
        color: Colors.blue,
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
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Color(0xff010203),
      ),
      elevation: 0,
      shape: Border(bottom: BorderSide(color: Color(0xff777777), width: 0.9)),
      iconTheme: IconThemeData(color: Color(0xff010203)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: Color(0xfff5f5f5),
      selectedIconTheme: IconThemeData(
        color: Colors.blue,
      ),
      unselectedIconTheme: IconThemeData(color: Color(0xff010203)),
    ),
  );
}
