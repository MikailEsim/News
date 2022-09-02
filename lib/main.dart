import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:projects/provider/general_provider.dart';
import 'package:projects/screens/exchangeRateScreen.dart';
import 'package:projects/screens/homeScreen.dart';
import 'package:projects/screens/prayerTimesScreen.dart';
import 'package:projects/screens/settingsScreen.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GeneralProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<GeneralProvider>(context);
          return MaterialApp(
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
  Color navigationColor = Colors.red;
  String navigationText = 'homePage';
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      setState(() {
        currentScreen = const HomeScreen();
        navigationColor = Colors.red;
        navigationText = 'homePage';
      });
    } else if (index == 1) {
      setState(() {
        currentScreen = const ExchangeRateScreen();
        navigationColor = Colors.purple;
        navigationText = 'exchangeRates';
      });
    } else if (index == 2) {
      setState(() {
        currentScreen = const PrayerTimesScreen();
        navigationColor = Colors.green;
        navigationText = 'prayerTimes';
      });
    } else if (index == 3) {
      setState(() {
        currentScreen = const SettingsScreen();
        navigationColor = Colors.green;
        navigationText = 'settings';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(navigationText).tr(),
        backgroundColor: navigationColor,
      ),
      body: Center(
        child: currentScreen,
      ),
      bottomNavigationBar: MoltenBottomNavigationBar(
        selectedIndex: _selectedIndex,
        domeHeight: 15.0,
        domeCircleColor: navigationColor,
        barColor: Colors.white,
        curve: Curves.linear,
        tabs: [
          MoltenTab(
            icon: const Icon(Icons.home, size: 30),
          ),
          MoltenTab(
            icon: const Icon(Icons.currency_exchange, size: 30),
          ),
          MoltenTab(
            icon: const Icon(Icons.access_time, size: 30),
          ),
          MoltenTab(
            icon: const Icon(Icons.settings, size: 30),
          ),
        ],
        onTabChange: _onItemTapped,
      ),
    );
  }
}
