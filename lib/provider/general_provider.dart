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
      scaffoldBackgroundColor: Colors.grey.shade900,
      colorScheme: const ColorScheme.dark());
  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light());
}
