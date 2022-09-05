import 'package:flutter/material.dart';
import '../screenUtil.dart';
import '../widgets/appbar.dart';
import '../widgets/bottomNavigationBar.dart';
import '../widgets/change_language_button_widget.dart';
import '../widgets/change_theme_button_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          Size.fromHeight(ScreenUtil.elementHeight(context, 60)),
          'exchangeRates'),
      bottomNavigationBar: const CustomBottomNavigationBar(3),
      body: Column(
        children: [
          Row(
            children: const [
              ChangeLanguageButtonWidget(),
              ChangeThemeButtonWidget(),
            ],
          )
        ],
      ),
    );
  }
}
