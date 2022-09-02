import 'package:flutter/material.dart';
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
