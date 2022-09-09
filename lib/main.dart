import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:projects/provider/general_provider.dart';
import 'package:projects/screens/exchangeRateScreens.dart';
import 'package:projects/screens/newsScreen.dart';
import 'package:projects/screens/prayerTimesScreen.dart';
import 'package:projects/screens/settingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'EN')],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr', 'TR'),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  void configLoading(isDarkMode) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle =
          isDarkMode ? EasyLoadingStyle.light : EasyLoadingStyle.dark
      ..indicatorSize = 50.0
      ..radius = 10.0;
  }

  getIsDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic isDarkMode = prefs.getBool("isDarkMode");
    configLoading(isDarkMode);
    return isDarkMode;
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GeneralProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<GeneralProvider>(context);
          themeProvider.toggleTheme(true);
          getIsDarkMode();
          return MaterialApp(
            builder: EasyLoading.init(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            initialRoute: '/news',
            routes: {
              '/news': (context) => const NewsScreen(),
              '/exchangeRates': (context) => const ExchangeRatesScreen(),
              '/prayerTimes': (context) => const PrayerTimesScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
          );
        },
      );
}
