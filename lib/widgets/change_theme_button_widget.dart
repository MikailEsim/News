import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/general_provider.dart';

class ChangeThemeButtonWidget extends StatefulWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  State<ChangeThemeButtonWidget> createState() =>
      _ChangeThemeButtonWidgetState();
}

class _ChangeThemeButtonWidgetState extends State<ChangeThemeButtonWidget> {
  dynamic isDarkMode = false;

  @override
  void initState() {
    super.initState();
    getIsDarkMode();
  }

  getIsDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool("isDarkMode");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(children: const [
            Icon(
              Icons.light_mode,
            )
          ]),
        ),
        Expanded(
          child: Column(
            children: [
              Switch.adaptive(
                  value: isDarkMode,
                  onChanged: (value) {
                    final provider =
                        Provider.of<GeneralProvider>(context, listen: false);
                    provider.toggleTheme(false);
                    getIsDarkMode();
                  }),
            ],
          ),
        ),
        Expanded(
          child: Column(children: const [
            Icon(
              Icons.dark_mode,
            )
          ]),
        ),
      ],
    );
  }
}
