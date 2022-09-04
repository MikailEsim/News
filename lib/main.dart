import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:projects/provider/general_provider.dart';
import 'package:projects/screens/exchangeRateScreen.dart';
import 'package:projects/screens/homeScreen.dart';
import 'package:projects/screens/prayerTimesScreen.dart';
import 'package:projects/screens/settingsScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('tr', 'TR'), Locale('en', 'EN')],
        path: 'assets/translations',
        fallbackLocale: const Locale('tr', 'TR'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void configLoading(isDarkMode) {
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle =
          isDarkMode ? EasyLoadingStyle.light : EasyLoadingStyle.dark
      ..indicatorSize = 50.0
      ..radius = 10.0;
  }

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GeneralProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<GeneralProvider>(context);
          configLoading(themeProvider.isDarkMode);
          return MaterialApp(
            builder: EasyLoading.init(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: MyStatefulWidget(),
          );
        },
      );
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Widget currentScreen = const HomeScreen();
  String navigationText = 'homePage';
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      setState(() {
        currentScreen = const HomeScreen();
        navigationText = 'homePage';
      });
    } else if (index == 1) {
      setState(() {
        currentScreen = const ExchangeRateScreen();
        navigationText = 'exchangeRates';
      });
    } else if (index == 2) {
      setState(() {
        currentScreen = const PrayerTimesScreen();
        navigationText = 'prayerTimes';
      });
    } else if (index == 3) {
      setState(() {
        currentScreen = const SettingsScreen();
        navigationText = 'settings';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          navigationText,
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        centerTitle: true,
      ),
      body: Center(
        child: currentScreen,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Color(0xff777777), width: 0.25))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_exchange), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
