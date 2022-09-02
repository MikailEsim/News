import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/general_provider.dart';

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<GeneralProvider>(context);

    return Switch.adaptive(
        value: themeProvider.isDarkMode,
        onChanged: (value) {
          final provider = Provider.of<GeneralProvider>(context, listen: false);
          provider.toggleTheme(value);
        });
  }
}
